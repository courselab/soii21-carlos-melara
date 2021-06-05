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

    You may get rid of built in commands if you run out of space.

 Directions
 ------------------------------

 Under your project tree, create a directory mbr.

 Copy the files

     main.c
     tos.c
     tos.h
     rt0.c

 
