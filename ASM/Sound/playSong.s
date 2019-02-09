.thumb

mov	r3,r0		@song to play

@reset FIFO_A
ldr	r0,=#0x4000080
ldrh	r1,[r0,#2]
ldr	r2,=#0x800
orr	r1,r2
strh	r1,[r0,#2]

@set DMA1 source
ldr	r0,=#0x40000BC
ldr	r1,[r3,#8]
str	r1,[r0]

@set DMA1 destination
ldr	r1,=#0x40000A0
str	r1,[r0,#4]

@set DMA1 count, not used but whatever
ldr	r1,[r3,#4]
lsr	r1,#2
strh	r1,[r0,#8]

@set DMA1 control
ldr	r1,=#0xB640
strh	r1,[r0,#10]

@set the sample rate
ldr	r0,=#0x4000100
ldr	r1,[r3]
strh	r1,[r0]

@enable timer 0
ldr	r1,=#0xC0
strh	r1,[r0,#2]

ldr	r0,=soundCounters
mov	r1,#0
ldr	r2,[r0]
str	r1,[r2]		@set played samples to 0
ldr	r2,[r0,#4]
str	r3,[r2]		@set song pointer

bx	lr
