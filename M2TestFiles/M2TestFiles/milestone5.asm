# milestone5.asm
#   - covers all but conditional branch instructions
#   - data and text segments both stress handling of immediate values 
#   - end-of-line comments and full-line comments in text segment
#
.data
Var0:    .word      -1
Var1:    .word   32767
Var2:    .word   29564
Var3:    .word   16384
Var4:    .word       0
Var5:    .word  -32767

.text
main:
         # load values of specified variables, except for V4
         la     $s1, Var1
         lw     $s1, ($s1)        # $s1 == 8
         la     $s2, Var2
         lw     $s2, ($s2)        # $s2 == 256
         lw     $s3, 8192($zero)  # $s3 == -1

         # compute some values, just for exercise
         addi   $s5, $zero, -1
         addi   $s5, $s3, 7800
         addi   $s6, $zero, -32000
         nor    $s6, $s3, $s4
         add    $s7, $s3, $s1
         addi   $s4, $s4, 32767

done:
         addi    $v0, $zero, 10      # set $v0 pgm termination syscall
         syscall
