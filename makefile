assemble:
	dasm game.asm -lgame.txt -f3 -v5 -ogame.bin


all: assemble run


run: game.bin
	stella game.bin