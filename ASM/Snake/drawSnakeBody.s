.thumb

push	{lr}
push	{r4-r6}
mov	r5,r0
@r5 = offset to body piece
mov	r4,r5
sub	r4,#2
mov	r6,r5
add	r6,#2

ldrb	r0,[r4]
ldrb	r1,[r6]
cmp	r1,r0
beq	vertical
ldrb	r0,[r4,#1]
ldrb	r1,[r6,#1]
cmp	r1,r0
beq	horizontal
@those were the easiest cases, now for the "hard" ones
@check higher
mov	r3,#0
ldrb	r0,[r4,#1]
ldrb	r1,[r6,#1]
ldrb	r2,[r5,#1]
cmp	r0,r2
bhi	higherthan
cmp	r1,r2
bhi	higherthan
add	r3,#1		@first bit to indicate not higher
higherthan:
ldrb	r0,[r4]
ldrb	r1,[r6]
ldrb	r2,[r5]
cmp	r0,r2
bhi	widerthan
cmp	r1,r2
bhi	widerthan
add	r3,#2		@second bit to indicate not wider
widerthan:

mov	r0,#1
and	r0,r3
cmp	r0,#0
beq	waluigis
mov	r0,#2
and	r0,r3
cmp	r0,#0
beq	luigishape
b	mirrorluigishape

waluigis:
mov	r0,#2
and	r0,r3
cmp	r0,#0
beq	waluigishape
b	mirrorwaluigishape

luigishape:
mov	r0,#5
mov	r1,#3
b	drawBody
mirrorluigishape:
mov	r0,#5
mov	r1,#2
b	drawBody
waluigishape:
mov	r0,#5
mov	r1,#1
b	drawBody
mirrorwaluigishape:
mov	r0,#5
mov	r1,#0
b	drawBody

horizontal:
mov	r0,#3
mov	r1,#0
b	drawBody

vertical:
mov	r0,#8
mov	r1,#0
b	drawBody

drawBody:
mov	r2,#0		@palette
ldr	r3,=makeTileAttribute
mov	lr,r3
.short	0xF800
ldr	r3,=drawTile
mov	lr,r3
ldrb	r2,[r5]		@x
add	r6,#1
ldrb	r3,[r5,#1]	@y
mov	r1,r0		@attribute
mov	r0,#0		@bg layer
.short	0xF800

pop	{r4-r6}
pop	{r0}
bx	r0
