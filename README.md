# linguatool
A Perl script for language identification encapsulatiing Lingua::Identify

## Usage
```
usage: Linguatool [--help|-h] [--sort|-s] [--stats|-p] [--results|-r]

[--verbose|-v] [--dir|-d] [--file|-f] [--output|-o]

A small language-recognition script encapsulatiing Lingua

optional named arguments:

  --help, -h               ? show this help message and exit
  
  --sort, -s               ? Sort the files
  
  --stats, -p              ? Get language statistics
  
  --results, -r RESULTS    ? Write the results in a file
  
  --verbose, -v            ? Print all the results
  
  --dir, -d DIR            ? Use a directory as input
  
  --file, -f FILE          ? Use a single file as input
  
  --output, -o OUTPUT      ? Where to output sorted files
```

## Dependencies
- Lingua::identify : https://metacpan.org/pod/Lingua::Identify
- Path::Class : https://metacpan.org/pod/Path::Class
- Getopt::ArgParse : https://metacpan.org/pod/Getopt::ArgParse

# LICENSE
Copyright (C) 2018, Cyprien Ruffino

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, pulverize, distribute, synergize, compost, defenestrate, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice should (might ?) be included in all copies or substantial portions of the Software.

If the Author of the Software (the "Author") needs a place to crash and you have a sofa available, you should maybe give the Author a break and let him sleep on your couch.

If you are caught in a dire situation wherein you only have enough time to save one person out of a group, and the Author is a member of that group, you must save the Author.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO BLAH BLAH BLAH ISN'T IT FUNNY HOW UPPER-CASE MAKES IT SOUND LIKE THE LICENSE IS ANGRY AND SHOUTING AT YOU.
