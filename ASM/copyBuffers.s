.thumb

push	{r4-r7}
mov	r7,#0
ldr	r4,=bgTilemapsBuffer
ldr	r5,=bgTilemaps

loop1:
mov	r6,r7
lsl	r6,#2
mov	r2,#0
ldr	r3,=#0x500
ldr	r0,=#0x02000000
add	r0,#0x10
ldrb	r0,[r0,r7]
cmp	r0,#0
beq	next
ldr	r0,[r4,r6]
cmp	r0,#0
beq	next
ldr	r1,[r5,r6]
cmp	r1,#0
beq	next
loop2:
ldr	r6,[r0,r2]
str	r6,[r1,r2]
cmp	r2,r3
beq	next
add	r2,#4
b	loop2
next:
add	r7,#1
cmp	r7,#4
beq	End
b	loop1

End:
pop	{r4-r7}
bx	lr
