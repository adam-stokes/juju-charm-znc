#!/usr/bin/env perl
BEGIN {
    system "cpanm -n IO::Socket::IP";
}

use charm -tester;

use IO::Socket::IP;

diag("install hook tests");

ok(path('/etc/systemd/system/znc.service')->exists, 'ZNC systemd service file exists');
ok(path('/home/ubuntu/.znc/configs/znc.conf')->exists, 'ZNC user config exists');

run 'systemctl status znc.service';
ok($? == 0, 'ZNC service is running.');

my $znc_port = config 'port';
my $socket = IO::Socket::IP->new(PeerAddr => 'localhost', PeerPort => $znc_port);
ok(defined $socket && ref $socket eq 'IO::Socket::IP', "ZNC is listening on $znc_port");

done_testing();
