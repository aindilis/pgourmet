package PGourmet::Inventory;

use PGourmet::Inventory::Item;
use Manager::Dialog qw ( Message Choose Approve QueryUser );
use PerlLib::Collection;

use Data::Dumper;
use File::Temp qw/ mktemp /;
use IO::Select;
use PerlLib::Hash;
use Text::CSV_XS;

use Class::MethodMaker
  new_with_init => 'new',
  get_set       => [ qw / ItemFile MyInventory DB Client Clientin / ];

sub init {
  my ($self, %args) = (shift,@_);
  $self->ItemFile($args{ItemFile} || mktemp("/tmp/XXXXXXX.inv"));

  $self->Client(STDOUT);
  $self->Clientin(STDIN);
  $self->ConfigureScanner;

  $self->MyInventory
    (PerlLib::Collection->new
     (Type => "GourmetJr::Inventory::Item",
      StorageFile => $self->ItemFile));

  $self->LoadDB;
  # print Dumper($self->MyInventory);
  $self->Load;
}

sub LoadDB {
  my ($self, %args) = (shift,@_);
  Message(Message => "Loading DB...");
  $csv = Text::CSV_XS->new();
  my $hash = {};
  foreach my $line (split /\n/,`cat data/items.csv`) {
    $status = $csv->parse($line);
    my @columns = $csv->fields();
    my $item = shift @columns;
    $hash->{$item} = \@columns;
  }
  $self->DB($hash);
}

sub Save {
  my ($self, %args) = (shift,@_);
  $self->MyInventory->Save;
  foreach my $cb ($self->MyInventory->Values) {
    $cb->Save;
  }
}

sub Load {
  my ($self, %args) = (shift,@_);
  Message(Message => "Loading inventory...");
  $self->MyInventory->Load;
}

sub AddItem {
  my ($self, %args) = (shift,@_);
  $self->MyInventory->Add($args{Item}->Name => $args{Item});
}

sub SubtractItem {
  my ($self, %args) = (shift,@_);
  $self->MyInventory->Subtract($self->MyInventory->SelectSubsetByKeyValue());
}

sub ListInventory {
  my ($self, %args) = (shift,@_);
  return $self->MyInventory->Values;
}

sub EditInventory {
  my ($self, %args) = (shift,@_);
  my $key = Choose("New",$self->MyInventory->Keys);
  if ($key eq "New") {
    $self->NewItem;
  } elsif (defined $key && exists $self->MyInventory->Contents->{$key}) {
    $self->MyInventory->Contents->{$key}->Edit;
  } else {
    Message (Message => "No MyInventory Exist");
    $self->NewItem;
  }
  # print Dumper($self->MyInventory);
}

sub NewItem {
  my ($self, %args) = (shift,@_);
  my $response;
  my %values;

  # here is the basic mode
  # print a message saying you can either scan an item or enter its name
  # determine whether the response is a barcode

  # if its a barcode, search for  it, if its not found, beep, and tell
  # the user they should add it  to the DB (could even have the option
  # to photograph it here)

  # if it is found, add that item to the DB

  # if its not  a barcode, simply create a new item  with a barcode of
  # -1 and add that to the db

#   while (1) {
#     my $i = $self->MyInventory->ReadFromPrompt();
#     chomp $i;
#     if (exists $self->MyInventory->DB->{$i}) {
#       print "Yeah\n";
#       print Dumper($self->MyInventory->DB->{$i});
#     }
#   }



  do {
    $response = Approve("Create a New Item? ");
    if ($response) {
      %values = ();
      foreach my $field (qw (Barcode Desc)) {
	#$values{$field} = QueryUser($field);
	print "<$field>: ";
	$values{$field} = <STDIN>;
	chomp $values{$field}
      }
      PrintHash(\%values);
    }
  } while ($response && !Approve("Is this correct? "));
  if ($response) {
    my $cb = GourmetJr::Inventory::Item->new(%values);
    $self->MyInventory->Add($cb->Barcode => $cb);
  }
}

sub ConfigureScanner {
  my ($self, %args) = (shift,@_);
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
  my ($self, %args) = (shift,@_);
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

1;
