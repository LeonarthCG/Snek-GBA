.thumb

push	{r4,r5}

ldr	r4,=#0x02000000
mov	r5,r4
ldrh	r0,[r5]
cmp	r0,#0
beq	gameOver
ldr	r3,=#540
cmp	r0,r3
beq	gameOver

mov	r3,r5
add	r3,#0x20
ldrh	r0,[r5]
lsl	r0,#1
sub	r0,#2
add	r3,r0
ldrb	r1,[r3]
ldrb	r2,[r3,#1]
ldrb	r3,[r5,#2]

cmp	r3,#0
bne	dontcheckleft
cmp	r1,#0
beq	gameOver
dontcheckleft:

cmp	r3,#3
bne	dontcheckright
cmp	r1,#0x1D
beq	gameOver
dontcheckright:

cmp	r3,#1
bne	dontcheckup
cmp	r2,#2
beq	gameOver
dontcheckup:

cmp	r3,#2
bne	dontcheckdown
cmp	r2,#0x13
beq	gameOver
dontcheckdown:

ldrh	r0,[r5]
ldrh	r1,[r5,#0xE]
cmp	r1,r0
bhi	grow

ldrh	r0,[r5]
lsl	r0,#1
sub	r0,#2
add	r0,#0x20
add	r2,r5,r0
mov	r3,r5
add	r3,#0x20
movebodyloop:
cmp	r2,r3
beq	move
ldrh	r1,[r3,#2]
strh	r1,[r3]
add	r3,#2
b	movebodyloop

move:
ldrh	r0,[r4]
lsl	r0,#1
sub	r0,#2
add	r0,#0x20
add	r4,r0
ldrb	r1,[r4]		@head x
ldrb	r2,[r4,#1]	@head y
ldrb	r3,[r5,#2]	@facing

cmp	r3,#0
bne	dontmoveleft
cmp	r1,#0
beq	gameOver
sub	r1,#1
b	domove
dontmoveleft:

cmp	r3,#3
bne	dontmoveright
cmp	r1,#0x1D
beq	gameOver
add	r1,#1
b	domove
dontmoveright:

cmp	r3,#1
bne	dontmoveup
cmp	r2,#2
beq	gameOver
sub	r2,#1
b	domove
dontmoveup:

cmp	r3,#2
bne	dontmovedown
cmp	r2,#0x13
beq	gameOver
add	r2,#1
b	domove
dontmovedown:
b	End

domove:
@check if the snake is going to hit herself
strb	r1,[r4]
strb	r2,[r4,#1]
b	End

grow:
ldrh	r0,[r4]
lsl	r0,#1
sub	r0,#2
add	r0,#0x20
ldrb	r1,[r4,r0]	@head x
add	r0,#1
ldrb	r2,[r4,r0]	@head y
add	r0,#1
ldrb	r3,[r5,#2]	@facing

cmp	r3,#0
bne	dontgrowleft
cmp	r1,#0
beq	gameOver
sub	r1,#1
b	doGrow
dontgrowleft:

cmp	r3,#3
bne	dontgrowright
cmp	r1,#0x1D
beq	gameOver
add	r1,#1
b	doGrow
dontgrowright:

cmp	r3,#1
bne	dontgrowup
cmp	r2,#2
beq	gameOver
sub	r2,#1
b	doGrow
dontgrowup:

cmp	r3,#2
bne	dontgrowdown
cmp	r2,#0x13
beq	gameOver
add	r2,#1
b	doGrow
dontgrowdown:
b	End

doGrow:
ldrh	r3,[r4]
add	r3,#1
strh	r3,[r4]
@check if the snake is going to hit herself
strb	r1,[r4,r0]
add	r0,#1
strb	r2,[r4,r0]
b	End

End:
pop	{r4,r5}
bx	lr

gameOver:
pop	{r4,r5}
bx	lr
