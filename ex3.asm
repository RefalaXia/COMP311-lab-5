# Assembly starter file for Exercise 3

.data 0x0
  
  columnPrompt:	.asciiz "Enter the column to print a line at (must be an integer in the range 0-29):\n"
  newline:	.asciiz "\n"
  displayChar:  .asciiz "*"
  lineChar:  .asciiz "|"
  i:	     .space 4


.text 0x3000

main:
 	# Print the prompt for reading the column number
  addi	$v0, $0, 4  			  # system call 4 is for printing a string
  la 	$a0, columnPrompt 		  # address of columnPrompt is in $a0
  syscall           			  # print the string


  addi	$v0, $0, 5			  # system call 5 is for reading an integer
  syscall 				  # integer value read is in $v0
  add	$s0, $0, $v0		          # copy the column number into $s0
  
  add	$8, $0, $0			  # i in $8 = 0, i is the column number
  add	$9, $0, $0			  # j in $9 = 0, j is the row number
  
loop:
  sll	$10, $8, 2			  # convert "i" to word offset by multiplying by 4
  sll	$11, $9, 2			  # convert "j" to word offset by multiplying by 4
  beq	$8, $s0, line 		 	  # jump to line if i = the column number entered

  slti	$10, $8, 30			  # for (...; i<30;...
  beq 	$10, $0, looptwo	          # if $10 = 0, go to looptwo
  addi	$v0, $0, 4			  # system call 11 is for printing a string
  la	$a0, displayChar		  # address of displayChar is in $a0
  syscall				  # print the string
  addi	$8, $8, 1			  # for (...; ...; i++
  slti	$10, $8, 30			  # for (...; i<30;...
  bne	$10, $0, loop			  # if $10 != 0, go to loop
  
looptwo:
  addi	$v0, $0, 4  			  # system call 4 is for printing a string
  la	$a0, newline			  # address of newline is in $a0
  syscall				  # print the string
  
  addi  $9, $9, 1			  # for (...; ...; j++
  slti	$11, $9, 10			  # for (...; j<10;...
  add	$8, $0, $0			  # i in $8 = 0, i is the column number
  bne	$11, $0, loop			  # if $11 != 0, go to loop
  beq   $11, $0, exit			  # if $11 = 0, go to exit
  
line:
  addi	$v0, $0, 4			  # system call 11 is for printing a string
  la	$a0, lineChar		  	  # address of lineChar is in $a0
  syscall				  # print the string
  addi	$8, $8, 1			  # for (...; ...; i++
  slti	$11, $9, 10			  # for (...; j<10;...
  bne	$11, $0, loop			  # if $11 != 0, go to loop

	# Exit from the program
exit:
  ori $v0, $0, 10       		  # system call code 10 for exit
  syscall               		  # exit the program
