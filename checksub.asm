tempchk	.fill	1		;
unsolvd	lda	#0		;
	rts			;
checkt	.macro	offset		;inline uint1_t checkt(uint4_t offset) {
	bit	state+\offset	; if (state[offset] & 0xc0 != 0x80)
	bpl	unsolvd		;  return 0; // give up since not a TOPLINK
	bvs	unsolvd		; // otherwise, keep checking
	.endm			;} // checkt()
checkb	.macro	offset		;inline uint1_t checkt(uint4_t offset) {
	bit	state+\offset	; if (state[offset] & 0xc0 != 0xc0)
	bpl	unsolvd		;  return 0; // give up since not a BOTLINK
	bvc	unsolvd		; // otherwise, keep checking
	.endm			;} // checkb()
checkc	.macro	offset		;inline uint1_t checkc(uint4_t offset) {
	lda	state+offset+0	;
	and	#$3f		;
	sta	tempchk		;
	lda	state+offset+1	;
	and	#$3f		;
	cmp	tempchk		;
	beq	+		;
	jmp	unsolvd		;
+	lda	state+offset+2	;
	and	#$3f		;
	cmp	tempchk		;
	beq	+		;
	jmp	unsolvd		;
+	lda	state+offset+3	;
	and	#$3f		;
	cmp	tempchk		;
	beq	+		;
	jmp	unsolvd		;
+
	.endm			;} // checkc()

checkok	checkt	0		;
	checkt	4		;
	checkt	8		;
	checkt	$c		;
	checkb	3		;
	checkb	7		;
	checkb	$b		;
	checkb	$f		;
;	checkc	0		;
;	checkc	4		;
;	checkc	8		;
;	checkc	$c		;
	lda	#1		;
	rts			;
