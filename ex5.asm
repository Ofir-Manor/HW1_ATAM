.global _start

.section .text
_start:
	movq 	head(%rip), %rdi #int* p1 = head
	movq	$0, %rsi #int* p2 = NULL
	movq	%rdi, %r8 #int* p3 = p1
	movl 	$0, %eax #int t1 = 0
	movl	$0, %ecx #int t2 = 0
	movb 	$0, %bl #bool not_sorted = FALSE
	testq 	%rdi, %rdi #if(p1 == NULL){
	cmovne  8(%rdi), %rsi #p2 = head -> next
.SORT:
	testq	%rsi, %rsi
	je 	.DONE #		goto DONE }
	movl	(%rdi), %eax #t1 = p1 -> id	
	movl	(%rsi), %ecx #t2 = p2 -> id
	#chek if need to switch nodes
	cmpl 	%ecx, %eax
	jle 	.NO_SWITCH
	#switch nodes
	movb 	$1, %bl #not_sorted = TRUE
	movq 	8(%rsi), %r9 #int* temp = p2 -> next
	movq 	%rdi, 8(%rsi) #p2 -> next = p1
	movq	8(%rdi), %r9 #p1 -> next = temp
	movq	%rsi, (%r8) #head / p3 -> next = p2
	#getting things ready for next iteration
	movq 	%r8, %rsi #p3 = p2
	addq	$8, %r8 #p3 = p3 -> next
	movq	%r9, %rsi #p2 = temp
	testq	%rsi, %rsi
	jne 	.SORT
.NO_SWITCH:
	#getting things ready for next iteration
	movq	%rdi, %r8 #p3 = p1
	addq 	$8, %r8 #p3 = p3 -> next 
	movq	8(%rdi), %rdi #p1 = p1 -> next
	testq	%rsi, %rsi
	cmovne	8(%rsi), %rsi #p2 = p2 -> next only if legal
	jne 	.SORT #inner loop, until we reach the end of the list
.DONE:
	testb	%bl, %bl #not_sorted == 0  => list sorted
	jne _start

	
	
