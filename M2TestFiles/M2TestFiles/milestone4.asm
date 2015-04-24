# milestone4.asm
#   - covers included R-type instructions, basic lw and syscall
#   - covers addi and la pseudo instruction as well
#   - same data segment as milestone3.asm
#   - end-of-line comments and full-line comments in text segment
#
.data
V1:      .word       8
V2:      .word     256
V3:      .word    1024
V4:      .word    8192
V5:      .word      10

.text
main:
         # load values of specified variables, except for V4
         la     $s1, V1
         lw     $s1, 0($s1)        # $s1 == 8
         la     $s2, V2
         lw     $s2, 0($s2)        # $s2 == 256
         la     $s3, V3
         lw     $s3, 0($s3)        # $s3 == 1024
         la     $s4, V5
         lw     $s4, 0($s4)        # $s4 == 10

         # compute some values, just for exercise
         addi   $s5, $zero, 32767     # that's the maximum value for a 16-bit integer
         add    $s5, $s1, $s5
         addi   $s6, $zero, -32768    # and that's the minimum
         nor    $s6, $s3, $s4
         add    $s7, $s3, $s1

done:
         addi    $v0, $zero, 10      # set $v0 pgm termination syscall
         syscall
