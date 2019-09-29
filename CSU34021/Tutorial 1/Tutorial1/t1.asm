.686
.model flat, C
option casemap:none

.data
public		g
g			DWORD		4

.code

public		min
min:		push	ebp
			mov		ebp, esp
			mov		eax, [ebp + 8]
			cmp		eax, [ebp + 12]
			jle		min0
			mov		eax, [ebp + 12]
min0:		cmp		eax, [ebp + 16]
			jle		min1
			mov		eax, [ebp + 16]
min1:		mov		esp, ebp
			pop		ebp
			ret		0

public		p
p:			push	ebp
			mov		ebp, esp
			push	[ebp + 12]
			push	[ebp + 8]
			push	g
			call	min
			add		esp, 12
			push	[ebp + 20]
			push	[ebp + 16]
			push	eax
			call	min
			mov		esp, ebp
			pop		ebp
			ret		0

public		gcd
gcd:		push	ebp
			mov		ebp, esp
			mov		eax, [ebp + 12]
			test	eax, eax
			je		gcd0
			mov		eax, [ebp + 8]	; eax = a
			mov		ecx, [ebp + 12] ; ecx = b
			xor		edx, edx		; edx = 0
			idiv	ecx				; edx = eax % ecx
			push	edx
			push	[ebp + 12]
			call	gcd
			add		esp, 8
			jmp		gcd1
gcd0:		mov		eax, [ebp + 8]
gcd1:		mov		esp, ebp
			pop		ebp
			ret		0

end
