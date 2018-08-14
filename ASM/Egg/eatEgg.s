.thumb

ldr	r0,=#0x02000000
ldrh	r1,[r0,#0x6]	@egg coords
ldrh	r2,[r0]		@size
lsl	r2,#1
add	r2,#0x20
sub	r2,#2
ldrh	r2,[r0,r2]	@head coords
cmp	r1,r2
bne	End
mov	r3,#0
strh	r3,[r0,#0x6]	@destroy egg
ldrh	r3,[r0,#0xE]
add	r3,#4		@add size
strh	r3,[r0,#0xE]

End:
bx	lr
