
read_folder("C:\\Users\\adhir\\source\\repos\\SnakeEditor\\*");

sub read_folder() {
    my @files = glob(@_[0]);

    foreach (@files) {

        if ($_ =~ /^((.)+(\.))+h$/) {
            #print $_ . "\n";
            add_header_guard($_);
        } else {

            if (-d $_){
                my @subfiles = glob($_ . "\\*");

                read_folder($_ . "\\*");
            }
            
        }
    }
}

sub add_header_guard() {
    my $file = @_[0];
    my $file_data = "";

    open(FH, '+<', $file);

    while (<FH>) {
        $file_data .= $_;
    }

    if ($file_data =~ /^((.)*(\s)?(.)*)(#pragma once)((.)*(\s)?(.)*)$/igm) {
        
        print "[CONVERTED] " . $file . "\n";
    } else {
        print "[UNTOUCHED] " . $file . "\n";
    }

    close($file);
}