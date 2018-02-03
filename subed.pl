#!/usr/bin/perl -w

use Data::Dumper;
use Manager::Dialog qw (SubsetSelect QueryUser);

# system to edit substitutions

# ensure that all items have a parent

# load barcodes

my $b = eval `cat data/barcodes`;
print Dumper($b);

my $r = eval `cat data/recipes`;
print Dumper($r);

my $s = eval `cat data/substitutions`;
print Dumper($s);


# all recipes should have one or many isas



# all barcodes should be one or many isas

# obviously a recipe can serve as a recipe "ingredient", should have
# two types of ingredients - recipes and boxes





# obtain lists of all recipes ingredients, etc
my $ing = {};
foreach my $key (keys %$r) {
  foreach my $i (keys %{$r->{$key}->{Ingredients}}) {
    $ing->{lc($i)} = 1;
  }
}

# obtain lists of all barcodes items, etc
my $bar = {};
foreach my $key (keys %$b) {
  $bar->{lc($b->{$key}->{Name})} = 1;
}

# obtain lists of all parents from substitutions, etc
my $sp = {};
my $sk = {};
foreach my $key (keys %$s) {
  $sk->{lc($key)} = 1;
  foreach my $i (keys %{$s->{$key}}) {
    $sp->{lc($i)} = 1;
  }
}

# now, we want  to assure that each of the barcode  items has at least
# one corresponding isa-parent

my @findparentsfor = keys %$bar;
push @findparentsfor, keys %$sp;

my $options = {};
foreach my $key (keys %$ing) {
  $options->{$key} = 1;
}
foreach my $key (keys %$sp) {
  $options->{$key} = 1;
}

while (@findparentsfor) {
  my $item = shift @findparentsfor;
  if (! defined $s->{$bar} or ! @{$s->{$bar}}) {
    # want the user to select from among the recipe ingredients at
    # least one item which this is a direct child of, otherwise, create an
    # intermediate substitution item
    my @set = qw(add-new-substitution);
    push @set, sort keys %$options;
    print "<<<$item>>>\n";
    my @parents = SubsetSelect(Set => \@set, Selection => {});
    foreach my $parent (@parents) {
      if ($parent eq "add-new-substitution") {
	# this will add a new substitution item"
	my $newparent = QueryUser("New parent: ");
	if ($newparent ne ".") {
	  $s->{$item}->{$newparent} = 1;
	  push @findparentsfor, $newparent;
	  $options->{$newparent} = 1;
	}
      } else {
	$s->{$item}->{$parent} = 1;
      }
    }
    # now save the results somewhere
    my $OUT;
    open (OUT,">/tmp/substitutions") or die "ouch";
    print OUT Dumper($s);
    close (OUT);
  }
}

