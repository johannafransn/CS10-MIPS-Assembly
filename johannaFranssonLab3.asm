#  CS10 Lab 3
# Program to demonstrate Arithmetic & Logical Operations
# Development Environment:  MARS MIPS Simulator
# Name:  Johanna Fransson
# Solution File: johannaFranssonLab3.asm
# Date:  28/4/19
# Registers Used:
# $s0 : holds myID = 20
# $s1 : holds nLet = 8
# $t6 : to hold branch result
# $t0 : to hold addition result
# $t1 : to hold subtract result
# $t3 : to hold multi result
# $t4 : to hold divide result
# $a0 : to contain string or number to be printed
# $v0 : syscall parameter

	.data
intro_msg:	 .asciiz "My family name is Fransson\nStudent ID: 20304515\n"
myID_msg:        .asciiz "The value of myID is 20\n"
letters_msg:     .asciiz "Number of letters in my lastname is 8\n\n"
addition:        .asciiz " myID + nLet = "
subtract:        .asciiz "\n nLet - myID = "
multi:           .asciiz "\n nLet * 4 = "
divide:          .asciiz "\n (myID + nLet) / 2 = "
divide_odd:	 .asciiz "\n (nLet + myId) is odd. (nLet + myId) + 1 = "

nLet: .word 7          		# nLet = 8
myID: .word 20          	# myID = 20


	.text
main:		
 
 li $v0, 4           		# Print intro_msg to console					
 la $a0, intro_msg  		# Load the addr of intro_msg into $a0
 syscall 
 
 li $v0, 4           		# Print myID_msg to console					
 la $a0, myID_msg  	        # Load the addr ofmyID_value into $a0
 syscall
   
 li $v0, 4           		# Print nr_letters to console					
 la $a0, letters_msg	        # Load the addr of letters_msg into $a0
 syscall
  
 li $v0, 4           		# Print addition to console					
 la $a0, addition	        # Load the addr of additon into $a0
 syscall
   
 lw     $s0, myID       	# $s0 = myId
 lw     $s1, nLet        	# $s0 = nLet
  
 add $t0, $s0, $s1		#Add myId+nLet = 28 = t0
 sub $t1, $s1, $s0		#Subtract nLet-myID = -12 = t1
 mulo $t3, $s1 4   		# $t3 = nLet * 4 = 32 = t3
 div  $t4, $t0 2		#Divide t0 with 2 = t4
		
 move  $a0, $t0		# Now print out the result
 li    $v0, 1            	# 1 means the print_int syscall
  syscall
  
 li $v0, 4           		# Print subtract to console					
 la $a0, subtract	        # Load the addr of subtract into $a0
 syscall
  
move  $a0, $t1		# Now print out the result
li    $v0, 1            	# 1 means the print_int syscall
syscall
  
li $v0, 4           		# Print subtract to console					
la $a0, multi	                # Load the addr of subtract into $a0
syscall
  
move  $a0, $t3			# Now print out the result
li    $v0, 1            	# 1 means the print_int syscall
syscall
  				
  	
andi $t6, $t0, 1 		# even/odd test
bne $t6, $zero, odd
j even 

odd: 	
			
addi $t0, $t0, 1		# (nLet + myId) + 1
la $a0, divide_odd
li $v0, 4
syscall

move $a0, $t0
li $v0, 1
syscall

even:

srl $t4, $t0, 1
la $a0, divide 			# divide: (nLet + myId) / 2
li $v0, 4
syscall

move $a0, $t4
li $v0, 1
syscall

li $v0, 10 			# exit
syscall
