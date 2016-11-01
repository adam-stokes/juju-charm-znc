#!/usr/bin/env perl

use charm -tester;

run 'systemctl status znc.service';
ok($? == 0, 'ZNC service is running.');

done_testing();
