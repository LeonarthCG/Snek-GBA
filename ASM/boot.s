.arm
ldr	r0,=toThumb
add	r0,#1
bx	r0

.thumb

toThumb:
ldr	r0,=#0x04000000
mov	r1,#0
strb	r1,[r0]

mov	r1,#1
strb	r1,[r0,#1]

@enable timer
ldr	r1,=#0x102
mov	r2,#0x83
strb	r2,[r0,r1]

@set background 0 to 256 colors mode
@mov	r1,#0x80
@strb	r1,[r0,#8]

mov	r1,#0x1F
strb	r1,[r0,#9]

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

ldr	r0,=mainLoop
mov	lr,r0
.short	0xF800
