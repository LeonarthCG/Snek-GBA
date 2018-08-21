.thumb
push	{lr}

@if no buttons are being pressed, unset the holding byte and draw speed
ldr	r3,=#0x04000130
ldrb	r3,[r3]
mov	r2,#0x30
and	r2,r3
cmp	r2,#0x10
beq	buttons
cmp	r2,#0x20
beq	buttons
b	resetCounter
buttons:

@check the counter and if it was reached unset the holding byte
ldr	r3,=#0x02000000
ldrb	r2,[r3]
cmp	r2,#17
blo	dontUnset
mov	r2,#0
strb	r2,[r3]
strb	r2,[r3,#1]
dontUnset:

@save button being pressed, unless holding byte is set
ldr	r3,=#0x02000000
ldrb	r2,[r3,#1]
cmp	r2,#0
bne	getSpeed
ldr	r1,=#0x04000130
ldrb	r1,[r1]
mov	r2,#0x30
and	r2,r1
cmp	r2,#0
beq	getSpeed
strb	r2,[r3,#2]
strb	r2,[r3,#1]

@change to the appropiate speed if possible
getSpeed:
ldr	r3,=#0x0E000000
ldrb	r0,[r3,#2]
ldr	r1,=#0x02000000
ldrb	r3,[r1]
cmp	r3,#0
bne	End
ldrb	r3,[r1,#2]
cmp	r3,#0x10
bne	higher
cmp	r0,#0
beq	drawSpeed
sub	r0,#1
b	drawSpeed
higher:
cmp	r0,#3
beq	drawSpeed
add	r0,#1
b	drawSpeed

drawSpeed:
push	{r0}
lsl	r0,#2
ldr	r2,=speedTSAs
ldr	r0,[r0,r2]
ldr	r1,=bgTilemaps
ldr	r2,=#0x3CC
add	r1,r2
ldr	r3,=loadData
mov	lr,r3
.short	0xF800
pop	{r0}

End:
@change the speed in the save
ldr	r3,=#0x0E000000
strb	r0,[r3,#2]

@draw the speed
ldr	r1,=speedTSAs
lsl	r0,#2
ldr	r0,[r1,r0]
ldr	r1,=bgTilemaps
ldr	r1,[r1,#8]
ldr	r2,=#0x3CC
add	r1,r2
ldr	r3,=loadData
mov	lr,r3
.short	0xF800

@add to counter if holding byte is set
ldr	r3,=#0x02000000
ldrb	r2,[r3,#1]
cmp	r2,#0
beq	noHolding
ldrb	r2,[r3]
add	r2,#1
strb	r2,[r3]

noHolding:
pop	{r0}
bx	r0

resetCounter:
ldr	r3,=#0x02000000
mov	r2,#0
strb	r2,[r3]
strb	r2,[r3,#1]
strb	r2,[r3,#2]
ldr	r3,=#0x0E000000
ldrb	r0,[r3,#2]
b	End
