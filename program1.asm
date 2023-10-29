#CS 2640 First Project
#Members: Nguyen Huy Anh Le, Nathan Brown, Xander Gupton, Emily Chiu
#10/23/2023
#Program that prompts user for two numbers
#Adds, subtracts, multiplies, and divides all numbers and prints results of each
#Checks if numbers are equal, prints result.

.data 
prompt1: .asciiz "Please enter the first integer: "
prompt2: .asciiz "Please enter the second integer: "
numsBack: .asciiz "The numbers entered are:"
numsSum: .asciiz "The sum of the numbers is: "
numsDiff: .asciiz "The difference of the numbers is: "
numsProduct: .asciiz "The product of the numbers is: "
numsQuo: .asciiz "The quotient of the numbers is: "
numsRemainder: .asciiz " with a remainder of "
numsEqual: .asciiz "User inputs are the same"
numsNotEqual: .asciiz "User inputs are different."
newLine: .asciiz "\n"

.text
main: 
	#output first number prompt
	li $v0, 4 
	la $a0, prompt1
	syscall
	#get user num 1
	li $v0, 5
	syscall
	move $s0, $v0
	
	#output second number prompt
	li $v0, 4 
	la $a0, prompt2
	syscall
	#get user num 1
	li $v0, 5
	syscall
	move $s1, $v0
	
	#output numbers back to the user
	li $v0, 4 
	la $a0, numsBack
	syscall
	#Print a new line
	li $v0, 4 
	la $a0, newLine
	syscall
	#Print out first number
	move $a0, $s0
	li $v0, 1
	syscall
	#Print a new line
	li $v0, 4 
	la $a0, newLine
	syscall
	#Print out second number
	move $a0, $s1
	li $v0, 1
	syscall
	#Print a new line
	li $v0, 4 
	la $a0, newLine
	syscall
	
	j math
	
math:
	#all operations, store in different temp variables
	add $t0, $s0, $s1
	sub $t1, $s0, $s1
	mul $t2, $s0, $s1
	div $s0, $s1
	mflo $t3 	#Quotient stored in lo register, move to $t3
	mfhi $t4	 	#Remainder stored in hi register, move to $t4
	
	#Print out addition result
	li $v0, 4 
	la $a0, numsSum
	syscall
	move $a0, $t0
	li $v0, 1
	syscall
	#Print a new line
	li $v0, 4 
	la $a0, newLine
	syscall
	#Print out subtraction result
	li $v0, 4 
	la $a0, numsDiff
	syscall
	move $a0, $t1
	li $v0, 1
	syscall
	#Print a new line
	li $v0, 4 
	la $a0, newLine
	syscall
	#Print out multiplication result
	li $v0, 4 
	la $a0, numsProduct
	syscall
	move $a0, $t2
	li $v0, 1
	syscall
	#Print a new line
	li $v0, 4 
	la $a0, newLine
	syscall
	#Print out division result
	li $v0, 4 
	la $a0, numsQuo
	syscall
	move $a0, $t3
	li $v0, 1
	syscall
	
	#Check for special case when remainder is present, otherwise continue to last part
	bnez $t4, remainder
	beqz $t4, checkEquals	
	
remainder:
	#If there is a remainder, print out extra text with remainder
	li $v0, 4
	la $a0, numsRemainder
	syscall
	move $a0, $t4
	li $v0, 1
	syscall
	
	j checkEquals
checkEquals:
	#Print a new line
	li $v0, 4 
	la $a0, newLine
	syscall
	
	#compare if number are equal or not
	beq $s0, $s1, equal	#if nums equal, go to equal
	bne $s0, $s1, notEqual	#if nums not equal, go to notEqual
	
equal:
	#runs if nums are equal
	li $v0, 4 
	la $a0, numsEqual
	syscall
	j exit
	
notEqual:
	#runs if nums are not equal
	li $v0, 4 
	la $a0, numsNotEqual
	syscall
	j exit
	
exit:
	#exit syscall
	li $v0, 10
	syscall
	
