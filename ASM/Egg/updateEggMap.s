.thumb
push	{lr}

@update egg map
ldr	r2,=#0x02000000
ldrh	r0,[r2,#0x1A]	@previous tail position
ldrh	r1,[r2]		@size
lsl	r1,#1
sub	r1,#2
add	r1,#0x20
ldrh	r1,[r2,r1]	@current head position
cmp	r0,r1
beq	End

@find head position in egg buffer
ldr	r3,=#0x02005000
headloop:
ldrh	r2,[r3]
cmp	r2,r1
beq	endheadloop
add	r3,#2
b	headloop
endheadloop:

cmp	r0,#0
bne	endremoveloop
removeloop:
ldrh	r2,[r3,#2]
strh	r2,[r3]
add	r3,#2
ldrh	r2,[r3]
cmp	r2,#0
beq	endremoveloop
b	removeloop
endremoveloop:

@add the tile the tail was previously in
strh	r0,[r3]

End:
pop	{r0}
bx	r0
