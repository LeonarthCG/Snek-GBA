cd %~dp0

del %~dp0rom.gba

cd "%~dp0Event Assembler"

Core A FE8 "-output:%~dp0rom.gba" "-input:%~dp0ROM Buildfile.event"

pause
