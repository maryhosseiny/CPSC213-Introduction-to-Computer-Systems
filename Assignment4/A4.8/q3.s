.pos 0x1000
code:
ld $i, r0               # r0 = addr of i
ld (r0), r1             # r1 = i
ld $s, r2               # r2 = addr of s
ld (r2, r1, 4), r3      # r3 = s.x[i]
ld $v0, r4              # r4 = addr of v0
st r3, (r4)             # v0 = s.x[i]

ld 0x8(r2), r0          # r0 = s.y[0]
ld (r0, r1, 4), r5      # r5 = s.y[i]
ld $v1, r4              # r4 = addr of v1
st r5, (r4)             # v1 = s.y[i]

ld 0xC(r2), r0          # r0 = s.z->x[0]
ld (r0, r1, 4), r5      # r5 = s.z->x[i] 
ld $v2, r4              # r4 = addr of v2
st r5, (r4)             # v2 = s.z->x[i]

ld 0xC(r0), r2          # r2 = s.z->z  
ld 0x8(r2), r0          # r0 = s.z->z->y[0]
ld (r0, r1, 4), r5      # r5 = s.z->z->y[i]
ld $v3, r4              # r4 = addr of v3
st r5, (r4)             # v3 = s.z->z->y[i]
halt                    # halt

.pos 0x2000
static:
  i:      .long 0   # i
  v0:     .long 0   # v0
  v1:     .long 0   # v1
  v2:     .long 0   # v2
  v3:     .long 0   # v3
  s:      .long 0   # s.x[0]
          .long 0   # s.x[1]
          .long s_y # s.y
          .long s_z # s.z
          
.pos 0x3000
heap:
  s_y:    .long 0     # s.y[0]
          .long 0     # s.y[1]

  s_z:    .long 0     # s.z->x[0]
          .long 0     # s.z->x[1]
          .long 0     # s.z->y
          .long s_z_z # s.z->z

  s_z_z:  .long 0     # s.z.z->x[0]
          .long 0     # s.z.z->x[1]
          .long s_z_z_y # s.z.z->y
          .long 0     # s.z.z->z

  s_z_z_y:.long 0     #s.z.z.y[0]
          .long 0     #s.z.z.y[1]