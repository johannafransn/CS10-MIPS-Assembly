# CS10 Computer Architecture & Organization
# Name: Johanna Fransson
# Lab Assignment 7
# Program Name:	johannafranssonFoothillLab7.asm
# Description:  Write your own exception handle program
#		for zerodivide.asm that will print
#		exception code & the instruction adress
#		
# Registers used:
# $v0 - save_v0 used to hold 0
# $a0 - save_a0 used to hold 0	
# $at - temporary register reserved for the assembler
# $k0 - temporary registers for kernel use.
# $k1 - temporary registers for kernel use.

	

	.kdata
	
instruc_adress: .asciiz "\n\nException was caused by the instruction at Address:"
excep_code:	.asciiz "\nThe exception code:  " 
ignore_msg:	.asciiz "\nOccured & Ignored, continue program "

			
			# Variables for save/restore of registers used in the handler
save_a0:		.word 0	
save_v0:		.word 0
		

	.ktext 0x80000180

	.set noat
	move $k1 $at                 # save $at to k1
	.set at

	sw $v0 save_v0               # $sp cannot be trusted so 
	sw $a0 save_a0               # save registers to static variables 
	
	li $v0 4               	     #  print_str
	la $a0 instruc_adress
	syscall
				     # Determine cause of the exception
	mfc0  $k0, $14  	     # Get cause register from coprocessor 0
	move  $a0, $k0  	     # move $k0 -> $a0 to later print
	li    $v0, 34   	     # 34 is print syscall in hex 
	syscall 
	
	li $v0 4                     # print_str
	la $a0 excep_code
	syscall
	
	li $v0 1                    # print_integer
	mfc0 $k0 $13                # Get the cause register
	srl $a0 $k0 2               # Right-justify interrupt level bits
	andi $a0 $a0 0xf	    # word-aligned ?
	syscall

	bne $k0 0x18 ok_pc		# Check for program counter issues
	nop

	mfc0 $a0 $14           		# EPC holds PC at moment exception occurred
	andi $a0 $a0 0x3        	# Is EPC word-aligned (multiple of 4)?
	beq $a0 0 ok_pc
	nop

	li $v0 10               	# Bail out if PC is unaligned
	syscall
ok_pc:

	li $v0 4                	# syscall 4 (print_str)
	la $a0 ignore_msg               # "occurred and ignored" message
	syscall

	srl $a0 $k0 2           	# Extract exception code from $k0 again
	andi $a0 $a0 0xf
	bne $a0 0 return                # 0 means exception was an interrupt
	nop

return:

	mfc0 $k0 $14            	# Get EPC register value
	addiu $k0 $k0 4         	# Skip faulting instruction by skipping
	                        	# forward by one instruction
                          		# (Need to handle delayed branch case here)
	mtc0 $k0 $14            	# Reset the EPC register
	
	lw $v0 save_v0                  # Restore $v0 and $a0
	lw $a0 save_a0

	.set noat			# Prevent assembler from modifying $at
	move $at $k1            	# Restore $at
	.set at

	mtc0 $0 $13             	# Clear Cause register

	mfc0 $k0 $12            	# Read status register
	ori  $k0 0x1            	# Set interrupt enable bit
	mtc0 $k0 $12			# Write back

	eret				# Returns the exception handler to the EPC register
	
	
