#!/usr/bin/env perl 

#  File: reload.pl
#  Type: Perl Source File 
#  Date: March 4, 2017 
# 
#  Description: 
#  THis file logs into a network device via SSH and reloads it.

#Pragmas
use Net::SSH::Expect;
use Term::ANSIColor;

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

#Run the reload command
$command = $ssh->exec("reload");

#In case you are asked to save your configuration
if($command =~ m/\[yes\/no\]/)
{
	print "Save Configuration? [yes/no]: ";
	chomp(my $response = <STDIN>);

	#Save The Configuration
	if($response eq "yes")
	{
		$command = $ssh->send("yes");
		$ssh->waitfor('Proceed with reload? [confirm]', 30);
	}
	else
	{
		$command = $ssh->exec("no");
	}
	$command = $ssh->exec("\n");
}
elsif($command =~ m/\[confirm\]/)
{
	$command = $ssh->exec("\n");
	print("$command\n");
}

# closes the ssh connection
$ssh->close();
