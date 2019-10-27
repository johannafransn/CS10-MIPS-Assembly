# CS10 Computer Architecture & Organization
# Name: Johanna Fransson
# Lab Assignment 6
# Program Name:	johannafranssonFoothillLab6.asm
# Description:  Write a program to compute the value 
#		of the sum 1*2  +  2*3 + … + 20*21.  
#		Use the designated register to fetch 
#		the 32-bit product result. Print the final result.
# Registers used:
# $t1 - to hold the result sum
# s0  - end of value n=20
# $s1 - start value of n=1
# $s2  - used to hold s2=1 to increment by 1 in loop
# $s3 - start value of n=2
# $s4 - store the products produced
# $a0 - load the address of str/int to be printed
# $v0 - holds adress to print str
#
#
#

	.data
	
name_msg:		.asciiz "My name is Johanna Fransson\n"
ID_msg:			.asciiz "My student ID is 20304515\n"

start_val_one:		.word 1		# created value for 1 (n start value)
start_val_two:		.word 2		# created value for 1 (n start value)


	.text

main:
	
	la $a0, name_msg    		
	li $v0, 4           		# print name_msg
	syscall
	
	la $a0, ID_msg			# print ID msg
	li $v0, 4
	syscall				
	
	
	li $s0, 20			# hold end of loop value 1<= n <=20
	lw $s1, start_val_one		# Stores the value of 1 into $s2
	lw $s3, start_val_two		# Stores the value of 2 into $s3
	

	
 loop:
 	
 	bgt $s1 $s0, exit               # branch if greater than n>20 to exit
 	
 	mult $s1, $s3		        # n(n+1) and s1=1 s3=2 (start values of series)
	mflo $s4		        # store lower 32 bit result of mult in $s4
	
	add $t1, $t1, $s4	        # t1=result sum and then add the products to t1
	
	addi $s1, $s1, 1	        # counter/increment
	addi $s3, $s3, 1

b loop 					# branch back to start
 

exit:

	move $a0, $t1			# moves $t1 into $a0 so it can be called & printed
	li $v0, 1			# print int	
	syscall
	
	li $v0, 10			# exit syscall
	syscall


# $s0 increment int (1)       =1 
# $s1 max val of n (21)       =s0
# $t0 inital val of n (1)     = S1
# $t1 result sum              = T1
# $t2 initial val of n (1)    = S3
# $t3 store induvidual products =s4
