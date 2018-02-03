#!/usr/bin/perl -w

# this is a  program for browsing and selecting  recipes that the user
# would  like   to  eat.    it  incorporates  alot   of  functionality
# eventually, but  for now its goal  is to aid  in generating shopping
# lists, maybe I should write it in perl/tk?

# load the recipes

sub LoadSharedPreferenceModel {

}

sub BootStrapPreferenceModel {

}

sub SelectUser {

}

sub LoadPreferenceModelForUser {

 }

sub LoadRecipeIndex {

}

sub GenerateRecipeIndex {
  # this is  an index, which  contains a compressed  representation of
  # recipes and their ingredients and instructions
  my $rd = "/var/lib/myfrdcsa/codebases/internal/gourmet/data/recipes/some";
  foreach my $f (split /\n/,`ls $rd`) {
    $recipes->{$f} = $f;
  }
}

# should we load all the information, or perhaps an index

sub SelectRecipes {
  # this will include the ability to select recipes
}

sub PrintShoppingList {
  my $OUT;
  open(OUT,">$rf") and print OUT $c and close(OUT);
  my $c = "print.pl $rf";
  system $c;
}

sub CalculateCost {

}

sub OptimizeListForCost {

}
