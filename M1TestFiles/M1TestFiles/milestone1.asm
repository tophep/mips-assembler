# milestone0.asm
# 
# Tests all the required elements.
#
.text
        add  $s0, $s1, $s2       # add and three register names
        sub  $s3, $s4, $s5       # sub and three more register names
        addi $s6, $s7, 1023      # addi, two more register names, immediate
        
        addi $v0, $v0, 10        # select exit call
        syscall                  # make call
