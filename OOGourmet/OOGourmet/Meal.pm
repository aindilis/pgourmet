package OOGourmet::Meal;

use Data::Dumper;

use Class::MethodMaker new_with_init => 'new',
  get_set =>
  [

   qw / Date Rating Recipe /

  ];

sub init {
  my ($self,%args) = @_;
  $self->Date($args{Date});
  $self->Rating($args{Rating});
  $self->Recipe($args{Recipe});
}

1;
