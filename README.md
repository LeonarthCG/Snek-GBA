# Snek GBA

Snek GBA is a homebrew Game Boy Advance Snake clone.
The game's code is written in asm and compiled with devkitARM.
The game is built with Event Assembler (EA), Lyn, and the EA Formatting Suite.

# Build Instructions

1) Download the project folder
2) Download [Event Assembler](http://feuniverse.us/t/event-assembler/1749), which includes the EA Formatting Suite, and extract it in the "Event Assembler" directory.
3) Download [Lyn](http://feuniverse.us/t/ea-asm-tool-lyn-elf2ea-if-you-will/2986) and place it in the "Event Assembler/Tools" directory.
4) Run build.cmd, which will run EA to generate "rom.gba" using "ROM Buildfile.event"

# Controls

* D-pad: Turn Snek. Switch between speeds options in the title screen.
* Enter: Start game. Pause/Resume game.
* Select: Change between titlescreens (only if max score has been reached).

# Credits

* Programming and Tiles: https://github.com/LeonarthCG
* Title and Victory screens: https://twitter.com/CeciDibujera https://ko-fi.com/A044FBN
* Testing: Sme and 2wb/eliwan
* Sound: https://Freesound.org, full credits in the sound section.

# Sounds

All songs and sound effects are from freesound.org.

The following changes were done to all of the sounds using Wavosaur, unless they already had that property:
* Converted to Mono.
* Changed format to .wav.
* Resampled to 11025hz.
* Bit depth changed to 8bits.
* Normalized to 0db.
* Silences trimmed for non-looping sounds.
* And finally, convertd to .bin format using Wav2gba.

A full list of credits for all sounds and songs:
* Main theme: [Video Game 7.wav by djgriffin](https://freesound.org/people/djgriffin/sounds/172561/) under the [Attribution Noncommercial License](https://creativecommons.org/licenses/by-nc/3.0/)
* Eat egg: [Water_Gulp.wav by Q.K.](https://freesound.org/people/Q.K./sounds/56271/) under the [Creative Commons 0 License](https://creativecommons.org/publicdomain/zero/1.0/)
* Change speed, pause/unpause: [Select by TiesWijnen](https://freesound.org/people/TiesWijnen/sounds/413310/) under the [Creative Commons 0 License](https://creativecommons.org/publicdomain/zero/1.0/)
* Start game: [Game Start by plasterbrain](https://freesound.org/people/plasterbrain/sounds/243020/) under the [Creative Commons 0 License](https://creativecommons.org/publicdomain/zero/1.0/)
* Game over: [heavy impact 1 by aropson](https://freesound.org/people/aropson/sounds/429169/) under the [Attribution License](https://creativecommons.org/licenses/by/3.0/)
* Victory: [OKAY! by Scrampunk](https://freesound.org/people/Scrampunk/sounds/345299/) under the [Attribution License](https://creativecommons.org/licenses/by/3.0/)
