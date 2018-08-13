.thumb

@r0 = x, r1 = y

lsl	r1,#8
add	r0,r1	@xy

ldr	r2,=#0x02000000
ldrh	r3,[r2]
add	r2,#0x20
lsl	r3,#1
add	r3,r2

loop:
cmp	r2,r3
beq	nobonk
ldrh	r1,[r2]
cmp	r1,r0
beq	bonk
add	r2,#2
b	loop

bonk:
mov	r0,#1
b	End

nobonk:
mov	r0,#0

End:
bx	lr
