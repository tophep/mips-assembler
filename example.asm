# adder.asm 
#
# The following program initializes an array of 10 elements and computes
# a running sum of all elements in the array. The program prints the sum 
# of all the entries in the array.

.data
	message: 	.asciiz "The sum of numbers in array is: "
      array:      .word   0:10
 array_size: .word   10
 other_array: .word 1,2,3,4,5
 message2: .asciiz "1"
 message3: .asciiz "111"

.text 

main:
	la   $a0, array
	la   $a1, array_size
	lw   $a1, 0($a1)
loop:
	sll  $t1, $t0, 2
	add  $t2, $a0, $t1
	sw   $t0, 0($t2)
	addi $t0, $t0, 1
	add  $t4, $t4, $t0
	slt  $t3, $t0, $a1
	bne  $t3, $zero, loop
	li   $v0, 4
	la   $a0, message
	syscall
	li   $v0, 1
	or   $a0, $t4, $zero
	syscall
	li   $v0, 10
	syscall