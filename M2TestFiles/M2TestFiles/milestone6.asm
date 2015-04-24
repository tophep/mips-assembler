# milestone6.asm
#   - covers conditional branch instructions
#
.data
ULimit:     .word     512
Init:       .word       0
Increment:  .word      17

.text
main:
         # load values of specified variables, except for V4
         la     $s1, Init
         lw     $s1, 0($s1)        # $s1 == initial value for summation
         la     $s2, ULimit
         lw     $s2, 0($s2)        # $s2 == iteration limit
         la     $s3, Increment
         lw     $s3, 0($s3)        # $s3 == base step value for summation
         
         beq    $s2, $zero, done   # nothing to sum if ULimit == 0
         
loop:
         add    $s1, $s1, $s3      # update running total for summation
         addi   $s3, $s3, 1        # increase step size
         addi   $s2, $s2, -1       # decrement loop counter
         
         bne    $s2, $zero, loop
done:
         addi   $v0, $zero, 10
         syscall
