.thumb

push	{lr}
push	{r4-r6}

mov	r4,r0		@value
mov	r5,r1		@destination
mov	r6,r2		@size in words

mov	r0,r6		@words to copy
lsl	r0,#2		@size in bytes
mov	r1,#0

loop:			@just write numbers of words to destination
cmp	r0,r1
beq	End
str	r4,[r5,r1]
add	r1,#4
b	loop

End:
pop	{r4-r6}
pop	{r0}
bx	r0
