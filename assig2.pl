use DBI;
use Switch;
$count=0;
$count1=0;
$dbh = DBI->connect( "dbi:ODBC:thamizl") || die "Cannot connect:     $DBI::errstr";
print "Enter your email id :";
$email=<>;
chomp($email);
print "Enter your password :";
$pwd=<>;
chomp($pwd);
my $sth = $dbh->prepare("select PASSWORD from users where email=? ");
$sth->execute($email) or die $DBI::errstr;
while (my @row = $sth->fetchrow_array()) {
   my ($pass)=@row;
   if ($pwd eq $pass) {
   	print "1.View Inbox\n";
	print "2.View sent mail\n";
	print "3.Compose New Mail\n";
	print "4.Search Inbox\n";
	print "5.Search Subject\n";
	print "6.Group Mail\n";
	print "Enter your choice :";
	$choice=<>;
	chomp($choice);
	shdvsvh
}else
{
	print "Wrong password";
}

}
switch($choice){
	case 1 { inbox();}
	case 2 { sentmail();}
   	case 3 { compose();}
   	case 4 { search();}
   	case 5 { search_sub();}
   	case 6 { groupmail();}
}
sub inbox{
	$dbh = DBI->connect( "dbi:ODBC:thamizl") || die "Cannot connect:     $DBI::errstr";
	my $sth = $dbh->prepare("select body from mails where to_id=? "); 
		$sth->execute($email) or die $DBI::errstr;
		while (my @row = $sth->fetchrow_array()) {
   		my ($inbox)=@row;
   		print $inbox;
   		print "\n";
   		print "***************************************";
   		print "\n";
   	}
}
sub sentmail{
	$dbh = DBI->connect( "dbi:ODBC:thamizl") || die "Cannot connect:     $DBI::errstr";
	my $sth = $dbh->prepare("select body from mails where from_id=? "); 
		$sth->execute($email) or die $DBI::errstr;
		while (my @row = $sth->fetchrow_array()) {
   		my ($sentmail)=@row;
   		print $sentmail;
   		print "\n";
   		print "***************************************";
   		print "\n";
   	}
}
sub compose{
	$dbh = DBI->connect( "dbi:ODBC:thamizl") || die "Cannot connect:     $DBI::errstr";
	print "Compose Mail\n";
   		print "To :";
   		$to=<>;
   		chomp($to);
   		print "Subject :";
   		$sub=<>;
   		chomp($sub);
   		print "Body :";
   		$body=<>;
   		chomp($body);
   		my $sth = $dbh->prepare("insert into mails(from_id,to_id,subject,body) values(?,?,?,?) "); 
		$sth->execute($email,$to,$sub,$body) or die $DBI::errstr;
		print "Send successfully";
}
sub search{
	$dbh = DBI->connect( "dbi:ODBC:thamizl") || die "Cannot connect:     $DBI::errstr";
	print "Enter keyword to search for mail :";
   		$search=<>;
   		chomp($search);
   		my $sth = $dbh->prepare("select body from mails where to_id=? "); 
   		$sth->execute($email) or die $DBI::errstr;
		while (my @row = $sth->fetchrow_array()) {
   		my ($msg)=@row;  	
   		if ($msg =~ m/$search/is){
   			print $msg;
   			print "\n";
   			print "***************************************";
   		print "\n";
   		}
   		}   	
}

sub search_sub{
	$dbh = DBI->connect( "dbi:ODBC:thamizl") || die "Cannot connect:     $DBI::errstr";
my $sth = $dbh->prepare("SELECT subject from mails where to_id=? ;");
$sth->execute($email) or die $DBI::errstr;
print "Enter the keyword to search in subject :";
$search=<>;
chomp($search);
while (my @row = $sth->fetchrow_array()) {
   my ($subject) = @row;
   if($subject=~m/($search)$/is){
   	print $subject;
   	print "\n";
   }
}

sub groupmail{
	$dbh = DBI->connect( "dbi:ODBC:thamizl") || die "Cannot connect:     $DBI::errstr";
print "Enter group mail id :";
$group=<>;
chomp($group);
print "subject :";
$subject=<>;
chomp($subject);
print "Body :";
$body=<>;
chomp($body);
my $sth = $dbh->prepare("SELECT email from groups where group_name=? ;");
$sth->execute($group) or die $DBI::errstr;
while (my @row = $sth->fetchrow_array()) {
   my ($members)=@row;
   my $sth = $dbh->prepare("insert into mails(from_id,to_id,subject,body) values(?,?,?,?) ;");
   $sth->execute($group,$members,$subject,$body) or die $DBI::errstr;
}
print "Mail sent successfully";
}
}
$sth->finish();
