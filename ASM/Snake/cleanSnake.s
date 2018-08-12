.thumb

ldr	r0,=#0x0600F800
ldr	r1,=#0x0600FD00
mov	r2,#0

loop:
str	r2,[r0]
add	r0,#4
cmp	r0,r1
beq	End
b	loop

End:
bx	lr
