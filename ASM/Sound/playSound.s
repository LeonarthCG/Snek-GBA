.thumb

mov	r3,r0		@song to play

@reset FIFO_B
ldr	r0,=#0x4000080
ldrh	r1,[r0,#2]
ldr	r2,=#0x8000
orr	r1,r2
strh	r1,[r0,#2]

@stop current DMA2
ldr	r0,=#0x40000C8
mov	r1,#0
strh	r1,[r0,#10]

@set DMA2 source
ldr	r1,[r3,#8]
str	r1,[r0]

@set DMA2 destination
ldr	r1,=#0x40000A4
str	r1,[r0,#4]

@set DMA2 count, not used but whatever
ldr	r1,[r3,#4]
lsr	r1,#2
strh	r1,[r0,#8]

@set DMA2 control
ldr	r1,=#0xB640
strh	r1,[r0,#10]

@set the sample rate
ldr	r0,=#0x4000100
ldr	r1,[r3]
strh	r1,[r0,#4]

@enable timer 1
ldr	r1,=#0xC0
strh	r1,[r0,#6]

ldr	r0,=soundCounters
mov	r1,#0
ldr	r2,[r0,#8]
str	r1,[r2]		@set played samples to 0
ldr	r2,[r0,#12]
str	r3,[r2]		@set song pointer

bx	lr
