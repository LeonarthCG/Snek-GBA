.thumb
push	{lr}
push	{r4-r7}
Start:
ldr	r4,=#0x02000000
ldrb	r5,[r4,#0x10]		@current credits image
ldrb	r6,[r4,#0x11]		@counter 1
mov	r0,r5
lsl	r0,#2
ldr	r7,=creditImages
ldr	r7,[r7,r0]		@pointer to credits image

@check if the pointer is 0, if so start over
cmp	r7,#0
bne	not0
mov	r0,#0
str	r0,[r4,#0x10]
b	Start
not0:

@if the first counter is 0, load the graphics
cmp	r6,#0
bne	dontLoad
mov	r0,r7
ldr	r1,=#0x0600A800
ldr	r3,=loadData
mov	lr,r3
.short	0xF800
dontLoad:

@if the first counter has not reached the max, continue moving credits to the left from offscreen
cmp	r6,#32
beq	counter2
@draw new tilemap
mov	r0,r6
ldr	r1,=#0x0600E4BE
sub	r1,r0
sub	r1,r0
loop1:
cmp	r0,#0
beq	breakloop1
mov	r2,r1
add	r2,r0
add	r2,r0
ldr	r3,=#0x140
add	r3,r0
strh	r3,[r2]
sub	r0,#1
b	loop1
breakloop1:
@increase counter
add	r6,#1
strb	r6,[r4,#0x11]		@counter 1
b	End

@this counter just makes us wait for a while
counter2:
ldrb	r6,[r4,#0x12]		@counter 2
cmp	r6,#0xFF
beq	counter3
@increase counter
add	r6,#1
strb	r6,[r4,#0x12]		@counter 2
b	End

@if the third counter has not reached the max, continue moving credits to the left offscreen
counter3:
ldrb	r6,[r4,#0x13]		@counter 3
cmp	r6,#32
beq	nextIndex
@draw new tilemap
mov	r0,r6
ldr	r7,=#0x140
add	r7,r0
mov	r1,#32
sub	r0,r1,r0
ldr	r1,=#0x0600E47E
loop3:
cmp	r0,#0
beq	breakloop3
mov	r2,r1
add	r2,r0
add	r2,r0
add	r3,r7,r0
strh	r3,[r2]
sub	r0,#1
b	loop3
breakloop3:
@increase counter
add	r6,#1
strb	r6,[r4,#0x13]		@counter 3
b	End

@increase index and end
nextIndex:
mov	r0,#0
str	r0,[r4,#0x10]
add	r5,#1
strb	r5,[r4,#0x10]

End:
pop	{r4-r7}
pop	{r0}
bx	r0
