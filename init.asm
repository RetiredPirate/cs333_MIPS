.data
list:
    .word 2, 3, 5, 23, 29, 11, -13, -10, 17, 19
end:
    .word 999999
string_least:
    .asciiz "Here be the least number: "
string_sum:
    .asciiz "Here be ye sum: "
enter:
    .asciiz "\n"

.text
main:

#load the array start address in reg $a0
#load the size of array in reg $a1
la $a0, list
la $t4, end
lw $a1, ($t4)

#load the first element in t0 (min)
lw $t0, ($a0)

#initialize the counter to 1
li $t1, 1

loop:
    addi $a0, $a0, 4    #increment pointer to array
    lw $t2, 0($a0)      #load next element of array

    beq $t2, $a1, exit  #exit at end of array

    addi $t1, $t1, 1    #increment counter
    lw $t2, 0($a0)      #load next element of array

    bge $t2, $t0, loop_end

    move $t0, $t2
loop_end:
j loop

exit:


#################### ADD LOOP

la $a0, list
la $t4, end
lw $a1, ($t4)
addi $t3, $0, 0

add_loop:
    lw $t1, ($a0)
    beq $a1, $t1, exit_add

    add $t3, $t1, $t3
    addi $a0, $a0, 4

    j add_loop

exit_add:

    addi $a0, $t0, 0

    li $v0, 4       # print the least value message
    la $a0, string_least
    syscall

    li $v0, 1       # print the value
    move $a0, $t0
    syscall

    li $v0, 4       # print enter character
    la $a0, enter
    syscall


    li $v0, 4       # print the sum value message
    la $a0, string_sum
    syscall

    li $v0, 1       # print the value
    move $a0, $t3
    syscall

    li $v0, 4       # print enter character
    la $a0, enter
    syscall


    li $v0, 10 #exit program
    syscall
