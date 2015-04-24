# milestone2.asm
#   - covers only included R-type instructions, so rather dull
#   - uses minimal data segment; no arrays
#
.data
V1:      .word       8
V2:      .word     256
V3:      .word    1024
V4:      .word    8192

.text
main:
         add    $s0, $zero, $zero
         sub    $s1, $s0, $s7
         add    $s5, $s3, $s0

         add    $s3, $s3, $s3
         nor    $s4, $s3, $s2

done:
