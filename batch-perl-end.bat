@goto runperl
#!perl
print "Hello world from Perl!\n";

my $i = 1;
foreach my $arg(@ARGV) {
	print "Argument #$i: $arg\n";
	$i++;
}

__END__
:runperl

:: 
:: The Batchography book by Elias Bachaalany
::

@perl -x "%~f0" %*