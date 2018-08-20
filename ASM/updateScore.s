.thumb
push	{lr}
push	{r4-r6}

@get score/size and high score
ldr	r0,=#0x0E000000
ldr	r3,=#0x02000000
ldrb	r1,[r0]
ldrb	r2,[r0,#1]
lsl	r2,#8
orr	r1,r2		@high score
ldrh	r3,[r3]		@size
cmp	r3,r1
blo	dontUpdate
mov	r1,r3
mov	r2,r3
lsr	r2,#8
mov	r3,#0xFF
and	r1,r3
and	r2,r3
strb	r1,[r0]
strb	r2,[r0,#1]
dontUpdate:

@draw current score
@first we get the decimal digits
ldr	r0,=#0x02000000
ldrh	r0,[r0]
mov	r1,#100
swi	#6
push	{r0}
mov	r0,r1
mov	r1,#10
swi	#6
push	{r0}
mov	r6,r1
pop	{r5}
pop	{r4}
@r4 = 100s, r5 = 10s, r6 = 1s
@draw the 100s, unless they are 0
cmp	r4,#0
beq	drawCurrent10s
ldr	r0,=drawTile
mov	lr,r0
mov	r0,#3
mov	r1,#0x17
add	r1,r4
mov	r2,#4
mov	r3,#0
.short	0xF800

@draw the 10s, unless they are 0 and 100s are zero
drawCurrent10s:
cmp	r4,#0
bne	not0current10s
cmp	r5,#0
beq	drawCurrent1s
not0current10s:
ldr	r0,=drawTile
mov	lr,r0
mov	r0,#3
mov	r1,#0x17
add	r1,r5
mov	r2,#5
mov	r3,#0
.short	0xF800

drawCurrent1s:
ldr	r0,=drawTile
mov	lr,r0
mov	r0,#3
mov	r1,#0x17
add	r1,r6
mov	r2,#6
mov	r3,#0
.short	0xF800

@draw high score
@first we get the decimal digits
ldr	r0,=#0x0E000000
ldrb	r1,[r0]
ldrb	r0,[r0,#1]
lsl	r0,#8
orr	r0,r1
mov	r1,#100
swi	#6
push	{r0}
mov	r0,r1
mov	r1,#10
swi	#6
push	{r0}
mov	r6,r1
pop	{r5}
pop	{r4}
@r4 = 100s, r5 = 10s, r6 = 1s
@draw the 100s, unless they are 0
cmp	r4,#0
beq	drawHighest10s
ldr	r0,=drawTile
mov	lr,r0
mov	r0,#3
mov	r1,#0x17
add	r1,r4
mov	r2,#0x17
mov	r3,#0
.short	0xF800

@draw the 10s, unless they are 0 and 100s are zero
drawHighest10s:
cmp	r4,#0
bne	not0Highest10s
cmp	r5,#0
beq	drawHighest1s
not0Highest10s:
ldr	r0,=drawTile
mov	lr,r0
mov	r0,#3
mov	r1,#0x17
add	r1,r5
mov	r2,#0x18
mov	r3,#0
.short	0xF800

drawHighest1s:
ldr	r0,=drawTile
mov	lr,r0
mov	r0,#3
mov	r1,#0x17
add	r1,r6
mov	r2,#0x19
mov	r3,#0
.short	0xF800

End:
pop	{r4-r6}
pop	{r0}
bx	r0
