.data
enter:
    .asciiz "\n"


.text
main:


move $t0, $sp

read:
    li $v0, 5
    syscall

    blez $v0, print      # break

    subu $sp, $sp, 4    # push to stack
    sw $v0, ($sp)

    j read              # repeat loop

print:
    beq $sp, $t0, endPrint

    lw $a0, 0($sp)      # print
    li $v0, 1
    syscall

    li $v0, 4       # print enter character
    la $a0, enter
    syscall

    # pop
    addiu $sp, $sp, 4

    j print

endPrint:
    li $v0, 10 #exit program
    syscall
