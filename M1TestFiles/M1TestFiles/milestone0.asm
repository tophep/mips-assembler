# milestone0.asm
# 
# Tests all the required elements.
#
.text
        add  $s0, $s1, $s2       # add and three register names
        sub  $s3, $s4, $s5       # sub and three more register names
        add  $s6, $s7, $s7       # add and last three s-registers
        sub  $v0, $v0, $v0       # sub and $v0
