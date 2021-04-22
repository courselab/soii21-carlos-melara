# SYSeg - System Software by Example

SYSeg is a collection of source code examples and programming exercises intended as a companion 
resource to illustrate general concepts and techniques of system software design and development.

## Quick start

Some examples need auxiliary artifacts which must be built beforehand.

 If you have obtained the project source from the __version control repository__,

 i.e. you've cloned the project from its official Git repository, execute the script 

 ```
 $ ./bootsrap.sh
 ```

to boostrap the build configuration script `configure`. To that end, you'll 
need to have GNU Build System (Autotools) installed. In Debian/Ubuntu based 
platforms,  you may install required software with

```
$ sudo apt install automake autoconf
```

On the other hand, if you have obtained the software form a __distribution 
repository__, usually as a tarball, you should already have the  script `configure`
and therefore may skip the previous step.

Either way, locate the file in the root of source directory and execute it

```
 $ ./configure
```

This script shall perform a series of tests to collect data about the build 
platform. If it complains about missing pieces of software, install them 
as needed and rerun `configure`.

Finally, build the software with

```
 $ make
 ```

**Note** that, as mentioned, this procedure is intended to build the auxiliary tools.
The examples and programming exercises themselves will not be built as result.
To that end, one need to acess the directories containing the respective source
code and follow the instructions indicated in the README file.

For more detailed instructions, please, refer to file `INSTALL`

## Overview

SYSeg contents. Please, refer to the README file in each directory for 
detailed information.

- Directory `eg` contains source code examples.
- Directory `try` contains programming exercises.
- Directory `tools` contains auxiliary tools used by examples and exercises.

Each subdirectory contains a README file with detailed information about its
contents and specific instructions on how to proceed.  **Tip**: if the file name
reads README, please, do as it advices.



  ACKNOWLEDGMENTS
  ---------------

  It is both a moral obligation and a personal pleasure to acknowledge and
  express the due gratitude to my colleague and friend Dr. Renê Souza Pinto
  for his wise advisory and tireless support. If it were not for Renê's 
  enviable technical skills and generosity to promptly share his knowledge,
  as well as his resolute willing to dig into obscure hardware and software
  issues I keep on presenting him, I would likely be stuck in some endless
  Stackoverflow wild quest, struggling with arcane code puzzles.
