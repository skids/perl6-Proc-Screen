use v6;
use lib <blib/lib lib>;
use File::Temp;

use Test;
if run "screen", "-ls", :out {
  plan 8;
}
else {
  plan 1;
  ok 1, "Skipping tests since 'screen' not installed or not in path";
  exit;
}

use Proc::Screen;
ok 1, "Used Proc::Screen and lived";
my $s;
lives-ok { $s = Proc::Screen.new }, "Instantiated a Proc::Screen and lived";
isa-ok $s, Proc::Screen, "...and actually got one." ;
lives-ok { $s.start }, "Ran screen -d -m";
lives-ok { $s.await-ready }, "screen -d -m completed and PID delivered";
isa-ok $s.command(|<register . OHAI>), Promise, "screen -X ran";
my ($fn, $fh) = |tempfile;
$s.command("writebuf", $fn);
$s.await-ready;
is $fh.slurp-rest, "OHAI", "Verified .command method is working";
lives-ok {$s.DESTROY}, "Can DESTROY by hand";
