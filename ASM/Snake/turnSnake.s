.thumb

ldr	r1,=#0x02000000

@get button presses
ldrb	r0,[r1,#5]
lsl	r0,#4
mov	r2,#0xF
add	r0,r2
mvn	r0,r0

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
ldrb	r1,[r2]
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
notright:
cmp	r0,#0x20
bne	notleft
cmp	r1,#0
beq	End
notleft:
cmp	r0,#0x40
bne	notup
cmp	r2,#2
beq	End
notup:
cmp	r0,#0x80
bne	notdown
cmp	r2,#0x13
beq	End
notdown:
ldr	r1,=#0x02000000
strb	r3,[r1,#2]

End:
ldr	r0,=#0x02000000	@clear button presses
mov	r1,#0		@this is to stop the infinite zig-zag the snake does if you hold up/down and left/right and release
strb	r1,[r0,#5]	@zig-zag can still be performed by holding down both keys, if you really really want to do that
bx	lr
