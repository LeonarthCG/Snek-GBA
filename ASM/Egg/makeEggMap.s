.thumb

push	{lr}

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

End:
pop	{r0}
bx	r0
