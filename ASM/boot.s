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
mov	r1,#1
strh	r1,[r0]		@set first bit of REG_IE (enable irq v-blank)

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

mov	r1,#3
strb	r1,[r0,#1]	@turn on bg layers 0 and 1

@enable timer 0, 1 and 2
ldr	r1,=#0x100
ldr	r2,=#0xEEDB
strh	r2,[r0,r1]	@start time for counter 0, 4389 until overflow
add	r1,#2
mov	r2,#0x81
strh	r2,[r0,r1]	@speed = 16.78MHz/64
add	r1,#2
mov	r2,#0x84
add	r1,#2
strh	r2,[r0,r1]	@count up when the previous one overflows
@this, if my math is right, should be 16.78MHz/64/4389 = 59.73Hz, the refresh rate of the console
add	r1,#4
mov	r2,#0x80
strh	r2,[r0,r1]	@used for the first rng seed

@set the offset for the bg map
mov	r1,#0x1F
strb	r1,[r0,#9]	@set the offset for the bg map 0
mov	r1,#0x1E
strb	r1,[r0,#11]	@set the offset for the bg map 1

swi	#5

ldr	r0,=titlescreenLoop
mov	lr,r0
.short	0xF800
