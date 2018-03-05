        ;
        ; Space Raid para Atari 2600 (banco 0, secundario)
        ;
        ; por Oscar Toledo Gutiérrez
        ;
        ; (c) Copyright 2013 Oscar Toledo Gutiérrez
        ;
        ; Creación: 21-oct-2013. Banco secundario.
        ; Revisión: 22-oct-2013. Se agregan bitmaps de las paredes y abismos.
        ;                        Nuevo kernel para manejar bitmaps grandes :).
        ; Revisión: 24-oct-2013. Se admiten más sprites para nave del jugador y
        ;                        así se liberan 6 sprites para los enemigos.
        ; Revisión: 25-oct-2013. Se mejora el dibujo del misil teledirigido.
        ;                        Se agrega antena animada.
        ; Revisión: 31-oct-2013. Se soluciona un problema de posicionamiento
        ;                        de pared, abismo y electricidad que hacía que
        ;                        consumiera una línea de video de más.
        ;

        processor 6502

        include space_raid_m.asm

        org $d000       ; Locación de inicio del ROM (4K)

        ; Si por alguna razón hubiera ocurrido un encendido aquí
inicio:
        sta banco1      ; Selecciona banco 1
        sei             ; Fantasma
        cld             ; Fantasma
        jmp 0           ; Fantasma

        sta banco0      ; Fantasma
        jmp b11
        
pan12:  sta banco1      ; Selecciona banco 1

        .byte "Space Raid, a game by Oscar Toledo G. (nanochess) :) Nov/06/2013"
        .byte 0


        ; Posiciona un sprite en X
        ; A = Posición X (¿rango?)
        ; X = Objeto por posicionar (0=P0, 1=P1, 2=M0, 3=M1, 4=BALL)
        ;
        ; >>> EL NUCLEO DEBE CABER EN UNA PÁGINA DE 256 BYTES <<<
        ; >>> COMPROBAR CHECANDO EL ARCHIVO LST GENERADO POR DASM <<<
        ;
posiciona_en_x:
        sec
        sta WSYNC       ; 0- Inicia sincronía de línea
        ldy offset9     ; Necesita desperdiciar tres ciclos
pex1:   sbc #15         ; 5- Gasta el tiempo necesario dividiendo X por 15
        bcs pex1        ; 7/8 - 12/17/22/27/32/37/42/47/52/57/62
pex3:   tay             ; 9
        lda tabla_ajuste_fino-$f1,y ; 13/14 - Consume 5 ciclos cruzando página
        sta HMP0,x      ; 17
        sta RESP0,x     ; 21/26/31/36/41/46/51/56/61/66/71 - Pos. "grande"
        rts

        ; Detecta código dividido entre dos páginas (usa un ciclo más)
        if (pex1&$ff00)!=(pex3&$ff00)
        lda megabug2    ; :P
        endif

b11:
        ;
        ; Posiciona horizontalmente la nave del jugador
        ;
        lda x_jugador
        ldx #0                  ; Player 0
        jsr posiciona_en_x
        ;
        ; Posiciona horizontalmente el único sprite
        ;
        ; Con este truco se ahorra todo el posicionamiento horizontal
        ; en el kernel 1 y se elimina el bug que generaba una línea extra.
        ;
        lda kernel
        beq k00
        lda xe3d1
        ldx #1                  ; Player 1
        jsr posiciona_en_x
k00:    ;
        ; Posiciona horizontalmente la bala del jugador
        ;
        lda x_bala
        ldx #2                  ; Missile 0
        jsr posiciona_en_x
        ;
        ; Posiciona la bala del enemigo
        ;
        lda x_bala2
        inx                     ; Missile 1
        jsr posiciona_en_x
        ;
        ; Posiciona la raya "3D"
        ;
        lda nivel
        lsr
        bcc b44b
        lda offset1
        cmp #$98                ; ¿Misil teledirigido?
        beq b44c                ; Sí, salta y congela la raya.
        lda cuadro
b44c:   eor #3
        and #3
        bpl b44
        
b44b:   lsr                     ; Cada dos espacios como tunel
        lsr
        bcc b44d
        lda cuadro
        lsr
        eor #3
        and #3
        bcc b44
        sbc #$20
        bmi b44

b44d:   ldy espacio
        dey
        cpy #14
        bcc b29
        ldy #13
b29:    sty espacio
        tya
        lsr                     ; Movimiento lento en espacio
        bcc b44
        sbc #$4b                ; Genera línea duplicada en espacio
b44:    adc #$78
        inx                     ; Ball
        jsr posiciona_en_x
        lda nivel
        lsr
        ldx #$40
        bcs b46
        lsr
        lsr
        bcs b46
        ldx #$70
b46:    txs

        ;
        ; Un poco más de aritmética
        ;
        ldx #1
        lda ye3d0
        beq b45
        sec
        sbc #10
        cmp ye3d1
        bcc b45
        dex
b45:    stx sprite
        ;
        ; Inicio de gráficas
        ;
        sta WSYNC              
        sta HMOVE               ; Ajuste fino de último posiciona_en_x
espera_vblank:
        lda INTIM
        bne espera_vblank
        lda #$02
        sta ENABL
        lda nivel
        lsr
        ldx #$10
        lda #COLOR_3D
        bcs pan11
        ldx #$00
        lda cuadro
        lsr
        and #$78
        ora #$04
        bcc pan11a
        eor #$7a
pan11a: asl
pan11:  stx CTRLPF              ; Tamaño de la raya 3D (ball)
        sta COLUPF              ; Color de la raya 3D (playfield no se usa)
        sta HMCLR               ; Evita movimiento posterior
        lda #COLOR_BALA         ; Para que la bala sea visible
        sta COLUP0              ; Color de nave (y bala jugador)
        lda color_grande        ; Color de bitmaps grandes
        sta COLUP1              ; Color de paredes (y bala enemigo)

        ldy #96                 ; 96 líneas
        ;
        ; Inicia núcleo gráfico
        ;
        ; Características:
        ; * 1 bala usando missile 0
        ; * 1 bala usando missile 1
        ; * 2 sprites usando player0 (nave y sombra)
        ; * 4 sprites usando player1 (tres enemigos más adorno)
        ; * 1 raya de escenario usando ball
        ;
        ; Cuenta de ciclos exacta para no perder líneas de video (si eso
        ; ocurriera, la cuenta de líneas hecha por Stella crecería)
        ;
        lda offset9
        ora #7
        sta offset9
        cmp #48
        bcc sombra
        sbc #48
        cmp #48
        bcc sombra
        sbc #48
sombra: clc
        adc #24
        sta offset9s
        lda #0
        sta WSYNC
        sta HMOVE
        sta VBLANK              ; Sale de VBLANK
        lda kernel              ; 8
        beq pan0                ; 13
        jmp pam0
        
        ; >>> EL NUCLEO DEBE CABER EN UNA PÁGINA DE 256 BYTES <<<
        ; >>> COMPROBAR CHECANDO EL ARCHIVO LST GENERADO POR DASM <<<
        ;
        ; 6 ciclos previos (entrada)
        ; 10 ciclos previos (pan6)
        ; 14 ciclos previos (pex2)
        ;
        ; Dado el caso se puede usar el registro S para ahorrar tiempo,
        ; pero no es necesario
pan0:
        ; ¿Llega a sprite de jugador?
        cpy yj3d                ; 3
        beq pan8                ; 5    6
        ; ¿Llega a sombra de jugador?
        cpy yj3d2               ; 8
        beq pan14               ; 10        11
        ldx linea_jugador       ; 13
        txa                     ; 15
        and #$07                ; 17
        beq pan5                ; 19
        dex                     ; 21
        bpl pan1                ; 24

        ; Inicia sombra de jugador
pan14:  ldx offset9s            ;           14
        .byte $ad               ;           17
        ; Inicia sprite de jugador
pan8:   ldx offset9             ;      9
pan1:   stx linea_jugador       ; 27   12   20
        lda colores_nave,x      ; 31   16   24
        sta COLUP0              ; 34   19   27
        lda sprites_nave,x      ; 38   23   31

pan5:   sta GRP0        ; 3    3 Pone bitmap Player 0 (note que llega con A=0)
        sta HMCLR       ; 3    6
        ; ¿Llega a sprite de enemigo?
        ldx sprite      ; 3    9 sprite actual
        tya             ; 2   11
        cmp ye3d0,x     ; 4   15
        bne pan4        ; 2/3 17
        ; >>> Como cmp resultó en Z=1, entonces C=1 <<< no hace falta SEC
        lda xe3d0,x     ; 3   21
        sta WSYNC       ; 76  24 - ciclos maximo :) - Inicia sincronía de línea
        sta HMOVE       ; 3
pex2:   sbc #15         ; 5- Gasta el tiempo necesario dividiendo X por 15
        bcs pex2        ; 7/8 - 12/17/22/27/32/37/42/47/52/57/62
        tax             ; 9
        lda tabla_ajuste_fino-$f1,x ; 13/14 - Consume extra si cruza página
        tsx     ; ldx #$40      ; 15
        sta HMP1        ; 18
        sta RESP1       ; 21/26/31/36/41/46/51/56/61/66/71 - Pos. "grande"
        stx HMBL        ; 24 - 74
        sta WSYNC       ; 27 - 77 o.O! (falta ganar un ciclo!!)
        sta HMOVE       ; 3
        lda largo_sprite; 6
        sta linea_doble ; 9
        dey             ; 11
        bne pan0        ; 13/14
        jmp pan10       ; 16

        ; Reg. X contiene 'sprite'
pan4:
        sta WSYNC       ; 73 ciclos máximo hasta aquí
        sta HMOVE       ; 3     3
        ;
        ; ¿Visualizar la bala?
        ;
    if 0        ; Ahorra cinco ciclos, hay que ver si puedo usarlos
        ldx #ENAM1      ; 2
        txs             ; 4
        cpy y_bala2     ; 7
        php             ; 10    Z cae perfecto en bit 1
        cpy y_bala      ; 13
        php             ; 16
        ldx sprite      ; 19
        ldx sprite      ; 22
        nop             ; 24
    else
        lda #0          ; 2     2
        cpy y_bala      ; 3     5
        bne pan3        ; 2/3   8
        lda #2          ; 2          9
pan3:   sta ENAM0       ; 3    11   12
        ; ¿Visualizar la bala del enemigo?
        lda #0          ; 2     2
        cpy y_bala2     ; 3     5
        bne pan7        ; 2/3   8
        lda #2          ; 2          9
pan7:   sta ENAM1       ;      11   12
    endif
        lda #0          ; 5
        dec linea_doble ; 10
        bmi pan6        ; 12/13
        lda linea_doble ; 15
        bne pan9        ; 17/18
        inc sprite      ; 22
pan9:   ora offset0,x   ; 26
        tax             ; 28
        lda colores,x   ; 32
        sta COLUP1      ; 35
        lda sprites,x   ; 39
pan6:   sta GRP1        ; 42 (notese que se llega aquí con A=0)
        tsx     ; ldx #$40        ; 68
        stx HMBL        ; 71
        sta WSYNC       ; 74 ciclos hasta aquí
        sta HMOVE       ; 3
        dey             ; 5
        beq pan10       ; 7/8
        jmp pan0        ; 10

        ; Llega aquí con 16 ó 8 ciclos
pan10:
        ldx #$ff        ; 18
        txs             ; 20
        jmp pan12       ; 23

        ; Detecta código dividido entre dos páginas (usa un ciclo más)
        if (pan0&$ff00)!=(pan10&$ff00)
        lda megabug1    ; :P
        endif

        ds 256-(.&$ff),$ff

        ; >>> EL NUCLEO DEBE CABER EN UNA PÁGINA DE 256 BYTES <<<
        ; >>> COMPROBAR CHECANDO EL ARCHIVO LST GENERADO POR DASM <<<
        ;
        ; 6 ciclos previos (entrada)
        ; 10 ciclos previos (pan6)
        ; 14 ciclos previos (pea2)
        ;
        ; Dado el caso se puede usar el registro S para ahorrar tiempo,
        ; pero no es necesario
pam0:
        ; ¿Llega a sprite de jugador?
        cpy yj3d                ; 3
        beq pam8                ; 5    6
        ; ¿Llega a sombra de jugador?
        cpy yj3d2               ; 8
        beq pam14               ; 10        11
        ldx linea_jugador       ; 13
        txa                     ; 15
        and #$07                ; 17
        beq pam5                ; 19
        dex                     ; 21
        bpl pam1                ; 24

pam14:  ldx offset9s            ;           14
        .byte $ad               ;           17
pam8:   ldx offset9             ;      9
pam1:   stx linea_jugador       ; 27   12   20
        lda colores_nave,x      ; 31   16   24
        sta COLUP0              ; 34   19   27
        lda sprites_nave,x      ; 38   23   31

pam5:   sta GRP0        ; 3    3 Pone bitmap Player 0 (note que llega con A=0)
        sta HMCLR       ; 3    6
        ; ¿Llega a sprite de enemigo?
        ldx sprite      ; 3    9 sprite actual
        tya             ; 2   11
        cmp ye3d0,x     ; 4   15
        bne pam4        ; 2/3 17
        ; >>> Como cmp resultó en Z=1, entonces C=1 <<< no hace falta SEC
        lda xe3d0,x     ; 3   21
        sta WSYNC       ; 76  24 - ciclos maximo :) - Inicia sincronía de línea
        sta HMOVE       ; 3
        nop             ; 5
        nop             ; 7
        nop             ; 9
        nop             ; 11
        nop             ; 13
        nop             ; 15
        nop             ; 17
        nop             ; 19
        nop             ; 21
        nop             ; 23
        tsx     ; ldx #$40        ; 25
        stx HMBL        ; 28
        sta WSYNC
        sta HMOVE       ; 3
        lda largo_sprite; 6
        sta linea_doble ; 9
        dey             ; 11
        bne pam0        ; 13/14
        jmp pam10       ; 16

        ; Reg. X contiene 'sprite'
pam4:
        sta WSYNC       ; 73 ciclos máximo hasta aquí
        sta HMOVE       ; 3     3
        ;
        ; ¿Visualizar la bala?
        ;
    if 0        ; Ahorra cinco ciclos, hay que ver si puedo usarlos
        ldx #ENAM1      ; 2
        txs             ; 4
        cpy y_bala2     ; 7
        php             ; 10    Z cae perfecto en bit 1
        cpy y_bala      ; 13
        php             ; 16
        ldx sprite      ; 19
        ldx sprite      ; 22
        nop             ; 24
    else
        lda #0          ; 2     2
        cpy y_bala      ; 3     5
        bne pam3        ; 2/3   8
        lda #2          ; 2          9
pam3:   sta ENAM0       ; 3    11   12
        ; ¿Visualizar la bala del enemigo?
        lda #0          ; 2     2
        cpy y_bala2     ; 3     5
        bne pam7        ; 2/3   8
        lda #2          ; 2          9
pam7:   sta ENAM1       ;      11   12
    endif
        lda #0          ; 5
        dec linea_doble ; 10
        bmi pam6        ; 12/13
        lda linea_doble ; 15
        bne pam9        ; 17/18
        inc sprite      ; 22
pam9:   ora offset0,x   ; 26
        sty temp        ; 29
        tay             ; 31
        lda (bitmap),y  ; 36
        ldy temp        ; 39
pam6:   sta GRP1        ; 42 (notese que se llega aquí con A=0)
        tsx     ; ldx #$40        ; 68
        stx HMBL        ; 71
        sta WSYNC       ; 74 ciclos hasta aquí
        sta HMOVE       ; 3
        dey             ; 5
        beq pam10       ; 7/8
        jmp pam0        ; 10

        ; Llega aquí con 16 ó 8 ciclos
pam10:
        ldx #$ff        ; 18
        txs             ; 20
        jmp pan12       ; 23

        ; Detecta código dividido entre dos páginas (usa un ciclo más)
        if (pam0&$ff00)!=(pam10&$ff00)
        lda megabug4    ; :P
        endif

        org $d5f1
tabla_ajuste_fino:
        .byte $70       ; 7 a la izq.
        .byte $60       ; 6 a la izq.
        .byte $50       ; 5 a la izq.
        .byte $40       ; 4 a la izq.
        .byte $30       ; 3 a la izq.
        .byte $20       ; 2 a la izq.
        .byte $10       ; 1 a la izq.
        .byte $00       ; Sin cambio
        .byte $f0       ; 1 a la der.
        .byte $e0       ; 2 a la der.
        .byte $d0       ; 3 a la der.
        .byte $c0       ; 4 a la der.
        .byte $b0       ; 5 a la der.
        .byte $a0       ; 6 a la der.
        .byte $90       ; 7 a la der.
        
        org $d600
        ; Sprites de la nave del jugador
        ;
        ; Los sprites están verticalmente al revés, para ahorrar
        ; instrucciones al visualizar.
        ;
sprites_nave:
        ; Nave grande ($00)
        .byte $1c
        .byte $38
        .byte $78
        .byte $fc
        .byte $fe
        .byte $ef
        .byte $6d
        .byte $46
        ; Nave media ($08)
        .byte $00
        .byte $30
        .byte $70
        .byte $fc
        .byte $fe
        .byte $6a
        .byte $6c
        .byte $40
        ; Nave chica ($10)
        .byte $00
        .byte $10
        .byte $30
        .byte $7c
        .byte $7a
        .byte $34
        .byte $20
        .byte $00
        ; Sombra chica ($18)
        .byte $00
        .byte $00
        .byte $00
        .byte $20
        .byte $30
        .byte $78
        .byte $7c
        .byte $48
        ; Sombra media ($20)
        .byte $00
        .byte $00
        .byte $10
        .byte $30
        .byte $7c
        .byte $7e
        .byte $6c
        .byte $40
        ; Sombra grande ($28)
        .byte $00
        .byte $00
        .byte $30
        .byte $70
        .byte $7c
        .byte $7e
        .byte $7e
        .byte $6c
        ; Nave grande yendo a izq. ($30)
        .byte $00
        .byte $1c
        .byte $78
        .byte $fc
        .byte $fe
        .byte $6f
        .byte $cb
        .byte $86
        ; Nave media yendo a izq. ($38)
        .byte $00
        .byte $00
        .byte $70
        .byte $fc
        .byte $fe
        .byte $56
        .byte $cc
        .byte $80
        ; Nave chica yendo a izq. ($40)
        .byte $00
        .byte $00
        .byte $30
        .byte $3c
        .byte $7a
        .byte $64
        .byte $40
        .byte $00
        ; Explosión ($48)
        .byte $00
        .byte $08
        .byte $56
        .byte $6c
        .byte $12
        .byte $38
        .byte $66
        .byte $00
        ; Sin uso ($50)
        .byte $00
        .byte $00
        .byte $00
        .byte $00
        .byte $00
        .byte $00
        .byte $00
        .byte $00
        ; Explosión ($58)
        .byte $22
        .byte $99
        .byte $66
        .byte $44
        .byte $13
        .byte $58
        .byte $a6
        .byte $49
        ; Nave grande yendo a der. ($60)
        .byte $08
        .byte $18
        .byte $38
        .byte $7c
        .byte $fe
        .byte $ed
        .byte $6f
        .byte $26
        ; Nave media yendo a der. ($68)
        .byte $10
        .byte $30
        .byte $70
        .byte $7c
        .byte $fa
        .byte $ee
        .byte $6c
        .byte $20
        ; Nave chica yendo a der. ($70)
        .byte $10
        .byte $10
        .byte $38
        .byte $3c
        .byte $7a
        .byte $74
        .byte $10
        .byte $00

colores_nave:
    if COLOR_NTSC = 1
        ; Nave grande ($00)
        .byte $0c
        .byte $0e
        .byte $18
        .byte $0e
        .byte $0e
        .byte $0e
        .byte $0e
        .byte $0c
        ; Nave media ($08)
        .byte $0c
        .byte $0c
        .byte $18
        .byte $0e
        .byte $0e
        .byte $0e
        .byte $0e
        .byte $0c
        ; Nave chica ($10)
        .byte $0c
        .byte $0c
        .byte $18
        .byte $0e
        .byte $0e
        .byte $0e
        .byte $0c
        .byte $0c
        ; Sombra grande ($18)
        .byte $90
        .byte $90
        .byte $90
        .byte $90
        .byte $90
        .byte $90
        .byte $90
        .byte $90
        ; Sombra media ($20)
        .byte $90
        .byte $90
        .byte $90
        .byte $90
        .byte $90
        .byte $90
        .byte $90
        .byte $90
        ; Sombra chica ($28)
        .byte $90
        .byte $90
        .byte $90
        .byte $90
        .byte $90
        .byte $90
        .byte $90
        .byte $90
        ; Nave grande ($30)
        .byte $0c
        .byte $0e
        .byte $18
        .byte $0e
        .byte $0e
        .byte $0e
        .byte $0e
        .byte $0c
        ; Nave media ($38)
        .byte $0c
        .byte $0c
        .byte $18
        .byte $0e
        .byte $0e
        .byte $0e
        .byte $0e
        .byte $0c
        ; Nave chica ($40)
        .byte $0c
        .byte $0c
        .byte $18
        .byte $0e
        .byte $0e
        .byte $0e
        .byte $0c
        .byte $0c
        ; Explosión 1 ($48)
        .byte $34
        .byte $34
        .byte $34
        .byte $1a
        .byte $1a
        .byte $34
        .byte $34
        .byte $34
        ; Sin uso ($50)
        .byte $0e
        .byte $0e
        .byte $0e
        .byte $0e
        .byte $0e
        .byte $0e
        .byte $0e
        .byte $0e
        ; Explosión 2 ($58)
        .byte $38
        .byte $38
        .byte $1c
        .byte $1c
        .byte $1c
        .byte $1c
        .byte $38
        .byte $38
        ; Nave grande ($60)
        .byte $0c
        .byte $0e
        .byte $18
        .byte $0e
        .byte $0e
        .byte $0e
        .byte $0e
        .byte $0c
        ; Nave media ($68)
        .byte $0c
        .byte $0c
        .byte $18
        .byte $0e
        .byte $0e
        .byte $0e
        .byte $0e
        .byte $0c
        ; Nave chica ($70)
        .byte $0c
        .byte $0c
        .byte $18
        .byte $0e
        .byte $0e
        .byte $0e
        .byte $0c
        .byte $0c
    else
        ; Nave grande ($00)
        .byte $0c
        .byte $0e
        .byte $28
        .byte $0e
        .byte $0e
        .byte $0e
        .byte $0e
        .byte $0c
        ; Nave media ($08)
        .byte $0c
        .byte $0c
        .byte $28
        .byte $0e
        .byte $0e
        .byte $0e
        .byte $0e
        .byte $0c
        ; Nave chica ($10)
        .byte $0c
        .byte $0c
        .byte $28
        .byte $0e
        .byte $0e
        .byte $0e
        .byte $0c
        .byte $0c
        ; Sombra grande ($18)
        .byte $B0
        .byte $B0
        .byte $B0
        .byte $B0
        .byte $B0
        .byte $B0
        .byte $B0
        .byte $B0
        ; Sombra media ($20)
        .byte $B0
        .byte $B0
        .byte $B0
        .byte $B0
        .byte $B0
        .byte $B0
        .byte $B0
        .byte $B0
        ; Sombra chica ($28)
        .byte $B0
        .byte $B0
        .byte $B0
        .byte $B0
        .byte $B0
        .byte $B0
        .byte $B0
        .byte $B0
        ; Nave grande ($30)
        .byte $0c
        .byte $0e
        .byte $28
        .byte $0e
        .byte $0e
        .byte $0e
        .byte $0e
        .byte $0c
        ; Nave media ($38)
        .byte $0c
        .byte $0c
        .byte $28
        .byte $0e
        .byte $0e
        .byte $0e
        .byte $0e
        .byte $0c
        ; Nave chica ($40)
        .byte $0c
        .byte $0c
        .byte $28
        .byte $0e
        .byte $0e
        .byte $0e
        .byte $0c
        .byte $0c
        ; Explosión 1 ($48)
        .byte $44
        .byte $44
        .byte $44
        .byte $2a
        .byte $2a
        .byte $44
        .byte $44
        .byte $44
        ; Sin uso ($50)
        .byte $0e
        .byte $0e
        .byte $0e
        .byte $0e
        .byte $0e
        .byte $0e
        .byte $0e
        .byte $0e
        ; Explosión 2 ($58)
        .byte $48
        .byte $48
        .byte $2c
        .byte $2c
        .byte $2c
        .byte $2c
        .byte $48
        .byte $48
        ; Nave grande ($60)
        .byte $0c
        .byte $0e
        .byte $28
        .byte $0e
        .byte $0e
        .byte $0e
        .byte $0e
        .byte $0c
        ; Nave media ($68)
        .byte $0c
        .byte $0c
        .byte $28
        .byte $0e
        .byte $0e
        .byte $0e
        .byte $0e
        .byte $0c
        ; Nave chica ($70)
        .byte $0c
        .byte $0c
        .byte $28
        .byte $0e
        .byte $0e
        .byte $0e
        .byte $0c
        .byte $0c
    endif

        org $d700
        ; Electricidad
        .byte $05,$2b,$59,$48,$85,$2b,$59,$48   ; Electricidad
        .byte $05,$2b,$59,$48,$85,$2b,$59,$48   ; Electricidad
        .byte $05,$2b,$59,$48,$85,$2b,$59,$48   ; Electricidad

        org $d800
        ; Pared con hueco a izq.
        .byte $00,$01,$03,$07,$0e,$0c,$2a,$66   ; Intermedio.
        .byte $ee,$dd,$bb,$77,$ee,$cc,$aa,$66   ; Intermedio. Repetido x4
        .byte $ee,$dd,$bb,$77,$ee,$cc,$aa,$66   ; Intermedio. Repetido x4
        .byte $ee,$dd,$bb,$77,$ee,$cc,$aa,$66   ; Intermedio. Repetido x4
        .byte $ee,$dd,$bb,$77,$ee,$cc,$aa,$66   ; Intermedio. Repetido x4
        .byte $ee,$dd,$bb,$77,$ef,$df,$be,$7c   ; Intermedio.
        .byte $f8,$70,$20,$00,$00,$00,$00,$00   ; Tope izq.
        .byte $00,$00,$00,$00,$00,$00,$00,$00   ; Relleno (a 64 bytes)
        .byte $00,$01,$03,$07,$0e,$0c,$2a,$66   ; Intermedio.
        .byte $ee,$dd,$bb,$77,$ee,$cc,$aa,$66   ; Intermedio. Repetido x4
        .byte $ee,$dd,$bb,$77,$ee,$cc,$aa,$66   ; Intermedio. Repetido x4
        .byte $ee,$dd,$bb,$77,$ee,$cc,$aa,$66   ; Intermedio. Repetido x4
        .byte $ee,$dd,$bb,$77,$ee,$cc,$aa,$66   ; Intermedio. Repetido x4
        .byte $ee,$df,$be,$7c,$f8,$70,$a0,$c0   ; Hueco en 1 o 2 (col.2/3)
        .byte $c0,$40,$80,$c0,$80,$00,$00,$00   ; Hueco en 1 o 2 (col.2/3) Tope
        .byte $00,$00,$00,$00,$00,$00,$00,$00   ; Relleno (a 64 bytes)
        .byte $00,$01,$03,$07,$0e,$0c,$2a,$66   ; Intermedio.
        .byte $ee,$dd,$bb,$77,$ee,$cc,$aa,$66   ; Intermedio. Repetido x4
        .byte $ee,$dd,$bb,$77,$ee,$cc,$aa,$66   ; Intermedio. Repetido x4
        .byte $ee,$dd,$bb,$77,$ee,$cc,$aa,$66   ; Intermedio. Repetido x4
        .byte $ee,$dd,$bb,$77,$ee,$cc,$aa,$66   ; Intermedio. Repetido x4
        .byte $ee,$dd,$bb,$77,$ef,$df,$be,$7c   ; Intermedio.
        .byte $f8,$70,$20,$00,$00,$00,$00,$00   ; Tope hueco.
        .byte $00,$00,$00,$00,$00,$00,$00,$00   ; Relleno (a 64 bytes)
        .byte $00,$00,$00,$00,$00,$00,$28,$6c   ; Inf. der.
        .byte $ec,$c4,$a8,$6c,$ec,$c4,$a8,$6c   ; Lado der. Repetido x4
        .byte $ec,$c4,$a8,$6c,$ec,$c4,$a8,$6c   ; Lado der. Repetido x4
        .byte $ec,$c4,$a8,$6c,$ec,$c4,$a8,$6c   ; Lado der. Repetido x4
        .byte $ec,$c4,$a8,$6c,$ec,$c4,$a8,$6c   ; Lado der. Repetido x4
        .byte $ec,$c4,$a8,$6c,$ec,$d4,$b8,$7c   ; Lado der.
        .byte $f8,$70,$a0,$c0,$80,$00,$00,$00   ; Tope der.
        .byte $00,$00,$00,$00,$00,$00,$00,$00   ; Relleno (a 64 bytes)

        org $d900
        ; Pared con hueco a der.
        .byte $00,$01,$03,$07,$0e,$0c,$2a,$66   ; Intermedio.
        .byte $ee,$dd,$bb,$77,$ee,$cc,$aa,$66   ; Intermedio. Repetido x4
        .byte $ee,$dd,$bb,$77,$ee,$cc,$aa,$66   ; Intermedio. Repetido x4
        .byte $ee,$dd,$bb,$77,$ee,$cc,$aa,$66   ; Intermedio. Repetido x4
        .byte $ee,$dd,$bb,$77,$ee,$cc,$aa,$66   ; Intermedio. Repetido x4
        .byte $ee,$dd,$bb,$77,$ef,$df,$be,$7c   ; Intermedio.
        .byte $f8,$70,$20,$00,$00,$00,$00,$00   ; Tope izq.
        .byte $00,$00,$00,$00,$00,$00,$00,$00   ; Relleno (a 64 bytes)
        .byte $00,$01,$03,$07,$0e,$0c,$2a,$66   ; Intermedio.
        .byte $ee,$dd,$bb,$77,$ee,$cc,$aa,$66   ; Intermedio. Repetido x4
        .byte $ee,$dd,$bb,$77,$ee,$cc,$aa,$66   ; Intermedio. Repetido x4
        .byte $ee,$dd,$bb,$77,$ee,$cc,$aa,$66   ; Intermedio. Repetido x4
        .byte $ee,$dd,$bb,$77,$ee,$cc,$aa,$66   ; Intermedio. Repetido x4
        .byte $ee,$dd,$bb,$77,$ef,$df,$be,$7c   ; Intermedio.
        .byte $f8,$70,$a0,$c0,$80,$00,$00,$00   ; Tope intermedio.
        .byte $00,$00,$00,$00,$00,$00,$00,$00   ; Relleno (a 64 bytes)
        .byte $00,$01,$03,$07,$0e,$0c,$2a,$66   ; Intermedio.
        .byte $ee,$dd,$bb,$77,$ee,$cc,$aa,$66   ; Intermedio. Repetido x4
        .byte $ee,$dd,$bb,$77,$ee,$cc,$aa,$66   ; Intermedio. Repetido x4
        .byte $ee,$dd,$bb,$77,$ee,$cc,$aa,$66   ; Intermedio. Repetido x4
        .byte $ee,$dd,$bb,$77,$ee,$cc,$aa,$66   ; Intermedio. Repetido x4
        .byte $ee,$df,$be,$7c,$f8,$70,$a0,$c0   ; Hueco en 1 o 2 (col.2/3)
        .byte $c0,$40,$80,$c0,$80,$00,$00,$00   ; Hueco en 1 o 2 (col.2/3) Tope
        .byte $00,$00,$00,$00,$00,$00,$00,$00   ; Relleno (a 64 bytes)
        .byte $00,$00,$00,$00,$00,$00,$28,$6c   ; Inf. der.
        .byte $ec,$c4,$a8,$6c,$ec,$c4,$a8,$6c   ; Lado der. Repetido x4
        .byte $ec,$c4,$a8,$6c,$ec,$c4,$a8,$6c   ; Lado der. Repetido x4
        .byte $ec,$c4,$a8,$6c,$ec,$c4,$a8,$6c   ; Lado der. Repetido x4
        .byte $ec,$c4,$a8,$6c,$ec,$c4,$a8,$6c   ; Lado der. Repetido x4
        .byte $ec,$c4,$a8,$6c,$ec,$d4,$b8,$7c   ; Lado der.
        .byte $f8,$70,$20,$00,$00,$00,$00,$00   ; Tope hueco.
        .byte $00,$00,$00,$00,$00,$00,$00,$00   ; Relleno (a 64 bytes)

        org $da00
        ; Pared con hueco grande
        .byte $00,$01,$03,$07,$0e,$0c,$2a,$66   ; Intermedio.
        .byte $ee,$dd,$bb,$77,$ee,$cc,$aa,$66   ; Intermedio. Repetido x4
        .byte $ee,$dd,$bb,$77,$ee,$cc,$aa,$66   ; Intermedio. Repetido x4
        .byte $ee,$dd,$bb,$77,$ee,$cc,$aa,$66   ; Intermedio. Repetido x4
        .byte $ee,$dd,$bb,$77,$ee,$cc,$aa,$66   ; Intermedio. Repetido x4
        .byte $ee,$dd,$bb,$77,$ef,$df,$be,$7c   ; Intermedio.
        .byte $f8,$70,$20,$00,$00,$00,$00,$00   ; Tope izq.
        .byte $00,$00,$00,$00,$00,$00,$00,$00   ; Relleno (a 64 bytes)
        .byte $00,$01,$03,$07,$0e,$0c,$2a,$66   ; Intermedio.
        .byte $ee,$dd,$bb,$77,$ee,$cc,$aa,$66   ; Intermedio. Repetido x4
        .byte $ee,$dd,$bb,$77,$ee,$cc,$aa,$66   ; Intermedio. Repetido x4
        .byte $ee,$dd,$bb,$77,$ee,$cc,$aa,$66   ; Intermedio. Repetido x4
        .byte $ee,$dd,$bb,$77,$ee,$cd,$ab,$67   ; Hueco en 1 y 2 (col.2,lin.3)
        .byte $ef,$df,$be,$7c,$f8,$70,$a0,$c0   ; Hueco en 1 o 2 (col.2/3)
        .byte $c0,$40,$80,$c0,$80,$00,$00,$00   ; Hueco en 1 o 2 (col.2/3) Tope
        .byte $00,$00,$00,$00,$00,$00,$00,$00   ; Relleno (a 64 bytes)
        .byte $00,$01,$03,$07,$0e,$0c,$2a,$66   ; Intermedio.
        .byte $ee,$dd,$bb,$77,$ee,$cc,$aa,$66   ; Intermedio. Repetido x4
        .byte $ee,$dd,$bb,$77,$ee,$cc,$aa,$66   ; Intermedio. Repetido x4
        .byte $ee,$dd,$bb,$77,$ee,$cc,$aa,$66   ; Intermedio. Repetido x4
        .byte $ee,$dd,$bb,$77,$ee,$cc,$aa,$66   ; Intermedio. Repetido x4
        .byte $ee,$df,$be,$7c,$f8,$70,$a0,$c0   ; Hueco en 1 o 2 (col.2/3)
        .byte $80,$00,$00,$00,$00,$00,$00,$00   ; Hueco en 1 y 2 (col.3) Tope
        .byte $00,$00,$00,$00,$00,$00,$00,$00   ; Relleno (a 64 bytes)
        .byte $00,$00,$00,$00,$00,$00,$28,$6c   ; Inf. der.
        .byte $ec,$c4,$a8,$6c,$ec,$c4,$a8,$6c   ; Lado der. Repetido x4
        .byte $ec,$c4,$a8,$6c,$ec,$c4,$a8,$6c   ; Lado der. Repetido x4
        .byte $ec,$c4,$a8,$6c,$ec,$c4,$a8,$6c   ; Lado der. Repetido x4
        .byte $ec,$c4,$a8,$6c,$ec,$c4,$a8,$6c   ; Lado der. Repetido x4
        .byte $ec,$c4,$a8,$6c,$ec,$d4,$b8,$7c   ; Lado der.
        .byte $f8,$70,$20,$00,$00,$00,$00,$00   ; Tope hueco.
        .byte $00,$00,$00,$00,$00,$00,$00,$00   ; Relleno (a 64 bytes)

        org $db00
        ; Abismo de entrada
        .byte $00,$01,$03,$0f,$1f,$3f,$7f,$7f   ; Relleno 8
        .byte $70,$60,$f0,$f8,$e0,$80,$00,$00   ; Relleno 7
        .byte $00,$00,$00,$00,$00,$00,$00,$00   ; Relleno 6
        .byte $00,$00,$00,$00,$00,$00,$00,$00   ; Relleno 5
        .byte $00,$00,$00,$00,$00,$00,$00,$00   ; Relleno 4
        .byte $00,$00,$00,$00,$00,$00,$00,$00   ; Relleno 3
        .byte $00,$00,$00,$00,$00,$00,$00,$00   ; Relleno 2
        .byte $00,$00,$00,$00,$00,$00,$00,$00   ; Relleno 1
        .byte $00,$00,$00,$03,$0f,$3f,$7f,$7f   ; Relleno 8
        .byte $ff,$f8,$c0,$80,$c0,$e0,$c0,$80   ; Relleno 7
        .byte $00,$00,$00,$00,$00,$00,$00,$00   ; Relleno 6
        .byte $00,$00,$00,$00,$00,$00,$00,$00   ; Relleno 5
        .byte $00,$00,$00,$00,$00,$00,$00,$00   ; Relleno 4
        .byte $00,$00,$00,$00,$00,$00,$00,$00   ; Relleno 3
        .byte $00,$00,$00,$00,$00,$00,$00,$00   ; Relleno 2
        .byte $00,$00,$00,$00,$00,$00,$00,$00   ; Relleno 1
        .byte $00,$00,$00,$01,$03,$07,$0f,$1f   ; Relleno 8
        .byte $fc,$f8,$fc,$f0,$c0,$80,$c0,$80   ; Relleno 7
        .byte $00,$00,$00,$00,$00,$00,$00,$00   ; Relleno 6
        .byte $00,$00,$00,$00,$00,$00,$00,$00   ; Relleno 5
        .byte $00,$00,$00,$00,$00,$00,$00,$00   ; Relleno 4
        .byte $00,$00,$00,$00,$00,$00,$00,$00   ; Relleno 3
        .byte $00,$00,$00,$00,$00,$00,$00,$00   ; Relleno 2
        .byte $00,$00,$00,$00,$00,$00,$00,$00   ; Relleno 1
        .byte $00,$00,$00,$00,$00,$00,$1f,$ff   ; Relleno 8
        .byte $fe,$f0,$e0,$f0,$c0,$80,$c0,$00   ; Relleno 7
        .byte $00,$00,$00,$00,$00,$00,$00,$00   ; Relleno 6
        .byte $00,$00,$00,$00,$00,$00,$00,$00   ; Relleno 5
        .byte $00,$00,$00,$00,$00,$00,$00,$00   ; Relleno 4
        .byte $00,$00,$00,$00,$00,$00,$00,$00   ; Relleno 3
        .byte $00,$00,$00,$00,$00,$00,$00,$00   ; Relleno 2
        .byte $00,$00,$00,$00,$00,$00,$00,$00   ; Relleno 1

        org $dc00
        ; Abismo de salida
        .byte $0f,$1c,$0c,$04,$18,$60,$80,$00   ; Relleno 8
        .byte $00,$00,$00,$00,$00,$00,$00,$00   ; Relleno 7
        .byte $00,$00,$00,$00,$00,$00,$00,$00   ; Relleno 6
        .byte $00,$00,$00,$00,$00,$00,$00,$00   ; Relleno 5
        .byte $00,$00,$00,$00,$00,$00,$00,$00   ; Relleno 4
        .byte $00,$00,$00,$00,$00,$00,$00,$00   ; Relleno 3
        .byte $00,$00,$00,$00,$00,$00,$00,$00   ; Relleno 2
        .byte $00,$00,$00,$00,$00,$00,$00,$00   ; Relleno 1
        .byte $01,$06,$38,$70,$30,$10,$20,$c0   ; Relleno 8
        .byte $00,$00,$00,$00,$00,$00,$00,$00   ; Relleno 7
        .byte $00,$00,$00,$00,$00,$00,$00,$00   ; Relleno 6
        .byte $00,$00,$00,$00,$00,$00,$00,$00   ; Relleno 5
        .byte $00,$00,$00,$00,$00,$00,$00,$00   ; Relleno 4
        .byte $00,$00,$00,$00,$00,$00,$00,$00   ; Relleno 3
        .byte $00,$00,$00,$00,$00,$00,$00,$00   ; Relleno 2
        .byte $00,$00,$00,$00,$00,$00,$00,$00   ; Relleno 1
        .byte $03,$06,$02,$04,$38,$70,$30,$c0   ; Relleno 8
        .byte $00,$00,$00,$00,$00,$00,$00,$00   ; Relleno 7
        .byte $00,$00,$00,$00,$00,$00,$00,$00   ; Relleno 6
        .byte $00,$00,$00,$00,$00,$00,$00,$00   ; Relleno 5
        .byte $00,$00,$00,$00,$00,$00,$00,$00   ; Relleno 4
        .byte $00,$00,$00,$00,$00,$00,$00,$00   ; Relleno 3
        .byte $00,$00,$00,$00,$00,$00,$00,$00   ; Relleno 2
        .byte $00,$00,$00,$00,$00,$00,$00,$00   ; Relleno 1
        .byte $01,$0f,$18,$08,$38,$60,$20,$c0   ; Relleno 8
        .byte $00,$00,$00,$00,$00,$00,$00,$00   ; Relleno 7
        .byte $00,$00,$00,$00,$00,$00,$00,$00   ; Relleno 6
        .byte $00,$00,$00,$00,$00,$00,$00,$00   ; Relleno 5
        .byte $00,$00,$00,$00,$00,$00,$00,$00   ; Relleno 4
        .byte $00,$00,$00,$00,$00,$00,$00,$00   ; Relleno 3
        .byte $00,$00,$00,$00,$00,$00,$00,$00   ; Relleno 2
        .byte $00,$00,$00,$00,$00,$00,$00,$00   ; Relleno 1

        org $dd00
        ; Para evitar cruces de página

        ; Sprites de 8 líneas ubicados en múltiplos de 8
        ; Sprites de 16 líneas ubicados en múltiplos de 16

        ;
        ; Colores de sprite por línea
        ;
colores:
    if COLOR_NTSC = 1
        ; Antena 2 ($00)
        .byte $26
        .byte $18
        .byte $0c
        .byte $0c
        .byte $0e
        .byte $0e
        .byte $0e
        .byte $0c
        ; Antena 3 ($08)
        .byte $26
        .byte $18
        .byte $0c
        .byte $0c
        .byte $0e
        .byte $0e
        .byte $0e
        .byte $0c
        ; Antena 4 ($10)
        .byte $26
        .byte $18
        .byte $0c
        .byte $0c
        .byte $0e
        .byte $0e
        .byte $0e
        .byte $0c
        ; Antena 5 ($18)
        .byte $26
        .byte $18
        .byte $0c
        .byte $0c
        .byte $0e
        .byte $0e
        .byte $0e
        .byte $0c
        ; Antena 6 ($20)
        .byte $26
        .byte $18
        .byte $0c
        .byte $0c
        .byte $0e
        .byte $0e
        .byte $0e
        .byte $0c
        ; Sin uso ($28)
        .byte $0e
        .byte $0e
        .byte $0e
        .byte $0e
        .byte $0e
        .byte $0e
        .byte $0e
        .byte $0e
        ; Avión grande ($30)
        .byte $b6
        .byte $b8
        .byte $ba
        .byte $ba
        .byte $ba
        .byte $ba
        .byte $b8
        .byte $b8
        ; Avión medio ($38)
        .byte $b6
        .byte $b8
        .byte $ba
        .byte $ba
        .byte $ba
        .byte $ba
        .byte $b8
        .byte $b8
        ; Avión chico ($40)
        .byte $b6
        .byte $b8
        .byte $ba
        .byte $ba
        .byte $ba
        .byte $ba
        .byte $b8
        .byte $b8
        ; Explosión 1 ($48)
        .byte $34
        .byte $34
        .byte $34
        .byte $1a
        .byte $1a
        .byte $34
        .byte $34
        .byte $34
        ; Cañón mirando a la der. ($50)
        .byte $26
        .byte $28
        .byte $2a
        .byte $2a
        .byte $2a
        .byte $2a
        .byte $2a
        .byte $2a
        ; Explosión 2 ($58)
        .byte $38
        .byte $38
        .byte $1c
        .byte $1c
        .byte $1c
        .byte $1c
        .byte $38
        .byte $38
        ; Agujero ($60)
        .byte $14
        .byte $16
        .byte $18
        .byte $1a
        .byte $1c
        .byte $1c
        .byte $1a
        .byte $1a
        ; Cañón mirando a la izq. ($68)
        .byte $26
        .byte $28
        .byte $2a
        .byte $2a
        .byte $2a
        .byte $2a
        .byte $2a
        .byte $2a
        ; Combustible ($70)
        .byte $b0
        .byte $ba
        .byte $ba
        .byte $ba
        .byte $ba
        .byte $98
        .byte $98
        .byte $0e
        ; Antena ($78)
        .byte $26
        .byte $18
        .byte $0c
        .byte $0c
        .byte $0e
        .byte $0e
        .byte $0e
        .byte $0c
        ; Agujero disparando ($80)
        .byte $36
        .byte $36
        .byte $36
        .byte $36
        .byte $36
        .byte $36
        .byte $36
        .byte $36
        ; Misil vertical ($88)
        .byte $34
        .byte $38
        .byte $0c
        .byte $0e
        .byte $0e
        .byte $0e
        .byte $0e
        .byte $0c
        ; Alienígena ($90)
        .byte $44
        .byte $44
        .byte $44
        .byte $4a
        .byte $4a
        .byte $4a
        .byte $48
        .byte $48
        ; Misil teledirigido ($98)
        .byte $36
        .byte $38
        .byte $38
        .byte $38
        .byte $38
        .byte $38
        .byte $38
        .byte $34
        ; Robotote ($a0)
        .byte $0c
        .byte $0e
        .byte $0c
        .byte $0e
        .byte $0c
        .byte $0e
        .byte $0c
        .byte $0e
        .byte $0c
        .byte $0e
        .byte $0c
        .byte $0e
        .byte $0c
        .byte $0e
        .byte $0c
        .byte $0e
        ; Adorno en pared de fortaleza ($b0)
        .byte $b2
        .byte $b2
        .byte $b4
        .byte $b4
        .byte $b6
        .byte $b6
        .byte $b6
        .byte $b6
        ; Sin uso ($b8)
        .byte $0e
        .byte $0e
        .byte $0e
        .byte $0e
        .byte $0e
        .byte $0e
        .byte $0e
        .byte $0e
        ; Satélite ($c0)
        .byte $0c
        .byte $0c
        .byte $98
        .byte $98
        .byte $98
        .byte $98
        .byte $0c
        .byte $0c
        .byte $0e
        .byte $0e
        .byte $0e
        .byte $0e
        .byte $38
        .byte $0e
        .byte $0e
        .byte $0e
        ; Mira ($d0)
        .byte $38
        .byte $38
        .byte $38
        .byte $38
        .byte $38
        .byte $38
        .byte $38
        .byte $38
        .byte $38
        .byte $38
        .byte $38
        .byte $38
        .byte $38
        .byte $38
        .byte $38
        .byte $38
        ; Adorno en pared de fortaleza ($e0)
        .byte $2a
        .byte $2a
        .byte $2a
        .byte $2a
        .byte $2a
        .byte $2a
        .byte $2a
        .byte $2a
        ; Adorno en piso de fortaleza ($e8)
        .byte $0c
        .byte $0c
        .byte $0c
        .byte $0c
        .byte $0c
        .byte $0c
        .byte $0c
        .byte $0c
        ; Planetoide ($f0)
        .byte $94
        .byte $96
        .byte $98
        .byte $9a
        .byte $9c
        .byte $9c
        .byte $9a
        .byte $98
        ; Planetoide ($f8)
        .byte $94
        .byte $94
        .byte $94
        .byte $98
        .byte $9a
        .byte $9c
        .byte $9c
        .byte $9c
    else
        ; Antena 2 ($00)
        .byte $26
        .byte $28
        .byte $0c
        .byte $0c
        .byte $0e
        .byte $0e
        .byte $0e
        .byte $0c
        ; Antena 3 ($08)
        .byte $26
        .byte $28
        .byte $0c
        .byte $0c
        .byte $0e
        .byte $0e
        .byte $0e
        .byte $0c
        ; Antena 4 ($10)
        .byte $26
        .byte $28
        .byte $0c
        .byte $0c
        .byte $0e
        .byte $0e
        .byte $0e
        .byte $0c
        ; Antena 5 ($18)
        .byte $26
        .byte $28
        .byte $0c
        .byte $0c
        .byte $0e
        .byte $0e
        .byte $0e
        .byte $0c
        ; Antena 6 ($20)
        .byte $26
        .byte $28
        .byte $0c
        .byte $0c
        .byte $0e
        .byte $0e
        .byte $0e
        .byte $0c
        ; Sin uso ($28)
        .byte $0e
        .byte $0e
        .byte $0e
        .byte $0e
        .byte $0e
        .byte $0e
        .byte $0e
        .byte $0e
        ; Avión grande ($30)
        .byte $76
        .byte $78
        .byte $7a
        .byte $7a
        .byte $7a
        .byte $7a
        .byte $78
        .byte $78
        ; Avión medio ($38)
        .byte $76
        .byte $78
        .byte $7a
        .byte $7a
        .byte $7a
        .byte $7a
        .byte $78
        .byte $78
        ; Avión chico ($40)
        .byte $76
        .byte $78
        .byte $7a
        .byte $7a
        .byte $7a
        .byte $7a
        .byte $78
        .byte $78
        ; Explosión 1 ($48)
        .byte $44
        .byte $44
        .byte $44
        .byte $2a
        .byte $2a
        .byte $44
        .byte $44
        .byte $44
        ; Cañón mirando a la der. ($50)
        .byte $26
        .byte $28
        .byte $2a
        .byte $2a
        .byte $2a
        .byte $2a
        .byte $2a
        .byte $2a
        ; Explosión 2 ($58)
        .byte $48
        .byte $48
        .byte $2c
        .byte $2c
        .byte $2c
        .byte $2c
        .byte $48
        .byte $48
        ; Agujero ($60)
        .byte $24
        .byte $26
        .byte $28
        .byte $2a
        .byte $2c
        .byte $2c
        .byte $2a
        .byte $2a
        ; Cañón mirando a la izq. ($68)
        .byte $26
        .byte $28
        .byte $2a
        .byte $2a
        .byte $2a
        .byte $2a
        .byte $2a
        .byte $2a
        ; Combustible ($70)
        .byte $70
        .byte $7a
        .byte $7a
        .byte $7a
        .byte $7a
        .byte $B8
        .byte $B8
        .byte $0e
        ; Antena ($78)
        .byte $26
        .byte $28
        .byte $0c
        .byte $0c
        .byte $0e
        .byte $0e
        .byte $0e
        .byte $0c
        ; Agujero disparando ($80)
        .byte $46
        .byte $46
        .byte $46
        .byte $46
        .byte $46
        .byte $46
        .byte $46
        .byte $46
        ; Misil vertical ($88)
        .byte $44
        .byte $48
        .byte $0c
        .byte $0e
        .byte $0e
        .byte $0e
        .byte $0e
        .byte $0c
        ; Alienígena ($90)
        .byte $64
        .byte $64
        .byte $64
        .byte $6a
        .byte $6a
        .byte $6a
        .byte $68
        .byte $68
        ; Misil teledirigido ($98)
        .byte $46
        .byte $48
        .byte $48
        .byte $48
        .byte $48
        .byte $48
        .byte $48
        .byte $44
        ; Robotote ($a0)
        .byte $0c
        .byte $0e
        .byte $0c
        .byte $0e
        .byte $0c
        .byte $0e
        .byte $0c
        .byte $0e
        .byte $0c
        .byte $0e
        .byte $0c
        .byte $0e
        .byte $0c
        .byte $0e
        .byte $0c
        .byte $0e
        ; Adorno en pared de fortaleza ($b0)
        .byte $72
        .byte $72
        .byte $74
        .byte $74
        .byte $76
        .byte $76
        .byte $76
        .byte $76
        ; Sin uso ($b8)
        .byte $0e
        .byte $0e
        .byte $0e
        .byte $0e
        .byte $0e
        .byte $0e
        .byte $0e
        .byte $0e
        ; Satélite ($c0)
        .byte $0c
        .byte $0c
        .byte $b8
        .byte $b8
        .byte $b8
        .byte $b8
        .byte $0c
        .byte $0c
        .byte $0e
        .byte $0e
        .byte $0e
        .byte $0e
        .byte $48
        .byte $0e
        .byte $0e
        .byte $0e
        ; Mira ($d0)
        .byte $48
        .byte $48
        .byte $48
        .byte $48
        .byte $48
        .byte $48
        .byte $48
        .byte $48
        .byte $48
        .byte $48
        .byte $48
        .byte $48
        .byte $48
        .byte $48
        .byte $48
        .byte $48
        ; Adorno en pared de fortaleza ($e0)
        .byte $2a
        .byte $2a
        .byte $2a
        .byte $2a
        .byte $2a
        .byte $2a
        .byte $2a
        .byte $2a
        ; Adorno en piso de fortaleza ($e8)
        .byte $0c
        .byte $0c
        .byte $0c
        .byte $0c
        .byte $0c
        .byte $0c
        .byte $0c
        .byte $0c
        ; Planetoide ($f0)
        .byte $b4
        .byte $b6
        .byte $b8
        .byte $ba
        .byte $bc
        .byte $bc
        .byte $ba
        .byte $b8
        ; Planetoide ($f8)
        .byte $b4
        .byte $b4
        .byte $b4
        .byte $b8
        .byte $ba
        .byte $bc
        .byte $bc
        .byte $bc
    endif

        org $de00       ; Locación de inicio del ROM
        ; Para evitar cruces de página

        ;
        ; Los sprites están verticalmente al revés, para ahorrar
        ; instrucciones al visualizar.
        ;
sprites:
        ; Antena 2 ($00)
        .byte $38
        .byte $18
        .byte $1c
        .byte $3e
        .byte $38
        .byte $37
        .byte $38
        .byte $1c
        ; Antena 3 ($08)
        .byte $1c
        .byte $18
        .byte $38
        .byte $7c
        .byte $1c
        .byte $ec
        .byte $1c
        .byte $38
        ; Antena 4 ($10)
        .byte $1c
        .byte $18
        .byte $0c
        .byte $3e
        .byte $2e
        .byte $16
        .byte $2e
        .byte $5c
        ; Antena 5 ($18)
        .byte $1c
        .byte $18
        .byte $0c
        .byte $1e
        .byte $3e
        .byte $3e
        .byte $3e
        .byte $5e
        ; Antena 6 ($20)
        .byte $38
        .byte $18
        .byte $1c
        .byte $3e
        .byte $3e
        .byte $3e
        .byte $3e
        .byte $1c
        ; Sin uso ($28)
        .byte $00
        .byte $00
        .byte $00
        .byte $00
        .byte $00
        .byte $00
        .byte $00
        .byte $00
        ; Avión grande ($30)
        .byte $04
        .byte $cc
        .byte $f8
        .byte $5c
        .byte $3e
        .byte $66
        .byte $42
        .byte $02
        ; Avión medio ($38)
        .byte $04
        .byte $0c
        .byte $78
        .byte $5c
        .byte $3e
        .byte $66
        .byte $42
        .byte $00
        ; Avión chico ($40)
        .byte $08
        .byte $18
        .byte $70
        .byte $58
        .byte $3c
        .byte $6c
        .byte $44
        .byte $00
        ; Explosión 1 ($48)
        .byte $00
        .byte $08
        .byte $56
        .byte $6c
        .byte $12
        .byte $38
        .byte $66
        .byte $00
        ; Cañón mirando a la der. ($50)
        .byte $39
        .byte $7b
        .byte $7e
        .byte $44
        .byte $3a
        .byte $7e
        .byte $3c
        .byte $00
        ; Explosión 2 ($58)
        .byte $22
        .byte $99
        .byte $66
        .byte $44
        .byte $13
        .byte $58
        .byte $a6
        .byte $49
        ; Agujero ($60)
        .byte $18
        .byte $3e
        .byte $76
        .byte $c3
        .byte $c3
        .byte $6e
        .byte $38
        .byte $00
        ; Cañón mirando a la izq. ($68)
        .byte $9c
        .byte $de
        .byte $7e
        .byte $22
        .byte $5c
        .byte $7e
        .byte $3c
        .byte $00
        ; Combustible ($70)
        .byte $3c
        .byte $7e
        .byte $7e
        .byte $66
        .byte $5a
        .byte $3c
        .byte $7e
        .byte $3c
        ; Antena ($78)
        .byte $38
        .byte $18
        .byte $30
        .byte $7c
        .byte $74
        .byte $68
        .byte $74
        .byte $3a
        ; Agujero disparando ($80)
        .byte $5f
        .byte $be
        .byte $7f
        .byte $eb
        .byte $df
        .byte $3a
        .byte $5c
        .byte $28
        ; Misil vertical ($88)
        .byte $38
        .byte $38
        .byte $7c
        .byte $38
        .byte $38
        .byte $38
        .byte $38
        .byte $10
        ; Alienígena ($90)
        .byte $38
        .byte $7c
        .byte $44
        .byte $ba
        .byte $ba
        .byte $7c
        .byte $7c
        .byte $38
        ; Misil teledirigido ($98)
        .byte $00
        .byte $c0
        .byte $f0
        .byte $7e
        .byte $1c
        .byte $0e
        .byte $0a
        .byte $02
        ; Robotote ($a0)
        .byte $06
        .byte $1a
        .byte $7f
        .byte $fa
        .byte $bf
        .byte $ea
        .byte $af
        .byte $fa
        .byte $bf
        .byte $fa
        .byte $b3
        .byte $93
        .byte $9f
        .byte $e2
        .byte $84
        .byte $40
        ; Adorno en pared de fortaleza ($b0)
        .byte $c0
        .byte $f0
        .byte $fc
        .byte $ff
        .byte $f3
        .byte $ee
        .byte $dc
        .byte $b8
        ; Sin uso ($b8)
        .byte $3c
        .byte $66
        .byte $c3
        .byte $ff
        .byte $ff
        .byte $db
        .byte $7e
        .byte $3c
        ; Satélite ($c0)
        .byte $10
        .byte $38
        .byte $14
        .byte $18
        .byte $30
        .byte $50
        .byte $18
        .byte $3e
        .byte $20
        .byte $5e
        .byte $3a
        .byte $7a
        .byte $7a
        .byte $7e
        .byte $7c
        .byte $30
        ; Mira ($d0 y $d8)
        .byte $00
        .byte $00
        .byte $00
        .byte $00
        .byte $00
        .byte $00
        .byte $00
        .byte $00
        .byte $00
        .byte $00
        .byte $44
        .byte $28
        .byte $00
        .byte $28
        .byte $44
        .byte $00
        ; Adorno 2 ($e0)
        .byte $c0
        .byte $f0
        .byte $fc
        .byte $ff
        .byte $ff
        .byte $fc
        .byte $f0
        .byte $c0
        ; Adorno de piso ($e8)
        .byte $30
        .byte $7c
        .byte $7f
        .byte $3f
        .byte $cf
        .byte $f2
        .byte $3c
        .byte $08
        ; Planetoide ($f0)
        .byte $d8
        .byte $bc
        .byte $8e
        .byte $76
        .byte $7a
        .byte $7d
        .byte $3d
        .byte $1b
        ; Planetoide ($f8)
        .byte $00
        .byte $38
        .byte $7c
        .byte $7c
        .byte $7c
        .byte $7c
        .byte $38
        .byte $00

        org $dffc
        .word inicio    ; Posición de inicio al recibir RESET
        .word inicio    ; Posición para servir BRK
