# advib
Auomated Dump via ImgBurn: Batch file(s) for mass ripping of optical media (CD and DVD)

Version: Alpha 1
The inital release of ADvIB.

This is relatively simply CMD-extended batch file I wrote to help me rip a large library of console games (PS1 and PS2) 
to a hard drive for archival purposes. The only thing it does is use variable and a one-game-per-line text file to convert
the disc to a bin/cue or ISO file, depending on the type. 

It is currently in a usable state but without any of the "niceties" of a normal, user-friendly utility (like running it with
no parameters giving you a help paragraph on how to use it or double-checking to make sure ImgBurn.exe exists).

The current plan is to add the nicities and as well as further features such as a config file to save settings. I would also like 
re-write the whole thing as an HTA in HTML/JScript (and since I want learn PowerShell maybe that too). 

Though at this stage this repoitory is just here for me to track the file while work on it, I will document some of the behaviours should anybody else want to use it for some reason:
- the input is a text file of game names: this is the name that will be used for bin/cue and ISO files.
        - THE NAMES IN THE TEXT FILE CANNOT CONTAIN SPACES. Escaping quotes is hard. I'm working on it (or it will have to wait for the re-write).
- There is currently no input validation for the paramters sent to the program. This means if you put mix the order of the drive letter and the text file or leave out a paramters entirely it will not stop and exit gracefully but try to run...unsuccessfully...
- The program does not check for the existance of the most required exe: imgburn.exe. I have been creating a symbolic link manually to be in the same directory as advib.cmd using the "mklink" command (it's already in windows)
- I have started to implement a plan to collect SHA1 checksum calculations as the mass image dumping went along using the Microsft command line utility FCIV - this you have to download separately and copy to a locaiton some where along your PATH (like c:\windows)
