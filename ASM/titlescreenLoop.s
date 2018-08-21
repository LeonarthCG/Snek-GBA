.thumb

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
dontFlicker:
strh	r2,[r0,#0x18]
ldr	r0,=#0x04000130
ldrb	r0,[r0]
mov	r1,#8
and	r0,r1
cmp	r0,#0
bne	titlescreen

ldr	r0,=#0x04000000
mov	r1,#3
strb	r1,[r0,#1]

ldr	r0,=fadeOut
mov	lr,r0
.short	0xF800

ldr	r0,=mainLoop
mov	lr,r0
.short	0xF800
