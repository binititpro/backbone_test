use strict;
use warnings;
use diagnostics;
use feature qw(switch);
use Cwd;
use v5.10; # earliest occurance of feature 
#no warnings 'experimental::smartmatch'; 

my $classpath="";
my $driver="";
my $env_url="";
my $changeLogFile="";

our ($env, $username, $password, $action, $rollbackcount ) = @ARGV;


my $pwd = cwd();


#sub readProperties {
	


#print " Current directory $pwd";
	


my $filename = "$pwd\\build.properties";

open(my $fh, '<:encoding(UTF-8)', $filename)
  or die "Could not open file '$filename' $!";
 
our  @rows = <$fh>;

chomp @rows;


foreach my $row (@rows) {

	if($row =~ m/^classpath/)

	{
		
	my @value=split('=', $row);
   #print "$rows[0]\n";
   
    $classpath = $value[1];
   
  # push @listarg, $classpath;
   
	print "classpath=$classpath\n";

	}

elsif($row =~ m/^$env+_url/) {
			
	my @value=split('=', $row, 2);
	   #print "$rows[0]\n";
	   
	$env_url = $value[1];
	   
		   
	   print "Url=$env_url\n";
	   
	#push @listarg, $ENV_url;   
	}

elsif($row =~ m/^driver/) {
			
my @value=split('=', $row);
	   #print "$rows[0]\n";
	   
	$driver = $value[1];
	   
	 print "driver=$driver\n";
	#push @listarg, $driver;
}

elsif($row =~ m/^changeLogFile/) {
			
	my @value=split('=', $row);
	   #print "$rows[0]\n";
	   
	$changeLogFile = $value[1];
	   
	  print "changeLogFile=$changeLogFile\n";
	#$value[1]push @listarg, $changeLogFile;
}
# elsif($row =~ m/^$ENV+_username/)

	# {
			
	# @value=split('=', $row);
	   # #print "$rows[0]\n";
	   
	  # $username = $value[1];
	   
	   # print "user=$username\n";
	   
# }

# elsif($row =~ m/^$ENV+_password/)

	# {
			
	# @value=split('=', $row);
	   # #print "$rows[0]\n";
	   
	  # $password = $value[1];
	   
	   # print "Password=$password\n";
	   
# }



 }   
#my $result = `liquibase --classpath=$classpath --driver=$driver --url="$ENV_url" --changeLogFile=$changeLogFile --username=$username --password=$password update `;



#readProperties();


sub readArgument {
		
#my ($env, $username, $password, $action) =  @ARGV;
	

if (not defined $env && $username && $password && $action) 
#if (not defined @ARGV) 

	{
		die "Need ENV, username and password as argument\n";
	}
 
if (defined $env && $username && $password && $action) 

	{
		print "Save Username ='$username' and Password= '*********'\n";
  
		print "Execute Liquibase using '$username'\n";
  
  #exit;
	}
 


}

sub doCheckSystemCommand {

    my $systemCommand = $_[0];
	
	#my $systemCommand = "liquibase --classpath=$classpath --driver=$driver --url=\"$env_url\" --changeLogFile=$changeLogFile --username=$username --password=$password $actionCommand ";

    #print LOG "$0: Executing [$systemCommand] \n";
    my $returnCode = system( $systemCommand );


	if ( $returnCode == 0 ) { 
	
	print "Liquibase command successfully executed with return code $returnCode";
	exit 0;
	}
	else{
        die "Failed executing [$systemCommand] with return code $returnCode\n"; 
    }
}

sub doExe {

	 
	if ($env eq "dev" && $action eq "update")
	
	{
		
	my $systemCommand = "liquibase --classpath=$classpath --driver=$driver --url=\"$env_url\" --changeLogFile=$changeLogFile --username=$username --password=$password update ";
	
		
	#$result = system("cmd /c 'dir' > null");

	&doCheckSystemCommand($systemCommand);

	
	}

	elsif ($env eq "dev" && $action eq "rollbackcount")
	{

	#&doCheckSystemCommand("rollbackcount");
	my $systemCommand = "liquibase --classpath=$classpath --driver=$driver --url=\"$env_url\" --changeLogFile=$changeLogFile --username=$username --password=$password $action $rollbackcount ";
	
	&doCheckSystemCommand($systemCommand);
	}

	if ($env eq "qa" && $action eq "update")
		
	{
			
	my $systemCommand = "liquibase --classpath=$classpath --driver=$driver --url=\"$env_url\" --changeLogFile=$changeLogFile --username=$username --password=$password update ";
	
		
	#$result = system("cmd /c 'dir' > null");

	&doCheckSystemCommand($systemCommand);
		
	} 
	
	elsif ($env eq "qa" && $action eq "rollbackcount")
		{

	#&doCheckSystemCommand("rollbackcount");
	my $systemCommand = "liquibase --classpath=$classpath --driver=$driver --url=\"$env_url\" --changeLogFile=$changeLogFile --username=$username --password=$password $action $rollbackcount ";
	
	&doCheckSystemCommand($systemCommand);
	}
	
	if ($env eq "uat" && $action eq "update")
	
	{
		
	my $systemCommand = "liquibase --classpath=$classpath --driver=$driver --url=\"$env_url\" --changeLogFile=$changeLogFile --username=$username --password=$password update ";
	
		
	#$result = system("cmd /c 'dir' > null")
	
	&doCheckSystemCommand($systemCommand);
	
	}

	elsif ($env eq "uat" && $action eq "rollbackcount")
		{

		
	#&doCheckSystemCommand("rollbackcount");
	my $systemCommand = "liquibase --classpath=$classpath --driver=$driver --url=\"$env_url\" --changeLogFile=$changeLogFile --username=$username --password=$password $action $rollbackcount ";
	
	&doCheckSystemCommand($systemCommand);
	}

else {
    print "Please provide correct action\n";
}
}


sub doAction {

		
given(@ARGV) {
   
#readArgument();  
#readProperties();

 	
when ($_ eq "dev") { 
  
 
    #my $result = `liquibase --classpath=sqljdbc.jar --driver=com.microsoft.sqlserver.jdbc.SQLServerDriver --url="jdbc:sqlserver://localhost:1433;databaseName=test" --changeLogFile=DatabaseChangelog.sql --username=binit --password=opelin123 update `;
     #$result = `liquibase --classpath=$classpath --driver=$driver --url="$env_url" --changeLogFile=$changeLogFile --username=$username --password=$password update `;
     #system ("liquibase --classpath=$classpath --driver=$driver --url="$env_url" --changeLogFile=$changeLogFile --username=$username --password=$password update");
    # print "--classpath=$classpath --driver=$driver --url="$ENV_url" --changeLogFile=$changeLogFile --username=$username --password=$password update ";
    	&doExe ();
    	
    	  }
  when ($_ = "qa") { 
  
 
    #my $result = `liquibase --classpath=sqljdbc.jar --driver=com.microsoft.sqlserver.jdbc.SQLServerDriver --url="jdbc:sqlserver://localhost:1433;databaseName=test" --changeLogFile=DatabaseChangelog.sql --username=binit --password=opelin123 update `;
     #$result = `liquibase --classpath=$classpath --driver=$driver --url="$ENV_url" --changeLogFile=$changeLogFile --username=$username --password=$password rollbackcount `;
     #system ("liquibase --classpath=$classpath --driver=$driver --url="$ENV_url" --changeLogFile=$changeLogFile --username=$username --password=$password update");
    # print "--classpath=$classpath --driver=$driver --url="$ENV_url" --changeLogFile=$changeLogFile --username=$username --password=$password update ";
    	&doExe ();
    	
    	  }  	  
    	  
    when($_ = "uat") { 
    	
		&doExe ();
    
    	}
   
    default { 
    	
    	print " Please provide correct env variable " ;
    	
    	 }
}
}


sub main {
  
	&readArgument(); 
	#readProperties();
	&doAction();
	#print "--classpath=$classpath --driver=$driver  --changeLogFile=$changeLogFile --username=$username --password=$password update ";
 }
 
&main();