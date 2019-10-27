# CS10 Computer Architecture and Organization
# Student: Johanna Fransson, 20304515	
# Lab Assignment 8
# Program Name:	johannafranssonLab8.asm
# Description: Rewriting code so no data hazards 
#	       will occur using only nops

	.data
name_msg:	.asciiz "My name is Johanna Fransson\n"
ID_msg:		.asciiz "My student ID is 20304515\n"


	.text
main:	

	la $a0, name_msg    	#Print string	
	li $v0, 4           		
	syscall
	
	la $a0, ID_msg		#Print string
	li $v0, 4
	syscall
	
	
	add $3, $2, $3 
	nop			# line i1 have dependency on i2 that causes hazard (3)
	nop			# line i1 have dependency on 13 that causes hazard (2)
	lw  $4, 100($3)
	nop			# line i2 have dependecy on i4 that causes hazard (4)
	sub $7, $6, $2	
	nop			# line i3 have dependecy on i4 that causes hazard (6)
	xor $6, $4, $3
	
	

	
 	
 	
 	
 	
 	
	