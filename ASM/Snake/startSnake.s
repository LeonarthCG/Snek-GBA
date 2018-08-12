.thumb

push	{lr}

@set the starting coords of each piece of the body
ldr	r0,=#0x0B19
ldr	r1,=#0x02000020
strh	r0,[r1]
sub	r0,#1
strh	r0,[r1,#2]
sub	r0,#1
strh	r0,[r1,#4]

@set starting size of snake
mov	r0,#3
ldr	r1,=#0x02000000
strh	r0,[r1]
strh	r0,[r1,#0xE]

pop	{r0}
bx	r0
