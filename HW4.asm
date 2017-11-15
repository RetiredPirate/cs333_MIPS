.data

arr:
    .word 30,-3,37,2876,28,7,-4,-73,-72,76
    .word 4,65,898,225,773,67437,5523,53,2256
    .word -44,2,77,2,774,2254,5287,222687,3235

endArr:
    .word -999999

enter:
    .asciiz "\n"


.text
main:

la $t0, arr         # $t0 outer pointer
lw $t1, ($t0)       # $t1 outer element
la $t2, arr         # $t2 inner pointer
lw $t3, ($t2)       # $t3 inner element
li $t4, 0           # $t4 temp for swaping values
la $t5, endArr      # $t5 is array end address
lw $t6, ($t5)       # $t6 is actual array end value
# li $t7, arr         # $t7 min value pointer
# lw $t8, ($t7)       # $t8 min value


outLoop:
    lw $t1, ($t0)
    beq $t1, $t6, endOutLoop   # break loop if end of array


    move $t2, $t0           # set up for inner loop
    move $t7, $t0
    lw $t8, ($t7)

    # this loop finds min element and swap with $t1
    inLoop:
        lw $t3, ($t2)
        beq $t3, $t6, endInLoop    # break at end of array

        #lw $t8, $t7
        bge $t3, $t8, next       # if $t3 >= $t8 then skip

        move $t8, $t3           # store min value
        move $t7, $t2           # store min pointer



        next:

        addi $t2, $t2, 4            #increment inner pointer
    j inLoop
    endInLoop:

    # swap values at $t0 and $t7
    lw $t1, ($t0)
    lw $t8, ($t7)

    sw $t1, ($t7)
    sw $t8, ($t0)

    addi $t0, $t0, 4    # increment outer pointer
j outLoop
endOutLoop:


# print the sorted array to the console
la $t0, arr         # $t0 array pointer

print:
    lw $t1, ($t0)
    beq $t0, $t5, endPrint      # break at end

    lw $a0, ($t0)      # print
    li $v0, 1
    syscall

    li $v0, 4       # print enter character
    la $a0, enter
    syscall

    # next element
    addi $t0, $t0, 4

j print
endPrint:



li $v0, 10 #exit program
syscall
