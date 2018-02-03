#!/usr/bin/perl -w

use UniLang::Agent::Agent;
use UniLang::Util::Message;

use Data::Dumper;

my $agent = UniLang::Agent::Agent->new
  (Name => $name || "test-agent",
   ReceiveHandler => \&Receive);

$agent->DoNotDaemonize(1);
$agent->Register
  (Host => "localhost",
   Port => "9000");

#   print $agent->QueryAgent
#     (Receiver => "PGourmet",
#      Contents => "\$UNIVERSAL::pgourmet->PrintFuckOff()");

print Dumper($agent->QueryAgent
  (Receiver => "PGourmet",
   Contents => "\$UNIVERSAL::pgourmet->PrintFuckOff()").">\n");

sleep 1;

# print "<".$agent->GetResults.">\n";
$agent->Deregister;
