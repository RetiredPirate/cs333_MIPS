.data

#### DO NOT MODIFY ####
# statically-allocated linked list
.align 2		#formatting: word-aligned
node1:	.word -5,node3
node2:	.word 17,0
node3:	.word 44,node4
node4:	.word 6,node5
firstElement:
	.word -9,node1
node5:	.word -21,node2

.text
main:

    la $a0, firstElement
    li $t0, 0

loop:
    lw $t1, ($a0)
    add $t0, $t0, $t1       # add to sum

    addi $a0, $a0, 4        # move to address
    lw $a0, ($a0)         # move to next node

    beqz $a0, end

    j loop
end:


    li $v0, 1       # print the value
    move $a0, $t0
    syscall

	# exit
	li $v0,10
	syscall
