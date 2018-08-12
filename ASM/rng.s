.thumb

push	{lr}

@if this is the first time this routine is called, get timer as original seed
ldr	r1,=#0x02000000
ldrb	r2,[r1,#12]
mov	r3,#1
strb	r3,[r1,#12]
cmp	r2,#0
bne	notfirst
ldr	r2,=#0x04000100
ldrh	r0,[r2]
b	wasfirst

notfirst:
ldr	r0,[r1,#8]
wasfirst:
@r0 is x

@a*x+c mod 32

@m is 2*32, which happens automatically
ldr	r2,=#0x01010101	@a
ldr	r3,=#0x31415927	@c

mul	r0,r2
add	r0,r3
str	r0,[r1,#8]
lsr	r0,#16		@only the top half bits

pop	{r1}
bx	r1
