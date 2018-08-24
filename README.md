# Snek GBA

Snek GBA is a homebrew Game Boy Advance Snake clone.
The game code is written in asm and compiled with devkitARM.
The game is built with Event Assembler (EA), Lyn, and the EA Formatting Suite.

# Build Instructions

1) Download the project folder
2) Download [Event Assembler](http://feuniverse.us/t/event-assembler/1749), which includes the EA Formatting Suite, and extract it in the "Event Assembler" directory.
3) Download [Lyn](http://feuniverse.us/t/ea-asm-tool-lyn-elf2ea-if-you-will/2986) and place it in the "Event Assembler/Tools" directory.
4) Run build.cmd, which will run EA to generate "rom.gba" using "ROM Buildfile.event"

# Controls

- D-pad: Turn Snake. Switch between speeds options in the title screen.
- Enter: Start game. Pause/Unpause game.
- Select: Change between titlescreens (only if max score has been reached).

# Credits

- Programming and Tiles: https://github.com/LeonarthCG
- Title and Victory screens: https://twitter.com/CeciDibujera https://ko-fi.com/A044FBN
- Testing: Sme and 2wb/eliwan
