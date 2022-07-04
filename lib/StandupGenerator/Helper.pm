package StandupGenerator::Helper;

use base 'Exporter';

our @EXPORT = qw( 
    find_last_file
    extract_identifiers
);

# Determine last file in a directory after sorting them alphabetically
sub find_last_file {
    my ($path) = @_;
    opendir my $dir, $path;
    my @files = readdir $dir;
    closedir $dir;
    my @sorted = sort @files;
    my $files_length = scalar(@files);
    my $last_file = $sorted[$files_length - 1];

    if (index($last_file, '.txt') == -1) {
        # When no .txt files exist in the directory, assume standups need to be initialized, so set the last file as a dummy
        $last_file = 's0d0.txt';
    }

    return $last_file;
}

# Get sprint and day numbers for a standup given its file name
sub extract_identifiers {
    my ($file) = @_;
    my $file_size = length($file) - 4;
    my $file_d_index = index($file, 'd');
    my $file_sprint = substr($file, 1, $file_d_index - 1);
    my $file_day = substr($file, $file_size - 1, 1);
    
    my %identifiers = (
        sprint => $file_sprint,
        day => $file_day,
    );

    return %identifiers;
}

1;