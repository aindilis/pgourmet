package PGourmet::Nut;

use Data::Dumper;

use Class::MethodMaker new_with_init => 'new',
  get_set =>
  [

   qw  / LongDesc /

  ];

sub init {
  my ($self,%args) = (shift,@_);
  $self->LongDesc($args{LongDesc});
}

1;
