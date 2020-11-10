.global _start

.section .text
_start:
	movq (num),%rax
	movq $1,%rbx
	movq $64, %rcx
	xor %rsp,%rsp
	jmp .Loop
.One:
	inc %rsp
.Zero:
	movq $1,%rbx
	shr $1,%rax
	dec %rcx
	cmp $0,%rcx
	je .End
.Loop:
	and %rax,%rbx
	cmp $1,%rbx
	je .One
	jmp .Zero
.End:
	movq %rsp, countBits
