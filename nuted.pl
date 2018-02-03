#!/usr/bin/perl -w

# this  is a simple  system to  cross reference  nutrition information
# with ingredients.   in other words,  the user inputs  an ingredient,
# preferably a direct as  opposed to produced ingredient.  This system
# looks up  the health information  for that ingredient.  Should  do a
# weighted intersection on bag of words?


use Manager::Dialog qw(QueryUser SubsetSelect);
use PerlLib::Collection;

use Data::Dumper;
use DBI;

my $dbh = DBI->connect("DBI:mysql:database=" .
		       "gourmet".
		       ";host=localhost",
		       "root", "",
		       {
			'RaiseError' => 1});

sub mysql_get_aoh {
  $query = shift;
  my @matches = ();
  my $sth = $dbh->prepare($query);
  $sth->execute();
  while (my $ref = $sth->fetchrow_hashref()) {
    push @matches, $ref;
  }
  $sth->finish();
  return \@matches;
}

my @items;
my $contentsfile = $ARGV[0];
my %freq;
my $num = 0;
my @results;
my $nut = {};

my $barcodes = eval `cat data/barcodes`;

sub ProcessIngredients {
  GenerateLanguageModel();

  # load the substitutions, or whatever
  foreach my $barcode (keys %$barcodes) {
    my $item = $barcodes->{$barcode}->{Name};
    my $match = MatchIngredient($item);
    if (@$match) {
      $nut->{$item} = $match->[0];
    } else {
      $nut->{$item} = "unknown";
    }
    my $OUT;
    open(OUT,">data/nutrition") or die "ouch\n";
    print OUT Dumper($nut);
    close(OUT);
  }
}

sub GenerateLanguageModel {
  if (0) {			#-e "data/nutrition.lm") {
    (%freq,$num) = eval `cat data/nutrition.lm`;
    print "NUM:$num\n";
  } else {
    my $query = "select * from food_des;";
    my $matches = mysql_get_aoh($query);
    foreach my $match (@$matches) {
      foreach my $word (split /\W+/, $match->{long_desc}) {
	if (defined $freq{$word}) {
	  $freq{$word} += 1;
	} else {
	  $freq{$word} = 1;
	}
	++$num;
      }
    }
    my $OUT;
    open(OUT,">nutrition.lm") or die "ouch!";
    print OUT Dumper($num,%freq);
    close(OUT);
  }
}

sub MatchIngredient {
  my $item = shift;
  my %score;
  chomp $item;
  my @keywords = split /\W+/, $item;
  foreach my $keyword (@keywords) {
    if (length $keyword > 3) {
      my $query = "select * from food_des where long_desc like '\%$keyword\%';";
      my $matches = mysql_get_aoh($query);
      foreach my $ref (@{$matches}) {
	my $result = $ref->{long_desc};
	if ($freq{$keyword}) {
	  $score{$result} += ($num / $freq{$keyword});
	}
      }
    }
  }
  my @top = sort {$score{$a} <=> $score{$b}} keys %score;
  #print "\n\n$line\n".Dumper(@keywords).Dumper(reverse map {[$_,$score{$_}]} splice (@top,-10));
  print "\n\n<$item>\n";
  my $set;
  if (@top > 20) {
    $set = [reverse splice (@top,-20)]
  } else {
    $set = [reverse @top];
  }
  my @results;
  foreach my $res (SubsetSelect
		   (Set => $set,
		    Selection => {})) {
    $res =~ s/ - .*//;
    push @results, $res;
  }
  return \@results;
}

ProcessIngredients;
