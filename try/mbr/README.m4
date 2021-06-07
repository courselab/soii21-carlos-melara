include(docm4.m4)
 MbrCmd - Mater Book Record Command interpreter
 ==============================================
DOCM4_DIR_NOTICE

 Overview
 ------------------------------

 MbrCmd is a very simple command line interpreter that fits entirely within
 the 512-byte master boot record of a USB stick. It is meant to be loaded
 through legacy BIOS boot method and execute in real mode on any x86 platform.

 The program interprets a few built in commands.

 Challenge
 ------------------------------

 1) Build and execute MbrCmd under a x86 emulator (e.g. qemu).

 2) Copy the program to a USB stick and boot it with BIOS legacy mode.

 3) Implement a new command exploring other BIOS services.

    You may get rid of built in commands implemented in the example
    code if you run out of space for your own commands.

 Directions
 ------------------------------

 Under this directory, invoke the make rule

   make pack

 This should create a tarball containing the project files.
 Copy it to your own project tree and uncompress the file.

DOCM4_UPDATE_AUTHOR_INFO

DOCM4_CLOSING_WORDS


 APPENDIX A
 ------------------------------
 
 Conveniency rules from Make bintool


DOCM4_MAKE_BINTOOLS_DOC
