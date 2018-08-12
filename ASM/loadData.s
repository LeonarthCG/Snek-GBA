.thumb

push	{lr}
push	{r4,r5}

mov	r4,r0		@source
mov	r5,r1		@destination

ldrh	r0,[r4]		@short 0 as identifier for uncompressed graphics
cmp	r0,#0
bne	compressed
ldrh	r0,[r4,#2]	@words to copy
lsl	r0,#2		@size in bytes
mov	r1,#0
add	r4,#4

uncompressedLoop:	@just copy words until the end of the source is reached
cmp	r0,r1
beq	End
ldr	r2,[r4,r1]
str	r2,[r5,r1]
add	r1,#4
b	uncompressedLoop

compressed:		@I doubt this will happen tbh
b	End

End:
pop	{r4,r5}
pop	{r0}
bx	r0
