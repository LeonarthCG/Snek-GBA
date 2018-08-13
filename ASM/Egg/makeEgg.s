.thumb

push	{lr}

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
str	r0,[r1,#0x14]

@make a list of all tiles that are available
mov	r0,#0
mov	r1,#2
mov	r2,#0	@ammount of tiles in the list*2
b	loopnoadd
loop:
add	r0,#1
loopnoadd:
cmp	r0,#0x1E
bne	dontincreasey
mov	r0,#0
add	r1,#1
dontincreasey:
cmp	r1,#0x14
beq	endloop
@check if the coords conflict with the body, if they do, do not add them to the list
push	{r0-r2}
ldr	r2,=bonkSnake
mov	lr,r2
.short	0xF800
mov	r3,r0
pop	{r0-r2}
cmp	r3,#1
beq	loop
ldr	r3,=#0x02005000
strb	r0,[r3,r2]
add	r2,#1
strb	r1,[r3,r2]
add	r2,#1
b	loop
endloop:

ldr	r0,=#0x02000000
strh	r2,[r0,#0x16]	@save length

@choose a tile from the list
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

@store coords
ldr	r3,=#0x02000000
strh	r0,[r3,#6]

End:
pop	{r0}
bx	r0
