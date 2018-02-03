package OOGourmet::Meal;

use Manager::Dialog qw (Approve QueryUser SubsetSelect);

use Data::Dumper;

use Class::MethodMaker new_with_init => 'new',
  get_set =>
  [

   qw / Date Rating /

  ];

sub init {
  my ($self,%args) = @_;
  $self->Date($args{Date});
  $self->Rating($args{Rating});
  $self->Recipe($args{Recipe});
}

sub Score {
  my ($self,%args) = @_;
  if ($args{Recipe}) {
    my $intendeddate = $args{IntendedDate};

    # we are scoring a recipe (as opposed to individual inventory
    # items, etc)
    my $nut = $self->GetNutritionValue
      (Recipe => $args{Recipe});
    # for now, just use nutr_val, whatever that supposed to mean
    if (scalar keys %$nut) {
      $nutval = $nut->{nutr_val};
    }

    # now calculate how much we've been having it recently.
    # actually fatigure should be calculated over ingredients as well or
    # maybe just use a generalized distance metric and compute the
    # pagerank
    my $fatigue = 0;
    my $nutval = 0;
    my $num = scalar @{$self->Plans};
    my $i = 1;
    foreach my $recipe (@{$UNIVERSAL::oogourmet->Plans}) {
      $fatigue += $num/($i * $i) if $meal->{Meal} eq $o;
      ++$i;
    }
    # now compute a composite score
    my $fatiguescale = -1;
    my $nutscale = 1/30;
    return $nutscale * $nutval + $fatiguescale * $fatigue;
  }
}

sub GetNutritionValue {
  my ($self,%args) = @_;
  if ($args{Recipe}) {
    my $r = $args{Recipe};
    if (! $self->NutritionValue) {
      my $totalnut = {};
      foreach my $ing ($self->Ingredients->Values) {
	foreach my $ing2 (keys %{$args{Record}->{$ing}}) {
	  my $act = $self->Barcodes->{$ing2}->{Name};
	  my $nut = $self->GetNutritionValue
	    (Ingredient => $act,
	     NoPrint => 1);
	  # print Dumper($nut);
	  if (scalar keys %$nut) {
	    foreach my $key (keys %$nut) {
	      if ($nut->{$key} =~ /^[0-9.]+$/) {
		$totalnut->{$key} += $nut->{$key};
	      }
	    }
	  }
	}
      }
      $self->MealNutritionValue->{$r} = $totalnut;
      return $totalnut;
    } else {
      return $self->MealNutritionValue->{$r};
    }
  } elsif ($args{Ingredient}) {
    my $long_desc = $self->Nutrition->{$args{Ingredient}};
    if ($long_desc) {
      print "\tLngDsc:\t$long_desc\n" unless $args{NoPrint};
      if ($long_desc ne "unknown") {
	my $query = "select ndb_no from food_des where long_desc='$long_desc';";
	my $matches = $self->SearchMysql(Query => $query);
	if (@$matches) {
	  my $ndbno = $matches->[0]->{ndb_no};
	  # print "NDBNO: $ndbno\n";
	  $query = "select * from nut_data where ndb_no='$ndbno';";
	  $matches = $self->SearchMysql(Query => $query);
	  if (@$matches) {
	    return $matches->[0];
	  }
	}
      }
    }
    return {};
  }
}

1;
