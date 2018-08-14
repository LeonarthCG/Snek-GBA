.thumb

push	{lr}
ldr	r1,=#0x02000000

@check game over
ldrb	r0,[r1,#0xD]
cmp	r0,#0xF0
bhi	End

@get button presses
ldrb	r0,[r1,#5]
lsl	r0,#4
mov	r2,#0xF
add	r0,r2
mvn	r0,r0

ldr	r2,=#0x04000130
ldrb	r2,[r2]
mov	r3,r2
mvn	r2,r2
lsr	r3,#4
cmp	r3,#0xF
beq	nobuttons
mov	r0,r2
nobuttons:

@get current facing and remove that and the opposite from the button presses
ldrb	r3,[r1,#2]
mov	r2,#0x30
cmp	r3,#0
beq	match
cmp	r3,#3
beq	match
mov	r2,#0xC0

match:
mvn	r2,r2
and	r0,r2		@button presses without current and opposite facing

getnew:
mov	r2,#0xFF
and	r0,r2
mov	r3,#0
cmp	r0,#0x20
beq	store
mov	r3,#1
cmp	r0,#0x40
beq	store
mov	r3,#2
cmp	r0,#0x80
beq	store
mov	r3,#3
cmp	r0,#0x10
beq	store
b	End

store:
@one final check, check if the snake is going to be turning towards the screen
ldr	r2,=#0x02000000
ldrh	r1,[r2]
lsl	r1,#1
add	r1,#0x20
sub	r1,#2
add	r2,r1
ldrb	r1,[r2]
ldrb	r2,[r2,#1]
cmp	r0,#0x10
bne	notright
cmp	r1,#0x1D
beq	End
@check if bonk
push	{r0-r3}
ldr	r3,=bonkSnake
mov	lr,r3
ldr	r2,=#0x02000000
ldrh	r3,[r2]
lsl	r3,#1
add	r3,#0x20
sub	r3,#2
add	r2,r3
ldrb	r0,[r2]
ldrb	r1,[r2,#1]
add	r0,#1
.short	0xF800
cmp	r0,#1
beq	turnBonk
pop	{r0-r3}
notright:
cmp	r0,#0x20
bne	notleft
cmp	r1,#0
beq	End
@check if bonk
push	{r0-r3}
ldr	r3,=bonkSnake
mov	lr,r3
ldr	r2,=#0x02000000
ldrh	r3,[r2]
lsl	r3,#1
add	r3,#0x20
sub	r3,#2
add	r2,r3
ldrb	r0,[r2]
ldrb	r1,[r2,#1]
sub	r0,#1
.short	0xF800
cmp	r0,#1
beq	turnBonk
pop	{r0-r3}
notleft:
cmp	r0,#0x40
bne	notup
cmp	r2,#2
beq	End
@check if bonk
push	{r0-r3}
ldr	r3,=bonkSnake
mov	lr,r3
ldr	r2,=#0x02000000
ldrh	r3,[r2]
lsl	r3,#1
add	r3,#0x20
sub	r3,#2
add	r2,r3
ldrb	r0,[r2]
ldrb	r1,[r2,#1]
sub	r1,#1
.short	0xF800
cmp	r0,#1
beq	turnBonk
pop	{r0-r3}
notup:
cmp	r0,#0x80
bne	notdown
cmp	r2,#0x13
beq	End
@check if bonk
push	{r0-r3}
ldr	r3,=bonkSnake
mov	lr,r3
ldr	r2,=#0x02000000
ldrh	r3,[r2]
lsl	r3,#1
add	r3,#0x20
sub	r3,#2
add	r2,r3
ldrb	r0,[r2]
ldrb	r1,[r2,#1]
add	r1,#1
.short	0xF800
cmp	r0,#1
beq	turnBonk
pop	{r0-r3}
notdown:
ldr	r1,=#0x02000000
strb	r3,[r1,#2]

End:
ldr	r0,=#0x02000000	@clear button presses
mov	r1,#0		@this is to stop the infinite zig-zag the snake does if you hold up/down and left/right and release
strb	r1,[r0,#5]	@zig-zag can still be performed by holding down both keys, if you really really want to do that
pop	{r0}
bx	r0

turnBonk:
pop	{r0-r3}
b	End
