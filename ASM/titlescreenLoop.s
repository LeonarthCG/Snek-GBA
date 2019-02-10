.thumb

@check if game beaten
ldr	r0,=#0x0E000000
ldrb	r1,[r0]
ldrb	r2,[r0,#1]
lsl	r2,#8
orr	r1,r2
ldr	r2,=#540
cmp	r1,r2
beq	beaten
mov	r2,#0
strb	r2,[r0,#3]
beaten:

@reset ram
ldr	r0,=fillDest
mov	lr,r0
mov	r0,#0		@value to fill with
ldr	r1,=#0x02000000	@destination
ldr	r2,=#0x20	@size in words
.short	0xF800

@turn on bg layers
ldr	r0,=#0x04000000
mov	r1,#0xF
strb	r1,[r0,#1]

@set background 0 to 256 colors mode, and change priority
mov	r1,#0x81
strb	r1,[r0,#8]

@set background 1, 2 and 3 starting tile block
ldr	r0,=#0x04000000
mov	r1,#0x08
strb	r1,[r0,#10]
strb	r1,[r0,#12]
strb	r1,[r0,#14]

@move bg 2 to the right
ldr	r1,=#0xFFFC
strh	r1,[r0,#0x18]

@lower bg 3 y coord a bit
ldr	r1,=#0xFFFD
strh	r1,[r0,#0x1E]

ldr	r0,=#0x0E000000
ldrb	r0,[r0,#3]
cmp	r0,#0
bne	winscreen
@if option 0
ldr	r0,=titlescreenIMG
ldr	r1,=#0x06000000
ldr	r3,=loadData
mov	lr,r3
.short	0xF800
ldr	r0,=titlescreenPAL
ldr	r1,=#0x05000000
ldr	r3,=loadData
mov	lr,r3
.short	0xF800
b	jumpwinscreen
winscreen:
@if option 1
ldr	r0,=winscreenIMG
ldr	r1,=#0x06000000
ldr	r3,=loadData
mov	lr,r3
.short	0xF800
ldr	r0,=winscreenPAL
ldr	r1,=#0x05000000
ldr	r3,=loadData
mov	lr,r3
.short	0xF800
jumpwinscreen:

ldr	r0,=titlescreenTSA
ldr	r1,=bgTilemaps
ldr	r1,[r1]
ldr	r3,=loadData
mov	lr,r3
.short	0xF800

ldr	r0,=presstartIMG
ldr	r1,=#0x06009800
ldr	r3,=loadData
mov	lr,r3
.short	0xF800

ldr	r0,=presstartIMG
ldrh	r0,[r0,#2]
lsl	r0,#2
ldr	r1,=#0x06009800
add	r1,r0
ldr	r0,=speedIMG
ldr	r3,=loadData
mov	lr,r3
.short	0xF800

ldr	r0,=presstartIMG
ldrh	r0,[r0,#2]
lsl	r0,#2
ldr	r1,=#0x06009800
add	r1,r0
ldr	r0,=speedIMG
ldrh	r0,[r0,#2]
lsl	r0,#2
add	r1,r0
ldr	r0,=githubIMG
ldr	r3,=loadData
mov	lr,r3
.short	0xF800

ldr	r0,=fillDest
mov	lr,r0
ldr	r0,=#0x00C000C0
ldr	r1,=bgTilemaps
ldr	r1,[r1,#4]
ldr	r2,=#0x200
.short	0xF800

ldr	r0,=fillDest
mov	lr,r0
ldr	r0,=#0x00C000C0
ldr	r1,=bgTilemaps
ldr	r1,[r1,#8]
ldr	r2,=#0x200
.short	0xF800

ldr	r0,=fillDest
mov	lr,r0
ldr	r0,=#0x00C000C0
ldr	r1,=bgTilemaps
ldr	r1,[r1,#12]
ldr	r2,=#0x200
.short	0xF800

ldr	r0,=presstartTSA
ldr	r1,=bgTilemaps
ldr	r1,[r1,#4]
ldr	r2,=#0x34C
add	r1,r2
ldr	r3,=loadData
mov	lr,r3
.short	0xF800

ldr	r0,=githubTSA
ldr	r1,=bgTilemaps
ldr	r1,[r1,#12]
ldr	r2,=#0x44C
add	r1,r2
ldr	r3,=loadData
mov	lr,r3
.short	0xF800

ldr	r0,=changeSpeed
mov	lr,r0
.short	0xF800

ldr	r0,=fadeIn
mov	lr,r0
.short	0xF800

ldr	r0,=#0x02000000
mov	r1,#0
strh	r1,[r0,#0x18]

titlescreen:
swi	#5
ldr	r0,=changeSpeed
mov	lr,r0
.short	0xF800
ldr	r0,=doCredits
mov	lr,r0
.short	0xF800
@check if the press start should turn on/off
ldr	r0,=#0x02000000
ldrh	r2,[r0,#0x18]
add	r2,#1
cmp	r2,#0x20
bne	dontFlicker
ldr	r1,=#0x04000000
mov	r2,#2
ldrb	r3,[r1,#1]
and	r3,r2
cmp	r3,#2
beq	setnodisplay
mov	r2,#0xF
b	afterjump
setnodisplay:
mov	r2,#0xD
afterjump:
strb	r2,[r1,#1]
mov	r2,#0
strh	r2,[r0,#0x18]
ldr	r0,=rng
mov	lr,r0
.short	0xF800
mov	r1,#50
swi	#6
cmp	r1,#0
bne	label
ldr	r0,=presstartTSA
ldrh	r2,[r0,#2]
add	r2,#1
lsl	r2,#2
add	r0,r2
ldr	r1,=#0x06009800
ldr	r3,=loadData
mov	lr,r3
.short	0xF800
b	dontFlicker2
label:
ldr	r0,=presstartIMG
ldr	r1,=#0x06009800
ldr	r3,=loadData
mov	lr,r3
.short	0xF800
dontFlicker2:
@check if select pressed and game beaten
ldr	r0,=#0x0E000000
ldrb	r1,[r0]
ldrb	r2,[r0,#1]
lsl	r2,#8
orr	r1,r2
ldr	r2,=#540
cmp	r1,r2
blo	notbeaten
ldr	r0,=#0x04000130
ldrb	r0,[r0]
mov	r1,#4
and	r0,r1
cmp	r0,#0
beq	changetitlescreen
notbeaten:
@check if start pressed
ldr	r0,=#0x04000130
ldrb	r0,[r0]
mov	r1,#8
and	r0,r1
cmp	r0,#0
bne	titlescreen

ldr	r0,=#0x04000000
mov	r1,#3
strb	r1,[r0,#1]

ldr	r0,=Game_StartData
ldr	r3,=playSound
mov	lr,r3
.short	0xF800

ldr	r0,=fadeOut
mov	lr,r0
.short	0xF800

@wait for sound effect
push	{r4}
ldr	r4,=soundCounters
ldr	r4,[r4,#12]
soundloop:
ldr	r0,[r4]
cmp	r0,#0
beq	sounddone
swi	#5
b	soundloop
sounddone:
pop	{r4}

ldr	r0,=mainLoop
mov	lr,r0
.short	0xF800

changetitlescreen:
ldr	r0,=fadeOut
mov	lr,r0
.short	0xF800
ldr	r0,=#0x0E000000
ldrb	r0,[r0,#3]
cmp	r0,#0
beq	winscreen2
@if option 0
ldr	r0,=titlescreenIMG
ldr	r1,=#0x06000000
ldr	r3,=loadData
mov	lr,r3
.short	0xF800
ldr	r0,=titlescreenPAL
ldr	r1,=#0x05000000
ldr	r3,=loadData
mov	lr,r3
.short	0xF800
ldr	r0,=#0x0E000000
mov	r1,#0
strb	r1,[r0,#3]
b	jumpwinscreen2
winscreen2:
@if option 1
ldr	r0,=winscreenIMG
ldr	r1,=#0x06000000
ldr	r3,=loadData
mov	lr,r3
.short	0xF800
ldr	r0,=winscreenPAL
ldr	r1,=#0x05000000
ldr	r3,=loadData
mov	lr,r3
.short	0xF800
ldr	r0,=#0x0E000000
mov	r1,#1
strb	r1,[r0,#3]
jumpwinscreen2:
ldr	r0,=fadeIn
mov	lr,r0
.short	0xF800
b	titlescreen

dontFlicker:
strh	r2,[r0,#0x18]
b	dontFlicker2
