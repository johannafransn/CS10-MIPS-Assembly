#
# CS10 Computer Architecture and Organization
# Johanna Fransson	
# Lab Assignment 5 
# Program Name:	johannafranssonFoothillLab5.asm
# Description:  Program to calculate the average of 
#		two values using the stack and procedures.
#
# Registers used:
# $a0 - load the address of string/integer to be printed
# $t0 - hold the average number
# $t1 - hold the sum value so we can calc average
# $v0 - hold print_str syscall
# $s0 - hold the value 12
# $s1 - hold the value 16
# $s2 - hold the value 2 so I can divide the sum to find the average
# $sp - stack pointer
# $ra - return address
# $sw - save the word
# $zero - used to move registers

	.data
name_msg:	.asciiz "My name is Johanna Fransson\n"
ID_msg:		.asciiz "My student ID is 20304515\n"

	.text
main:	

	la $a0, name_msg    		# load the address of name_msg into $a0
	li $v0, 4           		# print_string syscall
	syscall
	
	la $a0, ID_msg
	li $v0, 4
	syscall

	li $s0, 12			# num1=s0=12
	li $s1, 16			# num2=s1=16
	li $s2, 2			# will used to divide the sum of 12 and 16 to calc average
	
	sub $sp, $sp, 12		# creates space in stack frame
	sw $s0, 8($sp)			# pushing parameters into stack
	sw $s1, 4($sp)
			
	jal jf_avg			# calls function that is avg calc
	
	lw $t0, 0($sp)			# the result
	addi $sp, $sp, 8
	
	add $a0, $t0, $zero		
	li $v0, 1
	syscall

	li $v0, 10			# exit
	syscall


	jf_avg:				# function ''calculate the average''
		
		lw $s1, 4($sp)		# pass arguments
		lw $s0, 8($sp)
		addi $sp, $sp, 8	# creating room in stack
		sw $t0, 0($sp)		# keeps value in stack
		
		add $t1, $s1, $s0	# keeps sum of 12 and 16 in $t1
		
		div $t0, $t1, $s2	# stores $t1 divided by 2 into $t0 (calculates average)
		sw $t0, 4($sp)			

		lw $t0, 0($sp)		# return address
		addi $sp, $sp, 4
		
		jr $ra
		
