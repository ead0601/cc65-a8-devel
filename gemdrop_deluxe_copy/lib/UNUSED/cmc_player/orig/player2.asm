* player CMC skrocony

* init X-lsb, Y-msb muzyki

 opt 6

 org $2000

* strona 0

volume equ 0
numins equ 3

frq    equ 6
znieks equ 10
audc   equ 14

czest1 equ 15
czest2 equ 18
czest3 equ 21
zniek  equ 24
count1 equ 27
count2 equ 30
lopad  equ 33
numptr equ 36
poswpt equ 39
ilewol equ 42
czygrx equ 45
czygrc equ 48

dana0  equ 49
dana1  equ 52
dana2  equ 55
dana3  equ 58
dana4  equ 61
dana5  equ 64
ladr   equ 67
hadr   equ 70

posptr equ 73
possng equ 74
pocrep equ 75
konrep equ 76
ilrep  equ 77
tmpo   equ 78
ltemp  equ 79
b1     equ 80
b2     equ 81
b3     equ 82
czygr  equ 83

adrmus equ 84
adradr equ 86
adrsng equ 88
addr   equ 90
word   equ 92

* init

init lda #3
 sta $d20f
 stx adrmus
 stx word
 sty adrmus+1
 sty word+1
 clc
 txa
 adc #$14
 sta adradr
 tya
 adc #0
 sta adradr+1
 stx adrsng
 iny
 iny
 sty adrsng+1

 ldx #8
l9 lda #0
 sta $d200,x
 cpx #3
 bcs l10
 sta volume,x
 lda #$ff
 sta count1,x
 lda #$80
 sta czygrx,x
 sta czygrc
l10 dex
 bpl l9

 lda #0
 ldx #9
l5 sta poswpt,x
 dex
 bpl l5
 sta posptr
 sta possng
 lda #1
 sta czygr
 lda #$ff
 sta konrep

 ldy #$13
 lda (word),y
 tax
 ldy #0
 inc word+1
 inc word+1
 lda (word),y
 cmp #$cf
 bne l8
 tya
 clc
 adc #$55
 tay
 lda (word),y
 bmi l8
 tax
l8 stx tmpo
 stx ltemp
 rts

inst lda #0
 sta count1,x
 sta count2,x
 sta lopad,x

 lda b3
 asl @
 asl @
 asl @
 sta word
 clc
 lda adrmus
 adc #$30
 pha
 lda adrmus+1
 adc #1
 tay
 pla
 clc
 adc word
 sta ladr,x
 tya
 adc #0
 sta hadr,x

 clc
 lda adrmus
 adc #$94
 sta word
 lda adrmus+1
 adc #0
 sta word+1
 lda b3
 asl @
 adc b3
 asl @
 tay
 lda (word),y
 sta dana0,x
 iny
 lda (word),y
 sta dana1,x
 and #7
 sta b1
 iny
 lda (word),y
 sta dana2,x
 iny
 lda (word),y
 sta dana3,x
 iny
 lda (word),y
 sta dana4,x
 iny
 lda (word),y
 sta dana5,x

 ldy #0
 lda b1
 cmp #3
 bne l14
 ldy #2
l14 cmp #7
 bne l15
 ldy #4
l15 lda tab3,y
 sta word
 lda tab3+1,y
 sta word+1
 lda dana2,x
 lsr @
 lsr @
 lsr @
 lsr @
 clc
 adc b2
 sta b2
 sta zm2+1
 tay
 lda b1
 cmp #7
 bne l16
 tya
 asl @
 tay
 lda (word),y
 sta czest1,x
 iny
 sty b2
 jmp l17
l16 lda (word),y
 sta czest1,x
 lda dana2,x
 and #$f
 clc
 adc b2
 sta b2
l17 ldy b2
 lda b1
 cmp #5
 php
 lda (word),y
 plp
 beq l18
 cmp czest1,x
 bne l18
 sec
 sbc #1
l18 sta czest2,x
 lda dana0,x
 pha
 and #3
 tay
 lda tab4,y
 sta zniek,x
 pla
 lsr @
 lsr @
 lsr @
 lsr @
 ldy #$3e
 cmp #$f
 beq l19
 ldy #$37
 cmp #$e
 beq l19
 ldy #$30
 cmp #$d
 beq l19
 clc
zm2 adc #0
 tay
l19 lda tab5,y
 sta czest3,x
 rts

*--- play

play lda czygr
 beq play-1
 lda czygrc
 beq g2
 jmp dal3
g2 lda tmpo
 cmp ltemp
 beq g3
 jmp dal2
g3 lda posptr
 beq g4
 jmp dal1
g4 ldx #2
g5 ldy czygrx,x
 bmi g6
 sta czygrx,x
g6 sta poswpt,x
 dex
 bpl g5

 lda adrsng
 sta addr
 lda adrsng+1
 sta addr+1
 ldy possng
 sty word
g7 cpy konrep
 bne g8
 lda ilrep
 beq g8
 lda possng
 ldy pocrep
 sty possng
 dec ilrep
 bne g7
 sta possng
 tay
 bpl g7
g8 ldx #0
g9 lda (addr),y
 cmp #$fe
 bne g10
 ldy possng
 iny
 cpy word
 beq g11
 sty possng
 jmp g7
g10 sta numptr,x
 clc
 tya
 adc #$55
 tay
 inx
 cpx #3
 bcc g9
 ldy possng
 lda (addr),y
 bpl dal1
 cmp #$ff
 beq dal1
 lsr @
 lsr @
 lsr @
 and #$e
 tax
 lda tab2,x
 sta zm3+1
 lda tab2+1,x
 sta zm3+2
 lda numptr+1
 sta word+1
zm3 jsr g12
 sty possng
 cpy #$55
 bcs g11
 cpy word
 bne g7
g11 ldy word
 sty possng
 jmp up-1

g12 ldy #$ff
 rts
jump bmi g12
 tay
 rts
up bmi g12
 sec
 tya
 sbc word+1
 tay
 rts
down bmi g12
 clc
 tya
 adc word+1
 tay
 rts
temp bmi g12
 sta tmpo
 sta ltemp
 iny
 rts
rep bmi g12
 lda numptr+2
 bmi g12
 sta ilrep
 iny
 sty pocrep
 clc
 tya
 adc word+1
 sta konrep
 rts
break dey
 bmi g13
 lda (addr),y
 cmp #$8f
 beq g13
 cmp #$ef
 bne break
g13 iny
 rts

dal1 ldx #2
v1 lda ilewol,x
 beq v2
 dec ilewol,x
 bpl v7
v2 lda czygrx,x
 bne v7
 ldy numptr,x
 cpy #$40
 bcs v7
 lda adradr
 sta addr
 lda adradr+1
 sta addr+1
 lda (addr),y
 sta word
 clc
 tya
 adc #$40
 tay
 lda (addr),y
 sta word+1
 and word
 cmp #$ff
 beq v7
v3 ldy poswpt,x
 lda (word),y
 and #$c0
 bne v4
 lda (word),y
 and #$3f
 sta numins,x
 inc poswpt,x
 bpl v3
v4 cmp #$40
 bne v5
 lda (word),y
 and #$3f
 sta b2
 lda numins,x
 sta b3
 jsr inst
 jmp v6
v5 cmp #$80
 bne v7
 lda (word),y
 and #$3f
 sta ilewol,x
v6 inc poswpt,x
v7 dex
 bpl v1

 ldx posptr
 inx
 txa
 and #$3f
 sta posptr

dal2 dec ltemp
 bne dal3
 lda tmpo
 sta ltemp
 lda posptr
 bne dal3
 inc possng

dal3 ldy czest2
 lda dana1
 and #7
 cmp #5
 beq a1
 cmp #6
 bne a2
a1 dey
a2 sty frq+3
 ldy #0
 cmp #5
 beq a3
 cmp #6
 bne a4
a3 ldy #2
a4 cmp #7
 bne a5
 ldy #$28
a5 sty audc

 ldx #2
loop lda dana1,x
 and #$e0
 sta znieks,x
 lda ladr,x
 sta addr
 lda hadr,x
 sta addr+1
 lda count1,x
 cmp #$ff
 beq y4
 cmp #$f
 bne y2
 lda lopad,x
 beq y4
 dec lopad,x
 lda lopad,x
 bne y4
 ldy volume,x
 beq y1
 dey
y1 tya
 sta volume,x
 lda dana3,x
 sta lopad,x
 jmp y4
y2 lda count1,x
 lsr @
 tay
 lda (addr),y
 bcc y3
 lsr @
 lsr @
 lsr @
 lsr @
y3 and #$f
 sta volume,x
y4 ldy czest1,x
 lda dana1,x
 and #7
 cmp #1
 bne y6
 dey
 tya
 iny
 cmp czest2,x
 php
 lda #1
 plp
 bne y5
 asl @
 asl @
y5 and count2,x
 beq y6
 ldy czest2,x
 cpy #$ff
 bne y6
 lda #0
 sta volume,x
y6 tya
 sta frq,x
 lda #1
 sta b1
 lda count1,x
 cmp #$f
 beq y9
 and #7
 tay
 lda tab9,y
 sta word
 lda count1,x
 and #8
 php
 txa
 plp
 clc
 beq y7
 adc #3
y7 tay
 lda dana4,y
 and word
 beq y9
 lda czest3,x
 sta frq,x
 stx b1
 dex
 bpl y8
 sta frq+3
 lda #0
 sta audc
y8 inx
 lda zniek,x
 sta znieks,x
y9 lda count1,x
 and #$f
 cmp #$f
 beq y10
 inc count1,x
 lda count1,x
 cmp #$f
 bne y10
 lda dana3,x
 sta lopad,x
y10 lda czygrx,x
 bpl y11
 lda volume,x
 bne y11
 lda #$40
 sta czygrx,x
y11 inc count2,x
 ldy #0
 lda dana1,x
 lsr @
 lsr @
 lsr @
 lsr @
 bcc y12
 dey
y12 lsr @
 bcc y13
 iny
y13 clc
 tya
 adc czest1,x
 sta czest1,x
 lda czest2,x
 cmp #$ff
 bne y14
 ldy #0
y14 clc
 tya
 adc czest2,x
 sta czest2,x
 dex
 bmi x1
 jmp loop

x1 lda znieks
 sta znieks+3
 lda dana1
 and #7
 tax
 ldy #3
 lda b1
 beq x2
 ldy tab10,x
x2 tya
 pha
 lda tab8,y
 php
 and #$7f
 tax
 tya
 and #3
 asl @
 tay
 lda frq,x
d0 sta $d200,y
 iny
 lda volume,x
 cpx #3
 bne x3
 lda volume
x3 ora znieks,x
 plp
 bpl d1
 lda #0
d1 sta $d200,y
 pla
 tay
 dey
 and #3
 bne x2
 ldy #8
 lda audc
d2 sta $d200,y
 rts

*--- tablice

tab2 dta a(g12)
 dta a(jump)
 dta a(up)
 dta a(down)
 dta a(temp)
 dta a(rep)
 dta a(break)

tab3 dta a(tab5)
 dta a(tab6)
 dta a(tab7)

tab4 dta b($80),b($a0)
 dta b($20),b($40)

tab5 dta b($ff),b($f1),b($e4),b($d7)
 dta b($cb),b($c0),b($b5),b($aa)
 dta b($a1),b($98),b($8f),b($87)
 dta b($7f),b($78),b($72),b($6b)
 dta b($65),b($5f),b($5a),b($55)
 dta b($50),b($4b),b($47),b($43)
 dta b($3f),b($3c),b($38),b($35)
 dta b($32),b($2f),b($2c),b($2a)
 dta b($27),b($25),b($23),b($21)
 dta b($1f),b($1d),b($1c),b($1a)
 dta b($18),b($17),b($16),b($14)
 dta b($13),b($12),b($11),b($10)
 dta b($0f),b($0e),b($0d),b($0c)
 dta b($0b),b($0a),b($09),b($08)
 dta b($07),b($06),b($05),b($04)
 dta b($03),b($02),b($01),b($00)
 dta b($00)

tab6 dta b($00),b($00),b($00),b($00)
 dta b($f2),b($e9),b($da),b($ce)
 dta b($bf),b($b6),b($aa),b($a1)
 dta b($98),b($8f),b($89),b($80)
 dta b($7a),b($71),b($6b),b($65)
 dta b($5f),b($00),b($56),b($50)
 dta b($67),b($60),b($5a),b($55)
 dta b($51),b($4c),b($48),b($43)
 dta b($3f),b($3d),b($39),b($34)
 dta b($33),b($39),b($2d),b($2a)
 dta b($28),b($25),b($24),b($21)
 dta b($1f),b($1e),b($00),b($00)
 dta b($0f),b($0e),b($0d),b($0c)
 dta b($0b),b($0a),b($09),b($08)
 dta b($07),b($06),b($05),b($04)
 dta b($03),b($02),b($01),b($00)
 dta b($00)

tab7 dta a($b38),a($a8c),a($a00),a($96a)
 dta a($8e8),a($86a),a($7ef),a($780)
 dta a($708),a($6ae),a($646),a($5e6)
 dta a($595),a($541),a($4f6),a($4b0)
 dta a($46e),a($430),a($3f6),a($3bb)
 dta a($384),a($352),a($322),a($2f4)
 dta a($2c8),a($2a0),a($27a),a($255)
 dta a($234),a($214),a($1f5),a($1d8)
 dta a($1bd),a($1a4),a($18d),a($177)
 dta a($160),a($14e),a($138),a($127)
 dta a($115),a($106),a($0f7),a($0e8)
 dta a($0db),a($0cf),a($0c3),a($0b8)
 dta a($0ac),a($0a2),a($09a),a($090)
 dta a($088),a($07f),a($078),a($070)
 dta a($06a),a($064),a($05e),a($057)
 dta a($052),a($032),a($00a)

tab8 dta b($00),b($01),b($02),b($83)
 dta b($00),b($01),b($02),b($03)
 dta b($01),b($00),b($02),b($83)
 dta b($01),b($00),b($02),b($03)
 dta b($01),b($02),b($80),b($03)

tab9 dta b($80),b($40),b($20),b($10)
 dta b($08),b($04),b($02),b($01)

tab10 dta b(3),b(3),b(3),b(3)
 dta b(7),b($b),b($f),b($13)

 end
