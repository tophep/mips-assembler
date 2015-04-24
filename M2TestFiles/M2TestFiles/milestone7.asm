# milestone7.asm
#   - covers everything, including array in data segment
#
.data
ULimit:     .word      12
Init:       .word       0
Increment:  .word       2
Data:       .word    27:11

.text
main:
         # load values of specified variables, except for V4
         la     $s1, Init
         lw     $s1, 0($s1)        # $s1 == initial value for summation
         la     $s2, ULimit
         lw     $s2, 0($s2)        # $s2 == iteration limit
         la     $s3, Increment
         lw     $s3, 0($s3)        # $s3 == base step value for summation
         la     $s4, Data          # $s4 points to Data[0]
         
         beq    $s2, $zero, done   # nothing to sum if ULimit == 0
         
loop:
         lw     $s5, 0($s4)        # get current array element
         beq    $s1, $s5, skip     # update running total iff it doesn't match array elem
         add    $s1, $s1, $s3      # update running total for summation
skip:
         addi   $s4, $s4, 4        # increment pointer
         addi   $s3, $s3, 1        # increase step size
         addi   $s2, $s2, -1       # decrement loop counter
         
         bne    $s2, $zero, loop
done:
         addi   $v0, $zero, 10
         syscall
