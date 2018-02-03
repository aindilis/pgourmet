package PGourmet::Nut;

use Data::Dumper;

use Class::MethodMaker new_with_init => 'new',
  get_set =>
  [

   qw  / NDB_No FdGrp_Cd Long_Desc Shrt_Desc /

  ];

sub init {
  my ($self,%args) = (shift,@_);

  # 5-digit Nutrient Databank number that uniquely identifies a food item
  $self->NDB_No($args{NDB_No});

  # 4-digit code indicating food group to which a food item belongs
  FdGrp_Cd;

  # 200-character description of food item
  Long_Desc;

  # 60-character abbreviated description  of food item. Generated from
  # the  200-character  description  using abbreviations  in  appendix
  # A. If short description  was longer than 60 characters, additional
  # abbreviations were made.
  Shrt_Desc;

  # Other names  commonly used to  describe a food, for  example, "hot
  # dog" for "frankfurter"
  

  # Manufacturer's name for brand name foods

  # Item used in the Survey Nutrient Database (SNDB)

  # Description of inedible parts of a food item (refuse), such as seeds or bone

  # Percentage of refuse

  # Scientific name of the food item. Given for the least processed form of the food (usually raw), if applicable

  # Factor for converting nitrogen to protein

  # Factor for calculating calories from protein

  # Factor for calculating calories from fat

  # Factor for calculating calories from carbohydrate
}

1;
