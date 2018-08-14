.thumb

push	{lr}

ldr	r0,=#0x04000050
mov	r1,#0xFF
strb	r1,[r0]

mov	r2,#0
strb	r2,[r0,#4]
ldr	r1,=#0x02000000
strb	r2,[r1,#0x15]

loop:
swi	#5
ldr	r0,=#0x04000050
ldr	r1,=#0x02000000
ldrb	r2,[r1,#0x15]
mov	r3,r2
lsr	r2,#1
cmp	r2,#0x10
beq	End
add	r3,#1
strb	r3,[r1,#0x15]
lsr	r3,#1
strb	r3,[r0,#4]
b	loop

End:
pop	{r0}
bx	r0
