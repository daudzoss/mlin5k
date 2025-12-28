missing	.byte	0		;static uint4_t missing = 0;

.align	16

jumpto0	.word	allleft
jumpto1	.word	allrght
jumpto2	.word	slideup
jumpto3	.word	slidedn
jumpto4	.word	topleft
jumpto5	.word	toprght
jumpto6	.word	botleft
jumpto7	.word	botrght

jumpvec	.word	jumpto0

rndmove	lda	jumpvec		;void rndmove(void) {
	and	#$f0		;
	sta	jumpvec		;
	lda	RNDLOC1		;
	eor	RNDLOC2		;
	and	#$0e		;
	ora	jumpvec		;
	sta	jumpvec		;
rndjump	jmp	(jumpvec)	;} // rndmove()

allleft	rts
allrght	rts
slideup	rts
slidedn	rts
topleft	rts
toprght	rts
botleft	rts
botrght	rts

getmove	jsr	$ffe4		;void getmove(void) {
	beq	getmove		; switch (register char a = getchar()) {

	cmp	#'['		; case '[':
	beq	+		;
	cmp	#':'		; case ':':
	beq	+		;
	cmp	#'0'		; case '0':
	bne	++		;  return allleft(a);
+	jmp	allleft		;

+	cmp	#']'		; case ']':
	beq	+		;
	cmp	#$3b		; case ';':
	beq	+		;
	cmp	#'1'		; case '1':
	bne	++		;  return allrght(a);
+	jmp	allrght		;

+	cmp	#'i'		; case 'i':
	beq	+		;
	cmp	#'I'		; case 'I':
	beq	+		;
	cmp	#'2'		; case '2':
	bne	++		;  return slideup(a);
+	jmp	slideup		;

+	cmp	#'k'		; case 'k':
	beq	+		;
	cmp	#'K'		; case 'K':
	beq	+		;
	cmp	#'3'		; case '3':
	bne	++		;  return slidedn(a);
+	jmp	slidedn		;
	
+	cmp	#'('		; case '(':
	beq	+		;
	cmp	#'8'		; case '8':
	beq	+		;
	cmp	#'u'		; case 'u':
	beq	+		;
	cmp	#'U'		; case 'U':
	beq	+		;
	cmp	#'4'		; case '4':
	bne	++		;  return topleft(a);
+	jmp	topleft		;

+	cmp	#')'		; case ')':
	beq	+		;
	cmp	#'9'		; case '9':
	beq	+		;
	cmp	#'o'		; case 'o':
	beq	+		;
	cmp	#'O'		; case 'O':
	beq	+		;
	cmp	#'5'		; case '5':
	bne	++		;  return toprght(a);
+	jmp	toprght		;

+	cmp	#'<'		; case '<':
	beq	+		;
	cmp	#','		; case ',':
	beq	+		;
	cmp	#'j'		; case 'j':
	beq	+		;
	cmp	#'J'		; case 'J':
	beq	+		;
	cmp	#'6'		; case '6':
	bne	++		;  return botleft(a);
+	jmp	botleft		;

+	cmp	#'>'		; case '>':
	beq	+		;
	cmp	#'.'		; case '.':
	beq	+		;
	cmp	#'l'		; case 'l':
	beq	+		;
	cmp	#'L'		; case 'L':
	beq	+		;
	cmp	#'7'		; case '7':
	bne	++		;  return botrght(a);
+	jmp	botrght		; }
+	rts			;} // getmove()
