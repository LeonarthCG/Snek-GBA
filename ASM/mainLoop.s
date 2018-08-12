.thumb

ldrb	r0,=#0x02000000
mov	r1,#0x8
strb	r1,[r0,#3]	@speed
mov	r1,#0
strb	r1,[r0,#4]	@counter, game logic will only trigger if the counter matches the speed or is higher (in case of powerups)

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

ldr	r0,=startSnake
mov	lr,r0
.short	0xF800

main:
ldr	r2,=#0x02000000
ldr	r3,=#0x04000130
ldrb	r1,[r3]		@save button presses so that the player does not need to hold down the button until the counter matches the speed
lsr	r1,#4
cmp	r1,#0xF
beq	noButtons
strb	r1,[r2,#5]
noButtons:

swi	#5		@wait for vblank

ldr	r0,=copyBuffers
mov	lr,r0
.short	0xF800

ldr	r0,=#0x02000000
add	r0,#0x10
mov	r1,#0
strb	r1,[r0]		@set bg 0 to not be updated

ldrb	r0,=#0x02000000
ldrb	r1,[r0,#3]	@speed
ldrb	r2,[r0,#4]	@counter
mov	r3,r2
add	r3,#1
strb	r3,[r0,#4]	@counter
cmp	r2,r1
blo	skipSnake	@if counter is lower than speed, skip game logic and wait another frame
mov	r3,#0
strb	r3,[r0,#4]	@counter

ldr	r0,=#0x02000000
add	r0,#0x10
mov	r1,#1
strb	r1,[r0]		@set bg 0 to be updated

ldr	r0,=turnSnake
mov	lr,r0
.short	0xF800

ldr	r0,=moveSnake
mov	lr,r0
.short	0xF800

ldr	r0,=cleanSnake
mov	lr,r0
.short	0xF800

ldr	r0,=drawSnake
mov	lr,r0
.short	0xF800

skipSnake:

b	main
