.thumb

push	{lr}

@check if egg exists
ldr	r0,=#0x02000000
ldrh	r0,[r0,#6]	@egg coords
cmp	r0,#0
bne	End		@if egg already exists, do nothing

@generate egg color and save it
ldr	r0,=rng
mov	lr,r0
.short	0xF800
mov	r1,#1
and	r0,r1
ldr	r1,=#0x02000000
add	r0,#20
strb	r0,[r1,#0x14]

@choose a tile from the list
rngFailsafe:
ldr	r0,=rng
mov	lr,r0
.short	0xF800

ldr	r3,=#0x02000000
ldrh	r1,[r3,#0x16]
lsr	r1,#1
add	r1,#1
swi	#6		@divide random number by length/2 +1
lsl	r1,#1
ldr	r3,=#0x02005000
ldrh	r0,[r3,r1]
cmp	r0,#0
beq	rngFailsafe	@just in case

@store coords
ldr	r3,=#0x02000000
strh	r0,[r3,#6]

End:
pop	{r0}
bx	r0
