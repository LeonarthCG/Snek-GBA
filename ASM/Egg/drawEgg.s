.thumb

push	{lr}

ldr	r3,=drawTile
mov	lr,r3
ldr	r3,=#0x02000000
ldrh	r2,[r3,#6]
cmp	r2,#0
beq	End
ldrb	r2,[r3,#6]	@x
ldrb	r3,[r3,#7]	@y
mov	r0,#0
ldr	r1,=#0x02000000
ldrb	r1,[r1,#0x14]
.short	0xF800

End:
pop	{r0}
bx	r0
