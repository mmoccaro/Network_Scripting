#!/usr/bin/env perl 

#  File: Firmware_Version_Finder.pl
#  Type: Perl Source File 
#  Date: March 4, 2017 
# 
#  Description: 
#  THis file logs into a network device via SSH and print the firmware
#   version to the screen.

#Pragmas
use Net::SSH::Expect;

#Create an SSH session
my $ssh = Net::SSH::Expect->new (
    host => "10.0.0.17", 
    user => 'user',
    password=> 'user_password',  
    raw_pty => 1,
    no_terminal => 0
);

#Login
my $login_output = $ssh->login();

#Change Modes
my $command = $ssh->exec("en");

#Enter a password
$ssh->waitfor("Password:", 1);
$ssh->send("secret_password");

#Run this command to receive clean output
$command = $ssh->exec("terminal length 0");

#Run the version command and
#display the output.
$command = $ssh->exec("sh ver");
print "$command\n";

#Close the connection
$ssh->close();
