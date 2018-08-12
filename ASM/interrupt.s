.arm
ldr	r0,=toThumb
add	r0,#1
bx	r0

.thumb

toThumb:
ldr	r0,=#0x04000200		@mark the bit for the vblank interrupt
mov	r1,#1
strh	r1,[r0,#2]
ldr	r0,=#0x03007FF8		@also mark the bit for the vblank interrupt, I think the previous one is unneded
mov	r1,#1
strh	r1,[r0]
bx	lr
