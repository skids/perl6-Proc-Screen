use v6;
use lib <blib/lib lib>;
use Test;

# If we are run directly by testing, pass.
unless +@*ARGS {
  plan 1;
  is 1, 1, "Indirect test file args.t parses";
  exit;
}

# Echo the commandline arguments and then remain running

say @*ARGS.join(" ");

loop {
  sleep 60;
}
