.global _start

.section .text
_start:
.START:
	movq 	head(%rip), %rax #rax = head (int* p1 = head)
	xor	%rbx, %rbx #rbx = 0 (int* p2 = NULL)
	movq	$1, %rcx #rcx = 1 (int sorted = 1)
	xor 	%rdi, %rdi #rdi = 0 (enum case = HEAD)
	xor	%rdx, %rdx
	movq	$2, %r10
	jmp 	.WHILE
.NEXT:
	movq	8(%rax), %rax #p1 = p1 -> next
.SWITCH:
	movq    8(%rax), %rbx #p2 = p1 -> next
        testq	%rbx, %rbx
	cmove	%r10, %rdi #if(p2 == NULL) case = TAIL
	jmp	*.CASE(,%rdi,8)
.CASE:
	.quad 	.HEAD
	.quad 	.MID
	.quad 	.TAIL
.HEAD:
	inc 	%rdi #case = MID
	movl	(%rbx), %r15d
	cmpl	%r15d, (%rax)
	jle	.NEXT
	movq	$0, %rcx
	jmp 	.MID
	movq	%rbx, (head) #head = p2
	movq	8(%rbx), %r11	
	movq	%r11, 8(%rax) #p1 -> next = p2 -> next
	movq	%rax, 8(%rbx) #p2 -> next = p1
	jmp	.NEXT
.TAIL:
	testq	%rcx, %rcx #if(!sorted) goto start
	je	.START
	jmp	.END
.MID:
	movl	(%rbx), %r12d #t2 = p2 -> id  
	cmpl	%r12d, (%rax)
	jle	.NEXT #if(p1 -> id < p2 -> id) goto NEXT
	movq 	$0, %rcx
	movl	(%rax), %r8d #t1 = p2 -> id
	movl	4(%rax), %r9d #t12 = p1 -> data
        movl   	4(%rbx), %r13d #t22 = p2 -> data
	movl    %r12d, (%rax) #p1 -> id = t2
	movl  	%r13d, 4(%rax) #p1 -> data = t22
	movl   	%r8d, (%rbx) #p2 -> id = t1
        movl   	%r9d, 4(%rbx) #p2 -> data t12
	jmp	.NEXT	
.WHILE:
	testq 	%rax, %rax #while(p1 != NULL)
	jne 	.SWITCH	
.END:

