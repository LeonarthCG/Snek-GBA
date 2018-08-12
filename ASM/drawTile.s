.thumb

push	{lr}

@r0 = bg layer
@r1 = tile attribute (palette,tile id, flipping?
@r2 = x
@r3 = y

push	{r4,r5}
mov	r4,r2
mov	r5,r3

lsl	r0,#2
ldr	r2,=bgTilemapsBuffer
add	r0,r2
ldr	r0,[r0]		@bg layer map offset
lsl	r4,#1		@x*2 (*2 since each tile is a short)
add	r0,r4
lsl	r5,#6		@y*32*2 (32 being the ammount of tiles in a row)
add	r0,r5		@final offset = bg layer map offset + x*2 + y*32*2
strh	r1,[r0]

End:
pop	{r4,r5}
pop	{r0}
bx	r0
