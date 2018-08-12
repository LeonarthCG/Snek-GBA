.thumb

push	{lr}

@r0 = tile attribute (palette,tile id, flipping?
@r1 = bg layer
@r2 = x
@r3 = y

push	{r4,r5}
mov	r4,r2
mov	r5,r3

@set starting size of snake
lsl	r1,#2
ldr	r2,=bgTilemaps
add	r1,r2
ldr	r1,[r1]		@bg layer map offset
lsl	r4,#1		@x*2 (*2 since each tile is a short)
add	r1,r4
lsl	r5,#6		@y*32*2 (32 being the ammount of tiles in a row)
add	r1,r5		@final offset = bg layer map offset + x*2 + y*32*2
strh	r0,[r1]

End:
pop	{r4,r5}
pop	{r0}
bx	r0
