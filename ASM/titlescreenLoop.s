.thumb

@set background 0 to 256 colors mode, and change priority
ldr	r0,=#0x04000000
mov	r1,#0x81
strb	r1,[r0,#8]


@set background 1 starting tile block
ldr	r0,=#0x04000000
mov	r1,#0x08
strb	r1,[r0,#10]

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

ldr	r0,=fillDest
mov	lr,r0
ldr	r0,=#0x00C000C0
ldr	r1,=bgTilemaps
ldr	r1,[r1,#4]
ldr	r2,=#0x200
.short	0xF800

ldr	r0,=presstartTSA
ldr	r1,=bgTilemaps
ldr	r1,[r1,#4]
ldr	r2,=#0x38C
add	r1,r2
ldr	r3,=loadData
mov	lr,r3
.short	0xF800

ldr	r0,=fadeIn
mov	lr,r0
.short	0xF800

titlescreen:
ldr	r0,=#0x04000130
ldrb	r0,[r0]
mov	r1,#8
and	r0,r1
cmp	r0,#0
bne	titlescreen

ldr	r0,=fadeOut
mov	lr,r0
.short	0xF800

ldr	r0,=mainLoop
mov	lr,r0
.short	0xF800
