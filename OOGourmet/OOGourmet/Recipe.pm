package OOGourmet::Recipe;

use Manager::Dialog qw (Approve QueryUser SubsetSelect);

use Data::Dumper;

use Class::MethodMaker new_with_init => 'new',
  get_set =>
  [

   qw / Name Ingredients NutritionValue /

  ];

sub init {
  my ($self,%args) = @_;
  $self->Ingredients($args{Ingredients});
}

sub Score {
  my ($self,%args) = @_;
  my $intendeddate = $args{IntendedDate};

  # (ESTIMATED) NUTRITION CONTENT
  my $nut = $self->GetNutritionValue;
  # for now, just use nutr_val, whatever that supposed to mean
  if (scalar keys %$nut) {
    $nutval = $nut->{nutr_val};
  }

  # COLLABORATIVE FILTERING

  # calculate what the ratings would give this recipe

  # RECIPE FATIGUE

  # need a better model  than inverse exponential, perhaps could learn
  # this model using ANNs or something
  my $fatigue = 0;
  my $nutval = 0;
  my $num = $UNIVERSAL::oogourmet->Meals->Count;
  foreach my $meal (@{$UNIVERSAL::oogourmet->Meals->Values}) {
    if ($meal->Recipe eq $self->Name) {
      my $et = ElapsedTime($meal->Date,$args{IntendedDate} || GetDate());
      $et = 1 if $et < 1;
      $fatigue += $num / ($et * $et);
    }
  }

  # (ESTIMATED) RECIPE COST

  # SUSTAINABILITY

  # whether we  are depleting  our resources too  much given  our next
  # planned refill

  # now compute a composite score
  my $fatiguescale = -1;
  my $nutscale = 1/30;
  return $nutscale * $nutval + $fatiguescale * $fatigue;
}

sub GetNutritionValue {
  my ($self,%args) = @_;
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
    $self->NutritionValue($totalnut);
  } else {
    return $self->NutritionValue;
  }
}

1;
