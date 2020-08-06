use strict;
use warnings;
use File::Find::Rule;
use File::Basename qw/basename dirname fileparse/;
use Data::Dumper;
use utf8;


binmode STDIN,  ':encoding(cp932)';
binmode STDOUT, ':encoding(cp932)';
binmode STDERR, ':encoding(cp932)';

print "Folder: ";
chomp(my $dir = <STDIN>);
$dir =~ s{^"}{};
$dir =~ s{"$}{};
chdir "$dir";

my @sdlxliffs = File::Find::Rule->file->name('*.sdlxliff')->in($dir);
find( \&xmllint, $dir );

print "\nComplete!\n";


sub xmllint {
	for ( @sdlxliffs ) {
		my ($basename, $dirname) = fileparse $_;
		my $fullpath = $dirname.$basename;
		print "Processing...: $fullpath"."\n";
		chdir $dirname;
		my $cmd = "xmllint --format $basename --output $basename"; # File overwrite
		system(`$cmd`);
	}
}
