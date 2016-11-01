#!/usr/bin/env perl

use charm -tester;

run 'systemctl status znc.service';
ok($? >= 1, 'ZNC service is stopped.');

done_testing();
