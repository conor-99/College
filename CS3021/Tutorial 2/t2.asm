option casemap:none

includelib	legacy_stdio_definitions.lib
extrn		printf:near

.data
public		g
g			QWORD		4

.code

public		min
min:		mov		rax, rcx
			cmp		rax, rdx
			jle		min0
			mov		rax, rdx
min0:		cmp		rax, r8
			jle		min1
			mov		rax, r8
min1:		ret

public		p
p:			sub		rsp, 32
			mov		r12, rcx
			mov		r13, rdx
			mov		r14, r8
			mov		r15, r9
			mov		rcx, g
			mov		rdx, r12
			mov		r8, r13
			call	min
			mov		rcx, rax
			mov		rdx, r14
			mov		r8, r15
			call	min
			add		rsp, 32
			ret

public		gcd
gcd:		sub		rsp, 32
			test	rdx, rdx
			je		gcd0
			mov		rax, rcx	; a
			mov		r12, rdx	; b
			xor		rdx, rdx	; c = 0
			cqo
			idiv	r12			; c = a % b
			mov		rcx, r12
			call	gcd			; gcd(b, c)
			jmp		gcd1
gcd0:		mov		rax, rcx
gcd1:		add		rsp, 32
			ret

public		q
qf			db		'a = %I64d b = %I64d c = %I64d d = %I64d e = %I64d sum = %I64d\n', 0AH, 00H
q:			push	rbx
			mov		r15, [rsp + 48]	; e (param 5 comes after return and shadow space)
			sub		rsp, 56			; 7 params * 8

			mov		r11, rcx		; a
			mov		r12, rdx		; b
			mov		r13, r8			; c
			mov		r14, r9			; d

			mov		r10, r11		; sum = a
			add		r10, r12		; sum += b
			add		r10, r13		; sum += c
			add		r10, r14		; sum += d
			add		r10, r15		; sum += e

			mov		rbx, r10		; save sum
			
			lea		rcx, qf			; qf
			mov		rdx, r11		; a
			mov		r8, r12			; b
			mov		r9, r13			; c
			mov		[rsp + 32], r14 ; d
			mov		[rsp + 40], r15 ; e
			mov		[rsp + 48], r10 ; s
			call	printf

			mov		rax, rbx		; restore sum
			add		rsp, 56
			pop		rbx
			ret

public		qns
qnsf		db		'qns\n', 0AH, 00H
qns:		push	rbx
			sub		rsp, 32
			lea		rcx, qnsf
			call	printf
			xor		rax, rax
			add		rsp, 32
			pop		rbx
			ret

end
