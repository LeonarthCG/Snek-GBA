.thumb

push	{lr}
push	{r4-r7}
ldr	r4,=#0x02000000
@erase old tongue if it exists
ldr	r0,=bgTilemapsBuffer
ldr	r0,[r0]
ldr	r1,=#0x500
add	r1,r0
tongueloop:
cmp	r0,r1
beq	donetongue
ldrb	r2,[r0]
cmp	r2,#1
beq	erasetongue
cmp	r2,#6
beq	erasetongue
add	r0,#2
b	tongueloop
erasetongue:
mov	r2,#0
strh	r2,[r0]
donetongue:
@erase old tail
ldrh	r0,[r4,#0x1A]
cmp	r0,#0
beq	erasedtail
ldr	r3,=drawTile
mov	lr,r3
ldrb	r2,[r4,#0x1A]	@x
ldrb	r3,[r4,#0x1B]	@y
mov	r1,#0		@attribute
mov	r0,#0		@bg layer
.short	0xF800
erasedtail:
ldrh	r5,[r4]		@size
cmp	r5,#0
bne	dontEnd
b	End
dontEnd:
sub	r5,#1
lsl	r5,#1
mov	r7,r5
sub	r7,#4

@get snake size
sneakLoop:
mov	r6,#0x20
add	r6,r5
ldrh	r0,[r4]
lsl	r0,#1
sub	r0,#2
cmp	r0,r5
beq	drawHead
cmp	r5,#0
beq	drawTail
@otherwise draw body
add	r0,r4,r6
ldr	r3,=drawSnakeBody
mov	lr,r3
.short	0xF800
nextEntry:
cmp	r5,#0
beq	End
sub	r5,#2
cmp	r5,r7
beq	skip
b	sneakLoop
skip:
mov	r7,r5
b	sneakLoop

drawTail:
@check coords of previous tile to decide facing direction
mov	r3,#0
ldr	r0,=#0x02000020
ldrb	r1,[r0]		@x of tail
ldrb	r2,[r0,#2]	@x of body
cmp	r1,r2
beq	samex
mov	r3,#1
samex:
ldrb	r1,[r0,#1]	@y of tail
ldrb	r2,[r0,#3]	@y of body
cmp	r1,r2
beq	samey
mov	r3,#2
samey:
@r3 now has the data of the facing direction
@if x is the same (r3 = 2), it will be vertical, if y is the same it will be horizontal (r3 = 1)
mov	r0,#4		@tile
cmp	r3,#2
bne	notverticaltail
add	r0,#5
notverticaltail:
@now we need to check if rotation should be applied or not
push	{r0}
mov	r1,#0
ldr	r0,=#0x02000020
ldrb	r2,[r0]
ldrb	r3,[r0,#2]
cmp	r3,r2
blo	dontfliphorizontaltail
add	r1,#1
dontfliphorizontaltail:
ldrb	r2,[r0,#1]
ldrb	r3,[r0,#3]
cmp	r3,r2
blo	dontflipverticaltail
add	r1,#2
dontflipverticaltail:
pop	{r0}
mov	r2,#0		@palette
ldr	r3,=makeTileAttribute
mov	lr,r3
.short	0xF800
ldr	r3,=drawTile
mov	lr,r3
ldrb	r2,[r4,r6]	@x
add	r6,#1
ldrb	r3,[r4,r6]	@y
mov	r1,r0		@attribute
mov	r0,#0		@bg layer
.short	0xF800
b	nextEntry

drawHead:
mov	r0,#2		@tile
add	r0,#5
ldrb	r1,[r4,#2]	@facing
cmp	r1,#1
beq	verticalhead
cmp	r1,#2
beq	verticalhead
sub	r0,#5
verticalhead:
mov	r2,#0		@palette
ldr	r3,=makeTileAttribute
mov	lr,r3
.short	0xF800
ldr	r3,=drawTile
mov	lr,r3
ldrb	r2,[r4,r6]	@x
add	r6,#1
ldrb	r3,[r4,r6]	@y
mov	r1,r0		@attribute
mov	r0,#0		@bg layer
.short	0xF800

@draw tongue
sub	r6,#1
mov	r0,#1		@tile
add	r0,#5
ldrb	r1,[r4,#2]	@facing
cmp	r1,#1
beq	verticaltongue
cmp	r1,#2
beq	verticaltongue
sub	r0,#5
verticaltongue:
mov	r2,#0		@palette
ldr	r3,=makeTileAttribute
mov	lr,r3
.short	0xF800
ldr	r3,=drawTile
mov	lr,r3
ldrb	r2,[r4,r6]	@x
ldrb	r1,[r4,#2]	@facing
cmp	r1,#0
bne	notlefttongue
cmp	r2,#0
beq	endtongue
sub	r2,#1
notlefttongue:
cmp	r1,#3
bne	notrighttongue
cmp	r2,#0x1D
beq	endtongue
add	r2,#1
notrighttongue:
add	r6,#1
ldrb	r3,[r4,r6]	@y
cmp	r1,#1
bne	notuptongue
cmp	r3,#2
beq	endtongue
sub	r3,#1
notuptongue:
cmp	r1,#2
bne	notdowntongue
cmp	r3,#0x13
beq	endtongue
add	r3,#1
notdowntongue:
mov	r1,r0		@attribute
mov	r0,#0		@bg layer
.short	0xF800
endtongue:
b	nextEntry

End:
pop	{r4-r7}
pop	{r0}
bx	r0
