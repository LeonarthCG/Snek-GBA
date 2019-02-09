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
beq	wasvblank

@if timer 0, increase samples played, if samples are over end song
wascounter0:
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
	@ - !!! -
@start next song (or loop)
ldr	r0,=soundCounters
ldr	r0,[r0,#4]
ldr	r0,[r0]		@next song data
cmp	r0,#0
beq	endcounter0
ldr	r3,=playSong
mov	lr,r3
.short	0xF800
endcounter0:
mov	r0,#8
b	End


@if vblank, just acknowledge and return
wasvblank:
mov	r0,#1
b	End

End:
ldr	r1,=#0x04000200		@mark the bit for the interrupt
strh	r0,[r1,#2]
ldr	r1,=#0x03007FF8		@also mark the bit for the interrupt, I think the previous one is unneeded
strh	r0,[r1]
pop	{r0}
bx	r0
