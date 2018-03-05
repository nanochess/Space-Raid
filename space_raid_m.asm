        ;
        ; Space Raid para Atari 2600 (definiciones globales)
        ;
        ; por Oscar Toledo Gutiérrez
        ;
        ; (c) Copyright 2013 Oscar Toledo Gutiérrez
        ;
        ; Creación: 21-oct-2013. Separado del archivo principal.
        ; Revisión: 22-oct-2013. Nuevas variables para el kernel de bitmap
        ;                        grande y paredes.
        ; Revisión: 24-oct-2013. Nueva variable $cf.
        ;

        ;
        ; Defina esto a 1 para frecuencias NTSC (60 hz)
        ; Defina esto a 0 para frecuencias PAL (50 hz)
        ;
;NTSC    = 1

        ;
        ; Defina esto a 1 para colores NTSC
        ; Defina esto a 0 para colores PAL
        ;
;COLOR_NTSC     = 1

        ;
        ; Registros del TIA
        ;
VSYNC   = $00 ; 0000 00x0   Vertical Sync Set-Clear
VBLANK  = $01 ; xx00 00x0   Vertical Blank Set-Clear
WSYNC   = $02 ; ---- ----   Wait for Horizontal Blank
RSYNC   = $03 ; ---- ----   Reset Horizontal Sync Counter
NUSIZ0  = $04 ; 00xx 0xxx   Number-Size player/missile 0
NUSIZ1  = $05 ; 00xx 0xxx   Number-Size player/missile 1
COLUP0  = $06 ; xxxx xxx0   Color-Luminance Player 0
COLUP1  = $07 ; xxxx xxx0   Color-Luminance Player 1
COLUPF  = $08 ; xxxx xxx0   Color-Luminance Playfield
COLUBK  = $09 ; xxxx xxx0   Color-Luminance Background
CTRLPF  = $0a ; 00xx 0xxx   Control Playfield, Ball, Collisions
REFP0   = $0b ; 0000 x000   Reflection Player 0
REFP1   = $0c ; 0000 x000   Reflection Player 1
PF0     = $0d ; xxxx 0000   Playfield Register Byte 0
PF1     = $0e ; xxxx xxxx   Playfield Register Byte 1
PF2     = $0f ; xxxx xxxx   Playfield Register Byte 2
RESP0   = $10 ; ---- ----   Reset Player 0
RESP1   = $11 ; ---- ----   Reset Player 1
RESM0   = $12 ; ---- ----   Reset Missile 0
RESM1   = $13 ; ---- ----   Reset Missile 1
RESBL   = $14 ; ---- ----   Reset Ball
AUDC0   = $15 ; 0000 xxxx   Audio Control 0
AUDC1   = $16 ; 0000 xxxx   Audio Control 1
AUDF0   = $17 ; 000x xxxx   Audio Frequency 0
AUDF1   = $18 ; 000x xxxx   Audio Frequency 1
AUDV0   = $19 ; 0000 xxxx   Audio Volume 0
AUDV1   = $1a ; 0000 xxxx   Audio Volume 1
GRP0    = $1b ; xxxx xxxx   Graphics Register Player 0
GRP1    = $1c ; xxxx xxxx   Graphics Register Player 1
ENAM0   = $1d ; 0000 00x0   Graphics Enable Missile 0
ENAM1   = $1e ; 0000 00x0   Graphics Enable Missile 1
ENABL   = $1f ; 0000 00x0   Graphics Enable Ball
HMP0    = $20 ; xxxx 0000   Horizontal Motion Player 0
HMP1    = $21 ; xxxx 0000   Horizontal Motion Player 1
HMM0    = $22 ; xxxx 0000   Horizontal Motion Missile 0
HMM1    = $23 ; xxxx 0000   Horizontal Motion Missile 1
HMBL    = $24 ; xxxx 0000   Horizontal Motion Ball
VDELP0  = $25 ; 0000 000x   Vertical Delay Player 0
VDELP1  = $26 ; 0000 000x   Vertical Delay Player 1
VDELBL  = $27 ; 0000 000x   Vertical Delay Ball
RESMP0  = $28 ; 0000 00x0   Reset Missile 0 to Player 0
RESMP1  = $29 ; 0000 00x0   Reset Missile 1 to Player 1
HMOVE   = $2a ; ---- ----   Apply Horizontal Motion
HMCLR   = $2b ; ---- ----   Clear Horizontal Move Registers
CXCLR   = $2c ; ---- ----   Clear Collision Latches

CXM0P   = $00 ; xx00 0000       Read Collision  M0-P1   M0-P0
CXM1P   = $01 ; xx00 0000                       M1-P0   M1-P1
CXP0FB  = $02 ; xx00 0000                       P0-PF   P0-BL
CXP1FB  = $03 ; xx00 0000                       P1-PF   P1-BL
CXM0FB  = $04 ; xx00 0000                       M0-PF   M0-BL
CXM1FB  = $05 ; xx00 0000                       M1-PF   M1-BL
CXBLPF  = $06 ; x000 0000                       BL-PF   -----
CXPPMM  = $07 ; xx00 0000                       P0-P1   M0-M1
INPT0   = $08 ; x000 0000       Read Pot Port 0
INPT1   = $09 ; x000 0000       Read Pot Port 1
INPT2   = $0a ; x000 0000       Read Pot Port 2
INPT3   = $0b ; x000 0000       Read Pot Port 3
INPT4   = $0c ; x000 0000       Read Input (Trigger) 0 (0=pressed)
INPT5   = $0d ; x000 0000       Read Input (Trigger) 1 (0=pressed)

	; RIOT MEMORY MAP

SWCHA   = $280  ; Port A data register for joysticks:
                ; Bits 4-7 for player 1.  Bits 0-3 for player 2.
                ; bit 4/0 = 0 = Up
                ; bit 5/1 = 0 = Down
                ; bit 6/2 = 0 = Left
                ; bit 7/3 = 0 = Right
SWACNT  = $281  ; Port A data direction register (DDR)
SWCHB   = $282  ; Port B data (console switches)
                ; bit 0 = 0 = Reset button pressed
                ; bit 1 = 0 = Select button pressed
                ; bit 3 = 0 = B/W 1 = Color
                ; bit 6 = Jugador 1. 0 = Principiante 1 = Avanzado
                ; bit 7 = Jugador 2. 0 = Principiante 1 = Avanzado
SWBCNT  = $283  ; Port B DDR
INTIM   = $284  ; Timer output

TIMINT  = $285

TIM1T   = $294  ; set 1 clock interval
TIM8T   = $295  ; set 8 clock interval
TIM64T  = $296  ; set 64 clock interval
T1024T  = $297  ; set 1024 clock interval

        ;
        ; Selección de banco
        ;
banco0  = $fff8
banco1  = $fff9

        ;
        ; Inician datos en RAM
        ;
cuadro          = $80   ; Contador de cuadros visualizados

; Siguientes 2 accedidos en indice
y_jugador       = $81   ; Coordenada Y 3D del jugador
bala_y3d        = $82   ; Coordenada Y 3D de bala al ser disparada

; Siguientes 2 accedidos en indice
x_jugador       = $83   ; Coordenada X 3D del jugador
x_bala          = $84   ; Coordenada X bala

; Siguientes 2 accedidos en indice
yj3d            = $85   ; Coordenada Y 3D para jugador
y_bala          = $86   ; Coordenada Y bala

xj3d            = $87   ; Temporal
yj3d2           = $88   ; Coordenada Y 3D para sombra
linea_doble     = $89   ; Línea actual de sprite player 1
avance          = $8a   ; Avance de aviones (espacio)

; Siguientes 3 accedidos en indice
x_enemigo1      = $8b   ; Coordenada X de enemigo 1
x_enemigo2      = $8c   ; Coordenada X de enemigo 2
x_enemigo3      = $8d   ; Coordenada X de enemigo 3

; Siguientes 3 accedidos en indice
y_enemigo1      = $8e   ; Coordenada Y de enemigo 1
y_enemigo2      = $8f   ; Coordenada Y de enemigo 2
y_enemigo3      = $90   ; Coordenada Y de enemigo 3

; Siguientes 5 accedidos en indice
offset9         = $91   ; Offset a tabla sprites para player 0
offset0         = $92   ; Offset a tabla sprites para enemigo 1
offset1         = $93   ; Offset a tabla sprites para enemigo 2
offset2         = $94   ; Offset a tabla sprites para enemigo 3
offset3         = $95   ; Offset a tabla sprites para enemigo 4

; Siguientes 4 accedidos en indice
xe3d0           = $96   ; Coordenada X final de sprite 1
xe3d1           = $97   ; Coordenada X final de sprite 2
xe3d2           = $98   ; Coordenada X final de sprite 3
xe3d3           = $99   ; Coordenada X final de sprite 4

; Siguientes 5 accedidos en indice
ye3d0           = $9a   ; Coordenada Y final de sprite 1
ye3d1           = $9b   ; Coordenada Y final de sprite 2
ye3d2           = $9c   ; Coordenada Y final de sprite 3
ye3d3           = $9d   ; Coordenada Y final de sprite 4
ye3d4           = $9e   ; Siempre a cero para que funcione

x_bala2         = $9f   ; Coordenada X bala
y_bala2         = $a0   ; Coordenada Y bala
nivel_bala2     = $a1   ; Nivel de la bala
sprite          = $a2   ; Sprite actual en visualización (0-3 puede haber más)
nivel           = $a3   ; Nivel actual (0-3) (bit 0= 0=Espacio, 1=Fortaleza)
tiempo          = $a4   ; Tiempo para que aparezca otro elemento
lector          = $a5   ; Lector de nivel (2 bytes)
puntos          = $a7   ; Puntos (2 bytes) (BCD)

; Siguientes 3 accedidos en indice
ola             = $a9   ; Ola de ataque actual
secuencia       = $aa   ; Contador de secuencia
explosion       = $ab   ; Indica si explota

vidas           = $ac   ; Total de vidas
gasolina        = $ad   ; Total de gasolina (5.3) ($00-$50)
largo_sprite    = $ae   ; Largo actual de sprites
rand            = $af   ; Random
electrico       = $b0   ; Electricidad
nucita          = $b1   ; Estado de NUSIZ
antirebote      = $b2   ; Antirebote para disparo (INPT4)

; Siguientes 3 accedidos en indice
sonido_efecto   = $b3   ; Sonido actual de efecto
sonido_fondo    = $b4   ; Sonido actual de fondo
sonido_ap1      = $b5   ; Apuntador a efecto

sonido_f1       = $b6   ; Último dato de efecto
sonido_d1       = $b7   ; Duración de efecto
sonido_ap2      = $b8   ; Apuntador a fondo
sonido_f2       = $b9   ; Último dato de fondo
sonido_d2       = $ba   ; Duración de fondo
sonido_control  = $bb   ; Valor de control para canal 1
sonido_frec     = $bc   ; Dato (frec/vol) para canal 1
sonido_control2 = $bd   ; Valor de control para canal 0
sonido_frec2    = $be   ; Dato (frec/vol) para canal 0
dificultad      = $bf   ; Dificultad
mira            = $c0   ; Indica si la mira está activa
mira_off        = $c1   ; Restaura sprite
mira_x          = $c2   ; Restaura coordenada X
mira_y          = $c3   ; Restaura coordenada Y.
fondo           = $c4   ; Color de fondo
offset9s        = $c5   ; Sprite de sombra
proximo         = $c6   ; Próximo avión que disparará
espacio         = $c7   ; Contador de movimiento del espacio
bala_der        = $c8   ; Indica si bala enemigo va a la derecha
temp            = $c9   ; Valor temporal (kernel pam0-pam10)
bitmap          = $ca   ; Mega-bitmap actual (32x64) (kernel pam0-pam10)
color_grande    = $cc   ; Color para mega-bitmap
offset9temp     = $cd   ; Respaldo de offset9
offset0temp     = $ce   ; Respaldo de offset0
offset1temp     = $cf   ; Respaldo de offset1
offset2temp     = $d0   ; Respaldo de offset2
offset3temp     = $d1   ; Respaldo de offset3
ye3dtemp        = $d2   ; Respaldo de ye3d1
largotemp       = $d3   ; Respaldo de largo_sprite
kernel          = $d4   ; Selección de kernel
bala_x3d        = $d5   ; Coordenada X 3D de bala al ser disparada
linea_jugador   = $d6   ; Línea actual de sprite player 0
ajuste_nave     = $d7   ; Ajuste de nave para animación :)
; Siguientes 12 accedidos en indice
ap_digito       = $d8   ; Seis digitos de puntuación/vidas (12 bytes)

    if COLOR_NTSC=1
COLOR_BALA      = $0e
COLOR_3D        = $90
COLOR_FORTALEZA = $92
COLOR_FORTALEZA2 = $42
COLOR_ESPACIO   = $00
COLOR_GASOLINA  = $36
COLOR_PUNTOS    = $BA
COLOR_TITULO    = $20
    else
COLOR_BALA      = $0e
COLOR_3D        = $B0
COLOR_FORTALEZA = $B2
COLOR_FORTALEZA2 = $62
COLOR_ESPACIO   = $00
COLOR_GASOLINA  = $46
COLOR_PUNTOS    = $7A
COLOR_TITULO    = $20
    endif
