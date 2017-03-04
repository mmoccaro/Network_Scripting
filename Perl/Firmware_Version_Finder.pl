#!/usr/bin/env perl 

use Net::SSH::Expect;

my $ssh = Net::SSH::Expect->new (
    host => "127.0.0.1", 
    user => 'user',
    password=> 'user_password',  
    raw_pty => 1,
    no_terminal => 0
);

my $login_info = $ssh->login();
print "Login output: $login_info\n";

my $command = $ssh->exec("en");
print("$command\n");

$ssh->waitfor("Password:", 1);
$ssh->send("secret_password");	

$command = $ssh->exec("terminal length 0");
print("$command\n");

$command = $ssh->exec("sh ver");
print("$command\n");

$ssh->close();
