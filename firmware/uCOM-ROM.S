****************************************************************
*
* Disassembled by BrkDown on 12/17/23  2:36:45 PM
* Source built by BrkDown on 12/17/23  3:12:32 PM
*
* Project: VIDEX                                                
*
****************************************************************

        65816 off
        org $C800

Begin   start	

**--------------------------------------------------------------
L00C800 entry
        LDA $077B
        AND #$F8
        CMP #$30
        BEQ L00C829	; {+20}
L00C809 entry
        LDA #$30
        STA $077B
        STA $07FB
        LDA #$00
        STA $06FB
        JSR L00C961
        LDX #$0F
L00C81B entry
        TXA 
        STA $C0B0
        LDA L00C8A1,x
        STA $C0B1
        DEX 
        BPL L00C81B	; {-0D}
        INX 
L00C829 entry
        STA $C059
        RTS 

**--------------------------------------------------------------
        NOP 
L00C82E entry
        LDA $07FB
        AND #$08
        BEQ L00C83E	; {+09}
        JSR $FE93
        JSR VTAB
        JSR $FE89
L00C83E entry
        PLA 
        TAY 
        PLA 
        TAX 
        PLA 
        RTS 

**--------------------------------------------------------------
L00C844 entry
        JSR L00C8D1
L00C847 entry
        INC $4E
        BNE L00C84D	; {+02}
        INC $4F
L00C84D entry
        LDA $C000
        BPL L00C847	; {-0B}
        JSR L00C85C
        BCC L00C847	; {-10}
L00C857 entry
        BIT $C010
        CLC 
        RTS 

**--------------------------------------------------------------
L00C85C entry
        CMP #$8B
        BNE L00C862	; {+02}
        LDA #$DB
L00C862 entry
        CMP #$81
        BNE L00C870	; {+0A}
        LDA $07FB
        EOR #$40
        STA $07FB
        BCS L00C857	; {-19}
L00C870 entry
        PHA 
        LDA $07FB
        ASL A
        ASL A
        PLA 
        BCC L00C898	; {+1F}
        CMP #$B0
        BCC L00C898	; {+1B}
        BIT $C063
        BMI L00C896	; {+14}
        CMP #$B0
        BEQ L00C894	; {+0E}
        CMP #$C0
        BNE L00C88C	; {+02}
        LDA #$D0
L00C88C entry
        CMP #$DB
        BCC L00C898	; {+08}
        AND #$CF
        BNE L00C898	; {+04}
L00C894 entry
        LDA #$DD
L00C896 entry
        ORA #$20
L00C898 entry
        PHA 
        AND #$7F
        STA $067B
        PLA 
        SEC 
        RTS 

**--------------------------------------------------------------
L00C8A1 entry
        DC  I1'$7B'
        DC  I1'$50'
        DC  I1'$5C'
        DC  I1'$29'
        DC  I1'$1B'
        DC  I1'$08'
        DC  I1'$18'
        DC  I1'$1A'
        DC  I1'$00'
        DC  I1'$08'
        DC  I1'$E0'
        DC  I1'$08'
        DC  I1'$00'
        DC  I1'$00'
        DC  I1'$00'
        DC  I1'$00'
L00C8B1 entry
        STA $067B
        LDA $25
        CMP $05FB
        BEQ L00C8C1	; {+06}
        STA $05FB
        JSR L00CA04
L00C8C1 entry
        LDA $24
        CMP $057B
        BCC L00C8CB	; {+03}
        STA $057B
L00C8CB entry
        LDA $067B
        JSR L00CA89
L00C8D1 entry
        LDA #$0F
        STA $C0B0
        LDA $057B
        CMP #$50
        BCS L00C8F0	; {+13}
        ADC $047B
        STA $C0B1
        LDA #$0E
        STA $C0B0
        LDA #$00
        ADC $04FB
        STA $C0B1
L00C8F0 entry
        RTS 

**--------------------------------------------------------------
L00C8F1 entry
        EOR #$C0
        CMP #$08
        BCS L00C914	; {+1D}
        TAY 
        LDA #$C9
        PHA 
        LDA L00CBF2,y
        PHA 
        RTS 

**--------------------------------------------------------------
        NOP 
L00C901 entry
        LDY $057B
L00C904 entry
        LDA #$A0
L00C906 entry
        JSR L00CA71
        INY 
        CPY #$50
        BCC L00C906	; {-08}
        RTS 

**--------------------------------------------------------------
        LDA #$34
L00C911 entry
        STA $077B
L00C914 entry
        RTS 

**--------------------------------------------------------------
        LDA #$32
        BNE L00C911	; {-08}
        LDY #$C0
L00C91B entry
        LDX #True
L00C91D entry
        DEX 
        BNE L00C91D	; {-03}
        LDA $C030
        DEY 
        BNE L00C91B	; {-0B}
        RTS 

**--------------------------------------------------------------
L00C927 entry
        LDY $057B
        CPY #$50
        BCC L00C933	; {+05}
        PHA 
        JSR L00C9B0
        PLA 
L00C933 entry
        LDY $057B
        JSR L00CA71
        INC $057B
        BIT $0478
        BPL L00C948	; {+07}
        LDA $057B
        CMP #$50
        BCS L00C9B0	; {+68}
L00C948 entry
        RTS 

**--------------------------------------------------------------
        LDY $057B
        LDA $05FB
L00C94F entry
        PHA 
        JSR L00CA07
        JSR L00C904
        LDY #$00
        PLA 
        ADC #$00
        CMP #$18
        BCC L00C94F	; {-10}
        BCS L00C984	; {+23}
L00C961 entry
        JSR L00C967
        TYA 
        BEQ L00C94F	; {-18}
L00C967 entry
        LDA #$00
        STA $057B
        STA $05FB
        TAY 
        BEQ L00C984	; {+12}
        DEC $057B
        BPL L00C914	; {-63}
        LDA #$4F
        STA $057B
        LDA $05FB
        BEQ L00C914	; {-6D}
        DEC $05FB
L00C984 entry
        JMP L00CA04

**--------------------------------------------------------------
L00C987 entry
        LDA #$30
        STA $077B
        PLA 
        ORA #True
        CMP #$B1
        BNE L00C9FA	; {+67}
        LDA #$08
        STA $C058
        BNE L00C9F5	; {+5B}
L00C99A entry
        CMP #$B2
        BNE L00C9EF	; {+51}
        LDA #$FE
L00C9A0 entry
        AND $07FB
L00C9A3 entry
        STA $07FB
        RTS 

**--------------------------------------------------------------
L00C9A7 entry
        STA $067B
        LSR $0478
        JMP L00C8CB

**--------------------------------------------------------------
L00C9B0 entry
        JSR L00CA27
        INC $05FB
        LDA $05FB
L00C9B9 entry
        CMP #$18
        BCC L00CA07	; {+4A}
        DEC $05FB
        LDA $06FB
        ADC #$04
        AND #$7F
        STA $06FB
        JSR L00CA12
        LDA #$0D
        STA $C0B0
        LDA $047B
        STA $C0B1
        LDA #$0C
        STA $C0B0
        LDA $04FB
        STA $C0B1
        LDA #$17
        JSR L00CA07
        LDY #$00
        JSR L00C904
        BCS L00C984	; {-6B}
L00C9EF entry
        CMP #$B3
        BNE L00CA01	; {+0E}
        LDA #$01
L00C9F5 entry
        ORA $07FB
        BNE L00C9A3	; {-57}
L00C9FA entry
        CMP #$B0
        BNE L00C99A	; {-64}
        JMP L00C809

**--------------------------------------------------------------
L00CA01 entry
        JMP L00C927

**--------------------------------------------------------------
L00CA04 entry
        LDA $05FB
L00CA07 entry
        STA $04F8
        ASL A
        ASL A
        ADC $04F8
        ADC $06FB
L00CA12 entry
        PHA 
        LSR A
        LSR A
        LSR A
        LSR A
        STA $04FB
        PLA 
        ASL A
        ASL A
        ASL A
        ASL A
        STA $047B
        RTS 

**--------------------------------------------------------------
L00CA23 entry
        CMP #$0D
        BNE L00CA2D	; {+06}
L00CA27 entry
        LDA #$00
        STA $057B
        RTS 

**--------------------------------------------------------------
L00CA2D entry
        ORA #True
        CMP #$A0
        BCS L00CA01	; {-32}
        CMP #$87
        BCC L00CA3F	; {+08}
        TAY 
        LDA #$C9
        PHA 
        LDA L00C9B9,y
        PHA 
L00CA3F entry
        RTS 

**--------------------------------------------------------------
        DC  I1'$18'
        DC  I1'$71'
        DC  I1'$13'
        DC  I1'$B2'
        DC  I1'$48'
        DC  I1'$60'
        DC  I1'$AF'
        DC  I1'$9D'
        DC  I1'$F2'
        DC  I1'$13'
        DC  I1'$13'
        DC  I1'$13'
        DC  I1'$13'
        DC  I1'$13'
        DC  I1'$13'
        DC  I1'$13'
        DC  I1'$13'
        DC  I1'$13'
        DC  I1'$66'
        DC  I1'$0E'
        DC  I1'$13'
        DC  I1'$38'
        DC  I1'$00'
        DC  I1'$14'
        DC  I1'$7B'
L00CA59 entry
        CLC 
        TYA 
        ADC $047B
        PHA 
        LDA #$00
        ADC $04FB
        PHA 
        ASL A
        AND #$0C
        TAX 
        LDA $C0B0,x
        PLA 
        LSR A
        PLA 
        TAX 
        RTS 

**--------------------------------------------------------------
L00CA71 entry
        ASL A
        PHA 
        LDA $07FB
        LSR A
        PLA 
        ROR A
        PHA 
        JSR L00CA59
        PLA 
        BCS L00CA85	; {+05}
        STA L00CC00,x
        BCC L00CA88	; {+03}
L00CA85 entry
        STA $CD00,x
L00CA88 entry
        RTS 

**--------------------------------------------------------------
L00CA89 entry
        PHA 
        LDA #$F7
        JSR L00C9A0
        STA $C059
        LDA $077B
        AND #$07
        BNE L00CA9D	; {+04}
        PLA 
        JMP L00CA23

**--------------------------------------------------------------
L00CA9D entry
        AND #$04
        BEQ L00CAA4	; {+03}
        JMP L00C987

**--------------------------------------------------------------
L00CAA4 entry
        PLA 
        SEC 
        SBC #$20
        AND #$7F
        PHA 
        DEC $077B
        LDA $077B
        AND #$03
        BNE L00CACA	; {+15}
        PLA 
        CMP #$18
        BCS L00CABD	; {+03}
        STA $05FB
L00CABD entry
        LDA $05F8
        CMP #$50
        BCS L00CAC7	; {+03}
        STA $057B
L00CAC7 entry
        JMP L00CA04

**--------------------------------------------------------------
L00CACA entry
        PLA 
        STA $05F8
        RTS 

**--------------------------------------------------------------
L00CACF entry
        LDA $C000
        CMP #$93
        BNE L00CAE5	; {+0F}
        BIT $C010
L00CAD9 entry
        LDA $C000
        BPL L00CAD9	; {-05}
        CMP #$83
        BEQ L00CAE5	; {+03}
        BIT $C010
L00CAE5 entry
        RTS 

**--------------------------------------------------------------
L00CAE6 entry
        TAY 
        LDA L00CB31,y
        JSR L00C8F1
L00CAED entry
        JSR L00C844
        CMP #$CE
        BCS L00CAFC	; {+08}
        CMP #$C9
        BCC L00CAFC	; {+04}
        CMP #$CC
        BNE L00CAE6	; {-16}
L00CAFC entry
        JMP L00C8F1

**--------------------------------------------------------------
        NOP 
        BIT $FFCB
        BVS L00CB36	; {+31}
        SEC 
        BCC L00CB20	; {+18}
        CLV 
        BVC L00CB36	; {+2B}
        ORA ($82,x)
        ORA ($14),y
        TRB $4C22
        BRK 
        INY 
        JSR L00C844
        AND #$7F
        LDX #$00
        RTS 

**--------------------------------------------------------------
        JSR L00C9A7
        LDX #$00
L00CB20 entry
        RTS 

**--------------------------------------------------------------
        CMP #$00
        BEQ L00CB2F	; {+09}
        LDA $C000
        ASL A
        BCC L00CB2F	; {+03}
        JSR L00C85C
L00CB2F entry
        LDX #$00
L00CB31 entry
        RTS 

**--------------------------------------------------------------
        STA ($28),y
        SEC 
        CLV 
L00CB36 entry
        STA $CFFF
        PHA 
        STA $35
        TXA 
        PHA 
        TYA 
        PHA 
        LDA $35
        STX $35
        LDX #$C3
        STX $0478
        PHA 
        BVC L00CB5C	; {+10}
        LDA #$32
        STA $38
        STX $39
        LDA #$07
        STA $36
        STX $37
        JSR L00C800
        CLC 
L00CB5C entry
        BCC L00CBCD	; {+6F}
        PLA 
        LDY $35
        BEQ L00CB82	; {+1F}
        DEY 
        LDA $0678
        CMP #$88
        BEQ L00CB82	; {+17}
        CMP $0200,y
        BEQ L00CB82	; {+12}
        EOR #$20
        CMP $0200,y
        BNE L00CBB2	; {+3B}
        LDA $0678
        STA $0200,y
        BCS L00CB82	; {+03}
L00CB7F entry
        JSR L00CAED
L00CB82 entry
        LDA #True
        JSR L00C9F5
        JSR L00C844
        CMP #$9B
        BEQ L00CB7F	; {-0F}
        CMP #$8D
        BNE L00CB97	; {+05}
        PHA 
        JSR L00C901
        PLA 
L00CB97 entry
        CMP #$95
        BNE L00CBAD	; {+12}
        LDY $057B
        JSR L00CA59
        BCS L00CBA8	; {+05}
        LDA L00CC00,x
        BCC L00CBAB	; {+03}
L00CBA8 entry
        LDA $CD00,x
L00CBAB entry
        ORA #True
L00CBAD entry
        STA $0678
        BNE L00CBBA	; {+08}
L00CBB2 entry
        JSR L00C844
        LDY #$00
        STY $0678
L00CBBA entry
        TSX 
        INX 
        INX 
        INX 
        STA $0100,x
L00CBC1 entry
        LDA #$00
L00CBC3 entry
        STA $24
        LDA $05FB
        STA $25
        JMP L00C82E

**--------------------------------------------------------------
L00CBCD entry
        PLA 
        LDY $07FB
        BPL L00CBDB	; {+08}
        LDY $0678
        CPY #$E0
        BCC L00CBDB	; {+01}
        TYA 
L00CBDB entry
        JSR L00C8B1
        JSR L00CACF
        LDA #$7F
        JSR L00C9A0
        LDA $057B
        SBC #$47
        BCC L00CBC1	; {-2C}
        ADC #$1F
        CLC 
        BCC L00CBC3	; {-2F}
L00CBF2 entry
        DC  I1'$60'
        DC  I1'$38'
        DC  I1'$71'
        DC  I1'$B2'
        DC  I1'$7B'
        DC  I1'$00'
        DC  I1'$48'
        DC  I1'$66'
        DC  I1'$C4'
        DC  I1'$C2'
        DC  I1'$C1'
        DC  I1'$FF'
        DC  I1'$C3'
        NOP 

        end
