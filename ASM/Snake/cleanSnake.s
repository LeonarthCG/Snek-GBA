.thumb

ldr	r0,=bgTilemapsBuffer
ldr	r0,[r0]
ldr	r1,=#0x500
add	r1,r0
mov	r2,#0

loop:
str	r2,[r0]
add	r0,#4
cmp	r0,r1
beq	End
b	loop

End:
bx	lr
