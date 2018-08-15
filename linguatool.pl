#!/usr/bin/perl
use Lingua::Identify qw/langof/;
use Path::Class;
use warnings;
use Getopt::ArgParse;

sub parseargs{
  $ap = Getopt::ArgParse->new_parser(
          prog        => 'Linguatool',
          description => 'A small language-recognition script encapsulatiing Lingua',
   );

   $ap->add_arg('--output', '-o', required => 0, dest => 'output'
   , help => 'Where to output sorted files');

   $ap->add_arg('--file', '-f', required => 0, dest => 'file_input'
   , help => 'Use a single file as input');

   $ap->add_arg('--dir', '-d', required => 0, dest => 'dir_input'
   , help => 'Use a directory as input');

   $ap->add_arg('--verbose', '-v', type => 'Bool', dest => 'verbose'
   , help => 'Print all the results');


   $ap->add_arg('--results', '-r', required => 0, dest => 'results'
   , help => 'Write the results in a file');

   $ap->add_arg('--stats', '-p', type => 'Bool', dest => 'stats'
   , help => 'Get language statistics');

   $ap->add_arg('--sort', '-s', type => 'Bool', dest => 'sort'
   , help => 'Sort the files');


   $args = $ap->parse_args();

   return $args;
}

sub sort_files{
  my ($dir, $out) = @_;
  chomp $dir;

  if (not -e $dir){
    print "\n$dir doesn't exists\n";
    exit;
  }

  if (not -d $dir){
    print "\n$dir is a file\n";
    exit;
  }

  if (not -e $out){
    mkdir $out,0755;
  }

  if (not -d $out){
    print "\n$out is a file\n";
    exit;
  }

  $dh=dir($dir) or die $!;
  if($args->verbose){ print "Reading from $dir\n";}

  for my $file ($dh->children){
    next if $file->is_dir();
    next if not(index($file, ".txt") != -1);
    if($args->verbose){ print "${file} : ";}

    my $text = "";
    open(my $fh, '<:encoding(UTF-8)', $file);
    while (my $row = <$fh>) {
      $text = join $text, $row, "\n"
    }

    my $language = langof($text);
    my $outdir = "$out/$language";

    if(-e $outdir  and (not -d $outdir)) {
      my $tmp = file($outdir);
      $tmp->remove();

    }

    if(not(-e $outdir)) {
      mkdir $outdir,0755;
    }
    my $file_name = ( split m{/}, $file )[-1];
    my $target = dir($outdir);
    my $newfile = $target->file($file_name);
    $file->copy_to($newfile);

    if($args->verbose){ print "$language\n";}
  }
}

sub get_stats_from_file{
  my ($file) = @_;
  if (-d $file){
    print "\n$file is a directory\n";
    return;
  }

  if (not -e $file){
    print "\n$file doesn't exists\n";
    return;
  }

  open(my $fh, '<:encoding(UTF-8)', $file);

  my $text = "";
  while (my $row = <$fh>) {
    $text = join $text, $row, "\n"
  }

  return langof($text);
}

$args = parseargs();
eval{
  if((not $args->sort) and (not $args->stats)){
    die "";
  }

  #Sort files
  if($args->sort){
    if($args->dir_input){
      if($args->output){
        sort_files($args->dir_input, $args->output);
      }
      else{ die "";};
    }
    else{die "";};
  }

  #Get stats
  #  if($args->verbose){print "${file} : ";}

  if($args->stats){

    # Get stats from every file in a directory
    if($args->dir_input){
      my $dir = $args->dir_input;
      chomp $dir;

      if (not -e $dir){
        print "\n$dir doesn't exists\n";
        exit;
      }

      if (not -d $dir){
        print "\n$dir is a file\n";
        exit;
      }

      $dh=dir($dir) or die $!;

      if($args->verbose){ print "Reading from $dir\n";}

      for my $file ($dh->children){
        next if $file->is_dir();
        next if not(index($file, ".txt") != -1);

        my @language = get_stats_from_file($file);

        # Write the stats in an output directory
        if($args->output){
          my $out=$args->output;

          if (not -e $out){
            mkdir $out,0755;
          }
          my $mout = "$out/stats";
          if (not -e $mout){
            mkdir $mout ,0755;
          }


          my $output= ( split m{/}, $file )[-1];
          my $target = dir($mout);
          my $newfile = $target->file("$output.stat");
          open(my $foutput, '>', $newfile);
          print $foutput "$output\n";
          foreach my $k (@language) {
            print $foutput "$k\n";
          }
          close $foutput;
        }

        # Write the stats in an output file
        if($args->results){
          open(my $foutput, '>>', $args->results);
          my $file_name = ( split m{/}, $file )[-1];
          print $foutput "$file_name\n";
          foreach my $k (@language) {
            print $foutput "$k\n";
          }
          print $foutput "\n";
          close $foutput;
        }
        # Print the stats in an output file
        if($args->verbose){
          my $file_name = ( split m{/}, $file )[-1];
          print "$file_name\n";
          foreach my $k (@language) {
            print "$k\n";
          }
          print "\n"
        }
      }
    }

    if($args->file_input){
      @language = get_stats_from_file($args->file_input);
      my $file = ( split m{/}, $args->file_input )[-1];
      if($args->results){
        open(my $foutput, '>', $args->results);
        print $foutput "$file\n";
        foreach my $k (@language) {
          print $foutput "$k\n";
        }
      }
      if($args->verbose){
        foreach my $k (@language) {
          print "$k\n";
        }
      }
    }
  }
 };


 if ($@){
   $ap->print_usage();
 }
