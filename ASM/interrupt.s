.arm
ldr	r0,=toThumb
add	r0,#1
bx	r0

.thumb

toThumb:
push	{lr}
@check what type of interrupt we got
ldr	r0,=#0x04000200
ldrh	r1,[r0,#2]
mov	r0,#1
and	r0,r1
cmp	r0,#1
bne	notvblank
bl	wasvblank
notvblank:
mov	r0,#8
and	r0,r1
cmp	r0,#8
bne	notcounter0
bl	wascounter0
notcounter0:
mov	r0,#16
and	r0,r1
cmp	r0,#16
bne	notcounter1
bl	wascounter1
notcounter1:
b	End

@if timer 0, increase samples played, if samples are over end song
wascounter0:
push	{lr}
push	{r1}
ldr	r0,=soundCounters
ldr	r2,[r0]
ldr	r1,[r2]		@increase played samples
add	r1,#1
str	r1,[r2]
ldr	r2,[r0,#4]
ldr	r2,[r2]		@load song pointer to check sample ammount
ldr	r2,[r2,#4]
cmp	r1,r2
blo	endcounter0
@stop song playback
@set DMA1 control
ldr	r0,=#0x40000BC
mov	r1,#0
strh	r1,[r0,#10]
@stop timer 0 interrupts
ldr	r0,=#0x4000100
mov	r1,#0
strh	r1,[r0,#2]
@start next song (or loop)
ldr	r0,=soundCounters
ldr	r0,[r0,#4]
ldr	r0,[r0]		@next song data
cmp	r0,#0
ldr	r0,[r0,#12]
beq	endcounter0
ldr	r3,=playSong
mov	lr,r3
.short	0xF800
endcounter0:
mov	r0,#8
ldr	r1,=#0x04000200		@mark the bit for the interrupt
strh	r0,[r1,#2]
ldr	r1,=#0x03007FF8		@also mark the bit for the interrupt, I think the previous one is unneeded
strh	r0,[r1]
pop	{r1}
pop	{r0}
bx	r0

@if timer 1, increase samples played, if samples are over end sound
wascounter1:
push	{lr}
push	{r1}
ldr	r0,=soundCounters
ldr	r2,[r0,#8]
ldr	r1,[r2]		@increase played samples
add	r1,#1
str	r1,[r2]
ldr	r2,[r0,#12]
ldr	r2,[r2]		@load sound pointer to check sample ammount
ldr	r2,[r2,#4]
cmp	r1,r2
blo	endcounter1
@stop sound playback
@set DMA2 control
ldr	r0,=#0x40000C8
mov	r1,#0
strh	r1,[r0,#10]
@stop timer 1 interrupts
ldr	r0,=#0x4000100
mov	r1,#0
strh	r1,[r0,#6]
@start next sound (or loop)
ldr	r0,=soundCounters
ldr	r0,[r0,#12]
ldr	r0,[r0]		@next sound data
ldr	r0,[r0,#12]
cmp	r0,#0
beq	endcounter1
ldr	r3,=playSound
mov	lr,r3
.short	0xF800
endcounter1:
mov	r0,#16
ldr	r1,=#0x04000200		@mark the bit for the interrupt
strh	r0,[r1,#2]
ldr	r1,=#0x03007FF8		@also mark the bit for the interrupt, I think the previous one is unneeded
strh	r0,[r1]
pop	{r1}
pop	{r0}
bx	r0

@if vblank, just acknowledge and return
wasvblank:
push	{lr}
push	{r1}
mov	r0,#1
ldr	r1,=#0x04000200		@mark the bit for the interrupt
strh	r0,[r1,#2]
ldr	r1,=#0x03007FF8		@also mark the bit for the interrupt, I think the previous one is unneeded
strh	r0,[r1]
pop	{r1}
pop	{r0}
bx	r0

End:
pop	{r0}
bx	r0
