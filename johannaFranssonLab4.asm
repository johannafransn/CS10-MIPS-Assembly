#
# CS10 Computer Architecture and Organization
# Johanna Fransson	
# Lab Assignment 4 
# Program Name:	johannaFranssonLab4.asm
# Description:  User is gonna input a number, by looping
#		program is going to compute all the odd 
#		numbers it takes to get users number, then print
# Registers used:
# $a0 - load the address of string or integer to be printed
# $t0 - hold user input int value
# $t1 - hold strating loop value 1
# $v0 - hold print_str syscall


.data

name_msg:	.asciiz "Name: Johanna Fransson\n"
ID_msg:		.asciiz "Student ID: 20304515\n"
user_input:	.asciiz	"Enter the Top value: "
result:		.asciiz	"Sum for Top value is: "


.text

main:

la $a0, name_msg    			# Load the address of name_msg into $a0
li $v0, 4           			# Prints_string 
syscall

la $a0, ID_msg
li $v0, 4
syscall

li $v0, 4      				#  Prints_string
la $a0, user_input 			#  Using user_input
syscall
              
li $v0, 5     				# Let user enter integer store in $v0
syscall
move $t0, $v0  				# Put user input away into $t0


li $t1, 1				# Start the loop at value of 1
move $a0, $t1

add $a0, $zero, $zero			# Initialize

top_of_loop:

	bgt $t1, $t0, end_of_loop	# End loop if loop exceeds the user input ($t0) = loop limit
	
	add $a0, $a0, $t1		# Add odd numbers
	add $t1, $t1, 2			# $t0 += 2
	b top_of_loop			# And loop back

end_of_loop:	

	li $v0, 1			# Prints_int
	syscall
					# exit
	li $v0, 10
	syscall	


