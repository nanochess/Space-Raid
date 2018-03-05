        ;
        ; Space Raid para Atari 2600
        ;
        ; por Oscar Toledo Gutiérrez
        ;
        ; (c) Copyright 2013 Oscar Toledo Gutiérrez
        ;
        ; Creación: 27-ago-2011.
        ; Revisión: 23-may-2013. Se agrega posicionamiento en X.
        ; Revisión: 24-sep-2013. La nave se mueve en seudo-3D, crece y se
        ;			  achica, tiene sombra, dispara. Y hay un
        ;			  avión enemigo pasando.
        ; Revisión: 25-sep-2013. Ya hay una bala enemiga y hasta tres sprites
        ;			  enemigos.
        ; Revisión: 26-sep-2013. Se introducen todos los sprites.
        ; Revisión: 27-sep-2013. Fortalezas semi-operativas, va mostrando
        ;			  diferentes elementos. El espacio ya muestra
        ;			  olas de ataque de aviones :) La sombra del
        ;			  jugador desaparece en el espacio. Ya puede
        ;			  destruir enemigos. Se agrega espectacular
        ;			  raya 3D :P.
        ; Revisión: 28-sep-2013. Los cañones y los aviones ya disparan.
        ;			  Solucionado bug al explotar satélite. Se
        ;			  ajusta sincronía NTSC/PAL. Gasta gasolina en
        ;			  fortaleza, recupera con depósitos. Muestra
        ;			  total de gasolina, puntos y vida. Pantalla de
        ;			  Game Over preliminar.
        ; Revisión: 29-sep-2013. Se pone pantalla de título con efecto de
        ;			  brillo. Se agrandan las balas. Optimización
        ;			  del núcleo para corregir defectos visuales.
        ;			  Ya puntúa por destruir enemigos. La
        ;			  electricidad detiene la bala. El campo de
        ;			  electricidad ya se mueve.
        ; Revisión: 30-sep-2013. Se implementa la explosión de la nave. Ya se
        ;			  ve completo el robotote. El misil teledirigido
        ;			  ya sigue a la nave y son necesarios cinco
        ;			  impactos para destruirlo. Ya no tiene disparo
        ;			  continuo. El jugador explota cuando se le
        ;			  acaba la gasolina. El robotote avanza y
        ;			  dispara (10 impactos para detenerlo). Se
        ;			  soluciona bug en que no podía seleccionar
        ;			  nivel fortaleza como inicio (no iniciaba
        ;			  largo_sprite). Nuevo dibujo para el misil
        ;			  teledirigido. Ya dispara misiles verticales
        ;			  y pueden ser destruidos si el jugador va al
        ;			  nivel correcto. Se implementan los colores
        ;			  para PAL. Se integran efectos de sonido. Se
        ;			  corrige bug de avión invisible destruido en
        ;			  espacio. El avión pequeño ya no es tan
        ;			  pequeño.
        ; Revisión: 01-oct-2013. Las balas de los enemigos ya destruyen al
        ;			  jugador. El jugador ya puede chocar con los
        ;			  elementos del juego. Al tomar gasolina
        ;			  aumenta a unidades completas. Se hace "alta"
        ;			  la barrera eléctrica. El jugador inicia
        ;			  arriba después de ser destruido. Ya disparan
        ;			  los aviones chicos en la fortaleza. El botón
        ;			  de reset ya reinicia el juego. El switch de
        ;			  dificultad para el jugador 1 ya se toma en
        ;			  cuenta para que los cañones disparen más
        ;			  seguido. Juego completo :). Se alarga el
        ;			  sprite de electricidad, se acelera su
        ;			  movimiento para que parezca campo de fuerza y
        ;			  ya no se sale de la pantalla. El robotote
        ;			  empieza 10 pixeles más a la izquierda para
        ;			  no salirse de la pantalla. Corrección en la
        ;			  ubicación del disparo del robotote. Desaparece
        ;			  bala cuando ocurre explosión del jugador. Se
        ;			  agrega bitmap "by nanochess" :). Retorna el
        ;			  fondo a negro en caso de Game Over.
        ; Revisión: 02-oct-2013. Evita que disparen cañones invisibles (se
        ;			  escuchaba el sonido). Se optimiza más el
        ;			  código. No se podía hacer reset mientras
        ;			  explotaba. Ajuste en consumo de gasolina. La
        ;			  explosión del robotote y del satélite ya es
        ;			  animada. Corrección en misiles verticales,
        ;			  seguían subiendo aunque ya hubieran
        ;			  desaparecido. Se ajusta con el emulador
        ;			  Stella para que emita exactamente 262 líneas
        ;			  con NTSC (eran 265) y 312 con PAL (eran 315)
        ; Revisión: 03-oct-2013. La bala del jugador se centra en la punta de
        ;			  la nave, también la bala de los enemigos.
        ; 			  Ya hay suficientes botes de gasolina de
        ;			  acuerdo a la longitud del nivel y máxima
        ;			  dificultad. Descubrí el uso de HMCLR para
        ;			  ahorrar bytes :). Se integra mira para
        ;			  apuntar en el espacio (sólo dificultad fácil)
        ;			  Los campos eléctricos ya pueden estar arriba
        ;			  o abajo. Gané tiempo en el kernel para usar
        ;			  HMOVE en cada línea de la visualización
        ;			  principal y así desaparecen los fragmentos
        ;			  de pixeles que aparecían en la columna
        ;			  izquierda del video. Se modifica el indicador
        ;			  de puntuación para mantener la barra negra a
        ;			  la izquierda.
        ; Revisión: 04-oct-2013. Se reescribe otra vez el kernel de pantalla
        ;			  para que quepa una escritura en HMBL para
        ;			  evitar que las rayas 3D se desplacen cuando
        ;			  aparecía un sprite. La raya 3D se desplaza
        ;			  más rápido. Corrección en tabla de puntuación.
        ;			  Los agujeros de misil ahora a veces disparan
        ;			  al llegar al centro. Se agregan dos adornos en
        ;			  la pared de la fortaleza usando un cuarto
        ;			  sprite (nuevo). Colores variables en el
        ;			  espacio (es que es hiperespacio :P) Se centra
        ;			  el disparo del robotote. Mejores colores para
        ;			  los sprites. Los disparos son más aleatorios
        ;			  y la dificultad es progresiva.
        ; Revisión: 05-oct-2013. Color alterno cada dos fortalezas. Más
        ;			  optimización. Limita puntos a 9999. Se
        ;			  agrega cañón giratorio. Se corrige un bug
        ;			  en que cuando aparecía la mirilla y se
        ;			  disparaba entonces los enemigos explotaban
        ;			  inmediato.
        ; Revisión: 06-oct-2013. Se implementa PAL60, es la misma frecuencia
        ;			  que NTSC pero con colores PAL.
        ; Revisión: 07-oct-2013. Se optimiza el minireproductor de sonido y se
        ;			  cambia el formato (18 bytes ahorrados más tres
        ;			  posibles en efectos). Se corrige bug en
        ;			  fortaleza en un nivel avanzado al ser tocado
        ; 			  podía explotar dos veces ya que la gasolina
        ;			  seguía acabándose.
        ; Revisión: 08-oct-2013. Más optimización. Corrección en adornos de
        ;			  fortaleza, no salía la flecha amarilla.
        ;			  Ligera mejora en kernel de visualización. Ya
        ;			  hay sonido para cuando los aviones enemigos
        ;			  disparan. Ya se alternan los disparos de los
        ;			  aviones enemigos, antes sólo disparaba el
        ;			  primero de estos. El agujero de misil ya se
        ;			  llena de fuego al disparar misil y destruye
        ;			  al jugador si se toca en ese momento.
        ; Revisión: 09-oct-2013. Más optimización.
        ; Revisión: 10-oct-2013. Más optimización. Se reutiliza byte
        ;			  desaprovechado en letras para puntuación. Se
        ;			  combina la detección de colisión de bala y
        ;			  de nave y ahorré montones de bytes. Se
        ;			  agrega detección de código importante dividido
        ;			  entre dos páginas de 256 bytes (un salto 6502
        ;			  usa un ciclo extra)
        ; Revisión: 11-oct-2013. Más optimización. Permite seleccionar
        ;			  dificultad en Game Over.
        ; Revisión: 12-oct-2013. Rediseño del fondo en el espacio para que
        ;			  las rayas parezcan estrellas. Se agregan
        ;			  planetas (dos sprites) en el espacio :) Se
        ;			  agrega alienígena que anda en el piso de la
        ;			  fortaleza. Los cañones ya disparan a la
        ;			  derecha (aleatoriamente). Se compacta la
        ;			  representación de nivel de las fortalezas. Se
        ;			  agregan adornos de piso antes de los agujeros
        ;			  de misil. Se agrega un tiempo aleatorio entre
        ;			  elementos de fortaleza para que no se sientan
        ;			  "tan" iguales. El misil teledirigido congela
        ;			  el scroll de la raya 3D.
        ; Revisión: 19-oct-2013. Se corrige bug en que mira aparecía cuando
        ;			  el avión enemigo ya está detrás del jugador.
        ;			  Se corrige bug en que misil teledirigido iba
        ;			  muy abajo con respecto a la nave y era
        ;			  imposible atinarle cuando la nave estaba hasta
        ;			  arriba. Ahora son sólo tres niveles de gasto
        ;			  de gasolina y más altos, ya que en los niveles
        ;			  primarios apenas se consumía gasolina.
        ;			  Gasolina es 5.3. Ya dispara el tercer avión,
        ;			  era a causa de var. 'ola' no era tomada en
        ;			  cuenta cuando era $3b.
        ;

        ;
        ; ROM de 4K:
        ; o Espacio usado: 4079 bytes.
        ; o Espacio libre: 17 bytes.
        ;

        ;
        ; Manual del usuario:
        ;
        ; En este sorprendente juego isométrico en 3D, pilotee su nave de
        ; guerra y pase a la ofensiva contra el enemigo, aniquile sus fuerzas
        ; en el espacio y haga un ataque rápido a las fortalezas que encuentre
        ; en su camino. ¡Cuidado con el robot maestro y los misiles
        ; teledirigidos!
        ;
        ; o Seleccione dificultad con P1, Easy (A) / Hard (B)
        ;   En dificultad fácil obtendrá una mirilla para apuntar a los
        ;   aviones enemigos.
        ; o Oprima Reset en cualquier momento para reiniciar el juego
        ; o Mueva su nave utilizando la palanca de mandos (izq+der, arriba
        ;   para bajar y abajo para subir) ¡cuidado con los campos de fuerza!
        ; o Dispare a los enemigos utilizando el botón de la palanca de mandos.
        ; o Su nivel de combustible se muestra con una barra roja doble en la
        ;   parte inferior de la pantalla y se irá reduciendo. Destruya
        ;   bidones de combustible para recuperarlo. En el espacio el gasto
        ;   de combustible es mínimo, pero en fortalezas se consumirá y más
        ;   rápidamente en niveles avanzados.
        ; o Su puntuación se muestra en la parte inferior junto con el número
        ;   de naves restante.
        ;
        ; Tabla de puntuación.
        ; Misil - 1 punto
        ; Combustible - 1 punto
        ; Cañón - 2 puntos
        ; Avión - 2 puntos
        ; Alienígena - 3 puntos
        ; Antena de satélite - 5 puntos
        ; Misil teledirigido - 5 puntos
        ; Satélite - 10 puntos
        ; Robot - 25 puntos
        ;

        ;
        ; Notas:
        ; o En grupos de 3 los aviones destruidos no pueden dejar de moverse
        ;   de lo contrario alguno quedaría en coordenada Y "mezclada" y
        ;   "arruinaría" los demás sprites.
        ; o Personalmente no lo he probado en hardware real, pero en Atariage
        ;   varias personas dicen que ya lo probaron :) y según las mediciones
        ;   con el emulador Stella todo va bien.
        ; o Duración de la fortaleza 1: 53 segundos.
        ; o En ocasiones hay glitches gráficos en los pixeles superiores de
        ;   los sprites de los enemigos. Es normal.
        ; o En ocasiones las balas miden 3 líneas de video en lugar de 2. Es
        ;   normal.
        ;

        ;
        ; Sprites disponibles: 0
        ;
        ; Otras cosas interesantes que se pueden hacer:
        ; o Música de Game Over
        ; o Música en pantalla de título.
        ; o Usar botón de "Select" para algo
        ; o Usar botón de "B/W" para algo.
        ; o Que las antenas de satélite muevan la "cabeza"
        ;   o Sprite extra y comprobación aleatoria
        ;
        ; Con flicker se puede:
        ; o Pasar a 8K para hacer todo lo que está listado aquí :>
        ; o Colocar sprites de piso en la fortaleza
        ;   o Sprite extra, variables extra
        ; o Paredes de 48 pixeles de alto con un hueco para pasar (48+40)
        ;   probablemente usando NUSIZ de robot para reducir parpadeo.
        ;   o Dos bitmaps gigantes (hueco izq, hueco der)
        ; o Bitmaps de adorno para simular abismo en la entrada y salida de
        ;   la fortaleza (bitmap 48 pixeles)
        ;   o Dos bitmaps gigantes (dibujo entrada, dibujo salida)
        ; o Robotote mejor diseñado (bitmap 16 pixeles)
        ; o Hacer volar misiles mientras hay otros objetos en el piso.
        ;
        ; Cosas que no me convencen:
        ; o Sombras en el espacio para ayudarse con la altitud
        ; o Cambio de color de enemigo/nave cuando están en línea (preferí
        ;   la mirilla)
        ; o Sombra para robotote. (no es muy importante porque se pone al
        ;   nivel del jugador)
        ; o Sombra para misil teledirigido. (no es muy importante porque se
        ;   pone al nivel del jugador)
        ; o Fondo de estrellas con scrolling usando solamente ball (es
        ;   extremadamente difícil, no hay tiempo en el kernel). Hay un truco
        ;   en el Cosmic Ark, pero no se puede usar si se hace HMOVE en cada
        ;   línea.
        ;

        ;
        ; Defina esto a 1 para frecuencias NTSC (60 hz)
        ; Defina esto a 0 para frecuencias PAL (50 hz)
        ;
        ; Desactive comentario para http://8bitworkshop.com
        ;
;NTSC	  = 1

        ;
        ; Defina esto a 1 para colores NTSC
        ; Defina esto a 0 para colores PAL
        ;
        ; Desactive comentario para http://8bitworkshop.com
        ;
;COLOR_NTSC	 = 1

        ;
        ; Cada línea de video toma 76 ciclos del procesador
        ;
        ; Para NTSC (262 líneas):
        ;    3 - VSYNC
        ;    37 - VBLANK
        ;	   2812 (37 * 76) - 14
        ;	   2798 / 64 = 43.71 valor para TIM64T
        ;    202 - VIDEO
        ;    20 - VBLANK
        ;
        ; Para PAL (312 líneas):
        ;    3 - VSYNC
        ;    62 - VBLANK
        ;	   4712 (62 * 76) - 14
        ;	   4698 / 64 = 73.40 valor para TIM64T
        ;    202 - VIDEO
        ;    45 - VBLANK
        ;
        ; Notese que STA WSYNC no hace ninguna generación de sincronía,
        ; simplemente espera hasta que inicia el próximo HBLANK que es
        ; generado automáticamente por el hardware.
        ;
        ; Lo único que controla el software es la sincronía vertical
        ; (el VBLANK)
        ;
        ; El procesador 6507 del Atari 2600 es compatible con 6502 pero
        ; no tiene líneas de interrupción y su bus de direcciones está
        ; limitado a 13 bits.
        ;
        ; Para confirmar que el timing es correcto, utilice el emulador
        ; Stella y oprima Alt+I.
        ;
        ; Otros emuladores probados: z26.
        ;

        processor 6502

        ;
        ; Registros del TIA
        ;
VSYNC           = $00           ; 0000 00x0   Vertical Sync Set-Clear
VBLANK          = $01           ; xx00 00x0   Vertical Blank Set-Clear
WSYNC           = $02           ; ---- ----   Wait for Horizontal Blank
RSYNC           = $03           ; ---- ----   Reset Horizontal Sync Counter
NUSIZ0          = $04           ; 00xx 0xxx   Number-Size player/missile 0
NUSIZ1          = $05           ; 00xx 0xxx   Number-Size player/missile 1
COLUP0          = $06           ; xxxx xxx0   Color-Luminance Player 0
COLUP1          = $07           ; xxxx xxx0   Color-Luminance Player 1
COLUPF          = $08           ; xxxx xxx0   Color-Luminance Playfield
COLUBK          = $09           ; xxxx xxx0   Color-Luminance Background
CTRLPF          = $0a           ; 00xx 0xxx   Control Playfield, Ball, Collisions
REFP0           = $0b           ; 0000 x000   Reflection Player 0
REFP1           = $0c           ; 0000 x000   Reflection Player 1
PF0             = $0d           ; xxxx 0000   Playfield Register Byte 0
PF1             = $0e           ; xxxx xxxx   Playfield Register Byte 1
PF2             = $0f           ; xxxx xxxx   Playfield Register Byte 2
RESP0           = $10           ; ---- ----   Reset Player 0
RESP1           = $11           ; ---- ----   Reset Player 1
RESM0           = $12           ; ---- ----   Reset Missile 0
RESM1           = $13           ; ---- ----   Reset Missile 1
RESBL           = $14           ; ---- ----   Reset Ball
AUDC0           = $15           ; 0000 xxxx   Audio Control 0
AUDC1           = $16           ; 0000 xxxx   Audio Control 1
AUDF0           = $17           ; 000x xxxx   Audio Frequency 0
AUDF1           = $18           ; 000x xxxx   Audio Frequency 1
AUDV0           = $19           ; 0000 xxxx   Audio Volume 0
AUDV1           = $1a           ; 0000 xxxx   Audio Volume 1
GRP0            = $1b           ; xxxx xxxx   Graphics Register Player 0
GRP1            = $1c           ; xxxx xxxx   Graphics Register Player 1
ENAM0           = $1d           ; 0000 00x0   Graphics Enable Missile 0
ENAM1           = $1e           ; 0000 00x0   Graphics Enable Missile 1
ENABL           = $1f           ; 0000 00x0   Graphics Enable Ball
HMP0            = $20           ; xxxx 0000   Horizontal Motion Player 0
HMP1            = $21           ; xxxx 0000   Horizontal Motion Player 1
HMM0            = $22           ; xxxx 0000   Horizontal Motion Missile 0
HMM1            = $23           ; xxxx 0000   Horizontal Motion Missile 1
HMBL            = $24           ; xxxx 0000   Horizontal Motion Ball
VDELP0          = $25           ; 0000 000x   Vertical Delay Player 0
VDELP1          = $26           ; 0000 000x   Vertical Delay Player 1
VDELBL          = $27           ; 0000 000x   Vertical Delay Ball
RESMP0          = $28           ; 0000 00x0   Reset Missile 0 to Player 0
RESMP1          = $29           ; 0000 00x0   Reset Missile 1 to Player 1
HMOVE           = $2a           ; ---- ----   Apply Horizontal Motion
HMCLR           = $2b           ; ---- ----   Clear Horizontal Move Registers
CXCLR           = $2c           ; ---- ----   Clear Collision Latches

CXM0P           = $00           ; xx00 0000	   Read Collision  M0-P1   M0-P0
CXM1P           = $01           ; xx00 0000			   M1-P0   M1-P1
CXP0FB          = $02           ; xx00 0000			   P0-PF   P0-BL
CXP1FB          = $03           ; xx00 0000			   P1-PF   P1-BL
CXM0FB          = $04           ; xx00 0000			   M0-PF   M0-BL
CXM1FB          = $05           ; xx00 0000			   M1-PF   M1-BL
CXBLPF          = $06           ; x000 0000			   BL-PF   -----
CXPPMM          = $07           ; xx00 0000			   P0-P1   M0-M1
INPT0           = $08           ; x000 0000	   Read Pot Port 0
INPT1           = $09           ; x000 0000	   Read Pot Port 1
INPT2           = $0a           ; x000 0000	   Read Pot Port 2
INPT3           = $0b           ; x000 0000	   Read Pot Port 3
INPT4           = $0c           ; x000 0000	   Read Input (Trigger) 0 (0=pressed)
INPT5           = $0d           ; x000 0000	   Read Input (Trigger) 1 (0=pressed)

        ; RIOT MEMORY MAP

SWCHA           = $280          ; Port A data register for joysticks:
        ; Bits 4-7 for player 1.  Bits 0-3 for player 2.
        ; bit 4/0 = 0 = Up
        ; bit 5/1 = 0 = Down
        ; bit 6/2 = 0 = Left
        ; bit 7/3 = 0 = Right
SWACNT          = $281          ; Port A data direction register (DDR)
SWCHB           = $282          ; Port B data (console switches)
        ; bit 0 = 0 = Reset button pressed
        ; bit 1 = 0 = Select button pressed
        ; bit 3 = 0 = B/W 1 = Color
        ; bit 6 = Jugador 1. 0 = Principiante 1 = Avanzado
        ; bit 7 = Jugador 2. 0 = Principiante 1 = Avanzado
SWBCNT          = $283          ; Port B DDR
INTIM           = $284          ; Timer output

TIMINT          = $285

TIM1T           = $294          ; set 1 clock interval
TIM8T           = $295          ; set 8 clock interval
TIM64T          = $296          ; set 64 clock interval
T1024T          = $297          ; set 1024 clock interval

        ;
        ; Inicia línea de jugador
        ;
cuadro          = $80           ; Contador de cuadros visualizados
y_jugador       = $81           ; Coordenada Y 3D del jugador

        ; Siguientes 2 accedidos en indice
x_jugador       = $82           ; Coordenada X 3D del jugador
x_bala          = $83           ; Coordenada X bala

        ; Siguientes 2 accedidos en indice
yj3d            = $84           ; Coordenada Y 3D para jugador
y_bala          = $85           ; Coordenada Y bala

linea_jugador   = $86           ; Línea actual de sprite player 0
xj3d            = $87           ; Temporal
yj3d2           = $88           ; Coordenada Y 3D para sombra
linea_doble     = $89           ; Línea actual de sprite player 1
avance          = $8a           ; Avance de aviones (espacio)

        ; Siguientes 3 accedidos en indice
x_enemigo1      = $8b           ; Coordenada X de enemigo 1
x_enemigo2      = $8c           ; Coordenada X de enemigo 2
x_enemigo3      = $8d           ; Coordenada X de enemigo 3

        ; Siguientes 3 accedidos en indice
y_enemigo1      = $8e           ; Coordenada Y de enemigo 1
y_enemigo2      = $8f           ; Coordenada Y de enemigo 2
y_enemigo3      = $90           ; Coordenada Y de enemigo 3

        ; Siguientes 5 accedidos en indice
offset9         = $91           ; Offset a tabla sprites para player 0
offset0         = $92           ; Offset a tabla sprites para enemigo 1
offset1         = $93           ; Offset a tabla sprites para enemigo 2
offset2         = $94           ; Offset a tabla sprites para enemigo 3
offset3         = $95           ; Offset a tabla sprites para enemigo 4

        ; Siguientes 4 accedidos en indice
xe3d0           = $96           ; Coordenada X final de sprite 1
xe3d1           = $97           ; Coordenada X final de sprite 2
xe3d2           = $98           ; Coordenada X final de sprite 3
xe3d3           = $99           ; Coordenada X final de sprite 4

        ; Siguientes 5 accedidos en indice
ye3d0           = $9a           ; Coordenada Y final de sprite 1
ye3d1           = $9b           ; Coordenada Y final de sprite 2
ye3d2           = $9c           ; Coordenada Y final de sprite 3
ye3d3           = $9d           ; Coordenada Y final de sprite 4
ye3d4           = $9e           ; Siempre a cero para que funcione

x_bala2         = $9f           ; Coordenada X bala
y_bala2         = $a0           ; Coordenada Y bala
nivel_bala2     = $a1           ; Nivel de la bala
sprite          = $a2           ; Sprite actual en visualización (0-3 puede haber más)
nivel           = $a3           ; Nivel actual (0-3) (bit 0= 0=Espacio, 1=Fortaleza)
tiempo          = $a4           ; Tiempo para que aparezca otro elemento
lector          = $a5           ; Lector de nivel (2 bytes)
puntos          = $a7           ; Puntos (2 bytes) (BCD)

        ; Siguientes 3 accedidos en indice
ola             = $a9           ; Ola de ataque actual
secuencia       = $aa           ; Contador de secuencia
explosion       = $ab           ; Indica si explota

vidas           = $ac           ; Total de vidas
gasolina        = $ad           ; Total de gasolina (5.3) ($00-$50)
largo_sprite    = $ae           ; Largo actual de sprites
rand            = $af           ; Random
electrico       = $b0           ; Electricidad
nucita          = $b1           ; Estado de NUSIZ
antirebote      = $b2           ; Antirebote para disparo (INPT4)

        ; Siguientes 3 accedidos en indice
sonido_efecto   = $b3           ; Sonido actual de efecto
sonido_fondo    = $b4           ; Sonido actual de fondo
sonido_ap1      = $b5           ; Apuntador a efecto

sonido_ap2      = $b8           ; Apuntador a fondo
sonido_f1       = $b6           ; Último dato de efecto
sonido_f2       = $b9           ; Último dato de fondo
sonido_d1       = $b7           ; Duración de efecto
sonido_d2       = $ba           ; Duración de fondo
sonido_control  = $bb           ; Valor de control para canal 1
sonido_frec     = $bc           ; Dato (frec/vol) para canal 1
dificultad      = $bd           ; Dificultad
mira            = $be           ; Indica si la mira está activa
mira_off        = $bf           ; Restaura sprite
mira_x          = $c0           ; Restaura coordenada X
mira_y          = $c1           ; Restaura coordenada Y.
fondo           = $c2           ; Color de fondo
offset9s        = $c3           ; Sprite de sombra
proximo         = $c4           ; Próximo avión que disparará
espacio         = $c5           ; Contador de movimiento del espacio
bala_der        = $c6           ; Indica si bala enemigo va a la derecha

        ; Siguientes 12 accedidos en indice
ap_digito       = $c7           ; Seis digitos de puntuación/vidas (12 bytes)

        if      COLOR_NTSC=1
COLOR_BALA          = $0e
COLOR_FORTALEZA     = $92
COLOR_FORTALEZA2    = $42
COLOR_3D            = $90
COLOR_ESPACIO       = $00
COLOR_GASOLINA      = $36
COLOR_PUNTOS        = $BA
COLOR_TITULO        = $20
        else
COLOR_BALA          = $0e
COLOR_FORTALEZA     = $B2
COLOR_FORTALEZA2    = $62
COLOR_3D            = $B0
COLOR_ESPACIO       = $00
COLOR_GASOLINA      = $46
COLOR_PUNTOS        = $7A
COLOR_TITULO        = $20
        endif

        ;
        ; La RAM se halla entre $0080 y $00FF.
        ;

        org     $f000           ; Locación de inicio del ROM (4K)

        ; >>> EL NUCLEO DEBE CABER EN UNA PÁGINA DE 256 BYTES <<<
        ; >>> COMPROBAR CHECANDO EL ARCHIVO LST GENERADO POR DASM <<<
        ;
        ; 6 ciclos previos (entrada)
        ; 10 ciclos previos (pan6)
        ; 16 ciclos previos (pex2)
        ;
        ; Dado el caso se puede usar el registro S para ahorrar tiempo,
        ; pero no es necesario
pan0
        ; ¿Llega a sprite de jugador?
        cpy     yj3d            ; 3
        beq     pan8            ; 5	6
        ; ¿Llega a sombra de jugador?
        cpy     yj3d2           ; 8
        beq     pan14           ; 10	     11
        ldx     linea_jugador   ; 13
        txa                     ; 15
        and     #$07            ; 17
        beq     pan5            ; 19
        dex                     ; 21
        bpl     pan1            ; 24

pan14   ldx     offset9s        ;	     14
        .byte   $ad             ;	     17
pan8    ldx     offset9         ;	9
pan1    stx     linea_jugador   ; 27	12   20
        lda     colores,x       ; 31	16   24
        sta     COLUP0          ; 34	19   27
        lda     sprites,x       ; 38	23   31

pan5    sta     GRP0            ; 3	3 Pone bitmap Player 0 (note que llega con A=0)
        sta     HMCLR           ; 3	6
        ; ¿Llega a sprite de enemigo?
        ldx     sprite          ; 3	9 sprite actual
        tya                     ; 2   11
        cmp     ye3d0,x         ; 4   15
        bne     pan4            ; 2/3 17
        ; >>> Como cmp resultó en Z=1, entonces C=1 <<< no hace falta SEC
        lda     xe3d0,x         ; 3   21
        sta     WSYNC           ; 76  24 - ciclos maximo :) - Inicia sincronía de línea
        sta     HMOVE           ; 3
pex2    sbc     #15             ; 7- Gasta el tiempo necesario dividiendo X por 15
        bcs     pex2            ; 9/10 - 14/19/24/29/34/39/44/49/54/59/64/69
        tax                     ; 11
        lda     tabla_ajuste_fino-$f1,x; 15 - Consume 5 ciclos cruzando página
        tsx                     ; ldx #$40
        sta     HMP1            ; 18
        sta     RESP1           ; 21/26/31/36/41/46/51/56/61/66/71 - Pos. "grande"
        stx     HMBL
        sta     WSYNC
        sta     HMOVE           ; 3
        lda     largo_sprite    ; 6
        sta     linea_doble     ; 9
        dey                     ; 11
        bne     pan0            ; 13/14
        jmp     pan10           ; 16

        ; Reg. X contiene 'sprite'
pan4
        sta     WSYNC           ; 73 ciclos máximo hasta aquí
        sta     HMOVE           ; 3	 3
        ;
        ; ¿Visualizar la bala?
        ;
        if      0               ; Ahorra cinco ciclos, hay que ver si puedo usarlos
            ldx     #ENAM1      ; 2
            txs                 ; 4
            cpy     y_bala2     ; 7
            php                 ; 10	 Z cae perfecto en bit 1
            cpy     y_bala      ; 13
            php                 ; 16
            ldx     sprite      ; 19
            ldx     sprite      ; 22
            nop                 ; 24
        else
            lda     #0          ; 2	 2
            cpy     y_bala      ; 3	 5
            bne     pan3        ; 2/3	 8
            lda     #2          ; 2	      9
pan3        sta     ENAM0       ; 3	11   12
        ; ¿Visualizar la bala del enemigo?
            lda     #0          ; 2	 2
            cpy     y_bala2     ; 3	 5
            bne     pan7        ; 2/3	 8
            lda     #2          ; 2	      9
pan7        sta     ENAM1       ;	11   12
        endif
        lda     #0              ; 5
        dec     linea_doble     ; 10
        bmi     pan6            ; 12/13
        lda     linea_doble     ; 15
        bne     pan9            ; 17/18
        inc     sprite          ; 22
pan9    ora     offset0,x       ; 26
        tax                     ; 28
        lda     colores,x       ; 32
        sta     COLUP1          ; 35
        lda     sprites,x       ; 39
pan6    sta     GRP1            ; 42 (notese que se llega aquí con A=0)
        tsx                     ; ldx #$40	   ; 68
        stx     HMBL            ; 71
        sta     WSYNC           ; 74 ciclos hasta aquí
        sta     HMOVE           ; 3
        dey                     ; 5
        beq     pan10           ; 7/8
        jmp     pan0            ; 10

        ; Llega aquí con 13 ó 8 ciclos
pan10
        ldx     #$ff            ; 15
        txs                     ; 17
        jsr     muestra_puntos  ; 23
        jmp     pan12

        ; Detecta código dividido entre dos páginas (usa un ciclo más)
        if      (pan0&$ff00)!=(pan10&$ff00)
            lda     megabug1    ; :P
        endif

        ; Posiciona un sprite en X
        ; A = Posición X (¿rango?)
        ; X = Objeto por posicionar (0=P0, 1=P1, 2=M0, 3=M1, 4=BALL)
        ;
        ; >>> EL NUCLEO DEBE CABER EN UNA PÁGINA DE 256 BYTES <<<
        ; >>> COMPROBAR CHECANDO EL ARCHIVO LST GENERADO POR DASM <<<
        ;
posiciona_en_x
        sec
        sta     WSYNC           ; 0- Inicia sincronía de línea
        ldy     offset9         ; Necesita desperdiciar tres ciclos
pex1    sbc     #15             ; 4- Gasta el tiempo necesario dividiendo X por 15
        bcs     pex1            ; 6/7 - 11/16/21/26/31/36/41/46/51/56/61/66
pex3    tay                     ; 8
        lda     tabla_ajuste_fino-$f1,y; 13 - Consume 5 ciclos cruzando página
        sta     HMP0,x
        sta     RESP0,x         ; 21/26/31/36/41/46/51/56/61/66/71 - Pos. "grande"
        rts

        ; Detecta código dividido entre dos páginas (usa un ciclo más)
        if      (pex1&$ff00)!=(pex3&$ff00)
            lda     megabug2    ; :P
        endif

        ;
        ; Inicia explosión
        ;
inicia_explosion_sprite
        jsr     gana_puntos
inicia_explosion
        ldx     #3
ie1     lda     x_jugador
        sta     xe3d0,x
        lda     #$48
        sta     offset0,x
        dex
        bne     ie1
        sta     offset9
        stx     AUDV0           ; Quita sonido de motor
        stx     x_bala
        stx     y_bala
        stx     x_bala2
        stx     y_bala2
        stx     yj3d2           ; Quita sombra
        stx     ye3d0           ; Quita adorno
        lda     yj3d
        sta     ye3d2
        clc
        adc     #8
        sta     ye3d1
        sbc     #15
        sta     ye3d3
        lda     #60             ; Duración de la explosión en cuadros
        sta     explosion
        lda     #8
        sta     largo_sprite
        dec     vidas
        lda     #sonido_3-base_sonido
        jmp     efecto_sonido_prioridad

        .byte   "OTG:)Oct19/13"

        org     $f0f1           ; Locación de inicio del ROM
tabla_ajuste_fino
        .byte   $70             ; 7 a la izq.
        .byte   $60             ; 6 a la izq.
        .byte   $50             ; 5 a la izq.
        .byte   $40             ; 4 a la izq.
        .byte   $30             ; 3 a la izq.
        .byte   $20             ; 2 a la izq.
        .byte   $10             ; 1 a la izq.
        .byte   $00             ; Sin cambio
        .byte   $f0             ; 1 a la der.
        .byte   $e0             ; 2 a la der.
        .byte   $d0             ; 3 a la der.
        .byte   $c0             ; 4 a la der.
        .byte   $b0             ; 5 a la der.
        .byte   $a0             ; 6 a la der.
        .byte   $90             ; 7 a la der.

        ;
        ; Visualiza puntuación, vidas y gasolina (sub-kernel)
        ; >>> EL NUCLEO DEBE CABER EN UNA PÁGINA DE 256 BYTES <<<
        ; >>> COMPROBAR CHECANDO EL ARCHIVO LST GENERADO POR DASM <<<
        ;
muestra_puntos
        lda     #1              ; 25
        sta     CTRLPF          ; 28
        ldx     #0              ; 30
        stx     ENABL           ; 33
        stx     GRP0            ; 36
        stx     GRP1            ; 39
        stx     ENAM0           ; 42
        stx     ENAM1           ; 45
        lda     #COLOR_GASOLINA ; 47
        sta     COLUPF          ; 50
        lda     gasolina        ; 53
        clc                     ; 55
        adc     #7              ; 57
        lsr                     ; 59
        lsr                     ; 61
        sta     WSYNC           ; 66
        sta     HMOVE           ; 3
        stx     COLUBK          ; 6
        lsr                     ; 8
        tax                     ; 10
        lda     gas1,x          ; 14
        sta     PF0             ; 17
        lda     gas2,x          ; 21
        sta     PF1             ; 24
        lda     #COLOR_PUNTOS   ; 26
        sta     COLUP0          ; 29
        sta     COLUP1          ; 32
        lda     #$03            ; 34	 3 copias juntas
        ldx     #$f0            ; 36
        ;	 El código anterior reemplazó este código
        ;	  ldx #6		     ; 2
        ;	  sta WSYNC
        ;mp2:	  dex
        ;	  bpl mp2
        ;	  nop
        stx     RESP0           ; 39
        stx     RESP1           ; 42
        stx     HMP0            ; 45
        sta     NUSIZ0          ; 48
        sta     NUSIZ1          ; 51
        lsr                     ; 53
        sta     VDELP0          ; 56
        sta     VDELP1          ; 59
        sta     WSYNC           ; 62
        sta     HMOVE           ; 3
        lda     #6
        sta     linea_doble
mp1     ldy     linea_doble     ; 2
        lda     (ap_digito),y   ; 7
        sta     GRP0            ; 10
        sta     WSYNC           ; 13 + 61 = 76
        lda     (ap_digito+2),y ; 5
        sta     GRP1            ; 8
        lda     (ap_digito+4),y ; 13
        sta     GRP0            ; 16
        lda     (ap_digito+6),y ; 21
        sta     linea_jugador   ; 24
        lda     (ap_digito+8),y ; 29
        tax                     ; 31
        lda     (ap_digito+10),y; 36
        tay                     ; 38
        lda     linea_jugador   ; 41
        sta     GRP1            ; 44
        stx     GRP0            ; 47
        sty     GRP1            ; 50
        sta     GRP0            ; 53
        dec     linea_doble     ; 58
        bpl     mp1             ; 60/61
mp3
        ; Detecta código dividido entre dos páginas (usa un ciclo más)
        if      (mp1&$ff00)!=(mp3&$ff00)
            lda     megabug3    ; :P
        endif

        ldy     #0              ; 63
        sty     VDELP0          ; 66
        sty     VDELP1          ; 69
        if      NTSC=1
            ldx     #(21*76-14)/64
        else
            ldx     #(46*76-14)/64
        endif
        lda     #2
        sta     WSYNC
        sta     VBLANK          ; Comienza VBLANK
        stx     TIM64T
        lda     #$25
        sta     NUSIZ0          ; Tamaño de Player/Missile 0
        lda     nucita
        sta     NUSIZ1          ; Tamaño de Player/Missile 1
        inc     cuadro
        ;
        ; Generador de números bien aleatorios :P
        ;
        lda     rand
        sec
        ror
        eor     cuadro
        ror
        eor     rand
        ror
        eor     #9
        sta     rand
        sty     PF1
        sty     PF0
        sty     GRP1
        sty     GRP0
        rts

        ;
        ; Inicio del programa
        ;
inicio  sei                     ; Desactiva interrupciones
        cld                     ; Desactiva modo decimal
        ldx     #$ff            ; Carga X con FF...
        txs                     ; ...copia a registro de pila.
        lda     #0              ; Carga cero en A
limpia_mem
        sta     0,X             ; Guarda en posición 0 más X
        dex                     ; Decrementa X
        bne     limpia_mem      ; Continua hasta que X es cero.
        sta     SWACNT          ; Permite leer palancas
        sta     SWBCNT          ; Permite leer botones
        sty     rand
        tsx                     ; lda #$ff
        stx     antirebote

        ;
        ; Aquí reinicia el juego después de Game Over
        ;
reinicio
        ;
        ; Arma cadena de caracteres que forman mi logo
        ;
        lda     #(128+letras)&$ff
        ldx     #11
lm1     pha
        lda     #(letras+80)>>8
        sta     ap_digito,x
        pla
        dex
        sta     ap_digito,x
        sec
        sbc     #8
        dex
        bpl     lm1
        ;
        ; Pantalla de título
        ;
        lda     #mensaje_titulo&$ff
        jsr     mensaje
        ;
        ; Tacha un caracter para separar puntos y vidas
        ;
        lda     #(80+letras)&$ff
        sta     ap_digito+8

        ;
        ; Selecciona la dificultad
        ;
        lda     SWCHB
        and     #$40
        ora     #$0f
        sta     dificultad
        lda     #15             ; Coordenada X mínima (15), X máxima (55)
        sta     x_jugador
        lda     #0              ; Cero puntos
        sta     puntos
        sta     puntos+1
        lda     #0              ; Nivel inicial
        sta     nivel
        lda     #4              ; 5 vidas (la actual y cuatro extras)
        sta     vidas
        jsr     sel_nivel2      ; Carga el nivel

        ;
        ; Bucle principal del juego
        ;
bucle
        ; VERTICAL_SYNC
        lda     #2
        sta     VSYNC           ; Inicia sincronía vertical
        sta     WSYNC           ; 3 líneas de espera
        ldy     sonido_fondo    ; 3
        beq     s02d            ; 5
        dec     sonido_d2       ; 10
        bpl     s02c            ; 12
        ldx     sonido_ap2      ; 15
        lda     base_sonido,x   ; 19
        bne     s02a            ; 21
        ldx     sonido_fondo    ; 24
        inx                     ; 26
        lda     base_sonido,x   ; 30
s02a    sta     sonido_d2       ; 33
        inx                     ; 35
        lda     base_sonido,x   ; 39
        sta     sonido_f2       ; 42
        inx                     ; 44
        stx     sonido_ap2      ; 47
s02c    lda     base_sonido,y   ; 51
        sta     sonido_control  ; 54
        ldy     sonido_f2       ; 57
s02d    sty     sonido_frec     ; 60

s03     sta     WSYNC

        ldy     sonido_efecto   ; 3
        beq     s01             ; 5
        dec     sonido_d1       ; 10
        bpl     s01b            ; 12
        ldx     sonido_ap1      ; 15
        lda     base_sonido,x   ; 19
        bne     s01a            ; 22
        sta     sonido_efecto
        beq     s01

s01a    sta     sonido_d1       ; 25
        inx                     ; 27
        lda     base_sonido,x   ; 31
        sta     sonido_f1       ; 34
        inx                     ; 36
        stx     sonido_ap1      ; 39
s01b    lda     base_sonido,y   ; 43
        sta     sonido_control  ; 46
        lda     sonido_f1       ; 49
        sta     sonido_frec     ; 52
s01
        lda     sonido_control  ; 55
        sta     AUDC1           ; 58
        lda     sonido_frec     ; 61
        and     #$1f            ; 63
        sta     AUDF1           ; 66
        if      NTSC=1
            ldx     #(37*76-14)/64
        else
            ldx     #(62*76-14)/64
        endif
        sta     WSYNC
        ;
        stx     TIM64T
        lda     #0
        sta     VSYNC           ; Detiene sincronía vertical
        sta     linea_jugador
        sta     linea_doble
        lda     fondo
        sta     COLUBK
        lda     sonido_frec
        beq     s01d
        rol
        rol
        rol
        ora     #$08            ; Suma 8 al volumen
s01d    sta     AUDV1
        lda     #$ff
        sta     mira
        lda     explosion       ; ¿Jugador explotando?
        beq     b23a            ; No, salta.
        inc     xe3d1
        inc     xe3d3
        ldx     ye3d1
        beq     mex1
        inx
        cpx     #96
        bne     mex0
        ldx     #0
mex0    stx     ye3d1
mex1    lda     ye3d3
        beq     mex2
        dec     ye3d3
mex2    lda     ye3d2
        beq     mex3
        inc     xe3d2
        inc     xe3d2
        lda     xe3d2
        cmp     #120
        bcc     mex3
        lda     #0
        sta     ye3d2
mex3    dec     explosion       ; ¿Finalizó explosión?
        bne     b23b            ; No, salta.
        lda     vidas           ; ¿Aún tiene vidas?
        bpl     b23c            ; Sí, salta.
        lda     #mensaje_final&$ff
        jsr     mensaje         ; GAME OVER
        jmp     reinicio

b23c    jsr     sel_nivel2      ; Reinicia el nivel
b23b    jmp     b11

        ; Agrega elementos según el nivel
b23a    lda     nivel
        lsr
        bcs     b23
        jmp     b10

        ;
        ; Fortaleza: enemigos fijos
        ;
b23     lda     tiempo
        cmp     #25             ; ¿Agrega un adorno?
        bne     b23d            ; No, salta.
        lda     offset1
        cmp     #$60
        beq     b23d
        cmp     #$88            ; $88,$98,$a0 o $b8
        bcs     b23d
        lda     ye3d0
        bne     b23d
b23e    lda     #150
        sta     xe3d0
        lda     #96
        sta     ye3d0
        lda     #$e8            ; Adorno 1
        ldx     rand
        bpl     b23f
        lda     #$b0            ; Adorno 2
b23f    sta     offset0
b23d    dec     tiempo          ; ¿Tiempo de poner otro enemigo?
        beq     b61             ; Sí, salta.
        jmp     b12             ; No, desplaza los actuales

b61     ldy     #0
        lda     (lector),y
        beq     b28             ; Salta si es el final del nivel
        and     #$f8
        cmp     #$e0            ; ¿Adorno de nivel?
        beq     b60
        cmp     #$90            ; ¿Alienígena, misil, robotote $a0 o electricidad $b8?
        bcc     b60             ; No, salta.
b28     lda     ye3d1
        ora     ye3d2
        ora     ye3d3           ; ¿Ya desapareció todo?
        beq     b28c            ; No, espera un poco más
        jmp     b27

b28c    ldx     #8
        lda     (lector),y
        bne     b61a            ; Salta si no es el final del nivel
        jsr     adelanta_nivel
        jmp     b25

b61a    and     #$f8
        cmp     #$b8            ; ¿Electricidad?
        beq     b28b
        cmp     #$a0            ; ¿Robotote?
        bne     b28a
        lda     #$27            ; Usa un sprite más gordo
        sta     NUSIZ1          ; Tamaño de Player/Missile 1
        sta     nucita
        ldx     #16
        .byte   $ad             ; LDA para brincar siguientes dos bytes
b28b    ldx     #24             ; Largo del sprite (triple)
b28a    stx     largo_sprite
        jmp     b26

b60     lda     ye3d1
        beq     b26c
        lda     offset1
        cmp     #$88            ; ¿Hay un misil vertical activo?
        beq     b27             ; Sí, espera que termine antes de poner otra cosa
        cmp     #$60            ; ¿Hay un agujero de misil?
        bne     b26a            ; No, salta.
        lda     electrico       ; ¿Ya disparó?
        bne     b26
        ;
        ; Para reducir vacíos del área de juego en ciertas ocasiones
        ; dispara al llegar al centro.
        ;
        lda     rand
        asl
        asl
        lda     #80             ; Centro de la pantalla
        bcs     b26d
        ;
        ; Pequeña ecuación para atinarle al jugador si pasa por encima :>
        ;
        lda     yj3d
        sec
        sbc     ye3d1
        bcs     b26b
        lda     #0
b26b    asl
        clc
        adc     x_jugador
b26d    cmp     xe3d1
        bcc     b27
        jsr     insercion
        adc     #8              ; carry es 1, 9 pixeles mínimo entre sprites
        sta     ye3d1
        lda     #sonido_4-base_sonido
        jsr     efecto_sonido_prioridad
        lda     #$88            ; Misil vertical
        sta     offset1
        lda     #$80            ; Agujero disparando
        sta     offset2
        bne     b27

b26a    cmp     #$e0            ; ¿Adorno de piso?
        beq     b26c
        cmp     #$98            ; ¿Hay misil teledirigido, robotote $a0 o campo $b8?
        bcs     b27             ; Sí, salta a esperar
b26c    ldx     #8
        stx     largo_sprite
b26     lda     (lector),y
        and     #$07
        tax
        lda     offset_y,x
        sec
        sbc     #10             ; Tolerancia
        cmp     ye3d1           ; Se asegura de que la coordenada Y es aceptable
        bcs     b20
b27     inc     tiempo          ; Espera un poco más
b22     jmp     b12

b20     jsr     insercion
        ldy     #0
        sty     electrico
        lda     (lector),y
        and     #$f8
        sta     offset1
        ldx     #150
        cmp     #$a0            ; ¿Robotote?
        bne     b20a
        ldx     #140
b20a    stx     xe3d1
        ldx     #5
        cmp     #$e0            ; ¿Adorno de piso?
        beq     b20b
        lda     rand
        and     #4
        adc     #40
        tax
b20b    stx     tiempo
        lda     (lector),y
        and     #$07
        tax
        lda     offset_y,x
        sta     ola             ; Para referencia campo eléctrico
        sta     ye3d1
        jsr     adelanta_lector
        ;
        ; Desplaza los elementos de la fortaleza para efecto de scrolling
        ;
b12     ldx     #0
        stx     xj3d
        ldx     #$fc            ; Ajuste Y de bala para alienígena
        ldy     #32             ; Nivel con respecto al piso para posible bala
        lda     offset1
        cmp     #$90            ; ¿Alienígena?
        beq     b12g            ; Sí, salta.
        inc     xj3d            ; Ajuste Y del misil teledirigido
        inc     xj3d            ; Ajuste Y del misil teledirigido
        cmp     #$98            ; ¿Misil teledirigido?
        beq     b12b            ; Sí, salta
        ldx     #$f3            ; Ajuste Y de bala para robotote
        ldy     y_jugador       ; Nivel idéntico al del jugador para posible bala
        cmp     #$a0            ; ¿Robotote?
        bne     b12a            ; No, salta
b12g    lda     xe3d1
        cmp     #140            ; ¿Recién salido?
        bcs     b12d            ; Sí, salta, debe centrarlo
        lda     x_bala2         ; ¿Bala activa?
        bne     b12d            ; Sí, salta
        sta     bala_der
        lda     rand
        cmp     dificultad      ; ¿Tiempo de disparar?
        bcs     b12d            ; No, salta.
        txa
        adc     ye3d1
        sta     y_bala2
        lda     xe3d1
        jsr     efecto_disparo
b12d    lda     offset1
        cmp     #$90
        beq     b12b
        lda     cuadro
        lsr                     ; El robotote sólo se mueve cada dos cuadros
        bcc     b12c
        ldx     #8
        stx     xj3d
        ;
        ; Robotote y misil teledirigido siguen al jugador
        ;
b12b    lda     xe3d1
        cmp     #16             ; No desaparece porque el choque es inevitable
        bne     b14a
        lda     #0
        sta     ye3d1
        jmp     b25

b14a    dec     xe3d1
        sbc     x_jugador
        bpl     b14b
        lda     #0
b14b    lsr
        lsr
        clc
        adc     yj3d
        adc     xj3d            ; Corrección robotote
        tax
        lda     offset1
        cmp     #$90            ; ¿Alienígena?
        bne     b12f
        lda     #32             ; Sí, lleva al piso
        sbc     y_jugador
        sta     xj3d
        txa
        clc
        adc     xj3d
        tax
b12f    txa
        cmp     #96             ; Limita a la pantalla visible
        bcc     b12e
        lda     #96
b12e    sta     ye3d1
b12c    jmp     b25

        ;
        ; Desplaza los elementos fijos por el piso
        ;
b12a    ldx     #0
b15     lda     ye3d0,x         ; ¿Elemento activo?
        beq     b24             ; No, salta.
        dec     xe3d0,x
        lda     xe3d0,x
        cmp     #16
        bcs     b14
        lda     #16
        sta     xe3d0,x
        lda     #0
        sta     ye3d0,x
b14     and     #3
        cmp     #3
        bne     b17
        dec     ye3d0,x
b17     lda     x_bala2         ; ¿Bala activa?
        bne     b24             ; Sí, salta
        sta     bala_der
        lda     rand
        cmp     dificultad      ; ¿Tiempo de disparar?
        bcs     b24             ; No, salta.
        lda     offset0,x
        cmp     #$40            ; ¿Avión chico?
        beq     b17a
        cmp     #$68            ; ¿Cañón?
        beq     b17a
        cmp     #$50            ; ¿Cañón?
        bne     b24             ; No, salta.
        lda     rand
        lsr
        bcs     b17b
        lda     #1
        sta     bala_der
        bne     b17a

b17b    lda     #$68            ; Gira cañón
        sta     offset0,x
b17a    lda     ye3d0,x
        sec
        sbc     #7
        sta     y_bala2
        lda     offset0,x
        sec
        sbc     #$50
        beq     b17c
        lda     #$f8
b17c    clc
        adc     xe3d0,x
        adc     #8
        ldy     #32
        jsr     efecto_disparo
b24
        inx
        cpx     #4
        bne     b15

        lda     offset1
        cmp     #$88            ; ¿Misil vertical?
        bne     b24a
        lda     cuadro
        lsr                     ; Se alza un pixel cada dos cuadros
        bcs     b24a
        lda     ye3d1
        beq     b24c            ; ¿Salió de la pantalla?
        inc     ye3d1
        sec
        sbc     ye3d2
        cmp     #24
        bcc     b24d
        lda     #$60            ; Fin de fuego en agujero de misil
        sta     offset2
b24d    lda     ye3d1
        cmp     #97
        bne     b24a
b24c    lda     #1
        sta     electrico       ; Ya disparó
        ldx     #0
b24b    lda     ye3d2,x
        sta     ye3d1,x
        lda     xe3d2,x
        sta     xe3d1,x
        lda     offset2,x
        sta     offset1,x
        inx
        cpx     #2
        bne     b24b
b24a    jmp     b25

        ; Espacio exterior
b10
        dec     tiempo
        bne     b37a
        lda     y_enemigo1
        ora     y_enemigo2
        ora     y_enemigo3      ; ¿Aún hay enemigos activos?
        bne     b37
        tay                     ; ldy #0
        lda     (lector),y
        bne     b31             ; Salta si no es el final del nivel
        jsr     adelanta_nivel
        jmp     b25

b37     inc     tiempo
b37a    jmp     b38

b31     sta     ola
        jsr     adelanta_lector
        ldx     #0
        stx     secuencia
        stx     proximo
        ldx     #8
        stx     largo_sprite
        cmp     #$e0            ; Planetoide
        bcs     b36a
        cmp     #$c0            ; ¿Satélite?
        beq     b36
        ldx     #35
        cmp     #$3a
        bcc     b32
        beq     b34
        cmp     #$3c
        beq     b34
        ldx     #15
        cmp     #$3d
        bne     b34
        ldx     #55
b34     stx     x_enemigo1
        lda     (lector),y
        jsr     adelanta_lector
        tay
        ldx     #$40
        lda     #96
        bne     b35

b36a    ldx     #15
        stx     x_enemigo1
        ldx     #35
        stx     x_enemigo2
        lsr
        ldy     #50
        ldx     #12
        bcs     b36b
        ldy     #72
        ldx     #32
b36b    stx     y_enemigo2
        lda     #96
        ldx     #$f8
        stx     offset2
        ldx     #$f0
        bne     b35a

b36     tax                     ; Satélite
        lda     #105
        sta     x_enemigo1
        ldy     #72
        lda     #16
        sta     largo_sprite
        lda     #48
        bne     b35

b32     lda     #15
        sta     x_enemigo1
        stx     x_enemigo2
        lda     #55
        sta     x_enemigo3
        ldy     #72
        lda     ola
        cmp     #$38
        beq     b33
        ldy     #32
b33     sty     y_enemigo2
        sty     y_enemigo3
        ldx     #$40
        lda     #125
b35     stx     offset2
b35a    stx     offset1
        stx     offset3
        sty     y_enemigo1
        sta     avance
        lda     #50
        sta     tiempo

b38
        ;
        ; Posiciona los enemigos
        ;
        ldx     #0
        ldy     #0
        lda     avance
        pha                     ; Corrimiento a la derecha con signo (2 veces)
        rol
        pla
        ror
        pha
        rol
        pla
        ror
        sta     xj3d
b6      lda     x_enemigo1,y
        lsr
        sta     xe3d1,x
        lda     y_enemigo1,y
        beq     b6c
        clc
        adc     #7              ; Sólo suma 7 para evitar tener que usar sec
        sbc     xe3d1,x
        sec
        adc     xj3d
        sta     ye3d1,x
        beq     b6c
        cmp     #97             ; ¿Invisible?
        bcs     b6c
        lda     x_enemigo1,y
        ;	 clc		 ; La condición lo permite
        adc     avance
        sta     xe3d1,x
        cmp     #151            ; ¿Invisible?
        bcc     b6d
b6c     jmp     b5
b6d
        ;
        ; Verifica si pone "mira"
        ;
        lda     offset1,x
        cmp     #$c0
        beq     mr4
        cmp     #$48
        bcs     mr1
        lda     avance
        cmp     #160
        bcs     mr0
        cmp     #50
        bcc     mr0
mr4     lda     cuadro
        lsr
        bcs     mr0             ; Debe ser bcs o va a tratar de disparar siendo mira
        lda     dificultad
        rol                     ; ¿Máxima dificultad?
        bmi     mr0             ; Sí, salta.
        lda     y_enemigo1,y
        sec
        sbc     y_jugador
        clc
        adc     #2
        cmp     #5
        bcs     mr0
        lda     x_enemigo1,y
        sec
        sbc     x_jugador
        clc
        adc     #3
        cmp     #7
        bcs     mr0
        stx     mira            ; Depende de que no haya un avión detrás del otro
        lda     offset1,x
        sta     mira_off        ; Para restaurar
        cmp     #$c0            ; ¿Satélite?
        lda     #$d0
        bcs     mr3             ; Sí, salta (usa mirilla de 16 líneas)
        lda     #$d8            ; No, usa mirilla de 8 líneas
mr3     sta     offset1,x
        lda     xe3d1,x
        sta     mira_x
        lda     x_jugador
        clc
        adc     #32
        sta     xe3d1,x
        lda     ye3d1,x
        sta     mira_y
        lda     yj3d
        adc     #8
        sta     ye3d1,x
        lda     #1
        sta     AUDC1
        sta     AUDF1
        lda     #15
        sta     AUDV1
        bne     b8

mr0     lda     offset1,x
mr1     cmp     #$48
        bcs     b8
b7      lda     y_enemigo1,y
        cmp     #48
        lda     #$40
        bcc     b4
        lda     y_enemigo1,y
        cmp     #64
        lda     #$38
        bcc     b4
        lda     #$30
b4      sta     offset1,x
        lda     x_bala2         ; ¿Bala activa?
        bne     b8
        sta     bala_der
        lda     rand
        cmp     dificultad      ; ¿Tiempo de disparar?
        bcs     b8
        cpy     proximo         ; ¿Es el avión que debe disparar?
        bne     b8
        lda     ye3d1,x
        sec
        sbc     #7
        sta     y_bala2
        lda     y_enemigo1
        sta     nivel_bala2
        lda     xe3d1,x
        jsr     efecto_disparo2
        lda     ola
        cmp     #$3b            ; ¿Aviones después de bajar/subir?
        beq     b8a
        cmp     #$3a            ; ¿Ola de avión simple?
        bcs     b8              ; Sí, salta.
b8a     inc     proximo
        lda     proximo
        cmp     #3
        bne     b8
        lda     #0
        sta     proximo
b8      inx
b5      iny
        cpy     #3
        beq     b3
        jmp     b6

b3      lda     #0
b3b     sta     ye3d1,x
        inx
        cpx     #4
        bne     b3b

        ; Efecto de sonido según altitud de la nave
b25     lda     #72
        sec
        sbc     y_jugador
        lsr
        lsr
        adc     #7
        sta     AUDF0
        lda     #8
        sta     AUDC0
        lda     #5
        sta     AUDV0
        ; Cambio de tamaño de la nave del jugador
        ldx     #16
        lda     y_jugador
        cmp     #48
        bcc     b1
        ldx     #8
        cmp     #64
        bcc     b1
        ldx     #0
b1      stx     offset9
        ; Posicionamiento player 0 (nave)
        lda     x_jugador
        lsr
        sta     xj3d
        lda     y_jugador
        clc
        adc     #7              ; Sólo suma 7 para evitar tener que usar sec
        sbc     xj3d
        sta     yj3d
        lda     nivel
        lsr                     ; ¿Nivel en el espacio?
        bcc     b01             ; Salta, nunca pone sombra
        lda     #31
        ldx     offset9
        cpx     #16+7
        bne     b00
        lda     #30
b00     clc
        adc     #7              ; Sólo suma 7 para evitar tener que usar sec
        sbc     xj3d
        sta     yj3d2           ; Coordenada Y de la sombra
        sbc     yj3d
        cmp     #$fa            ; ¿Se sobrepone con nave?
        bcc     b001
b01     lda     #0
b0      sta     yj3d2
b001
b11

        ;
        ; Posiciona horizontalmente la nave del jugador
        ;
        lda     x_jugador
        ldx     #0              ; Player 0
        jsr     posiciona_en_x
        ;
        ; Posiciona horizontalmente la bala del jugador
        ;
        lda     x_bala
        ldx     #2              ; Missile 0
        jsr     posiciona_en_x
        ;
        ; Posiciona la bala del enemigo
        ;
        lda     x_bala2
        inx                     ; Missile 1
        jsr     posiciona_en_x
        ;
        ; Posiciona la raya "3D"
        ;
        lda     nivel
        lsr
        bcc     b44b
        lda     offset1
        cmp     #$98            ; ¿Misil teledirigido?
        beq     b44c            ; Sí, salta y congela la raya.
        lda     cuadro
b44c    eor     #3
        and     #3
        bpl     b44

b44b    ldy     espacio
        dey
        cpy     #14
        bcc     b29
        ldy     #13
b29     sty     espacio
        tya
        lsr                     ; Movimiento lento en espacio
        bcc     b44
        sbc     #$4b            ; Genera línea duplicada en espacio
b44     adc     #$78
        inx                     ; Ball
        jsr     posiciona_en_x
        lda     nivel
        lsr
        ldx     #$40
        bcs     b46
        ldx     #$70
b46     txs
        ; Parpadeo de explosiones
        lda     cuadro
        and     #3
        bne     b43
        ldx     #4
b40     lda     offset9,x
        cmp     #$48
        beq     b41
        cmp     #$58
        bne     b42
b41     eor     #$10
        sta     offset9,x
b42     dex
        bpl     b40
b43

        ;
        ; Un poco más de aritmética
        ;
        ldx     #1
        lda     ye3d0
        beq     b45
        sec
        sbc     #10
        cmp     ye3d1
        bcc     b45
        dex
b45     stx     sprite
        ;
        ; Inicio de gráficas
        ;
        sta     WSYNC
        sta     HMOVE           ; Ajuste fino de último posiciona_en_x
espera_vblank
        lda     INTIM
        bne     espera_vblank
        lda     #$02
        sta     ENABL
        lda     nivel
        lsr
        ldx     #$10
        lda     #COLOR_3D
        bcs     pan11
        ldx     #$00
        lda     cuadro
        lsr
        and     #$78
        ora     #$04
        bcc     pan11a
        eor     #$7a
pan11a  asl
pan11   stx     CTRLPF          ; Tamaño de la raya 3D (ball)
        sta     COLUPF          ; Color de la raya 3D (playfield no se usa)
        sta     HMCLR           ; Evita movimiento posterior
        lda     #COLOR_BALA     ; Para que la bala sea visible
        sta     COLUP0

        ldy     #96             ; 96 líneas
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
        lda     offset9
        ora     #7
        sta     offset9
        clc
        adc     #24
        sta     offset9s
        lda     #0
        sta     WSYNC
        sta     HMOVE
        sta     VBLANK          ; Sale de VBLANK
        jmp     pan0

        ;
        ; Fin de gráficas (200 líneas)
        ;
pan12   lda     offset9
        and     #$f8
        sta     offset9
        ldx     mira            ; Restaura mira si hubo
        bmi     mr2
        lda     mira_off
        sta     offset1,x
        lda     mira_x
        sta     xe3d1,x
        lda     mira_y
        sta     ye3d1,x
mr2
        ;
        ; Corriendo a 30 cuadros por segundo
        ;
        lda     cuadro
        lsr
        bcs     z1a
        jmp     z1

z1a
        jsr     generico
        lda     explosion
        beq     z2a
        jmp     b50
z2a
        ; Lee el joystick del jugador 0
        ldy     x_jugador
        lda     SWCHA
        bmi     z2              ; ¿Derecha?
        cpy     #55
        beq     z2
        inc     x_jugador

z2      rol                     ; ¿Izquierda?
        bmi     z3
        cpy     #15
        beq     z3
        dec     x_jugador

z3      ldy     y_jugador
        rol                     ; ¿Abajo?
        bmi     z4
        cpy     #72
        beq     z4
        inc     y_jugador

z4      rol                     ; ¿Arriba?
        bmi     z5
        cpy     #32             ; Nave va para abajo
        beq     z5
        dec     y_jugador

z5      jsr     boton_disparo   ; ¿Botón oprimido?
        bpl     z8
        lda     x_bala
        bne     z8
        lda     x_jugador
        clc
        adc     #12
        sta     x_bala
        ldx     #-2             ; Ajusta coordenada de la bala
        lda     offset9
        cmp     #8
        beq     z0
        ldx     #-3
        bcs     z0
        ldx     #-1
z0      txa
        clc
        adc     yj3d
        sta     y_bala
        lda     #sonido_1-base_sonido
        jsr     efecto_sonido

z8
        ;
        ; Mueve bala del enemigo
        ;
        lda     x_bala2         ; ¿Bala activa?
        beq     z10
        ldx     bala_der
        beq     z10a
        clc
        adc     #1
        sta     x_bala2
        lda     y_bala2
        sec
        sbc     #2
        sta     y_bala2
        beq     z11
        bcc     z11
        bcs     z11a

z10a    sec
        sbc     #4
        cmp     #15
        bcc     z11
        sta     x_bala2
        dec     y_bala2
z11a    lda     nivel_bala2
        sec
        sbc     y_jugador
        clc
        adc     #2
        cmp     #5
        bcs     z10
        lda     CXM1P           ; Colisión misil 1
        bpl     z10             ; ¿Chocó con player 0? no, salta
        jsr     inicia_explosion
z11     lda     #0
        sta     y_bala2
        sta     x_bala2
z10

        ;
        ; Corriendo a 60 cuadros por segundo
        ;
z1      ldy     #0              ; Sólo comprueba jugador
        lda     x_bala          ; ¿Bala activa?
        beq     z44

z40     inc     y_bala
        clc
        adc     #4
        cmp     #150
        bcc     z7
        lda     #0
        sta     y_bala
z7      sta     x_bala
        iny                     ; Comprueba bala y jugador

        ;
        ; Comprueba si el jugador (y=0) o la bala (y=1) chocan con
        ; algún elemento
        ;
z44     ldx     #2
z30     lda     nivel
        lsr
        bcc     z35
        ; Fortaleza
        lda     ye3d1,x
        bne     zz35
        jmp     z32

zz35    lda     offset1,x
        cmp     #$b8            ; ¿Electricidad?
        beq     z35b
        cmp     #$98            ; ¿Misil teledirigido o robotote $a0?
        bcs     z35c            ; Sí, salta, siempre al nivel
        cmp     #$88            ; ¿Misil vertical?
        bne     z35a
        lda     ye3d1,x         ; Saca nivel en referencia a su agujero
        ;	 sec		 ; Garantizado
        sbc     ye3d2,x
        clc
        adc     #32
        bne     z36

z35a    lda     #32             ; En el piso
        bne     z36

z35b    lda     ola
        cmp     #105
        lda     y_jugador
        bcc     z35e
        cmp     #48             ; Arriba de la zona: pasa a choque
        bcs     z35c
z35g    jmp     z32b

z35e    cmp     #56
        bcs     z35g

        ; Simplifica detección de impacto robotote
z35c    tya
        lsr
        lda     CXM0P           ; ¿Choque entre misil 0 y player 1?
        bcs     z35f
        lda     CXPPMM          ; ¿Choque entre player 0 y player 1?
z35f    bpl     z35d            ; No, salta.
        bmi     z34

        ; Espacio
z35     lda     y_enemigo1,x
        bne     z36
z35d    jmp     z32

z36     sec
        sbc     y_jugador
        clc
        adc     #2
        cmp     #5
        bcs     z35d
z31     lda     x_jugador,y
        sec
        sbc     xe3d1,x
        cpy     #0
        clc
        beq     z31a
        adc     #8
        cmp     #10
        jmp     z31b

z31a    adc     #4
        cmp     #13
z31b    bcs     z32
z33     lda     yj3d,y
        sec
        sbc     ye3d1,x
        cpy     #0
        clc
        beq     z33a
        adc     #7
        cmp     #8
        jmp     z33b

z33a    adc     #4
        cmp     #9
z33b    bcs     z32
z34     ; El jugador/bala tocó un enemigo
        lda     offset1,x
        cmp     #$e0            ; ¿Adorno o planetoides?
        bcs     z32             ; Sí, no afecta
        cmp     #$48            ; ¿Explosión 1?
        beq     z32             ; Sí, no afecta
        cmp     #$58            ; ¿Explosión 2?
        beq     z32             ; Sí, no afecta
        cmp     #$60            ; ¿Agujero de misil?
        beq     z32             ; Sí, no afecta
        cpy     #0
        bne     z34a
        jsr     inicia_explosion_sprite
        jmp     z32c

z34a    lda     offset1,x       ; Toma sprite
        cmp     #$80            ; ¿Agujero de misil disparando?
        beq     z37             ; Sí, detiene bala
        cmp     #$b8            ; ¿Electricidad?
        beq     z37             ; Sí, detiene bala
        cmp     #$70            ; ¿Gasolina?
        bne     z38             ; No, salta.
        lda     gasolina
        clc
        adc     #$0f            ; Más gasolina
        and     #$f8
        cmp     #$50            ; Limita a diez unidades
        bcc     z39
        lda     #$50
z39     sta     gasolina
z38     lda     offset1,x       ; Toma sprite
        cmp     #$98            ; ¿Misil teledirigido?
        bne     z38a
        inc     electrico
        ldy     electrico
        cpy     #5              ; ¿Cinco impactos?
        bne     z37             ; No, salta.
z38a    cmp     #$a0            ; ¿Robotote?
        bne     z38b
        inc     electrico
        ldy     electrico
        cpy     #10             ; ¿Diez impactos?
        bne     z37             ; No, salta.
z38b    jsr     gana_puntos
        lda     #$48            ; Convierte en explosión
        sta     offset1,x
        lda     #sonido_3-base_sonido
        jsr     efecto_sonido_prioridad
z37     lda     #0              ; Desaparece la bala
        sta     y_bala
        sta     x_bala
        ldy     #1
z32     dex
        bmi     z32b
        jmp     z30
z32b    dey
        bmi     z32c
        jmp     z44

z32c

z6
        ;
        ; Procesa ola de ataque
        ;
        inc     secuencia
        ldx     secuencia
        ldy     y_enemigo1
        lda     ola
        cmp     #$38
        bne     z14
        cpx     #32
        bcc     z17
        dey
        cpy     #32
z16     bne     z22
        lda     #$3b
        sta     ola
        bne     z22

z14     cmp     #$39
        bne     z15
        cpx     #32
        bcc     z17
        iny
        cpy     #72
        jmp     z16

z15     cmp     #$c0            ; Satélite
        bne     z20
        dec     x_enemigo1
        lda     x_enemigo1
        cmp     #10
        beq     z21
        bne     z9

z20     cmp     #$3a
        bne     z17
        lda     offset1
        cmp     #$48
        bcs     z17
        tya
        cmp     y_jugador
        beq     z23
        lda     #$fe
        bcs     z18
        lda     #$01
z18     adc     y_enemigo1
        sta     y_enemigo1
z23     lda     x_enemigo1
        cmp     x_jugador
        beq     z17
        lda     #$fe
        bcs     z19
        lda     #$01
z19     adc     x_enemigo1
        sta     x_enemigo1
z17     dec     avance
        lda     x_enemigo1
        clc
        adc     avance
        cmp     #15
        bne     z9
z21     ldy     #0
z22     sty     y_enemigo1
        sty     y_enemigo2
        sty     y_enemigo3
z9
        ;
        ; Mueve el campo eléctrico
        ;
        lda     ye3d1
        beq     z41
        lda     offset1
        cmp     #$b8            ; ¿Electricidad?
        bne     z41
        ldx     electrico
        cpx     #5              ; ¿Alcanzó el ancho horizontal?
        bne     z43             ; No, salta.
z42     lda     ye3d1
        clc
        adc     #4
        sta     ye3d1
        lda     xe3d1
        sbc     #8-1
        sta     xe3d1
        dex
        bne     z42
        beq     z43a

z43     inx
        lda     ye3d1
        sec
        sbc     #4
        sta     ye3d1
        lda     xe3d1
        clc
        adc     #8
        sta     xe3d1
        cmp     #160            ; ¿Se sale de la pantalla?
        bcs     z42
z43a    stx     electrico
z41
        ; Sonido de fondo
        ldx     offset1
        lda     #sonido_5-base_sonido
        cpx     #$c0            ; ¿Satèlite?
        beq     b11b
        lda     #sonido_6-base_sonido
        cpx     #$98            ; ¿Misil teledirigido?
        beq     b11b
        lda     #sonido_7-base_sonido
        cpx     #$b8            ; ¿Electricidad?
        beq     b11b
        lda     #sonido_8-base_sonido
        cpx     #$a0            ; ¿Robotote?
        beq     b11b
        lda     #0
b11b    cmp     sonido_fondo
        beq     b11c
        sta     sonido_fondo
        tax
        inx
        stx     sonido_ap2
        lda     #0
        sta     sonido_d2
b11c
        lda     cuadro
        ;and #$ff	 ; ¿256 cuadros? (4 segundos)
        bne     b50
        lda     nivel
        lsr                     ; ¿Espacio?
        bcc     b50             ; Sí, no gasta gasolina
        cmp     #6
        ldx     #-2
        bcc     b51
        dex                     ; -3
        cmp     #12
        bcc     b51
        dex                     ; -4
b51     txa
        clc
        adc     gasolina        ; Resta gasolina
        sta     gasolina
        beq     b50a            ; ¿Se acabó?
        bpl     b50
        lda     #0
        sta     gasolina
b50a    jsr     inicia_explosion
b50

        ;
        ; Actualiza el indicador de puntos, se hace hasta
        ; después de haber visualizado el indicador de puntos,
        ; así que puede haber un desfase de un cuadro
        ;
        ldx     #0
        ldy     #6
ap1     lda     puntos,x
        and     #$0f
        asl
        asl
        asl
        ;	 clc
        adc     #letras&$ff
        sta     ap_digito,y
        dey
        dey
        lda     puntos,x
        inx
        lsr
        and     #$78
        clc
        adc     #letras&$ff
        sta     ap_digito,y
        dey
        dey
        bpl     ap1
        ;
        ; Actualiza indicador de vidas
        ;
        lda     vidas
        bpl     av1
        lda     #0
av1     asl
        asl
        asl
        adc     #letras&$ff
        sta     ap_digito+10
overscan
        lda     INTIM
        bne     overscan
        sta     WSYNC
        sta     CXCLR           ; Limpia colisiones
        jmp     bucle

        ;
        ; Inserción de nuevo sprite
        ;
insercion
        ldx     #1
in0     lda     offset1,x
        sta     offset2,x
        lda     xe3d1,x
        sta     xe3d2,x
        lda     ye3d1,x
        sta     ye3d2,x
        dex
        bpl     in0
        rts

        ; Efecto de disparo enemigo
efecto_disparo
        sty     nivel_bala2
efecto_disparo2
        sta     x_bala2
        lda     #sonido_2-base_sonido
        ; Pone un efecto de sonido
efecto_sonido
        pha
        lda     sonido_efecto
        cmp     #sonido_3-base_sonido; ¿Hay explosión o lanzamiento?
        pla
        bcs     es1
efecto_sonido_prioridad
        sta     sonido_efecto
        sta     sonido_ap1
        inc     sonido_ap1
        lda     #0
        sta     sonido_d1
es1     rts

        ;
        ; Gana puntos por destruir un enemigo
        ;
gana_puntos
        lda     offset1,x       ; Este valor siempre es un múltiplo de 8
        sec
        sbc     #64
        bcs     gp2
        lda     #0
gp2     tay
        lda     letras+7,y      ; Indexa en puntuación
        sed
        clc
        adc     puntos
        sta     puntos
        lda     puntos+1
        adc     #0
        bcc     gp1
        lda     #$99
        sta     puntos
gp1     sta     puntos+1
        cld
        rts

        ;
        ;
        ; Selecciona el siguiente nivel e incrementa la dificultad
        ;
adelanta_nivel
        lda     dificultad
        clc
        adc     #4
        bpl     an1
        lda     #$7f
an1     sta     dificultad
        inc     nivel
        bcc     sel_nivel

sel_nivel2
        lda     #$50            ; Valor 5.3
        sta     gasolina
        lda     #72             ; El jugador empieza arriba
        sta     y_jugador       ; Coordenada Y mínima (72), Y máxima (32)
sel_nivel
        lda     nivel
        and     #3
        bne     sn1
        lda     #espacio_1&$ff
        ldx     #espacio_1>>8
        bne     sn4

sn1     cmp     #1
        bne     sn2
        lda     #fortaleza_1&$ff
        ldx     #fortaleza_1>>8
        bne     sn4

sn2     cmp     #2
        bne     sn3
        lda     #espacio_2&$ff
        ldx     #espacio_2>>8
        bne     sn4

sn3     lda     #fortaleza_2&$ff
        ldx     #fortaleza_2>>8
sn4     sta     lector
        stx     lector+1
        lda     #0
        ldx     #2
sn6     sta     ola,x
        ;sta secuencia
        ;sta explosion
        sta     ye3d1,x
        ;sta ye3d2
        ;sta ye3d3
        sta     y_enemigo1,x
        ;sta y_enemigo2
        ;sta y_enemigo3
        sta     sonido_efecto,x
        ;sta sonido_fondo
        ;sta sonido_ap1
        dex
        bpl     sn6
        sta     ye3d0
        sta     sonido_ap2
        lda     #10
        sta     tiempo
        ldx     #COLOR_ESPACIO  ; Espacio
        lda     nivel
        lsr
        bcc     sn5
        ldx     #COLOR_FORTALEZA; Fortaleza
        lsr
        lsr
        bcc     sn5
        ldx     #COLOR_FORTALEZA2; Fortaleza
sn5     stx     fondo           ; Color de fondo
        lda     #$25
        sta     NUSIZ0          ; Tamaño de Player/Missile 0
        sta     NUSIZ1          ; Tamaño de Player/Missile 1
        sta     nucita
        ldx     #8
        stx     largo_sprite
        rts

        ;
        ; Mensaje hasta botón oprimido
        ;
mensaje
        ldx     #mensaje_final>>8
        sta     lector
        stx     lector+1
        lda     #0
        sta     ola
        sta     AUDV0           ; Apaga el sonido
        sta     AUDV1
me0     ; VERTICAL_SYNC
        lda     #2
        sta     VSYNC           ; Inicia sincronía vertical
        sta     WSYNC           ; 3 líneas de espera
        sta     WSYNC
        if      NTSC=1
            ldx     #(37*76-14)/64
        else
            ldx     #(62*76-14)/64
        endif
        sta     WSYNC
        ;
        stx     TIM64T
        lda     #0
        sta     VSYNC           ; Detiene sincronía vertical
        ;
        ; Inicio de gráficas
        ;
        ; Asume inicialización previa (inicio del juego)
        ; o que se llamó muestra_puntos (deja vars. iniciadas)
        ;
        lda     cuadro
        lsr
        tax
        and     #$10
        bne     me3
        txa
        eor     #$0e
        tax
me3     txa
        and     #$0e
        ora     #COLOR_TITULO
        sta     COLUP0
        eor     #$0e
        sta     COLUP1
        lda     #$02
        sta     CTRLPF
me1
        lda     INTIM
        bne     me1
        tay
        sta     VBLANK
        ldx     #53
me4     sta     WSYNC
        dex
        bne     me4
        ;
        ; Visualiza mensaje
        ;
me2     sta     WSYNC
        lda     (lector),y
        sta     PF0
        iny
        lda     (lector),y
        sta     PF1
        iny
        lda     (lector),y
        sta     PF2
        iny
        ldx     #7
me6     sta     WSYNC
        dex
        bne     me6
        cpy     #33
        bne     me2
        lda     #0
        sta     PF0
        sta     PF1
        sta     PF2
        ldx     #53
me5     sta     WSYNC
        dex
        bne     me5
        ;
        ;
        ;
        jsr     muestra_puntos
        ;
        ; Fin de gráficas (200 líneas)
        ;
me7     lda     INTIM
        bne     me7
        sta     WSYNC
        lda     ola
        cmp     #32
        beq     me9
        inc     ola
me10    jmp     me0

me9     jsr     generico
        jsr     boton_disparo   ; ¿Botón oprimido?
        bpl     me10
        rts

        ;
        ; Formato de sonido:
        ; Primer byte - Instrumento (control TIA en realidad)
        ;
        ; Después:
        ; Primer byte - Frec. (bits 0-4) y vol (bits 5-7) (sumar 8)
        ; Segundo byte - Duración en cuadros
        ;
        ; Si el primer byte es 0xff termina el efecto
        ;
        ; Por su estructura se garantiza que termina alineado en 2 bytes
        ;

        org     $fc10

        ; Offset Y de elementos en fortaleza
offset_y
        .byte   35,45,55,65,81,105

        ; Espacio 1
espacio_1
        .byte   $f0             ; Planetoide
        .byte   $38             ; Tres aviones por arriba
        .byte   $39             ; Tres aviones por abajo
        .byte   $3a,52          ; Avión loquito
        .byte   $3b,72          ; Un avión a la vez
        .byte   $3c,52          ; Un avión a la vez
        .byte   $3d,32          ; Un avión a la vez
        .byte   $c0             ; Satélite
        .byte   $39             ; Tres aviones por abajo
        .byte   $3b,32          ; Un avión a la vez
        .byte   $3c,52          ; Un avión a la vez
        .byte   $3d,72          ; Un avión a la vez
        .byte   $38             ; Tres aviones por arriba
        .byte   $3a,52          ; Avión loquito
        .byte   $00             ; Fin de nivel

        ; Avión grande = $30	3
        ; Avión medio = $38	3
        ; Avión chico = $40	3
        ; Combustible = $70	2
        ; Antena = $78 	2
        ; Agujero = $60
        ; Cañón girado = $50	2
        ; Cañón = $68		2
        ; Alienígena = $90	3
        ; Misil = $98		5
        ; Satélite = $C0      10
        ; Robotote = $A0      25
        ; Electricidad = $B8
        ; Adorno de piso = $e0, sólo antes de $60

        ; Fortaleza 1
fortaleza_1
        .byte   $70
        .byte   $71
        .byte   $6b
        .byte   $e1
        .byte   $62
        .byte   $e0
        .byte   $63
        .byte   $79
        .byte   $68
        .byte   $53
        .byte   $e0
        .byte   $61
        .byte   $e0
        .byte   $62
        .byte   $70
        .byte   $6a
        .byte   $e2
        .byte   $63
        .byte   $79
        .byte   $60
        .byte   $e2
        .byte   $63
        .byte   $52
        .byte   $72
        .byte   $61
        .byte   $6a
        .byte   $78
        .byte   $bc             ; Electricidad
        .byte   $9b             ; Misil
        .byte   $70
        .byte   $73
        .byte   $73
        .byte   $79
        .byte   $93             ; Alienígena
        .byte   $6a
        .byte   $51
        .byte   $6b
        .byte   $71
        .byte   $60
        .byte   $62
        .byte   $78
        .byte   $62
        .byte   $00             ; Fin de nivel

base_sonido
        ; Silencio
sonido_0
        .byte   $00             ; Debe usar un byte

        ; Disparo del jugador
sonido_1
        .byte   $08             ; Instrumento
        .byte   1,$80
        .byte   2,$82
        .byte   3,$85
        .byte   3,$45
        .byte   3,$05
        .byte   0

        ; Disparo enemigo
sonido_2
        .byte   $0e
        .byte   1,$e3
        .byte   1,$c1
        .byte   1,$a2
        .byte   1,$81
        .byte   1,$60
        .byte   0

        ; Explosión
sonido_3
        .byte   $08
        .byte   2,$84
        .byte   3,$e5
        .byte   3,$e6
        .byte   2,$a7
        .byte   2,$68
        .byte   2,$6c
        .byte   2,$70
        .byte   5,$78
        .byte   5,$1c
        .byte   5,$1f
        .byte   0

        ; Lanzamiento
sonido_4
        .byte   $08
        .byte   10,$9f
        .byte   10,$f0
        .byte   20,$ee
        .byte   0

        ; Los siguientes cuatro son sonidos de fondo continuos
        ; Satélite
sonido_5
        .byte   $01
        .byte   7,$41
        .byte   3,$43
        .byte   7,$81
        .byte   3,$83
        .byte   0

        ; Misil teledirigido
sonido_6
        .byte   $05
        .byte   1,$e0
        .byte   2,$e2
        .byte   3,$e3
        .byte   0

        ; Electricidad
sonido_7
        .byte   $0f
        .byte   2,$01
        .byte   1,$e0
        .byte   2,$82
        .byte   0

        ; Robotote
sonido_8
        .byte   $04
        .byte   5,$84
        .byte   5,$82
        .byte   5,$83
        .byte   5,$88
        .byte   5,$84
        .byte   3,$86
        .byte   0

        ; Fortaleza 2
fortaleza_2
        .byte   $42
        .byte   $43
        .byte   $71
        .byte   $71
        .byte   $60
        .byte   $e2
        .byte   $63
        .byte   $e0
        .byte   $61
        .byte   $7a
        .byte   $68
        .byte   $51
        .byte   $6a
        .byte   $6b
        .byte   $79
        .byte   $72
        .byte   $9b             ; Misil
        .byte   $bc             ; Electricidad
        .byte   $e0
        .byte   $61
        .byte   $93             ; Alienígena
        .byte   $60
        .byte   $68
        .byte   $bd             ; Electricidad
        .byte   $73
        .byte   $72
        .byte   $78
        .byte   $7b
        .byte   $bc             ; Electricidad
        .byte   $73
        .byte   $72
        .byte   $79
        .byte   $9b             ; Misil
        .byte   $bd             ; Electricidad
        .byte   $40
        .byte   $70
        .byte   $93             ; Alienígena
        .byte   $93             ; Alienígena
        .byte   $93             ; Alienígena
        .byte   $43
        .byte   $7a
        .byte   $71
        .byte   $7b
        .byte   $a3             ; Robotote
        .byte   $00             ; Fin de nivel

        ; Espacio 2
espacio_2
        .byte   $f1             ; Planetoide
        .byte   $3a,32          ; Avión loquito
        .byte   $c0             ; Satélite
        .byte   $3b,52          ; Un avión a la vez
        .byte   $3c,52          ; Un avión a la vez
        .byte   $3d,52          ; Un avión a la vez
        .byte   $38             ; Tres aviones por arriba
        .byte   $3a,72          ; Avión loquito
        .byte   $39             ; Tres aviones por abajo
        .byte   $3b,72          ; Un avión a la vez
        .byte   $3c,52          ; Un avión a la vez
        .byte   $3d,72          ; Un avión a la vez
        .byte   $c0             ; Satélite
        .byte   $39             ; Tres aviones por abajo
        .byte   $3a,52          ; Avión loquito
        .byte   $00             ; Fin de nivel y alineación

        org     $fd00           ; Locación de inicio del ROM
        ; Para evitar cruces de página

        ; Sprites de 8 líneas ubicados en múltiplos de 8
        ; Sprites de 16 líneas ubicados en múltiplos de 16

        ;
        ; Colores de sprite por línea
        ;
colores
        if      COLOR_NTSC = 1
        ; Nave
            .byte   $0c
            .byte   $0e
            .byte   $18
            .byte   $0e
            .byte   $0e
            .byte   $0e
            .byte   $0e
            .byte   $0c

            .byte   $0c
            .byte   $0c
            .byte   $18
            .byte   $0e
            .byte   $0e
            .byte   $0e
            .byte   $0e
            .byte   $0c

            .byte   $0c
            .byte   $0c
            .byte   $18
            .byte   $0e
            .byte   $0e
            .byte   $0e
            .byte   $0c
            .byte   $0c

        ; Sombra
            .byte   $90
            .byte   $90
            .byte   $90
            .byte   $90
            .byte   $90
            .byte   $90
            .byte   $90
            .byte   $90

            .byte   $90
            .byte   $90
            .byte   $90
            .byte   $90
            .byte   $90
            .byte   $90
            .byte   $90
            .byte   $90

            .byte   $90
            .byte   $90
            .byte   $90
            .byte   $90
            .byte   $90
            .byte   $90
            .byte   $90
            .byte   $90

        ; Aviones

            .byte   $b6
            .byte   $b8
            .byte   $ba
            .byte   $ba
            .byte   $ba
            .byte   $ba
            .byte   $b8
            .byte   $b8

            .byte   $b6
            .byte   $b8
            .byte   $ba
            .byte   $ba
            .byte   $ba
            .byte   $ba
            .byte   $b8
            .byte   $b8

            .byte   $b6
            .byte   $b8
            .byte   $ba
            .byte   $ba
            .byte   $ba
            .byte   $ba
            .byte   $b8
            .byte   $b8

        ; Explosión 1

            .byte   $34
            .byte   $34
            .byte   $34
            .byte   $1a
            .byte   $1a
            .byte   $34
            .byte   $34
            .byte   $34

        ; Cañón

            .byte   $26
            .byte   $28
            .byte   $2a
            .byte   $2a
            .byte   $2a
            .byte   $2a
            .byte   $2a
            .byte   $2a

        ; Explosión 2

            .byte   $38
            .byte   $38
            .byte   $1c
            .byte   $1c
            .byte   $1c
            .byte   $1c
            .byte   $38
            .byte   $38

        ; Agujero

            .byte   $14
            .byte   $16
            .byte   $18
            .byte   $1a
            .byte   $1c
            .byte   $1c
            .byte   $1a
            .byte   $1a

        ; Cañón

            .byte   $26
            .byte   $28
            .byte   $2a
            .byte   $2a
            .byte   $2a
            .byte   $2a
            .byte   $2a
            .byte   $2a

        ; Combustible

            .byte   $b0
            .byte   $ba
            .byte   $ba
            .byte   $ba
            .byte   $ba
            .byte   $98
            .byte   $98
            .byte   $0e

        ; Antena

            .byte   $26
            .byte   $18
            .byte   $0c
            .byte   $0c
            .byte   $0e
            .byte   $0e
            .byte   $0e
            .byte   $0c

        ; Agujero disparando

            .byte   $36
            .byte   $36
            .byte   $36
            .byte   $36
            .byte   $36
            .byte   $36
            .byte   $36
            .byte   $36

        ; Misil V

            .byte   $34
            .byte   $38
            .byte   $0c
            .byte   $0e
            .byte   $0e
            .byte   $0e
            .byte   $0e
            .byte   $0c

        ; Alienígena
            .byte   $44
            .byte   $44
            .byte   $44
            .byte   $4a
            .byte   $4a
            .byte   $4a
            .byte   $48
            .byte   $48

        ; Misil teledirigido

            .byte   $36
            .byte   $38
            .byte   $38
            .byte   $38
            .byte   $38
            .byte   $38
            .byte   $38
            .byte   $34

        ; Robotote

            .byte   $0c
            .byte   $0e
            .byte   $0c
            .byte   $0e
            .byte   $0c
            .byte   $0e
            .byte   $0c
            .byte   $0e
            .byte   $0c
            .byte   $0e
            .byte   $0c
            .byte   $0e
            .byte   $0c
            .byte   $0e
            .byte   $0c
            .byte   $0e

        ; Adorno en pared de fortaleza

            .byte   $b2
            .byte   $b2
            .byte   $b4
            .byte   $b4
            .byte   $b6
            .byte   $b6
            .byte   $b6
            .byte   $b6

        ; Electricidad

            .byte   $0e
            .byte   $0e
            .byte   $0e
            .byte   $0e
            .byte   $0e
            .byte   $0e
            .byte   $0e
            .byte   $0e

        ; Satélite

            .byte   $0c
            .byte   $0c
            .byte   $98
            .byte   $98
            .byte   $98
            .byte   $98
            .byte   $0c
            .byte   $0c
            .byte   $0e
            .byte   $0e
            .byte   $0e
            .byte   $0e
            .byte   $38
            .byte   $0e
            .byte   $0e
            .byte   $0e

        ; Mira

            .byte   $38
            .byte   $38
            .byte   $38
            .byte   $38
            .byte   $38
            .byte   $38
            .byte   $38
            .byte   $38
            .byte   $38
            .byte   $38
            .byte   $38
            .byte   $38
            .byte   $38
            .byte   $38
            .byte   $38
            .byte   $38

        ; Adorno en piso de fortaleza

            .byte   $0c
            .byte   $0c
            .byte   $0c
            .byte   $0c
            .byte   $0c
            .byte   $0c
            .byte   $0c
            .byte   $0c

        ; Adorno en pared de fortaleza

            .byte   $2a
            .byte   $2a
            .byte   $2a
            .byte   $2a
            .byte   $2a
            .byte   $2a
            .byte   $2a
            .byte   $2a

        ; Planetoide
            .byte   $94
            .byte   $96
            .byte   $98
            .byte   $9a
            .byte   $9c
            .byte   $9c
            .byte   $9a
            .byte   $98

        ; Planetoide
            .byte   $94
            .byte   $94
            .byte   $94
            .byte   $98
            .byte   $9a
            .byte   $9c
            .byte   $9c
            .byte   $9c

        else
        ; Nave
            .byte   $0c
            .byte   $0e
            .byte   $28
            .byte   $0e
            .byte   $0e
            .byte   $0e
            .byte   $0e
            .byte   $0c

            .byte   $0c
            .byte   $0c
            .byte   $28
            .byte   $0e
            .byte   $0e
            .byte   $0e
            .byte   $0e
            .byte   $0c

            .byte   $0c
            .byte   $0c
            .byte   $28
            .byte   $0e
            .byte   $0e
            .byte   $0e
            .byte   $0c
            .byte   $0c

        ; Sombra
            .byte   $B0
            .byte   $B0
            .byte   $B0
            .byte   $B0
            .byte   $B0
            .byte   $B0
            .byte   $B0
            .byte   $B0

            .byte   $B0
            .byte   $B0
            .byte   $B0
            .byte   $B0
            .byte   $B0
            .byte   $B0
            .byte   $B0
            .byte   $B0

            .byte   $B0
            .byte   $B0
            .byte   $B0
            .byte   $B0
            .byte   $B0
            .byte   $B0
            .byte   $B0
            .byte   $B0

        ; Aviones

            .byte   $76
            .byte   $78
            .byte   $7a
            .byte   $7a
            .byte   $7a
            .byte   $7a
            .byte   $78
            .byte   $78

            .byte   $76
            .byte   $78
            .byte   $7a
            .byte   $7a
            .byte   $7a
            .byte   $7a
            .byte   $78
            .byte   $78

            .byte   $76
            .byte   $78
            .byte   $7a
            .byte   $7a
            .byte   $7a
            .byte   $7a
            .byte   $78
            .byte   $78

        ; Explosión 1

            .byte   $44
            .byte   $44
            .byte   $44
            .byte   $2a
            .byte   $2a
            .byte   $44
            .byte   $44
            .byte   $44

        ; Cañón

            .byte   $26
            .byte   $28
            .byte   $2a
            .byte   $2a
            .byte   $2a
            .byte   $2a
            .byte   $2a
            .byte   $2a

        ; Explosión 2

            .byte   $48
            .byte   $48
            .byte   $2c
            .byte   $2c
            .byte   $2c
            .byte   $2c
            .byte   $48
            .byte   $48

        ; Agujero

            .byte   $24
            .byte   $26
            .byte   $28
            .byte   $2a
            .byte   $2c
            .byte   $2c
            .byte   $2a
            .byte   $2a

        ; Cañón

            .byte   $26
            .byte   $28
            .byte   $2a
            .byte   $2a
            .byte   $2a
            .byte   $2a
            .byte   $2a
            .byte   $2a

        ; Combustible

            .byte   $70
            .byte   $7a
            .byte   $7a
            .byte   $7a
            .byte   $7a
            .byte   $B8
            .byte   $B8
            .byte   $0e

        ; Antena

            .byte   $26
            .byte   $28
            .byte   $0c
            .byte   $0c
            .byte   $0e
            .byte   $0e
            .byte   $0e
            .byte   $0c

        ; Agujero disparando

            .byte   $46
            .byte   $46
            .byte   $46
            .byte   $46
            .byte   $46
            .byte   $46
            .byte   $46
            .byte   $46

        ; Misil V

            .byte   $44
            .byte   $48
            .byte   $0c
            .byte   $0e
            .byte   $0e
            .byte   $0e
            .byte   $0e
            .byte   $0c

        ; Alienígena
            .byte   $64
            .byte   $64
            .byte   $64
            .byte   $6a
            .byte   $6a
            .byte   $6a
            .byte   $68
            .byte   $68

        ; Misil teledirigido

            .byte   $46
            .byte   $48
            .byte   $48
            .byte   $48
            .byte   $48
            .byte   $48
            .byte   $48
            .byte   $44

        ; Robotote

            .byte   $0c
            .byte   $0e
            .byte   $0c
            .byte   $0e
            .byte   $0c
            .byte   $0e
            .byte   $0c
            .byte   $0e
            .byte   $0c
            .byte   $0e
            .byte   $0c
            .byte   $0e
            .byte   $0c
            .byte   $0e
            .byte   $0c
            .byte   $0e

        ; Adorno en pared de fortaleza

            .byte   $72
            .byte   $72
            .byte   $74
            .byte   $74
            .byte   $76
            .byte   $76
            .byte   $76
            .byte   $76

        ; Electricidad

            .byte   $0e
            .byte   $0e
            .byte   $0e
            .byte   $0e
            .byte   $0e
            .byte   $0e
            .byte   $0e
            .byte   $0e

        ; Satélite

            .byte   $0c
            .byte   $0c
            .byte   $b8
            .byte   $b8
            .byte   $b8
            .byte   $b8
            .byte   $0c
            .byte   $0c
            .byte   $0e
            .byte   $0e
            .byte   $0e
            .byte   $0e
            .byte   $48
            .byte   $0e
            .byte   $0e
            .byte   $0e

        ; Mira

            .byte   $48
            .byte   $48
            .byte   $48
            .byte   $48
            .byte   $48
            .byte   $48
            .byte   $48
            .byte   $48
            .byte   $48
            .byte   $48
            .byte   $48
            .byte   $48
            .byte   $48
            .byte   $48
            .byte   $48
            .byte   $48

        ; Adorno en piso de fortaleza

            .byte   $0c
            .byte   $0c
            .byte   $0c
            .byte   $0c
            .byte   $0c
            .byte   $0c
            .byte   $0c
            .byte   $0c

        ; Adorno en pared de fortaleza

            .byte   $2a
            .byte   $2a
            .byte   $2a
            .byte   $2a
            .byte   $2a
            .byte   $2a
            .byte   $2a
            .byte   $2a

        ; Planetoide
            .byte   $b4
            .byte   $b6
            .byte   $b8
            .byte   $ba
            .byte   $bc
            .byte   $bc
            .byte   $ba
            .byte   $b8

        ; Planetoide
            .byte   $b4
            .byte   $b4
            .byte   $b4
            .byte   $b8
            .byte   $ba
            .byte   $bc
            .byte   $bc
            .byte   $bc

        endif

        org     $fe00           ; Locación de inicio del ROM
        ; Para evitar cruces de página

        ;
        ; Los sprites están verticalmente al revés, para ahorrar
        ; instrucciones al visualizar.
        ;
sprites
        ; Nave grande ($00)
        .byte   $1c
        .byte   $38
        .byte   $78
        .byte   $fc
        .byte   $fe
        .byte   $ef
        .byte   $6d
        .byte   $46
        ; Nave media ($08)
        .byte   $00
        .byte   $30
        .byte   $70
        .byte   $fc
        .byte   $fe
        .byte   $6a
        .byte   $6c
        .byte   $40
        ; Nave chica ($10)
        .byte   $00
        .byte   $10
        .byte   $30
        .byte   $7c
        .byte   $7a
        .byte   $34
        .byte   $20
        .byte   $00
        ; Sombra chica ($18)
        .byte   $00
        .byte   $00
        .byte   $00
        .byte   $20
        .byte   $30
        .byte   $78
        .byte   $7c
        .byte   $48
        ; Sombra media ($20)
        .byte   $00
        .byte   $00
        .byte   $10
        .byte   $30
        .byte   $7c
        .byte   $7e
        .byte   $6c
        .byte   $40
        ; Sombra grande ($28)
        .byte   $00
        .byte   $00
        .byte   $30
        .byte   $70
        .byte   $7c
        .byte   $7e
        .byte   $7e
        .byte   $6c
        ; Avión grande ($30)
        .byte   $04
        .byte   $cc
        .byte   $f8
        .byte   $5c
        .byte   $3e
        .byte   $66
        .byte   $42
        .byte   $02
        ; Avión medio ($38)
        .byte   $04
        .byte   $0c
        .byte   $78
        .byte   $5c
        .byte   $3e
        .byte   $66
        .byte   $42
        .byte   $00
        ; Avión chico ($40)
        .byte   $08
        .byte   $18
        .byte   $70
        .byte   $58
        .byte   $3c
        .byte   $6c
        .byte   $44
        .byte   $00
        ; Explosión ($48)
        .byte   $00
        .byte   $08
        .byte   $56
        .byte   $6c
        .byte   $12
        .byte   $38
        .byte   $66
        .byte   $00
        ; Cañón mirando a la der. ($50)
        .byte   $39
        .byte   $7b
        .byte   $7e
        .byte   $44
        .byte   $3a
        .byte   $7e
        .byte   $3c
        .byte   $00
        ; Explosión ($58)
        .byte   $22
        .byte   $99
        .byte   $66
        .byte   $44
        .byte   $13
        .byte   $58
        .byte   $a6
        .byte   $49
        ; Agujero ($60)
        .byte   $18
        .byte   $3e
        .byte   $76
        .byte   $c3
        .byte   $c3
        .byte   $6e
        .byte   $38
        .byte   $00
        ; Cañón mirando a la izq. ($68)
        .byte   $9c
        .byte   $de
        .byte   $7e
        .byte   $22
        .byte   $5c
        .byte   $7e
        .byte   $3c
        .byte   $00
        ; Combustible ($70)
        .byte   $3c
        .byte   $7e
        .byte   $7e
        .byte   $66
        .byte   $5a
        .byte   $3c
        .byte   $7e
        .byte   $3c
        ; Antena ($78)
        .byte   $38
        .byte   $18
        .byte   $30
        .byte   $7c
        .byte   $74
        .byte   $68
        .byte   $74
        .byte   $3a
        ; Agujero disparando ($80)
        .byte   $5f
        .byte   $be
        .byte   $7f
        .byte   $eb
        .byte   $df
        .byte   $3a
        .byte   $5c
        .byte   $28
        ; Misil vertical ($88)
        .byte   $38
        .byte   $38
        .byte   $7c
        .byte   $38
        .byte   $38
        .byte   $38
        .byte   $38
        .byte   $10
        ; Alienígena ($90)
        .byte   $38
        .byte   $7c
        .byte   $44
        .byte   $ba
        .byte   $ba
        .byte   $7c
        .byte   $7c
        .byte   $38
        ; Misil teledirigido ($98)
        .byte   $00
        .byte   $c0
        .byte   $f6
        .byte   $7c
        .byte   $1e
        .byte   $0e
        .byte   $0a
        .byte   $02
        ; Robotote ($a0)
        .byte   $06
        .byte   $1a
        .byte   $7f
        .byte   $fa
        .byte   $bf
        .byte   $ea
        .byte   $af
        .byte   $fa
        .byte   $bf
        .byte   $fa
        .byte   $b3
        .byte   $93
        .byte   $9f
        .byte   $e2
        .byte   $84
        .byte   $40
        ; Adorno en pared de fortaleza ($b0)
        .byte   $c0
        .byte   $f0
        .byte   $fc
        .byte   $ff
        .byte   $f3
        .byte   $ee
        .byte   $dc
        .byte   $b8
        ; Electricidad ($b8)
        ; Tiene truco para replicar 3 veces, al hacer OR con $00-$17 sigue
        ; estando en el rango $b8-$bf
        .byte   $05
        .byte   $2b
        .byte   $59
        .byte   $48
        .byte   $85
        .byte   $2b
        .byte   $59
        .byte   $48
        ; Satélite ($c0)
        .byte   $10
        .byte   $38
        .byte   $14
        .byte   $18
        .byte   $30
        .byte   $50
        .byte   $18
        .byte   $3e
        .byte   $20
        .byte   $5e
        .byte   $3a
        .byte   $7a
        .byte   $7a
        .byte   $7e
        .byte   $7c
        .byte   $30
        ; Mira ($d0 y $d8)
        .byte   $00
        .byte   $00
        .byte   $00
        .byte   $00
        .byte   $00
        .byte   $00
        .byte   $00
        .byte   $00
        .byte   $00
        .byte   $00
        .byte   $44
        .byte   $28
        .byte   $00
        .byte   $28
        .byte   $44
        .byte   $00
        ; Adorno de piso ($e0)
        .byte   $30
        .byte   $7c
        .byte   $7f
        .byte   $3f
        .byte   $cf
        .byte   $f2
        .byte   $3c
        .byte   $08
        ; Adorno 2 ($e8)
        .byte   $c0
        .byte   $f0
        .byte   $fc
        .byte   $ff
        .byte   $ff
        .byte   $fc
        .byte   $f0
        .byte   $c0
        ; Planetoide ($f0)
        .byte   $d8
        .byte   $bc
        .byte   $8e
        .byte   $76
        .byte   $7a
        .byte   $7d
        .byte   $3d
        .byte   $1b
        ; Planetoide ($f8)
        .byte   $00
        .byte   $38
        .byte   $7c
        .byte   $7c
        .byte   $7c
        .byte   $7c
        .byte   $38
        .byte   $00

gas1    .byte   $00,$40,$c0,$c0,$c0,$c0,$c0,$c0,$c0,$c0,$c0
gas2    .byte   $00,$00,$00,$80,$c0,$e0,$f0,$f8,$fc,$fe,$ff

letras
        .byte   $00,$fe,$c6,$c6,$c6,$fe,$00,$02
        .byte   $00,$78,$30,$30,$70,$30,$00,$00
        .byte   $00,$fe,$c0,$fe,$06,$fe,$00,$02
        .byte   $00,$fe,$06,$fe,$06,$fe,$00,$00
        .byte   $00,$06,$06,$fe,$c6,$c6,$00,$00
        .byte   $00,$fe,$06,$fe,$c0,$fe,$00,$02
        .byte   $00,$fe,$c6,$fe,$c0,$fe,$00,$01
        .byte   $00,$18,$18,$0c,$06,$fe,$00,$02
        .byte   $00,$fe,$c6,$fe,$c6,$fe,$00,$00
        .byte   $00,$fe,$06,$fe,$c6,$fe,$00,$01
        .byte   $00,$00,$00,$00,$00,$00,$00,$03
        .byte   $0e,$e2,$ae,$aa,$aa,$ea,$80,$05
        .byte   $00,$0a,$0a,$0a,$0a,$0e,$00,$25
        .byte   $00,$ea,$aa,$ea,$2a,$ee,$00,$00
        .byte   $00,$ee,$a8,$a8,$a8,$ee,$00,$00
        .byte   $00,$ae,$a8,$ae,$aa,$ee,$80,$00
        .byte   $00,$ee,$22,$ee,$88,$ee,$00,$10

mensaje_titulo
        .byte   $70,$ee,$77
        .byte   $10,$aa,$11
        .byte   $70,$ee,$71
        .byte   $40,$8a,$11
        .byte   $70,$8a,$77
        .byte   $00,$00,$00
        .byte   $c0,$9e,$1d
        .byte   $40,$52,$25
        .byte   $c0,$9e,$25
        .byte   $40,$52,$25
        .byte   $40,$52,$1d

mensaje_final
        .byte   $f0,$7a,$7a
        .byte   $10,$4b,$0b
        .byte   $d0,$7b,$3b
        .byte   $90,$4a,$0a
        .byte   $f0,$4a,$7a
        .byte   $00,$00,$00
        .byte   $f0,$4b,$3b
        .byte   $90,$4a,$48
        .byte   $90,$4b,$39
        .byte   $90,$32,$48
        .byte   $f0,$33,$4b

        ;
        ; Adelanta lector de nivel
        ;
adelanta_lector
        inc     lector
        bne     al1
        inc     lector+1
al1     rts

        ;
        ; Obtiene botón de disparo.
        ; Se asegura de que el jugador no puede dejar oprimido el botón :>
        ;
boton_disparo
        lda     INPT4
        eor     #$ff
        tax
        eor     antirebote
        stx     antirebote
        bpl     bd1
        lda     antirebote      ; Puede ser txa pero desalinea JMP construido abajo
bd1     rts

        ; Servicio genérico
generico
        lda     SWCHB
        lsr                     ; ¿Reset?
        bcs     bd1
        ;jmp $f000
        .byte   $4c             ; Forma JMP

        org     $fffc
        .word   inicio          ; Posición de inicio al recibir RESET
        .word   inicio          ; Posición para servir BRK
