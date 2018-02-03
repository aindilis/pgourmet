package PGourmet::Inventory::Item;

use strict;
use Carp;

use vars qw/ $VERSION /;
$VERSION = '1.00';
use Class::MethodMaker
  new_with_init => 'new',
  get_set       => [ qw / Barcode Size Desc / ];

sub init {
  my ($self,%args) = (shift,@_);
  $self->Barcode($args{Barcode});
  $self->Size($args{Size});
  $self->Desc($args{Desc});
}

1;
