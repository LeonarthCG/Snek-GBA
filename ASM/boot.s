.arm
ldr	r0,=toThumb
add	r0,#1
bx	r0

.thumb

toThumb:
ldr	r0,=#0x04000200
mov	r1,#1
strb	r1,[r0,#8]	@set Master Interrupt Control to 1, enabling interrupts

ldr	r0,=#0x04000200
mov	r1,#0x19
strh	r1,[r0]		@set first bit of REG_IE (enable irq v-blank), third and fourth for timer 0 and 1 overflow

ldr	r0,=#0x04000004
mov	r2,#8
strh	r2,[r0]		@set 3rd bit of DISPSTAT (enable irq v-blank)

ldr	r0,=#0x03007FFC
ldr	r1,=interrupt
str	r1,[r0]		@set the interrupt routine

ldr	r0,=#0x04000000
mov	r1,#0
strb	r1,[r0]		@set video mode

mov	r1,#0xFF
mov	r2,#0x50
strb	r1,[r0,r2]	@activate bg blending

mov	r1,#0x10
add	r2,#4
strb	r1,[r0,r2]	@start with a black screen

@enable timers 2 and 3
ldr	r0,=#0x04000000
ldr	r1,=#0x108
@used for the first rng seed
ldr	r2,=#0xEEDB
strh	r2,[r0,r1]	@start time for counter 2, 4389 until overflow
add	r1,#2
mov	r2,#0x81
strh	r2,[r0,r1]	@counter 2 speed = 16.78MHz/64 and enable
add	r1,#2
mov	r2,#0x84
@start time 0 for counter 3
add	r1,#2
strh	r2,[r0,r1]	@count up when the previous one overflows
@this, if my math is right, should be 16.78MHz/64/4389 = 59.73Hz, the refresh rate of the console

@set the offset for the bg map
mov	r1,#0x1F
strb	r1,[r0,#9]	@set the offset for the bg map 0
mov	r1,#0x1E
strb	r1,[r0,#11]	@set the offset for the bg map 1
mov	r1,#0x1D
strb	r1,[r0,#13]	@set the offset for the bg map 2
mov	r1,#0x1C
strb	r1,[r0,#15]	@set the offset for the bg map 3

@set the first 4 bytes of the save to 0
ldr	r0,=#0x0E000000
ldrb	r1,[r0,#2]
cmp	r1,#3
bhi	resetSave
ldrb	r1,[r0]
ldrb	r2,[r0,#1]
lsl	r2,#8
orr	r1,r2
ldr	r2,=#540
cmp	r1,r2
bhi	resetSave
ldrb	r1,[r0,#3]
cmp	r1,#1
bhi	resetSave
mov	r2,#0xFF
ldrb	r1,[r0]
cmp	r1,r2
bne	dontset0
ldrb	r1,[r0,#1]
cmp	r1,r2
bne	dontset0
ldrb	r1,[r0,#2]
cmp	r1,r2
bne	dontset0
ldrb	r1,[r0,#3]
cmp	r1,r2
bne	dontset0
resetSave:
mov	r1,#0
strb	r1,[r0]
strb	r1,[r0,#1]
strb	r1,[r0,#3]
mov	r1,#1
strb	r1,[r0,#2]
dontset0:

@wait for v-blank
swi	#5

@prepare sound
@set direct sound outputs and counters
ldr	r0,=#0x4000080
ldr	r1,=#0x730E
strh	r1,[r0,#2]

@enable sound
ldr	r1,=#0x80
strh	r1,[r0,#4]

ldr	r0,=VideoGame7Data
ldr	r3,=playSong
mov	lr,r3
.short	0xF800

ldr	r0,=titlescreenLoop
mov	lr,r0
.short	0xF800
