# advib
Auomated Dump via ImgBurn: Batch file(s) for mass ripping of optical media
(CD and DVD)

Version: Alpha 1
The initial release of ADvIB.

Requirements:
- ImgBurn: You can install the program or use the portable one. You can even
create a symbolic link for the exe in the same directory as advib.cmd. As of
this initial "Alpha 1" release, advib wants the exe in the same directory.
- The directory structure it expects (like an already existing PS2 folder).

Optional:
- fciv: a command line utility available free from Microsoft.

Notes: This has only been tested on Windows 10 AU, as of September 2016. I have
no reason to think it wouldn't work on other versions of (post-XP) windows
however.
For all I know it would work on XP, I don't currently have to test the idea.

This is relatively simply CMD-extended batch file I wrote to help me rip a
large library of console games (PS1 and PS2)
to a hard drive for archival purposes. The only thing it does is use variable
and a one-game-per-line text file to convert
the disc to a bin/cue or ISO file, depending on the type.

It is currently in a usable state but without any of the "niceties" of a
normal, user-friendly utility (like running it with
no parameters giving you a help paragraph on how to use it or double-checking
to make sure ImgBurn.exe exists).

The current plan is to add the niceties and as well as further features such
as a config file to save settings. I would also like
re-write the whole thing as an HTA in HTML/JScript (and since I want learn
  PowerShell maybe that too).

Though at this stage this repository is just here for me to track the file while
work on it, I will document some of the behaviors should anybody else want to
use it for some reason:
- the input is a text file of game names: this is the name that will be used
for bin/cue and ISO files.
- THE NAMES IN THE TEXT FILE CANNOT CONTAIN SPACES. Escaping quotes is hard.
I'm working on it (or it will have to wait for the re-write).
- There is currently no input validation for the parameters sent to the program.
This means if you put mix the order of the drive letter and the text file or
leave out a parameters entirely it will not stop and exit gracefully but try
to run...unsuccessfully...
- The program does not check for the existance of the most required exe:
imgburn.exe. I have been creating a symbolic link manually to be in the same
directory as advib.cmd using the "mklink" command (it's already in windows)
- I have started to implement a plan to collect SHA1 checksum calculations as
the mass image dumping went along using the Microsoft command line utility
FCIV - this you have to download separately and copy to a location some where
along your PATH (like c:\windows)
- advib does not stop and ask for a location or create a missing folder if there
isn't one, it will simply error out. For instance if you specify PS2 as the
parameter,
it will look for a "PS2" folder. If it doesn't find this folder it just keeps
going.
