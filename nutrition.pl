#!/usr/bin/perl -w

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

my @items;
# my $col = PerlLib::Collection->new(Type => );

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

sub Start {
  # select an ingredient
  my $search = QueryUser("What food shall we search for?");
  my $query = "select * from food_des where long_desc like '\%$search\%';";
  print $query;
  my $matches = mysql_get_aoh($query);
  my @chosen = SubsetSelect(Set => [map {$_->{long_desc}} @$matches],
			    Selection => {});
  print Dumper(@chosen);
}

Start;
