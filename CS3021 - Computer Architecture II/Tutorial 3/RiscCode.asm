/*
min:
	a, b, c 	= R26, R27, R28
	v 			= R16
	ret expr 	= R1
	ret addr 	= R25
*/
min:	add 	R0, R26, R16		; mov R16, R26
		sub 	R16, R27, R0, {C}	; cmp R27, R16
		jge 	min0				; jge min0
		xor 	R0, R0, R0			; nop
		add 	R0, R27, R16		; mov R16, R27
min0:	sub		R16, R28, R0, {C}	; cmp R28, R16
		jge		min1				; jge min1
		xor		R0, R0, R0			; nop
		add 	R0, R28, R16		; mov R16, R28
min1:	add 	R0, R16, R16 		; mov R1, R16
		ret		R25					; ret

/*
p:
	i, j, k, l	= R26, R27, R28, R29
	v			= R16 					// v = min(g, i, j)
	g 			= R9
	sp 			= R2 					// stack pointer
	ret expr 	= R1
	ret addr 	= R25
*/
p:		add 	R0, #4, R9 			; mov R9, #4
		sts 	R28, R2 			; push R28
		sub 	R2, #4, R2 			; // decrement SP
		add 	R0, R27, R28		; mov R28, R27
		add 	R0, R26, R27 		; mov R27, R26
		add 	R0, R9, R26 		; mov R26, R9
		callr	R25, min 			; call min 			// min(g, i, j)
		xor 	R0, R0, R0			; nop
		ldss 	R2, R28				; pop R28
		add 	R2, #4, R2 			; // increment SP
		add 	R0, R1, R26 		; mov R26, R1
		add 	R0, R28, R27		; mov R27, R28
		add 	R0, R29, R28		; mov R28, R29
		callr 	R25, min 			; call min 			// min(min(g, i, j), k, l)
		xor 	R0, R0, R0 			; nop
		ret 	R25					; ret

/*
gcd:
	a, b 		= R26, R27
	u, v 		= R16, R17	// u, v = temp values
	ret expr 	= R1
	ret addr 	= R25
mod:
	a, b 		= R26, R27
	ret expr 	= R1
	ret addr 	= R25
*/
gcd: 	add 	R27, R27, R0 		; test R27, R27
		je 		gcd0				; je gcd0
		add 	R0, R26, R16		; mov R16, R26
		add 	R0, R27, R17		; mov R17, R27
		callr 	R25, mod 			; call mod 		// mod(a, b)
		xor 	R0, R0, R0			; nop
		add 	R0, R17, R26		; mov R26, R17
		add 	R0, R1, R27 		; mov R27, R1
		callr 	R25, gcd 			; call gcd 		// gcd(b, a % b)
		xor 	R0, R0, R0			; nop
		jmp 	gcd1				; jmp gcd1
		xor 	R0, R0, R0			; nop
gcd0: 	add 	R0, R26, R1 		; mov R1, R26
gcd1: 	ret 	R25 				; ret
