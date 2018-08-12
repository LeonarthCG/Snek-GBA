.thumb

@ r0 = tile id
@ r1 = facing direction
@ r2 = palette

@just shifting the values and anding them so they do not go over the limis
@10 first bits are tile id, then one bit for horizontal and one bit for vertical flipping, lastly 4 bits for palette id

ldr	r3,=#0x3FF
and	r0,r3

lsl	r1,#10
ldr	r3,=#0xC00
and	r1,r3

lsl	r2,#12
ldr	r3,=#0xF000
and	r2,r3

add	r0,r1
add	r0,r2

bx	lr
