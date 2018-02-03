package PGourmet::Web;

use 

use Class::MethodMaker new_with_init => 'new',
  get_set =>
  [

   qw / Client Clientin Debug Config Barcodes IBarcodes Inventory
   Recipes Substitutions ISubstitutions Palatability Plans Files
   Nutrition MealNutritionValue Inventory RecipeIngredientList DBH /

  ];

sub init {
  my ($self,%args) = @_;
  my $specification = "
	-a		Add items to inventory
	-d		Debug mode
	-c		Choose meal
	-l		List next meals
	-r		Lookup recipe
	-s		Add substitutions
";
  $self->Client(STDOUT);
  $self->Clientin(STDIN);
  $self->ConfigureScanner;

  $self->Config(BOSS::Config->new
		(Spec => $specification,
		 ConfFile => ""));
  my $conf = $self->Config->CLIConfig;
  $self->Barcodes({});
  $self->IBarcodes({});
  $self->Inventory({});
  $self->Recipes({});
  $self->Substitutions({});
  $self->ISubstitutions({});
  $self->Nutrition({});
  $self->Palatability({});

  $self->Plans([]);
  $self->Files({});

  $self->Files->{barcodes} = "data/barcodes";
  $self->Files->{inventory} = "data/inventory";
  $self->Files->{recipes} = "data/recipes";
  $self->Files->{substitutions} = "data/substitutions";
  $self->Files->{nutrition} = "data/nutrition";
  $self->Files->{palatability} = "data/palatability";

  $self->MealNutritionValue({});

  $self->DBH
    (DBI->connect
     ("DBI:mysql:database=" .
      "gourmet".
      ";host=localhost",
      "root", "",
      {
       'RaiseError' => 1}));
}

sub LoadBarcodes {
  my ($self,%args) = @_;
  $self->Barcodes
    ($self->LoadDataFromFile
     (Data => $self->Barcodes,
      File => $self->Files->{barcodes}));
  foreach my $b (keys %{$self->Barcodes}) {
    $self->IBarcodes->{$self->Barcodes->{$b}->{Name}} = $b;
  }
}

sub AddBarcode {
  my ($self,%args) = @_;
  if (! exists $self->Barcodes->{$args{Barcode}}) {
    # look up in the data file
    # otherwise ask the user what it is:
    my $th = {};
    foreach my $field (qw (Name ServingsPerContainer)) {
      print "$field: ";
      $th->{$field} = $self->Clean($self->ReadFromPrompt);
    }
    if (Approve(Dumper($th)."\nCorrect?")) {
      $self->Barcodes->{$args{Barcode}} = $th;
      $self->SaveBarcodes;
    }
  }
}

sub SaveBarcodes {
  my ($self,%args) = @_;
  $self->SaveDataToFile
    (
     Data => $self->Barcodes,
     File => $self->Files->{barcodes},
    );
}

# take inventory of the food supplies
sub LoadInventory {
  my ($self,%args) = @_;
  if (-f $self->Files->{inventory}) {
    $self->Inventory
      ($self->LoadDataFromFile
      (
       Data => $self->Inventory,
       File => $self->Files->{inventory},
      ));
  } else {
    $self->Inventory({});
  }
}

sub SaveInventory {
  my ($self,%args) = @_;
  $self->SaveDataToFile
    (
     Data => $self->Inventory,
     File => $self->Files->{inventory},
    );
}

sub GetNextID {
  my ($self,$barcode) = (shift,shift);
  my $max = 0;
  foreach my $key (keys %{$self->Inventory->{$barcode}}) {
    if ($key + 1 > $max) {
      $max = $key + 1;
    }
  }
  return $max;
}

sub Clean {
  my ($self,$t) = (shift,shift);
  $t =~ s/^[\s\n]+//;
  $t =~ s/[\s\n]+$//;
  return $t;
}

sub InventoryAddItem {
  my ($self,%args) = @_;

  print "Please scan barcode: ";
  my $tmp = $self->ReadFromPrompt;
  my $barcode = $self->Clean($tmp);
  if (! exists $self->Barcodes->{$barcode}) {
    $self->AddBarcode(Barcode => $barcode);
  }
  print "Quantity: ";
  my $quantity = $self->Clean($self->ReadFromPrompt);
  $quantity = 1 unless $quantity;
  my $next = $self->GetNextID($barcode);
  for (my $i = $next; $i < $quantity + $next; ++$i) {
    $self->Inventory->{$barcode}->{$i}->{ServingsRemaining} =
      $self->Barcodes->{$barcode}->{ServingsPerContainer};
  }
  $self->SaveInventory;
  $self->PrintInventory;
}

sub InventoryRemoveItem {
  my ($self,%args) = @_;
}

sub PrintInventory {
  my ($self,%args) = @_;
  print "Barcode\t\tQty\tSrv\tName\n";
  print "----------------------------------------\n";
  foreach my $bc (keys %{$self->Inventory}) {
    # calculate total keys
    my $cnt = 0;
    my $servings = 0;
    foreach my $key (keys %{$self->Inventory->{$bc}}) {
      ++$cnt;
      $servings += $self->Inventory->{$bc}->{$key}->{ServingsRemaining};
    }
# -1     print "$bc\n";
# 0    print "$cnt\n";
# 0    print "$servings\n";
# undef    print "$self->Barcodes->{$bc}->{Name}\n";
    print "$bc\t$cnt\t$servings\t".$self->Barcodes->{$bc}->{Name}."\n" if $bc != -1;
  }
}

sub LoadRecipes {
  my ($self,%args) = @_;
  $self->Recipes
    ($self->LoadDataFromFile
    (
     Data => $self->Recipes,
     File => $self->Files->{recipes}
    ));
}

sub SaveRecipes {
  my ($self,%args) = @_;
  $self->SaveDataToFile
    (
     Data => $self->Recipes,
     File => $self->Files->{recipes},
    );
}

sub LoadSubstitutions {
  my ($self,%args) = @_;
  $self->Substitutions
    ($self->LoadDataFromFile
    (
     Data => $self->Substitutions,
     File => $self->Files->{substitutions}
    ));
  foreach my $i (keys %{$self->Substitutions}) {
    foreach my $j (keys %{$self->Substitutions->{$i}}) {
      $self->ISubstitutions->{$j}->{$i} = 1;
    }
  }
}

sub SaveSubstitutions {
  my ($self,%args) = @_;
  $self->SaveDataToFile
    (
     Data => $self->Substitutions,
     File => $self->Files->{substitutions},
    );
}

sub SaveDataToFile {
  my ($self,%args) = @_;
  my $OUT;
  open (OUT, ">$args{File}")  or die "ouch\n";
  print OUT Dumper($args{Data});
  close (OUT);
}

sub LoadDataFromFile {
  my ($self,%args) = @_;
  print "Loading $args{File}\n";
  if (-e $args{File}) {
    my $c = `cat "$args{File}"`;
    # print "Contents: $c\n";
    my $d = eval $c;
    # print Dumper($d);
    $args{Data} = $d;
    return $d;
  } else {
    return 0;
  }
}

sub PrintData {
  my ($self,%args) = @_;
  print Dumper($args{Data});
}

sub GetAllMatches {
  my ($self,$ing) = (shift,lc(shift));
  my $debug = 0;
  my @queue = $ing;
  print "<<<$ing:" if $debug;
  my $seen = {};
  my $matches = {};
  while (@queue) {
    my $ing = shift @queue;
    if (! $seen->{$ing}) {
      # iterate through all substitutions and return all keys
      foreach my $sat (keys %{$self->ISubstitutions->{$ing}}) {
	push @queue, $sat;
	if (! $seen->{$sat}) {
	  print "$sat --- " if $debug;
	  $matches->{defined $self->IBarcodes->{$sat} ? $self->IBarcodes->{$sat} : -1} = 1;
	}
      }
      $seen->{$ing} = 1;
    }
  }
  print ">>>\n" if $debug;
  return keys %$matches;
}

sub HaveEnoughServings {
  my ($self,$ing,$sr) = (shift,shift,shift);
  # LIMITATIONS
  # Assumes that all items are in the inventory
  foreach my $productinstance (keys %{$self->Inventory->{$ing}}) {
    # print Dumper($ing,$sr,$self->Inventory->{$ing}->{$productinstance});
    if ($self->Inventory->{$ing}->{$productinstance}->{ServingsRemaining} >= $sr) {
      return $productinstance;
    }
  }
  return -1;
}

# LIMITATIONS

# Requires that all ingredients in a recipe have a substitution in the
# database, and that that substitution  has a barcode.  This fails for
# water, for instance.

# Assumes that if you have two different instances of the same product
# in inventory, does not add their remaining servings together.

# Uses servings as the only unit of measurement.

sub ListSatisfiableModels {
  my ($self,$ing,$sr) = (shift,shift,shift);
  # iterate across the recipes,
  my $matches = [];
  my $models = {};
  foreach my $rec (keys %{$self->Recipes}) {
    # checking whether we have enough for that recipe
    my $tmp = {};
    print "---\n" if $debug;
    my $all = 1;
    foreach my $ing (keys %{$self->Recipes->{$rec}->{Ingredients}}) {
      print "I1: $ing\n" if $debug;
      my $servingsrequired = $self->Recipes->{$rec}->{Ingredients}->{$ing};
      my $any = 0;
      foreach my $ing2 ($self->GetAllMatches($ing)) {
	print "I2: $ing2\n" if $debug;
	my $item = $self->HaveEnoughServings($ing2,$servingsrequired);
	if ($item != -1) {
	  if (defined $models->{$rec}->{$ing}->{$ing2}) {
	    push @{$models->{$rec}->{$ing}->{$ing2}}, $item;
	  } else {
	    $models->{$rec}->{$ing}->{$ing2} = [$item];
	  }
	  $any = 1;
	}
      }
      if (! $any) {
	$all = 0;
      }
    }
    if ($all) {
      push @$matches, $rec;
    } else {
      delete $models->{$rec};
    }
  }
  return {Matches => $matches,
	  Models => $models};
}

sub Choose {
  my ($self,%args) = @_;
  if ($args{Options}) {
    if ($args{Randomly}) {
      return $args{Options}->[int rand @{$args{Options}}];
    } else {
      if ($args{Message}) {
	print $args{Message}."\n";
      }
      my $i = 0;
      foreach my $o (@{$args{Options}}) {
	print $i++.") $o\n";
      }
      my $ret = "";
      while ($ret !~ /^([0-9]+|q)$/) {
	$ret = <STDIN>;
	chomp $ret;
      }
      # print Dumper($args{Options}->[$ret]);
      return $args{Options}->[$ret];
    }
  }
}

sub RemoveModelFromInventory {
  my ($self,%args) = @_;
  my $commit = $self->ChooseValidModelRandomly(%args);
  my $retval = {};
  foreach my $list (@$commit) {
    $self->Inventory->{$list->[1]}->{$list->[2]}->{ServingsRemaining} -= $list->[3];
    $retval->{$list->[0]}->{$list->[1]}->{$list->[2]} = 1;
  }
  return $retval;
}

sub ChooseValidModelRandomly {
  my ($self,%args) = @_;
  my $commit = [];
  foreach my $ing (keys %{$self->Recipes->{$args{Meal}}->{Ingredients}}) {
    my $servingsrequired = $self->Recipes->{$args{Meal}}->{Ingredients}->{$ing};
    my $product =
      $self->Choose
	(Randomly => 1,
	 Options => [keys %{$args{Models}->{$ing}}]);
    my $pii =
      $self->Choose
	(Randomly => 1,
	 Options => $args{Models}->{$ing}->{$product});
    if ($self->Inventory->{$product}->{$pii}->{ServingsRemaining} >= $servingsrequired) {
      push @$commit, [$ing,$product,$pii,$servingsrequired];
    } else {
      return 0;
    }
  }
  return $commit;
}


sub PlanMeal {
  my ($self,%args) = @_;
  my $date = $args{Date};
  my $plan = {};
  my $possible = $self->ListSatisfiableModels;
  my $score = {};
  my $max = -100000;
  my $bestoption;
  # get  a score for  each model,  choosing the  best one  rather than
  # scoring the recipe as a  whole, we will score the ingredients
  foreach my $recipe (keys %{$possible->{Models}}) {
    # print "<<<$recipe>>>\n";
    # compute a recipe based score first
    $score->{$recipe} = $self->GetScore
      (Recipe => $recipe,
       Models => $possible->{Models});
    if ($score->{$recipe} >= $max) {
      $bestoption = $recipe;
      $max = $score->{$recipe};
    }
  }
  # now we know the best model, and the meal
  # my $meal = $possible->{Matches}->[rand @{$possible->{Matches}}];
  my $meal = $bestoption;
  my $response = $self->RemoveModelFromInventory
    (Meal => $meal, # $possible->{Meals}->{$meal},
     Models => $possible->{Models}->{$meal});
  if ($response) {
    $plan->{Date} = $date;
    $plan->{Meal} = $meal;
    $self->PrettyPrintMeal
      (Date => $date,
       Meal => $meal,
       Record => $response,
       Score => $max);
    return $plan;
  } else {
    print "Not enough items for meals\n" if $debug;
  }
}

sub PlanMeals {
  my ($self,%args) = @_;
  # first generate a list of all  the times that meals are expected to
  # occur.  for now, simply generate a list of a few times.

  # my $realinventory = $self->Inventory;
  foreach my $i (1..100) {
    # my $date = `date "+%Y%m%d%H%M%S"`;
    my $dateprefix = `date -d "+ $i days" "+%Y%m%d"`;
    chomp $dateprefix;
    if ($dateprefix =~ /^([0-9]{4})([0-9]{2})([0-9]{2})$/) {
      #print "<$1><$2><$3>\n";
      foreach my $h (qw(090000 130000 170000)) {
	my $plan = $self->PlanMeal(Date => "$dateprefix$h");
	if ($plan != -1) {
	  push @{$self->Plans}, $plan;
	}
      }
    }
  }
}

sub Serve {
  my ($self,%args) = @_;
  my $m = $args{Meal};
}

sub ExecutePlans {
  my ($self,%args) = @_;
  while (@{$self->Plans}) {
    my $plannedmeal = shift @{$self->Plans};
    $self->Serve(Meal => $plannedmeal);
  }
}

sub Load {
  my ($self,%args) = @_;
  my $conf = $self->Config->CLIConfig;

  $self->LoadBarcodes;
  $self->LoadInventory;
  $self->LoadRecipes;
  $self->LoadSubstitutions;
  # PrintData(Data => $self->ISubstitutions);
  # PrintData(Data => $self->IBarcodes);
  $self->LoadNutrition;
  $self->LoadPalatability;
  $self->PrintInventory;

  if (exists $conf->{-a}) {
    while (1) {
      $self->InventoryAddItem;
    }
  }
  if (exists $conf->{-s}) {
    $self->MatchSubsitutions;
  }
  if (exists $conf->{-l}) {
    $self->PlanMeals;
    $self->PrintInventory;
    $self->ExecutePlans;
  }
  if (exists $conf->{-r}) {
    $self->LookupRecipe;
  }
}

sub LoadPalatability {
  my ($self,%args) = @_;
  $self->Palatability
    ($self->LoadDataFromFile
     (
      Data => $self->Palatability,
      File => $self->Files->{palatability}
     ));
}

sub SavePalatability {
  my ($self,%args) = @_;
  $self->SaveDataToFile
    (
     Data => $self->Palatability,
     File => $self->Files->{palatability},
    );
}

sub LoadNutrition {
  my ($self,%args) = @_;
  $self->Nutrition
    ($self->LoadDataFromFile
     (
      Data => $self->Nutrition,
      File => $self->Files->{nutrition}
     ));
}

sub SaveNutrition {
  my ($self,%args) = @_;
  $self->SaveDataToFile
    (
     Data => $self->Nutrition,
     File => $self->Files->{nutrition},
    );
}

sub ConfigureScanner {
  my ($self, %args) = @_;
  # CONFIGURE HARDWARE
  my $scannertype = "flic";
  my $scannerdevice = "/dev/ttyS0";
  if ($scannertype eq "flic") {
    $SCANNER = 0;
    open(SCANNER,"<$scannerdevice");
    $read_set = IO::Select->new();
    $read_set->add(\*STDIN);
    $read_set->add(\*SCANNER);
    $read_set->add($self->Clientin);
  }
}

sub ReadFromPrompt {
  my ($self, %args) = @_;
  my $prompt = "> ";
  my $client = $self->Client;
  my $clientin = $self->Clientin;
  print $client $prompt;
  autoflush $client;
  do {
    @handles = $read_set->can_read($timeout);
  } while (!@handles);
  foreach $handle (@handles) {
    $buf = <$handle>;
    if (fileno($handle) eq fileno(SCANNER)) {
      $tmp = <$handle>;
      $buf =~ s/[\r]//g;
      print "$buf";
    } elsif (fileno($handle) eq fileno($clientin)) {
    }
  }
  $buf =~ s/\r//g;
  print $client "\n";
  return $buf;
}

sub BuildIngredientList {
  my ($self, %args) = @_;
  $self->RecipeIngredientList({});
  foreach my $rec (keys %{$self->Recipes}) {
    foreach my $ing (keys %{$self->Recipes->{$rec}->{Ingredients}}) {
      $self->RecipeIngredientList->{$ing} = 1;
    }
  }
}

sub MatchSubsitutions {
  my ($self, %args) = @_;
  # this function edits the inventory x ingredients substitution matrix
  $self->BuildIngredientList;
  foreach my $item (keys %{$self->Barcodes}) {
    my $name = $self->Barcodes->{$item}->{Name};
    print "Name: $name\n";
    # now choose what items from the recipes this provides
    my $res = "";
    while ($res ne "_done") {
      my @list = ("_done","_other",sort keys %{$self->RecipeIngredientList});
      $res = $self->Choose(Options => \@list);
      print "<$res>\n";
      if ($res eq "_other") {
	$self->RecipeIngredientList->{$self->Clean($self->ReadFromPrompt)} = 1;
      } elsif ($res ne "_done") {
	$self->Substitutions->{$name}->{$res} = 1;
      }
    }
    $self->SaveSubstitutions;
  }
}

sub GetScore {
  my ($self,%args) = @_;
  # now, rate it relative to the other options, if you have to, use an
  # ordinal scale.
  if ($args{Recipe}) {

    # we are scoring a recipe (as opposed to individual inventory
    # items, etc)
#     my $nut = $self->GetNutritionValue(Recipe => $args{Recipe});
#     # for now, just use nutr_val, whatever that supposed to mean
#     if (scalar keys %$nut) {
#       $nutval = $nut->{nutr_val};
#     }

    # do a small sampling for each recipe under consideration
    # 1 for now, hehe
    my $commit = $self->ChooseValidModelRandomly
      (Meal => $args{Recipe},
       Models => $args{Models}->{$args{Recipe}});
    my $tnut = {};
    foreach my $list (@$commit) {
      # calculate nutrition value for ingredient
      my $ing = $self->Barcodes->{$list->[1]}->{Name};
      my $nut = $self->GetNutritionValue
	(Ingredient => $ing,
	 NoPrint => 1);
      foreach my $key (keys %$nut) {
	if ($nut->{$key} =~ /^[0-9\.]+$/) {
	  $tnut->{$key} += $nut->{$key};
	}
      }
    }
    # now calculate how much we've been having it recently.
    # actually fatigure should be calculated over ingredients as well or
    # maybe just use a generalized distance metric and compute the
    # pagerank

    my $nutval = $tnut->{nutr_val} || 0;
    my $fatigue = 0;
    my $num = scalar @{$self->Plans};
    my $i = 1;
    foreach my $meal (reverse @{$self->Plans}) {
      # print "$fatigue += $num/($i * $i) if $meal->{Meal} eq $args{Recipe}\n";
      $fatigue += $num/($i * $i) if $meal->{Meal} eq $args{Recipe};
      ++$i;
    }
    # now compute a composite score
    my $fatiguescale = -1;
    my $nutscale = 1/30;
    # print Dumper($nutscale, $nutval, $fatiguescale, $fatigue);
    my $score = $nutscale * $nutval + $fatiguescale * $fatigue;
    return $score;
  }
}

sub SearchMysql {
  my ($self,%args) = @_;
  $query = $args{Query};
  my @matches = ();
  my $sth = $self->DBH->prepare($query);
  $sth->execute();
  while (my $ref = $sth->fetchrow_hashref()) {
    push @matches, $ref;
  }
  $sth->finish();
  return \@matches;
}

sub GetNutritionValue {
  my ($self,%args) = @_;
  if ($args{Recipe}) {
    my $r = $args{Recipe};
    if (! scalar keys %{$self->MealNutritionValue->{$r}}) {
      # calculate the nutrition value using

      # do we really know what the record is, or just the model?
      # well, the model should be useful for guiding things anyway

      # obviously improve the accuracy of this
      my $totalnut = {};
      # print Dumper($args{Record});
      foreach my $ing (keys %{$args{Record}}) {
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

sub PrettyPrintMeal {
  my ($self,%args) = @_;
  print "----------------------------------------\n";
  print "Date:\t$args{Date}\n";
  print "Meal:\t$args{Meal}\n";
  $self->GetNutritionValue
    (Recipe => $args{Meal},
     Record => $args{Record});
  print "NutVal:\t".($self->MealNutritionValue->{$args{Meal}}->{nutr_val} || "?")."\n";
  print "Score:\t".$args{Score}."\n";
  # $self->PrintNutritionInformation(Record => $args{Record});
}

sub PrintNutritionInformation {
  my ($self,%args) = @_;
  foreach my $ing (keys %{$args{Record}}) {
    print "\t-------------\n";
    print "\tIngred:\t$ing\n";
    foreach my $ing2 (keys %{$args{Record}->{$ing}}) {
      my $act = $self->Barcodes->{$ing2}->{Name};
      # now here is where we get nutrition information
      print "\tBrcd:\t$ing2\n";
      print "\tName:\t$act\n";
      my $nut = $self->GetNutritionValue(Ingredient => $act);
      if (scalar keys %$nut) {
	print "\tNutVl:\t$nut->{nutr_val}\n";
	# print Dumper($nut);
      }
    }
  }
}

sub LookupRecipe {
  my ($self,%args) = @_;
  # foreach my $r ($self->Recipes->SelectSubsetByValue) {
  foreach my $r
    (SubsetSelect
     (Set => [sort keys %{$self->Recipes}],
      Selection => {})) {
    print Dumper($self->Recipes->{$r});
  }
}

sub ChooseMeal {
  my ($self,%args) = @_;
  # We want to be able to display/select meals for each person

}

1;

