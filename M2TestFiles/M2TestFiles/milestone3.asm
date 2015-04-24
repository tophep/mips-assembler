# milestone3.asm
#   - covers included R-type instructions, basic lw and syscall
#   - same data segment as milestone10.asm
#   - end-of-line comments
#
.data
V1:      .word       8
V2:      .word     256
V3:      .word    1024
V4:      .word    8192
V5:      .word      10

.text
main:
         lw     $s0, 8204($zero)     # $s0 points to beginning of data segment
         lw     $s1, 0($s0)          # $s1 == 8
         lw     $s2, 4($s0)          # $s2 == 256
         lw     $s3, 8($s0)          # $s3 == 1024
         lw     $s4, 16($s0)         # $s4 == 10

         add    $s5, $s1, $s2
         nor    $s6, $s3, $s4
         add    $s7, $s3, $s1

done:
         add    $v0, $zero, $s4      # set $v0 pgm termination syscall
         syscall
