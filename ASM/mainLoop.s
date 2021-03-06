.thumb

@reset ram
ldr	r0,=fillDest
mov	lr,r0
mov	r0,#0		@value to fill with
ldr	r1,=#0x02000000	@destination
ldr	r2,=#0x1540	@size in words
.short	0xF800

ldr	r0,=fillDest
mov	lr,r0
mov	r0,#0
ldr	r1,=bgTilemapsBuffer
ldr	r1,[r1]
ldr	r2,=#0x200
.short	0xF800

ldr	r0,=fillDest
mov	lr,r0
mov	r0,#0
ldr	r1,=bgTilemapsBuffer
ldr	r1,[r1,#4]
ldr	r2,=#0x200
.short	0xF800

ldr	r0,=fillDest
mov	lr,r0
mov	r0,#0
ldr	r1,=bgTilemaps
ldr	r1,[r1,#12]
ldr	r2,=#0x200
.short	0xF800

ldr	r0,=fillDest
mov	lr,r0
mov	r0,#0
ldr	r1,=bgTilemapsBuffer
ldr	r1,[r1,#12]
ldr	r2,=#0x200
.short	0xF800

@make the bg2 background
ldr	r0,=backgroundgridTSA
ldr	r1,=bgTilemapsBuffer
ldr	r1,[r1,#8]
ldr	r3,=loadData
mov	lr,r3
.short	0xF800
ldr	r0,=scoreTSA
ldr	r1,=bgTilemapsBuffer
ldr	r1,[r1,#8]
ldr	r3,=loadData
mov	lr,r3
.short	0xF800

@enable all bgs
ldr	r0,=#0x04000000
mov	r1,#0xF
strb	r1,[r0,#1]

@bg 0 priority
mov	r1,#2
strb	r1,[r0,#0x8]
@bg 1 priority
mov	r1,#0
strb	r1,[r0,#0xA]
@bg 2 priority
mov	r1,#3
strb	r1,[r0,#0xC]
@bg 3 priority
mov	r1,#1
strb	r1,[r0,#0xE]

@lower bg 3 y coord a bit
ldr	r1,=#0xFFFD
strh	r1,[r0,#0x1E]

@move bg 2 to the center
mov	r1,#0
strh	r1,[r0,#0x18]

ldr	r0,=snekIMG
ldr	r1,=#0x06000000
ldr	r3,=loadData
mov	lr,r3
.short	0xF800

ldr	r0,=snekPAL
ldr	r1,=#0x05000000
ldr	r3,=loadData
mov	lr,r3
.short	0xF800

ldr	r0,=snekIMG
ldrh	r0,[r0,#2]
lsl	r0,#2
ldr	r1,=#0x06000000
add	r1,r0
ldr	r0,=heckIMG
ldr	r3,=loadData
mov	lr,r3
.short	0xF800

ldr	r0,=snekIMG
ldrh	r0,[r0,#2]
lsl	r0,#2
ldr	r1,=#0x06000000
add	r1,r0
ldr	r0,=heckIMG
ldrh	r0,[r0,#2]
lsl	r0,#2
add	r1,r0
ldr	r0,=heckmirrorIMG
ldr	r3,=loadData
mov	lr,r3
.short	0xF800

@change speed
ldr	r0,=#0x02000000
ldr	r1,=#0x0E000000
ldrb	r1,[r1,#2]
ldr	r2,=speedSpeeds
ldrb	r1,[r2,r1]
strb	r1,[r0,#3]	@speed

ldr	r0,=startSnake
mov	lr,r0
.short	0xF800

ldr	r0,=#0x02000000
mov	r1,#0
strb	r1,[r0,#2]	@reset facing direction
strb	r1,[r0,#0xD]	@reset game state
mov	r1,#1
strb	r1,[r0,#0x10]	@set all bgs to be updated
strb	r1,[r0,#0x11]
strb	r1,[r0,#0x12]
strb	r1,[r0,#0x13]

ldr	r0,=drawSnake
mov	lr,r0
.short	0xF800

ldr	r0,=makeEggMap
mov	lr,r0
.short	0xF800

ldr	r0,=makeEgg
mov	lr,r0
.short	0xF800

ldr	r0,=drawEgg
mov	lr,r0
.short	0xF800

@draw the max size for the score
ldr	r0,=bgTilemapsBuffer
ldr	r0,[r0,#12]
add	r0,#0x12
mov	r1,#0x1C
strh	r1,[r0]
mov	r1,#0x1B
strh	r1,[r0,#2]
mov	r1,#0x17
strh	r1,[r0,#4]
@draw the empty scores
ldr	r0,=bgTilemapsBuffer
ldr	r0,[r0,#12]
add	r0,#8
mov	r1,#0x16
strh	r1,[r0]
strh	r1,[r0,#2]
strh	r1,[r0,#4]
ldr	r0,=bgTilemapsBuffer
ldr	r0,[r0,#12]
add	r0,#0x2E
mov	r1,#0x16
strh	r1,[r0]
strh	r1,[r0,#2]
strh	r1,[r0,#4]

ldr	r0,=updateScore
mov	lr,r0
.short	0xF800

ldr	r0,=copyBuffers
mov	lr,r0
.short	0xF800

ldr	r0,=#0x02000000
add	r0,#0x10
mov	r1,#0
strb	r1,[r0]		@set all bgs 0 to not be updated
strb	r1,[r0,#1]
strb	r1,[r0,#2]
strb	r1,[r0,#3]

ldr	r0,=fadeIn
mov	lr,r0
.short	0xF800

main:
@check if paused
ldr	r0,=#0x04000130
ldrb	r1,[r0]
mov	r0,#8
and	r0,r1
cmp	r0,#0
bne	dontpauseGame
b	pauseGame
dontpauseGame:

ldr	r2,=#0x02000000
ldr	r3,=#0x04000130
ldrb	r1,[r3]		@save button presses so that the player does not need to hold down the button until the counter matches the speed
lsr	r1,#4
cmp	r1,#0xF
beq	noButtons
strb	r1,[r2,#5]
noButtons:

ldr	r0,=copyBuffers
mov	lr,r0
.short	0xF800

ldr	r0,=#0x02000000
add	r0,#0x10
mov	r1,#0
strb	r1,[r0]		@set bg 0 to not be updated

ldr	r2,=#0x02000000
ldr	r3,=#0x04000130
ldrb	r1,[r3]		@save button presses so that the player does not need to hold down the button until the counter matches the speed
lsr	r1,#4
cmp	r1,#0xF
beq	noButtons2
strb	r1,[r2,#5]
noButtons2:

ldr	r0,=#0x02000000
ldr	r3,=#0x04000100
ldrh	r3,[r3,#12]	@counter
ldrb	r1,[r0,#12]	@counter checked
cmp	r1,#1
beq	counterused
strh	r3,[r0,#0x18]	@counter last time logic was ran
mov	r1,#1
strb	r1,[r0,#4]	@counter checked
counterused:
ldrb	r1,[r0,#3]	@speed
ldrh	r2,[r0,#0x18]	@counter last time logic was ran
cmp	r3,r2
blo	checkLower
add	r2,r1
cmp	r3,r2
bhs	runSnake
b	skipSnake	@skip game logic

checkLower:
mov	r1,r3
sub	r1,r2,r1
ldrb	r2,[r0,#3]	@speed
cmp	r1,r2
bhs	runSnake
b	skipSnake

runSnake:
strh	r3,[r0,#0x18]	@update counter

@check for win
ldrb	r3,[r0,#0xD]
cmp	r3,#0xFE
bne	notWIN1
b	WIN
notWIN1:

@check for game over
ldrb	r3,[r0,#0xD]
cmp	r3,#0xFF
beq	gameover

ldr	r0,=#0x02000000
add	r0,#0x10
mov	r1,#1
strb	r1,[r0]		@set bg 0 and 3 to be updated
strb	r1,[r0,#3]

ldr	r0,=turnSnake
mov	lr,r0
.short	0xF800

ldr	r0,=moveSnake
mov	lr,r0
.short	0xF800

@check for win
ldr	r0,=#0x02000000
ldrb	r3,[r0,#0xD]
cmp	r3,#0xFE
bne	notWIN2
b	WIN
notWIN2:

@check for game over
ldrb	r3,[r0,#0xD]
cmp	r3,#0xFF
beq	gameover

ldr	r0,=eatEgg
mov	lr,r0
.short	0xF800

ldr	r0,=updateEggMap
mov	lr,r0
.short	0xF800

ldr	r0,=makeEgg
mov	lr,r0
.short	0xF800

ldr	r0,=#0x02000000
ldrb	r0,[r0,#0xD]
cmp	r0,#0xF0
bhi	nobg0draw

ldr	r0,=drawSnake
mov	lr,r0
.short	0xF800

ldr	r0,=drawEgg
mov	lr,r0
.short	0xF800

ldr	r0,=updateScore
mov	lr,r0
.short	0xF800

nobg0draw:

b	main

skipSnake:
swi	#5		@wait for vblank
b	main

gameover:
ldr	r0,=heavy_impact_1Data
ldr	r3,=playSound
mov	lr,r3
.short	0xF800
swi	#5
swi	#5
swi	#5
swi	#5
swi	#5
swi	#5
swi	#5
swi	#5
@death animation
ldr	r0,=killSnake
mov	lr,r0
.short	0xF800
ldr	r0,=#0x02000000
add	r0,#0x10
mov	r1,#1
strb	r1,[r0,#1]	@set bg 1 to be updated
ldr	r0,=copyBuffers
mov	lr,r0
.short	0xF800
ldr	r0,=#0x02000000
add	r0,#0x10
mov	r1,#0
strb	r1,[r0,#1]	@set bg 1 to not be updated
gameoverWin:
swi	#5
swi	#5
swi	#5
swi	#5
swi	#5
swi	#5
swi	#5
swi	#5
swi	#5
swi	#5
swi	#5
swi	#5
swi	#5
swi	#5
swi	#5
swi	#5
swi	#5
swi	#5
swi	#5
swi	#5
swi	#5
swi	#5
swi	#5
swi	#5
swi	#5
swi	#5
swi	#5
swi	#5
swi	#5
swi	#5
swi	#5
swi	#5
@back to title screen
ldr	r0,=fadeOut
mov	lr,r0
.short	0xF800
ldr	r0,=titlescreenLoop
mov	lr,r0
.short	0xF800

pauseGame:
ldr	r0,=SelectData
ldr	r3,=playSound
mov	lr,r3
.short	0xF800
@darken screen
ldr	r0,=#0x04000000
mov	r1,#0x54
mov	r2,#8
strb	r2,[r0,r1]
@lot of frames to wait for better button behaviour and also just to make it look better
swi	#5
swi	#5
swi	#5
swi	#5
swi	#5
swi	#5
swi	#5
swi	#5
swi	#5
swi	#5
swi	#5
swi	#5
swi	#5
swi	#5
swi	#5
pauseGameLoop:
swi	#5
@check if unpause
ldr	r0,=#0x04000130
ldrb	r1,[r0]
mov	r0,#8
and	r0,r1
cmp	r0,#0
beq	unpauseGame
b	pauseGameLoop
unpauseGame:
swi	#5
swi	#5
swi	#5
swi	#5
swi	#5
swi	#5
swi	#5
swi	#5
swi	#5
swi	#5
swi	#5
swi	#5
swi	#5
swi	#5
swi	#5
swi	#5
swi	#5
swi	#5
ldr	r0,=SelectData
ldr	r3,=playSound
mov	lr,r3
.short	0xF800
swi	#5
swi	#5
@undarken screen
ldr	r0,=#0x04000000
mov	r1,#0x54
mov	r2,#0
strb	r2,[r0,r1]
@change timer
ldr	r0,=#0x02000000
ldr	r3,=#0x04000100
ldrh	r3,[r3,#4]	@counter
strh	r3,[r0,#0x18]	@counter last time logic was ran
b	main

WIN:
ldr	r0,=OKAYData
ldr	r3,=playSound
mov	lr,r3
.short	0xF800
ldr	r0,=#0x0E000000
mov	r1,#1
strb	r1,[r0,#3]
swi	#5
swi	#5
swi	#5
swi	#5
swi	#5
swi	#5
swi	#5
swi	#5
b	gameoverWin
