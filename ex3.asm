.global _start

.section .text
_start:
	xor %rcx,%rcx #int i = 0;
	xor %rax,%rax #int a = 0;
	xor %rsp,%rsp #int t = 0;
	movw (len),%cx #i = *len;
	movq $arr,%rbx #p = arr;
.Loop:
	movl (%rbx,%rcx,4),%esp #t = p[i];
	addq %rsp,%rax #a += t;
	loop .Loop #i--
.End:
	movw (len),%cx
	xor %rdx,%rdx
	div %rcx
	movq %rax,(avg)
