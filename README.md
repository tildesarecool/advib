# advib
Auomated Dump via ImgBurn: Batch file(s) for mass ripping of optical media
(CD and DVD)

This batch file should be easily customizable for other uses. DVD movies and
audio CDs, for instance (though obviously something beyond ImgBurn is required
  for breaking DVD encryption/copy protection).

Notes: This has only been tested on Windows 10 AU, as of September 2016. I have
no reason to think it wouldn't work on other versions of (post-XP) Windows
however.
For all I know it would work on XP, I don't currently have to test that.

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

Usage:
advib [gamelist.txt] [drive letter] [console]
Where:
- gamelist.txt is a text file containing game names, one per line. For best results,
do not have spaces in the text file name an do not leave spaces in the game names
in the text file.
- driver letter: the drive letter of the CD/DVD drive advib will be using,
such as D:. It should be possible to run multiple instances of advib in
separately launched CMD windows.
- console: since in my case I'm dumping PS1 and PS2 games, console would be
either PS1 or PS2.

Requirements:
- ImgBurn: You can install the program or use the portable one. You can even
create a symbolic link for the exe in the same directory as advib.cmd. As of
this initial "Alpha 1" release, advib wants the exe in the same directory.
- The directory structure it expects (like an already existing PS2 folder).
Download ImgBurn:
http://www.imgburn.com/index.php?act=download
Tip: install to the normal location and use the mklink command to create a
symbolic link.
Example:
mklink c:\adivb\imgburn.exe "c:\Program Files (x86)\ImgBurn\ImgBurn.exe"
I think of it as "mklink [imaginary] [real]" -- first the one "fake" thing
you're creating, then the actual thing you're "spoofing" for lack of a better
term.

This way everything stays in one place instead of getting scattered about the
file system (deleting this symbolic link will not break anything).

Optional:
- fciv: a command line utility available free from Microsoft.
Download FCIV:
https://support.microsoft.com/en-us/kb/841290
advib simply uses this as a command. You can use it outside of advib...
Tips: Extract the self-extracting exe in place then manually copy it some where
in your "PATH" such as C:\Windows.

Version: Alpha 1 (September 2016)
The initial release of ADvIB.

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
- The program does not check for the existence of the most required exe:
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
