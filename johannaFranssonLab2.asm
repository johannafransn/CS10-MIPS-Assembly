#  CS10 Lab 3
# Program to demonstrate Arithmetic & Logical Operations
# Development Environment:  MARS MIPS Simulator
# Name:  Johanna Fransson
# Solution File: johannaFranssonLab3.asm
# Date:  28/4/19
# Registers Used:
# $s0 : holds myID
# $s1 : holds nLet

	.data
intro_msg:	.asciiz	"My family name is Fransson\nStudent ID: 20304515\n"
myID_value:     .asciiz "The value of myID is 20\n"
nr_letters:     .asciiz "Number of letters in my lastname is 8\n\n"
addition:       .asciiz " myID + nLet = "
subtract:       .asciiz "\n nLet - myID = "
multi:          .asciiz "\n nLet * 4 = "
	.text
main:		
 
   li $v0, 4           		# Print intro_msg to console					
   la $a0, intro_msg  		# Load the addr of intro_msg into $a0
   syscall 
    				
   li $v0, 4           		# Print myID_value to console					
   la $a0, myID_value  	        # Load the addr ofmyID_value into $a0
   syscall
   
   li $v0, 4           		# Print nr_letters to console					
   la $a0,   nr_letters	        # Load the addr of nr_letters into $a0
   syscall
  
   li $v0, 4           		# Print addition to console					
   la $a0, addition	        # Load the addr of additon into $a0
   syscall

   li $s0, 20			#Store myID in s0
   li $s1, 8			#Store myID in s1
   add $t0, $s1 $s0		# t1 = 20 + 8 = 28
   
   li $v0, 1			#Print integer
   move $a0, $t0
   syscall
   
    li $v0, 4           	# Print subtract to console					
   la $a0, subtract	        # Load the addr of subtract into $a0
   syscall
   
   li $s0, 20			#Store myID in s0
   li $s0, 8			#Store myID in s1
   sub $t1, $s0 $s1		# t2 = 8 - 20 = 
   
   li $v0, 1			#Print integer
   move $a0, $t1
   syscall
   
   li $v0, 4           		# Print multi to console					
   la $a0, multi	        # Load the addr of multi into $a0
   syscall
   
   li $s0, 20			#Store myID in s0
   li $s0, 8			#Store myID in s1
   mul $t2, $s1, 4		# t3 = 8 * 4 =
   
   li $v0, 1			#Print integer
   move $a0, $t2
   syscall
   
   li $v0, 10 			# Exit the program
   syscall 
