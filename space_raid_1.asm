        ;
        ; Space Raid para Atari 2600 (banco 1, principal)
        ;
        ; por Oscar Toledo Gutiérrez
        ;
        ; (c) Copyright 2013 Oscar Toledo Gutiérrez
        ;
        ; Creación: 27-ago-2011.
        ; Revisión: 23-may-2013. Se agrega posicionamiento en X.
        ; Revisión: 24-sep-2013. La nave se mueve en seudo-3D, crece y se
        ;                        achica, tiene sombra, dispara. Y hay un
        ;                        avión enemigo pasando.
        ; Revisión: 25-sep-2013. Ya hay una bala enemiga y hasta tres sprites
        ;                        enemigos.
        ; Revisión: 26-sep-2013. Se introducen todos los sprites.
        ; Revisión: 27-sep-2013. Fortalezas semi-operativas, va mostrando
        ;                        diferentes elementos. El espacio ya muestra
        ;                        olas de ataque de aviones :) La sombra del
        ;                        jugador desaparece en el espacio. Ya puede
        ;                        destruir enemigos. Se agrega espectacular
        ;                        raya 3D :P.
        ; Revisión: 28-sep-2013. Los cañones y los aviones ya disparan.
        ;                        Solucionado bug al explotar satélite. Se
        ;                        ajusta sincronía NTSC/PAL. Gasta gasolina en
        ;                        fortaleza, recupera con depósitos. Muestra
        ;                        total de gasolina, puntos y vida. Pantalla de
        ;                        Game Over preliminar.
        ; Revisión: 29-sep-2013. Se pone pantalla de título con efecto de
        ;                        brillo. Se agrandan las balas. Optimización
        ;                        del núcleo para corregir defectos visuales.
        ;                        Ya puntúa por destruir enemigos. La
        ;                        electricidad detiene la bala. El campo de
        ;                        electricidad ya se mueve.
        ; Revisión: 30-sep-2013. Se implementa la explosión de la nave. Ya se
        ;                        ve completo el robotote. El misil teledirigido
        ;                        ya sigue a la nave y son necesarios cinco
        ;                        impactos para destruirlo. Ya no tiene disparo
        ;                        continuo. El jugador explota cuando se le
        ;                        acaba la gasolina. El robotote avanza y
        ;                        dispara (10 impactos para detenerlo). Se
        ;                        soluciona bug en que no podía seleccionar
        ;                        nivel fortaleza como inicio (no iniciaba
        ;                        largo_sprite). Nuevo dibujo para el misil
        ;                        teledirigido. Ya dispara misiles verticales
        ;                        y pueden ser destruidos si el jugador va al
        ;                        nivel correcto. Se implementan los colores
        ;                        para PAL. Se integran efectos de sonido. Se
        ;                        corrige bug de avión invisible destruido en
        ;                        espacio. El avión pequeño ya no es tan
        ;                        pequeño.
        ; Revisión: 01-oct-2013. Las balas de los enemigos ya destruyen al
        ;                        jugador. El jugador ya puede chocar con los
        ;                        elementos del juego. Al tomar gasolina
        ;                        aumenta a unidades completas. Se hace "alta"
        ;                        la barrera eléctrica. El jugador inicia
        ;                        arriba después de ser destruido. Ya disparan
        ;                        los aviones chicos en la fortaleza. El botón
        ;                        de reset ya reinicia el juego. El switch de
        ;                        dificultad para el jugador 1 ya se toma en
        ;                        cuenta para que los cañones disparen más
        ;                        seguido. Juego completo :). Se alarga el
        ;                        sprite de electricidad, se acelera su
        ;                        movimiento para que parezca campo de fuerza y
        ;                        ya no se sale de la pantalla. El robotote
        ;                        empieza 10 pixeles más a la izquierda para
        ;                        no salirse de la pantalla. Corrección en la
        ;                        ubicación del disparo del robotote. Desaparece
        ;                        bala cuando ocurre explosión del jugador. Se
        ;                        agrega bitmap "by nanochess" :). Retorna el
        ;                        fondo a negro en caso de Game Over.
        ; Revisión: 02-oct-2013. Evita que disparen cañones invisibles (se
        ;                        escuchaba el sonido). Se optimiza más el
        ;                        código. No se podía hacer reset mientras
        ;                        explotaba. Ajuste en consumo de gasolina. La
        ;                        explosión del robotote y del satélite ya es
        ;                        animada. Corrección en misiles verticales,
        ;                        seguían subiendo aunque ya hubieran
        ;                        desaparecido. Se ajusta con el emulador
        ;                        Stella para que emita exactamente 262 líneas
        ;                        con NTSC (eran 265) y 312 con PAL (eran 315)
        ; Revisión: 03-oct-2013. La bala del jugador se centra en la punta de
        ;                        la nave, también la bala de los enemigos.
        ;                        Ya hay suficientes botes de gasolina de
        ;                        acuerdo a la longitud del nivel y máxima
        ;                        dificultad. Descubrí el uso de HMCLR para
        ;                        ahorrar bytes :). Se integra mira para
        ;                        apuntar en el espacio (sólo dificultad fácil)
        ;                        Los campos eléctricos ya pueden estar arriba
        ;                        o abajo. Gané tiempo en el kernel para usar
        ;                        HMOVE en cada línea de la visualización
        ;                        principal y así desaparecen los fragmentos
        ;                        de pixeles que aparecían en la columna
        ;                        izquierda del video. Se modifica el indicador
        ;                        de puntuación para mantener la barra negra a
        ;                        la izquierda.
        ; Revisión: 04-oct-2013. Se reescribe otra vez el kernel de pantalla
        ;                        para que quepa una escritura en HMBL para
        ;                        evitar que las rayas 3D se desplacen cuando
        ;                        aparecía un sprite. La raya 3D se desplaza
        ;                        más rápido. Corrección en tabla de puntuación.
        ;                        Los agujeros de misil ahora a veces disparan
        ;                        al llegar al centro. Se agregan dos adornos en
        ;                        la pared de la fortaleza usando un cuarto
        ;                        sprite (nuevo). Colores variables en el
        ;                        espacio (es que es hiperespacio :P) Se centra
        ;                        el disparo del robotote. Mejores colores para
        ;                        los sprites. Los disparos son más aleatorios
        ;                        y la dificultad es progresiva.
        ; Revisión: 05-oct-2013. Color alterno cada dos fortalezas. Más
        ;                        optimización. Limita puntos a 9999. Se
        ;                        agrega cañón giratorio. Se corrige un bug
        ;                        en que cuando aparecía la mirilla y se
        ;                        disparaba entonces los enemigos explotaban
        ;                        inmediato.
        ; Revisión: 06-oct-2013. Se implementa PAL60, es la misma frecuencia
        ;                        que NTSC pero con colores PAL.
        ; Revisión: 07-oct-2013. Se optimiza el minireproductor de sonido y se
        ;                        cambia el formato (18 bytes ahorrados más tres
        ;                        posibles en efectos). Se corrige bug en
        ;                        fortaleza en un nivel avanzado al ser tocado
        ;                        podía explotar dos veces ya que la gasolina
        ;                        seguía acabándose.
        ; Revisión: 08-oct-2013. Más optimización. Corrección en adornos de
        ;                        fortaleza, no salía la flecha amarilla.
        ;                        Ligera mejora en kernel de visualización. Ya
        ;                        hay sonido para cuando los aviones enemigos
        ;                        disparan. Ya se alternan los disparos de los
        ;                        aviones enemigos, antes sólo disparaba el
        ;                        primero de estos. El agujero de misil ya se
        ;                        llena de fuego al disparar misil y destruye
        ;                        al jugador si se toca en ese momento.
        ; Revisión: 09-oct-2013. Más optimización.
        ; Revisión: 10-oct-2013. Más optimización. Se reutiliza byte
        ;                        desaprovechado en letras para puntuación. Se
        ;                        combina la detección de colisión de bala y
        ;                        de nave y ahorré montones de bytes. Se
        ;                        agrega detección de código importante dividido
        ;                        entre dos páginas de 256 bytes (un salto 6502
        ;                        usa un ciclo extra)
        ; Revisión: 11-oct-2013. Más optimización. Permite seleccionar
        ;                        dificultad en Game Over.
        ; Revisión: 12-oct-2013. Rediseño del fondo en el espacio para que
        ;                        las rayas parezcan estrellas. Se agregan
        ;                        planetas (dos sprites) en el espacio :) Se
        ;                        agrega alienígena que anda en el piso de la
        ;                        fortaleza. Los cañones ya disparan a la
        ;                        derecha (aleatoriamente). Se compacta la
        ;                        representación de nivel de las fortalezas. Se
        ;                        agregan adornos de piso antes de los agujeros
        ;                        de misil. Se agrega un tiempo aleatorio entre
        ;                        elementos de fortaleza para que no se sientan
        ;                        "tan" iguales. El misil teledirigido congela
        ;                        el scroll de la raya 3D.
        ; Revisión: 19-oct-2013. Se corrige bug en que mira aparecía cuando
        ;                        el avión enemigo ya está detrás del jugador.
        ;                        Se corrige bug en que misil teledirigido iba
        ;                        muy abajo con respecto a la nave y era
        ;                        imposible atinarle cuando la nave estaba hasta
        ;                        arriba. Ahora son sólo tres niveles de gasto
        ;                        de gasolina y más altos, ya que en los niveles
        ;                        primarios apenas se consumía gasolina.
        ;                        Gasolina es 5.3. Ya dispara el tercer avión,
        ;                        era a causa de var. 'ola' no era tomada en
        ;                        cuenta cuando era $3b.
        ; Revisión: 21-oct-2013. Movido a banco principal 4K. Operativo.
        ; Revisión: 22-oct-2013. Se reordenan las estructuras. Se integra
        ;                        lógica para mostrar paredes, detección de
        ;                        colisión con paredes, y se integran paredes en
        ;                        fortalezas y abismos.
        ; Revisión: 23-oct-2013. Se soluciona bug de explosiones que iban muy
        ;                        rápido. Se agregan 4 niveles extra. Ya toca
        ;                        música en título y fin de juego.
        ; Revisión: 24-oct-2013. Se soluciona bug en que daba puntos
        ;                        incorrectos al estrellarse contra pared. La
        ;                        nave del jugador tiene sprites extras al
        ;                        irse a izquierda y derecha :)
        ; Revisión: 25-oct-2013. La vida se resta al terminar de explotar.
        ;                        Ahora da vidas cada 200 puntos. Se soluciona
        ;                        bug en que NUSIZ no era restaurado despues
        ;                        de robotote y fondo de mensaje quedaba en
        ;                        azul. Se anima la antena.
        ; Revisión: 26-oct-2013. Reproductor de música adaptado para doble
        ;                        canal. Nueva música de Game Over y se retira
        ;                        música de título.
        ; Revisión: 31-oct-2013. Si el jugador explota más allá de la mitad del
        ;                        nivel entonces reinicia a medio nivel. Ya no
        ;                        se altera el contador de líneas al entrar en
        ;                        Game Over.
        ; Revisión: 01-nov-2013. Corrección de las alteraciones en el contador
        ;                        de líneas al cambiar entre pantallas de
        ;                        mensaje.
        ; Revisión: 06-nov-2013. Ajuste en coordenadas del agujero de la pared.
        ; Revisión: 15-nov-2013. Corrección en toca_musica, la sincronía
        ;                        vertical sólo duraba 2 líneas en vez de 3.
        ;                        Pequeñas optimizaciones. El reset torcía por
        ;                        completo la sincronía, ahora sólo desvía una
        ;                        línea la frecuencia.
        ;

        processor 6502

        include space_raid_m.asm

        ;
        ; ROM de 8K:
        ;
        ; Banco 0:
        ; o Espacio usado: 2675 bytes.
        ; o Espacio libre: 1421 bytes.
        ;
        ; Banco 1:
        ; o Espacio usado: 4078 bytes.
        ; o Espacio libre: 18 bytes.
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
        ; Sprites disponibles: 1
        ;
        ; Bugs conocidos:
        ; o Ninguno.
        ;
        ; Otras cosas interesantes que se pueden hacer:
        ; o Usar botón de "Select" para algo
        ; o Usar botón de "B/W" para algo.
        ;
        ; Con flicker se puede:
        ; o Colocar sprites de piso en la fortaleza
        ;   o Sprite extra, variables extra
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
        ;   en el Cosmic Ark, pero sólo se puede usar cuando no se hace HMOVE
        ;   en cada línea.
        ;

        ;
        ; Cada línea de video toma 76 ciclos del procesador
        ;
        ; Para NTSC (262 líneas):
        ;    3 - VSYNC
        ;    37 - VBLANK
        ;         2812 (37 * 76) - 14
        ;         2798 / 64 = 43.71 valor para TIM64T
        ;    202 - VIDEO
        ;    20 - VBLANK
        ;
        ; Para PAL (312 líneas):
        ;    3 - VSYNC
        ;    62 - VBLANK
        ;         4712 (62 * 76) - 14
        ;         4698 / 64 = 73.40 valor para TIM64T
        ;    202 - VIDEO
        ;    45 - VBLANK
        ;
        ; Notese que STA WSYNC no hace ninguna generación de sincronía,
        ; simplemente espera hasta que inicie el próximo HBLANK
        ; (generado automáticamente por el hardware), la siguiente
        ; instrucción empieza en cero ciclos, el próximo STA WSYNC debe
        ; sumar a 76 ciclos o menos.
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

        ;
        ; La RAM se halla entre $0080 y $00FF.
        ;

        org $f000

        ;
        ; Inicio del programa
        ;
inicio: sta banco1      ; Fantasma
        sei             ; Desactiva interrupciones
        cld             ; Desactiva modo decimal
        jmp inicio2

b11:    sta banco0
        jmp 0           ; Fantasma

        sta banco1      ; Fantasma
        ;
        ; Fin de gráficas (200 líneas)
        ;
pan12:  jsr muestra_puntos
        lda offset9temp ; Restaura sprite nave
        sta offset9
        lda offset1temp ; Restaura sprite interno
        sta offset1
        lda offset2temp ; Restaura sprite interno
        sta offset2
        lda offset3temp ; Restaura sprite interno
        sta offset3
        lda ye3dtemp
        sta ye3d1
        lda largotemp
        sta largo_sprite
        ldx mira        ; Restaura mira si hubo
        bmi mr2
        lda mira_off
        sta offset1,x
        lda mira_x
        sta xe3d1,x
        lda mira_y
        sta ye3d1,x
mr2:
        ;
        ; Corriendo a 30 cuadros por segundo
        ;
        lda cuadro
        lsr
        bcs z1a
        jmp z1

z1a:
        lda explosion
        beq z2a
        jmp b50

z2a:    lda #0
        sta ajuste_nave
        ; Lee el joystick del jugador 0
        ldy x_jugador
        lda SWCHA
        bmi z2          ; ¿Derecha?
        ldx #$60
        stx ajuste_nave
        cpy #55
        beq z2
        inc x_jugador

z2:     rol             ; ¿Izquierda?
        bmi z3
        ldx #$30
        stx ajuste_nave
        cpy #15
        beq z3
        dec x_jugador

z3:     ldy y_jugador
        rol             ; ¿Abajo?
        bmi z4
        cpy #72
        beq z4
        inc y_jugador

z4:     rol             ; ¿Arriba?
        bmi z5
        cpy #32         ; Nave va para abajo
        beq z5
        dec y_jugador

z5:     jsr boton_disparo       ; ¿Botón oprimido?
        bpl z8
        lda x_bala
        bne z8
        lda y_jugador
        sta bala_y3d
        lda x_jugador
        sta bala_x3d
        clc
        adc #12
        sta x_bala
        ldx #-2                 ; Ajusta coordenada de la bala
        lda offset9
        cmp #8
        beq z0
        dex                     ; -3
        bcs z0
        ldx #-1
z0:     txa
        clc
        adc yj3d
        sta y_bala
        lda #sonido_1-base_sonido
        jsr efecto_sonido

z8:
        ;
        ; Mueve bala del enemigo
        ;
        lda x_bala2     ; ¿Bala activa?
        beq z10
        ldx bala_der
        clc
        beq z10a
        dec y_bala2
        adc #1
        bne z11a

z10a:   sbc #3          ; #4 por el carry
        cmp #15
        bcc z11
z11a:   dec y_bala2
        beq z11
        bmi z11
        sta x_bala2
        lda nivel_bala2
        sec
        sbc y_jugador
        clc
        adc #2
        cmp #5
        bcs z10
        lda CXM1P       ; Colisión misil 1
        bpl z10         ; ¿Chocó con player 0? no, salta
        jsr inicia_explosion
z11:    lda #0
        sta y_bala2
        sta x_bala2
z10:

        ;
        ; Corriendo a 60 cuadros por segundo
        ;
z1:     ldy #0          ; Sólo comprueba jugador
        lda x_bala      ; ¿Bala activa?
        beq z44         ; No, salta.

z40:    iny             ; Comprueba bala y jugador
        inc y_bala
        clc
        adc #4
        cmp #150
        bcc z7
        dey
        tya
        sta y_bala
z7:     sta x_bala

        ;
        ; Comprueba si el jugador (y=0) o la bala (y=1) chocan con
        ; algún elemento
        ;
z44:    ldx #2
z30:    lda nivel
        lsr
        bcs z30a
        jmp z35

        ; Fortaleza
z30a:   lda ye3d1,x
        bne zz35
        jmp z32

zz35:   lda offset1,x
        sec
        sbc #$c0        ; ¿Pared?
        bcc z37j        ; No, salta.
        cmp #$18
        bcc z37k
        bcs z37h        ; Ignora lo demás

z37j:   jmp z37a

z37k:   sta temp
        cpy #0
        bne z37b
        ; Jugador contra pared
        lda avance
        cmp #21         ; ¿Llegó al punto de choque?
        bcs z37h        ; No, salta.
        lda y_jugador
        cmp #72
        bne z37g
        lda temp
        bne z37c
        lda x_jugador
        sec
        sbc #31
        cmp #8
        bcc z37h
        bcs z37g

z37c:   cmp #8
        sec
        bne z37d
        lda x_jugador
        sbc #46
        cmp #8
        bcs z37g
z37h:   jmp z32

z37d:   lda x_jugador
        sbc #31
        cmp #23
        bcc z37h
        bcs z37g

        ; Bala contra pared
z37b:   lda x_bala
        sec
        sbc bala_x3d
        clc
        adc #4
        cmp avance
        bcc z35d
        lda bala_y3d
        cmp #72
        bne z37g
        lda temp
        bne z37e
        lda bala_x3d
        sec
        sbc #31
        cmp #8
        bcc z35d
        bcs z37g

z37e:   cmp #8
        sec
        bne z37f
        lda bala_x3d
        sbc #46
        cmp #8
        bcc z35d
        bcs z37g

z37f:   lda bala_x3d
        sbc #31
        cmp #23
        bcc z35d
z37g:   jmp z34

z37a:   lda offset1,x
        cmp #$b8        ; ¿Electricidad?
        beq z35b
        cmp #$98        ; ¿Misil teledirigido o robotote $a0?
        bcs z35c        ; Sí, salta, siempre al nivel
        cmp #$88        ; ¿Misil vertical?
        bne z35a
        lda ye3d1,x     ; Saca nivel en referencia a su agujero
;       sec             ; Garantizado
        sbc ye3d2,x
        clc
        adc #32
        bne z36

z35a:   lda #32         ; En el piso
        bne z36

z35b:   lda ola
        cmp #105
        lda y_jugador
        bcc z35e
        cmp #48         ; Arriba de la zona: pasa a choque
        bcs z35c
z35g:   jmp z32b

z35e:   cmp #56
        bcs z35g

        ; Simplifica detección de impacto robotote
z35c:   tya
        lsr
        lda CXM0P       ; ¿Choque entre misil 0 y player 1?
        bcs z35f
        lda CXPPMM      ; ¿Choque entre player 0 y player 1?
z35f:   bpl z35d        ; No, salta.
        bmi z34

        ; Espacio
z35:    lda y_enemigo1,x
        bne z36
z35d:   jmp z32

z36:    sec
        sbc y_jugador,y
        clc
        adc #2
        cmp #5
        bcs z35d
z31:    lda xe3d1,x
        sec
        sbc x_jugador,y
        cpy #0
        clc
        beq z31a
        adc #8
        cmp #10
        jmp z31b

z31a:   adc #4
        cmp #13
z31b:   bcs z35d
z33:    lda yj3d,y
        sec
        sbc ye3d1,x
        cpy #0
        clc
        beq z33a
        adc #7
        cmp #8
        jmp z33b

z33a:   adc #4
        cmp #9
z33b:   bcs z32
z34:    ; El jugador/bala tocó un enemigo
        lda offset1,x
        cmp #$d8        ; ¿Adorno o planetoides?
        bcs z32         ; Sí, no afecta
        cmp #$48        ; ¿Explosión 1?
        beq z32         ; Sí, no afecta
        cmp #$58        ; ¿Explosión 2?
        beq z32         ; Sí, no afecta
        cmp #$60        ; ¿Agujero de misil?
        beq z32         ; Sí, no afecta
        cpy #0
        bne z34a
        jsr inicia_explosion_sprite
        jmp z32c

z34a:   lda nivel
        lsr
        lda offset1,x   ; Toma sprite
        bcc z38
        cmp #$b8        ; ¿Electricidad, pared 1/2/3, abismos?
        bcs z37         ; Sí, detiene bala
        cmp #$80        ; ¿Agujero de misil disparando?
        beq z37         ; Sí, detiene bala
        cmp #$70        ; ¿Gasolina?
        bne z38         ; No, salta.
        lda gasolina
        clc
        adc #$0f        ; Más gasolina
        and #$f8
        cmp #$50        ; Limita a diez unidades
        bcc z39
        lda #$50
z39:    sta gasolina
z38:    lda offset1,x   ; Toma sprite
        cmp #$98        ; ¿Misil teledirigido?
        bne z38a
        inc electrico
        ldy electrico
        cpy #5          ; ¿Cinco impactos?
        bne z37         ; No, salta.
z38a:   cmp #$a0        ; ¿Robotote?
        bne z38b
        inc electrico
        ldy electrico
        cpy #10         ; ¿Diez impactos?
        bne z37         ; No, salta.
z38b:   jsr gana_puntos
        lda #$48        ; Convierte en explosión
        sta offset1,x
        lda #sonido_3-base_sonido
        jsr efecto_sonido_prioridad
z37:    ldx #0          ; Desaparece la bala y evita checar otro enemigo
        stx y_bala
        stx x_bala
        ldy #1          ; Restaura Y, ya sabe lo que tiene :)
z32:    dex
        bmi z32b
        jmp z30
z32b:   dey
        bmi z32c
        jmp z44

z32c:

z6:
        ;
        ; Procesa ola de ataque
        ;
        lda nivel
        lsr             ; ¿En espacio?
        bcs z9          ; No, salta.
        inc secuencia
        ldx secuencia
        ldy y_enemigo1
        lda ola
        cmp #$38
        bne z14
        cpx #32
        bcc z17
        dey
        cpy #32
z16:    bne z22
        lda #$3b
        sta ola
        bne z22

z14:    cmp #$39
        bne z15
        cpx #32
        bcc z17
        iny
        cpy #72
        jmp z16

z15:    cmp #$c0        ; Satélite
        bne z20
        dec x_enemigo1
        lda x_enemigo1
        cmp #10
        beq z21
        bne z9

z20:    cmp #$3a
        bne z17
        lda offset1
        cmp #$48
        bcs z17
        tya
        cmp y_jugador
        beq z23
        lda #$fe
        bcs z18
        lda #$01
z18:    adc y_enemigo1
        sta y_enemigo1
z23:    lda x_enemigo1
        cmp x_jugador
        beq z17
        lda #$fe
        bcs z19
        lda #$01
z19:    adc x_enemigo1
        sta x_enemigo1
z17:    dec avance
        lda x_enemigo1
        clc
        adc avance
        cmp #15
        bne z9
z21:    ldy #0
z22:    sty y_enemigo1
        sty y_enemigo2
        sty y_enemigo3
z9:
        ;
        ; Mueve el campo eléctrico
        ;
        lda ye3d1
        beq z41
        ldx electrico
        lda offset1
        sec
        sbc #$c0        ; ¿Pared o abismo?
        cmp #$28
        bcs z42b
z42a:   cpx #3          ; ¿Alcanzó el ancho horizontal?
        bne z42d        ; No, salta.
z42c:   lda ye3d1
        clc
        adc #8
        sta ye3d1
        lda xe3d1
        sbc #16-1
        sta xe3d1
        dex
        bne z42c
        beq z43a

z42d:   inx
        lda ye3d1
        sec
        sbc #8
        sta ye3d1
        lda xe3d1
        clc
        adc #16
        sta xe3d1
        cmp #160        ; ¿Se sale de la pantalla?
        bcs z42c
        bcc z43a

z42b:   lda offset1
        cmp #$b8        ; ¿Electricidad?
        bne z41
        cpx #5          ; ¿Alcanzó el ancho horizontal?
        bne z43         ; No, salta.
z42:    lda ye3d1
        clc
        adc #4
        sta ye3d1
        lda xe3d1
        sbc #8-1
        sta xe3d1
        dex
        bne z42
        beq z43a

z43:    inx
        lda ye3d1
        sec
        sbc #4
        sta ye3d1
        lda xe3d1
        clc
        adc #8
        sta xe3d1
        cmp #160        ; ¿Se sale de la pantalla?
        bcs z42
z43a:   stx electrico
z41:
        ; Sonido de fondo
        ldx offset1
        lda nivel
        lsr             ; ¿En el espacio?
        bcs b11d        ; No, salta.
        lda #sonido_5-base_sonido
        cpx #$c0        ; ¿SatËlite?
        beq b11b
b11d:   lda #sonido_6-base_sonido
        cpx #$98        ; ¿Misil teledirigido?
        beq b11b
        lda #sonido_7-base_sonido
        cpx #$b8        ; ¿Electricidad?
        beq b11b
        lda #sonido_8-base_sonido
        cpx #$a0        ; ¿Robotote?
        beq b11b
        lda #0
b11b:   cmp sonido_fondo
        beq b11c
        sta sonido_fondo
        tax
        inx
        stx sonido_ap2
        lda #0
        sta sonido_d2
b11c:
        lda cuadro
        ;and #$ff       ; ¿256 cuadros? (4 segundos)
        bne b50
        lda nivel
        lsr             ; ¿Espacio?
        bcc b50         ; Sí, no gasta gasolina
        cmp #6
        ldx #-2         ; -2
        bcc b51
        dex             ; -3
        cmp #12
        bcc b51
        dex             ; -4
b51:    txa
        clc
        adc gasolina    ; Resta gasolina
        sta gasolina
        beq b50a        ; ¿Se acabó?
        bpl b50
        lda #0
        sta gasolina
b50a:   jsr inicia_explosion
b50:
        ;
        ; Actualiza el indicador de puntos, se hace hasta
        ; después de haber visualizado el indicador de puntos,
        ; así que puede haber un desfase de un cuadro
        ;
        ldx #0
        ldy #6
ap1:    lda puntos,x
        and #$0f        ; Dígito bajo
        asl             ; Múltiplica por ocho
        asl
        asl
;       clc             ; carry ya está a cero
        adc #letras&$ff
        sta ap_digito,y
        dey
        dey
        lda puntos,x
        inx
        and #$f0        ; Dígito alto
        lsr             ; Deja como dígito bajo multiplicado por ocho
;       clc             ; carry ya está a cero
        adc #letras&$ff
        sta ap_digito,y
        dey
        dey
        bpl ap1
        ;
        ; Actualiza indicador de vidas
        ;
        lda vidas
        bpl av1
        lda #0
av1:    asl
        asl
        asl
;       clc             ; carry ya está a cero
        adc #letras&$ff
        sta ap_digito+10
overscan:
        lda INTIM
        bne overscan
        jsr generico
        jmp bucle

        ;
        ; Limpia la memoria
        ;
inicio2:
        ldx #$ff        ; Carga X con FF...
        txs             ; ...copia a registro de pila.
        lda #0          ; Carga cero en A
limpia_mem:
        sta 0,X         ; Guarda en posición 0 más X
        dex             ; Decrementa X
        bne limpia_mem  ; Continua hasta que X es cero.
        sta SWACNT      ; Permite leer palancas
        sta SWBCNT      ; Permite leer botones
        sty rand
        tsx             ; ldx #$ff
        stx antirebote
;       jmp reinicio    ; Innecesario

        ;
        ; Aquí reinicia el juego después de Game Over
        ;
reinicio:
        ;
        ; Arma cadena de caracteres que forman mi logo
        ;
        lda #(128+letras)&$ff
        ldx #11
lm1:    pha
        lda #(letras+80)>>8
        sta ap_digito,x
        pla
        dex
        sta ap_digito,x
        sec
        sbc #8
        dex
        bpl lm1
        lda #1
        jsr pantalla_en_blanco
        ;
        ; Pantalla de título
        ;
        lda #mensaje_titulo&$ff
        ldy #sonido_0-base_sonido       ; Silencio, ldy #0
        jsr mensaje
        ;
        ; Tacha un caracter para separar puntos y vidas
        ;
        lda #(80+letras)&$ff
        sta ap_digito+8

        ;
        ; Selecciona la dificultad
        ;
        lda SWCHB
        and #$40
        ora #$0f
        sta dificultad
        lda #15         ; Coordenada X mínima (15), X máxima (55)
        sta x_jugador
        lda #0          ; Cero puntos
        sta puntos
        sta puntos+1
        lda #0          ; Nivel inicial
        sta nivel
        lda #4          ; 5 vidas (la actual y cuatro extras)
        sta vidas
        jsr sel_nivel2  ; Carga el nivel
        lda #1
        jsr pantalla_en_blanco

        ;
        ; Bucle principal del juego
        ;
bucle:
        jsr toca_musica
        lda fondo
        sta COLUBK
        lda sonido_frec2
        beq s01e
        lda sonido_control2
        sta AUDC1
        lda sonido_frec2
        and #$1f
        sta AUDF1
        lda sonido_frec2
        jmp s01f

s01e:   lda sonido_control      ; 55
        sta AUDC1               ; 58
        lda sonido_frec         ; 61
        and #$1f                ; 63
        sta AUDF1               ; 66
        lda sonido_frec
s01f:   beq s01d
        rol
        rol
        rol
        ora #$08        ; Suma 8 al volumen
s01d:   sta AUDV1
        lda #$ff
        sta mira
        lda explosion   ; ¿Jugador explotando?
        beq b23a        ; No, salta.
        inc xe3d1       ; Explosión de arriba
        inc xe3d3       ; Explosión de abajo
        ldx ye3d1
        beq mex1
        inx
        cpx #96
        bne mex0
        ldx #0
mex0:   stx ye3d1
mex1:   lda ye3d3
        beq mex2
        dec ye3d3
mex2:   lda ye3d2
        beq mex3
        inc xe3d2       ; Explosión intermedia
        inc xe3d2
        lda xe3d2
        cmp #120
        bcc mex3
        lda #0
        sta ye3d2
mex3:   dec explosion   ; ¿Finalizó explosión?
        bne b23b        ; No, salta.
        dec vidas       ; ¿Aún tiene vidas?
        bpl b23c        ; Sí, salta.
        lda #0
        jsr pantalla_en_blanco
        lda #mensaje_final&$ff
        ldy #sonido_9-base_sonido
        jsr mensaje     ; GAME OVER
        jmp reinicio

b23c:   lda lector      ; Obtiene punto de inicio actual
        sta offset0temp
        jsr sel_nivel2  ; Reinicia el nivel
        lda offset0temp
        sec
        sbc lector      ; Verifica avance
        cmp #24         ; ¿Más de la mitad del nivel?
        bcc b23b        ; No, salta.
        ldx #24         ; Sí, inicia a medio nivel
b23g:   jsr adelanta_lector
        dex
        bne b23g
b23b:   jmp b001

b23a:

        ; Agrega elementos según el nivel
        lda nivel
        lsr
        bcs b23
        jmp b10

        ;
        ; Fortaleza: enemigos fijos
        ;
b23:    lda tiempo
        cmp #25         ; ¿Agrega un adorno?
        bne b23d        ; No, salta.
        lda offset1
        cmp #$60
        beq b23d
        cmp #$88        ; ¿es $88,$98,$a0,$b8,$c0,$c8,$d0,$d8 o $e0?
        bcs b23d        ; Sí, evita poner adorno.
        lda ye3d0
        bne b23d
b23e:   lda #150
        sta xe3d0
        lda #96
        sta ye3d0
        lda #$e0        ; Adorno 1
        ldx rand
        bpl b23f
        lda #$b0        ; Adorno 2
b23f:   sta offset0
b23d:   dec tiempo      ; ¿Tiempo de poner otro enemigo?
        beq b61         ; Sí, salta.
        jmp b12         ; No, desplaza los actuales

b61:    ldy #0
        lda (lector),y
        beq b28         ; Salta si es el final del nivel
        and #$f8
        cmp #$e8        ; ¿Adorno de nivel?
        beq b60
        cmp #$90        ; ¿Alienígena, misil, robotote $a0 o electricidad $b8?
                        ; ¿Pared $c0,$c8,$d0,$d8 o $e0?
        bcc b60         ; No, salta.
b28:    lda ye3d1
        ora ye3d2
        ora ye3d3       ; ¿Ya desapareció todo?
        beq b28c        ; No, espera un poco más
        jmp b27

b28c:   ldx #8
        lda (lector),y
        bne b61a        ; Salta si no es el final del nivel
        jsr adelanta_nivel
        jmp b25

b61a:   and #$f8
        cmp #$c0
        bcc b28e
        cmp #$e8
        bcc b28d
b28e:   cmp #$b8        ; ¿Electricidad?
        beq b28b
        cmp #$a0        ; ¿Robotote?
        bne b28a
        lda #$27        ; Usa un sprite más gordo
        sta NUSIZ1      ; Tamaño de Player/Missile 1
        sta nucita
        ldx #16
        .byte $ad       ; LDA para brincar siguientes dos bytes
b28b:   ldx #24         ; Largo del sprite (triple)
b28a:   stx largo_sprite
        jmp b26

b28d:   lda #$25        ; Vuelve a tam. 2x (requerido luego de robotote)
        sta NUSIZ1      ; Tamaño de Player/Missile 1
        sta nucita
        ldx #56         ; Largo del sprite: todo el espacio vertical :)
        bne b28a

b60:    lda ye3d1
        beq b26c
        lda offset1
        cmp #$88        ; ¿Hay un misil vertical activo?
        beq b27         ; Sí, espera que termine antes de poner otra cosa
        cmp #$60        ; ¿Hay un agujero de misil?
        bne b26a        ; No, salta.
        lda electrico   ; ¿Ya disparó?
        bne b26
        ;
        ; Para reducir vacíos del área de juego en ciertas ocasiones
        ; dispara al llegar al centro.
        ;
        lda rand
        asl
        asl
        lda #80         ; Centro de la pantalla
        bcs b26d
        ;
        ; Pequeña ecuación para atinarle al jugador si pasa por encima :>
        ;
        lda yj3d
        sec
        sbc ye3d1
        bcs b26b
        lda #0
b26b:   asl
        clc
        adc x_jugador
b26d:   cmp xe3d1
        bcc b27
        jsr insercion
        adc #8          ; carry es 1, 9 pixeles mínimo entre sprites
        sta ye3d1
        lda #sonido_4-base_sonido
        jsr efecto_sonido_prioridad
        lda #$88        ; Misil vertical
        sta offset1
        lda #$80        ; Agujero disparando
        sta offset2
        bne b27

b26a:   cmp #$e8        ; ¿Adorno de piso?
        beq b26c
        cmp #$98        ; ¿Hay misil teledirigido, robotote $a0 o campo $b8?
        bcs b27         ; Sí, salta a esperar
b26c:   ldx #8
        stx largo_sprite
b26:    lda (lector),y
        and #$07
        tax
        lda offset_y,x
        sec
        sbc #10         ; Tolerancia
        cmp ye3d1       ; Se asegura de que la coordenada Y es aceptable
        bcs b20
b27:    inc tiempo      ; Espera un poco más
b22:    jmp b12

b20:    jsr insercion
        ldy #0
        sty electrico
        lda (lector),y
        and #$f8
        sta offset1
        ldx #150
        cmp #$a0        ; ¿Robotote?
        bne b20a
        ldx #140
b20a:   stx xe3d1
        stx avance      ; Para calcular pared "cercana"
        ldx #5
        cmp #$e8        ; ¿Adorno de piso?
        beq b20b
        lda rand
        and #4
        adc #40
        tax
b20b:   stx tiempo
        lda (lector),y
        and #$07
        tax
        lda offset_y,x
        sta ola         ; Para referencia campo eléctrico
        sta ye3d1
        jsr adelanta_lector
        ;
        ; Desplaza los elementos de la fortaleza para efecto de scrolling
        ;
b12:    ldx #0
        stx xj3d
        ldx #$fc        ; Ajuste Y de bala para alienígena
        ldy #32         ; Nivel con respecto al piso para posible bala
        lda offset1
        cmp #$90        ; ¿Alienígena?
        beq b12g        ; Sí, salta.
        inc xj3d        ; Ajuste Y del misil teledirigido
        inc xj3d        ; Ajuste Y del misil teledirigido
        cmp #$98        ; ¿Misil teledirigido?
        beq b12b        ; Sí, salta
        ldx #$f3        ; Ajuste Y de bala para robotote
        ldy y_jugador   ; Nivel idéntico al del jugador para posible bala
        cmp #$a0        ; ¿Robotote?
        bne b12a        ; No, salta
b12g:   lda xe3d1
        cmp #140        ; ¿Recién salido?
        bcs b12d        ; Sí, salta, debe centrarlo
        lda x_bala2     ; ¿Bala activa?
        bne b12d        ; Sí, salta
        sta bala_der
        lda rand
        cmp dificultad  ; ¿Tiempo de disparar?
        bcs b12d        ; No, salta.
        txa
        adc ye3d1
        sta y_bala2
        lda xe3d1
        jsr efecto_disparo
b12d:   lda offset1
        cmp #$90
        beq b12b
        lda cuadro
        lsr             ; El robotote sólo se mueve cada dos cuadros
        bcc b12c
        ldx #8
        stx xj3d
        ;
        ; Robotote y misil teledirigido siguen al jugador
        ;
b12b:   lda xe3d1
        cmp #16         ; ¿Llegó al borde de la pantalla?
        bne b14a
        lda #0          ; Desaparece
        sta ye3d1
        jmp b25

b14a:   dec xe3d1
        sbc x_jugador
        bpl b14b
        lda #0
b14b:   lsr
        lsr
        clc
        adc yj3d
        adc xj3d        ; Corrección robotote
        tax
        lda offset1
        cmp #$90        ; ¿Alienígena?
        bne b12f
        lda #32         ; Sí, lleva al piso
        sbc y_jugador
        sta xj3d
        txa
        clc
        adc xj3d
        tax
b12f:   txa
        cmp #96         ; Limita a la pantalla visible
        bcc b12e
        lda #96
b12e:   sta ye3d1
b12c:   jmp b25

        ;
        ; Desplaza los elementos fijos por el piso
        ;
b12a:
        ; Para ajustar coordenadas de agujeros en la pared
;        lda avance
;        cmp #22
;        beq b24e

        dec avance
        ldx #0
b15:    lda ye3d0,x     ; ¿Elemento activo?
        beq b24         ; No, salta.
        dec xe3d0,x
        lda xe3d0,x
        cmp #16
        bcs b14
        lda #16
        sta xe3d0,x
        lda #0
        sta ye3d0,x
b14:    and #3
        cmp #3
        bne b17
        dec ye3d0,x
b17:    lda x_bala2     ; ¿Bala activa?
        bne b24         ; Sí, salta
        sta bala_der
        lda rand
        cmp dificultad  ; ¿Tiempo de disparar?
        bcs b24         ; No, salta.
        lda offset0,x
        cmp #$40        ; ¿Avión chico?
        beq b17a
        cmp #$68        ; ¿Cañón mirando a jugador?
        beq b17a
        cmp #$50        ; ¿Cañón mirando a derecha?
        bne b24         ; No, salta.
        lda rand
        lsr
        bcs b17b
        inc bala_der    ; Dispara una bala a la derecha
        bne b17a

b17b:   lda #$68        ; Gira cañón
        sta offset0,x
b17a:   lda ye3d0,x
        sec
        sbc #7
        sta y_bala2
        lda offset0,x
        sec
        sbc #$50
        beq b17c
        lda #$f8
b17c:   clc
        adc xe3d0,x
        adc #8
        ldy #32
        jsr efecto_disparo
b24:
        inx
        cpx #4
        bne b15

b24e:   lda offset1
        cmp #$88        ; ¿Misil vertical?
        bne b24a
        lda cuadro
        lsr             ; Se alza un pixel cada dos cuadros
        bcs b24a
        lda ye3d1
        beq b24c        ; ¿Salió de la pantalla?
        inc ye3d1
        sec
        sbc ye3d2
        cmp #24
        bcc b24d
        lda #$60        ; Fin de fuego en agujero de misil
        sta offset2
b24d:   lda ye3d1
        cmp #97
        bne b24a
b24c:   lda #1
        sta electrico   ; Ya disparó
        ldx #0          ; Elimina el misil de la lista visible
b24b:   lda ye3d2,x
        sta ye3d1,x
        lda xe3d2,x
        sta xe3d1,x
        lda offset2,x
        sta offset1,x
        inx
        cpx #2
        bne b24b
b24a:   jmp b25

        ; Espacio exterior
b10:
        dec tiempo
        bne b37a
        lda y_enemigo1
        ora y_enemigo2
        ora y_enemigo3  ; ¿Aún hay enemigos activos?
        bne b37
        tay             ; ldy #0
        lda (lector),y
        bne b31         ; Salta si no es el final del nivel
        jsr adelanta_nivel
        jmp b25

b37:    inc tiempo
b37a:   jmp b38

b31:    sta ola
        jsr adelanta_lector
        ldx #0
        stx secuencia
        stx proximo
        ldx #8
        stx largo_sprite
        cmp #$e8        ; Planetoide
        bcs b36a
        cmp #$c0        ; ¿Satélite?
        beq b36
        ldx #35         ; Enemigo solitario por el centro
        cmp #$3a
        bcc b32
        beq b34
        cmp #$3c
        beq b34
        ldx #15         ; Enemigo solitario por la izquierda
        cmp #$3d
        bne b34
        ldx #55         ; Enemigo solitario por la derecha
b34:    stx x_enemigo1
        lda (lector),y
        jsr adelanta_lector
        tay
        ldx #$40
        lda #96
        bne b35

b36a:   ldx #15         ; Planetoide 1
        stx x_enemigo1
        ldx #35         ; Planetoide 2
        stx x_enemigo2
        lsr
        ldy #50
        ldx #12
        bcs b36b        ; Alternativa de posición
        ldy #72
        ldx #32
b36b:   stx y_enemigo2
        lda #96
        ldx #$f8
        stx offset2
        ldx #$f0
        bne b35a

b36:    tax             ; Satélite
        lda #105
        sta x_enemigo1
        ldy #72
        lda #16         ; Más largo que los otros sprites
        sta largo_sprite
        lda #48
        bne b35

b32:    lda #15         ; Tres enemigos
        sta x_enemigo1
        stx x_enemigo2
        lda #55
        sta x_enemigo3
        ldy #72
        lda ola
        cmp #$38
        beq b33
        ldy #32
b33:    sty y_enemigo2
        sty y_enemigo3
        ldx #$40
        lda #125
b35:    stx offset2
b35a:   stx offset1
        stx offset3
        sty y_enemigo1
        sta avance
        lda #50
        sta tiempo

b38:
        ;
        ; Posiciona los enemigos
        ;
        ldx #0
        ldy #0
        lda avance
        pha             ; Corrimiento a la derecha con signo (2 veces)
        rol
        pla
        ror
        pha
        rol
        pla
        ror
        sta xj3d
b6:     lda x_enemigo1,y
        lsr
        sta xe3d1,x
        lda y_enemigo1,y
        beq b6c
        clc
        adc #7          ; Sólo suma 7 para evitar tener que usar sec
        sbc xe3d1,x
        sec
        adc xj3d
        sta ye3d1,x
        beq b6c
        cmp #97         ; ¿Invisible?
        bcs b6c
        lda x_enemigo1,y
;       clc             ; La condición lo permite
        adc avance
        sta xe3d1,x
        cmp #150        ; ¿Invisible?
        bcc b6d         ; Nota: si se pone 151 se "traga" un scanline de más
b6c:    jmp b5
b6d:
        ;
        ; Verifica si pone "mira"
        ;
        lda offset1,x
        cmp #$c0
        beq mr4
        cmp #$48
        bcs mr1
        lda avance
        cmp #160
        bcs mr0
        cmp #50
        bcc mr0
mr4:    lda cuadro
        lsr
        bcs mr0         ; Debe ser bcs o va a tratar de disparar siendo mira
        lda dificultad
        rol             ; ¿Máxima dificultad?
        bmi mr0         ; Sí, salta.
        lda y_enemigo1,y
        sec
        sbc y_jugador
        clc
        adc #2
        cmp #5
        bcs mr0
        lda x_enemigo1,y
        sec
        sbc x_jugador
        clc
        adc #3
        cmp #7
        bcs mr0
        stx mira        ; Depende de que no haya un avión detrás del otro
        lda offset1,x
        sta mira_off    ; Para restaurar
        cmp #$c0        ; ¿Satélite?
        lda #$d0
        bcs mr3         ; Sí, salta (usa mirilla de 16 líneas)
        lda #$d8        ; No, usa mirilla de 8 líneas
mr3:    sta offset1,x
        lda xe3d1,x
        sta mira_x
        lda x_jugador
        clc
        adc #32
        sta xe3d1,x
        lda ye3d1,x
        sta mira_y
        lda yj3d
        adc #8
        sta ye3d1,x
        lda #1          ; Sonido para mirilla
        sta AUDC1
        sta AUDF1
        lda #15
        sta AUDV1
        bne b8

mr0:    lda offset1,x
mr1:    cmp #$48
        bcs b8
b7:     lda y_enemigo1,y
        cmp #48
        lda #$40
        bcc b4
        lda y_enemigo1,y
        cmp #64
        lda #$38
        bcc b4
        lda #$30
b4:     sta offset1,x
        lda x_bala2     ; ¿Bala activa?
        bne b8
        sta bala_der
        lda rand
        cmp dificultad  ; ¿Tiempo de disparar?
        bcs b8
        cpy proximo     ; ¿Es el avión que debe disparar?
        bne b8
        lda ye3d1,x
        sec
        sbc #7
        sta y_bala2
        lda y_enemigo1
        sta nivel_bala2
        lda xe3d1,x
        jsr efecto_disparo2
        lda ola
        cmp #$3b        ; ¿Aviones después de bajar/subir?
        beq b8a
        cmp #$3a        ; ¿Ola de avión simple?
        bcs b8          ; Sí, salta.
b8a:    inc proximo
        lda proximo
        cmp #3
        bne b8
        lda #0
        sta proximo
b8:     inx
b5:     iny
        cpy #3
        beq b3
        jmp b6

b3:     lda #0
b3b:    sta ye3d1,x
        inx
        cpx #4
        bne b3b

        ; Efecto de sonido según altitud de la nave
b25:    lda #72
        sec
        sbc y_jugador
        lsr
        lsr
        adc #7
        sta AUDF0
        lda #8
        sta AUDC0
        lda #5
        sta AUDV0
        ; Cambio de tamaño de la nave del jugador
        ldx #16
        lda y_jugador
        cmp #48
        bcc b1
        ldx #8
        cmp #64
        bcc b1
        ldx #0
b1:     stx offset9
        ; Posicionamiento player 0 (nave)
        lda x_jugador
        lsr
        sta xj3d
        lda y_jugador
        clc
        adc #7                  ; Sólo suma 7 para evitar tener que usar sec
        sbc xj3d
        sta yj3d
        lda nivel
        lsr                     ; ¿Nivel en el espacio?
        bcc b01                 ; Salta, nunca pone sombra
        lda #31
        ldx offset9
        cpx #16
        bne b00
        lda #30
b00:    clc
        adc #7                  ; Sólo suma 7 para evitar tener que usar sec
        sbc xj3d
        sta yj3d2               ; Coordenada Y de la sombra
        sbc yj3d
        cmp #$fa                ; ¿Se sobrepone con nave?
        bcc b002                ; No, salta.
b01:    lda #0                  ; Sí, anula sombra.
b0:     sta yj3d2
b002:   lda offset9
        clc
        adc ajuste_nave
        sta offset9
b001:
        ; Parpadeo de explosiones
        lda cuadro
        and #3          ; Cada cuatro cuadros
        bne b43
        ldx #4
b40:    lda offset9,x
        cmp #$48        ; Intercambia entre $48 y $58
        beq b41
        cmp #$58
        bne b42
b41:    eor #$10        ; Con esto basta
        sta offset9,x
b42:    dex
        bpl b40
b43:
        ;
        ; Manejo de paredes y abismos
        ;
        lda COLOR_BALA
        sta color_grande
        ldx #4
c03:    lda offset9,x
        sta offset9temp,x
        cmp #$78        ; Antena
        bne c04
        lda cuadro
        lsr
        lsr
        lsr
        lsr
        and #$07
        tay
        lda antena,y    ; La antena de satélite gira la cabeza
        sta offset9,x
c04:    dex
        bpl c03
        lda ye3d1
        sta ye3dtemp
        lda largo_sprite
        sta largotemp
        lda #0          ; Kernel de 5 sprites
        sta kernel
        lda explosion
        bne c01
        lda nivel
        lsr             ; ¿En el espacio?
        bcc c01         ; Sí, salta
        lda offset1
        cmp #$b8        ; ¿Electricidad?
        beq c05
        sec
        sbc #$c0        ; ¿Es una pared?
        bcc c01
        cmp #$28
        bcs c01         ; No, salta.
        lsr
        lsr
        lsr
        adc #$d8        ; <<< Es una posición en memoria <<<
        sta bitmap+1
        cmp #$db
        bcc c02
        lda #0          ; Color negro para abismos
        sta color_grande
c02:    lda electrico
        lsr
        ror
        ror
c06:    sta offset1     ; Traslado de número de sprite
        lda #96
        sta kernel      ; Kernel de 3 sprites (uno largo)
        clc
        sbc ye3d1       ; ¿Necesita recorte vertical?
        bpl c01
        adc largo_sprite
        sta largo_sprite
        lda #96
        sta ye3d1
c01:    jmp b11

c05:    lda #$d7        ; <<< Es una posición de memoria <<<
        sta bitmap+1
        lda #$00
        beq c06

        ;
        ; Inserción de nuevo sprite
        ;
insercion:
        ldx #1
in0:    lda offset1,x
        sta offset2,x
        lda xe3d1,x
        sta xe3d2,x
        lda ye3d1,x
        sta ye3d2,x
        dex
        bpl in0
        rts

        ; Efecto de disparo enemigo
efecto_disparo:
        sty nivel_bala2
efecto_disparo2:
        sta x_bala2
        lda #sonido_2-base_sonido
        ; Pone un efecto de sonido
efecto_sonido:
        pha
        lda sonido_efecto
        cmp #sonido_3-base_sonido       ; ¿Hay explosión o lanzamiento?
        pla
        bcs es1
efecto_sonido_prioridad:
        sta sonido_efecto
        sta sonido_ap1
        inc sonido_ap1
        lda #0
        sta sonido_d1
es1:    rts

        ;
        ; Gana puntos por destruir un enemigo
        ;
gana_puntos:
        lda nivel
        lsr                     ; ¿Espacio?
        lda offset1,x           ; Este valor siempre es un múltiplo de 8
        bcc gp3                 ; Sí, salta.
        cmp #$c0                ; ¿Pared?
        bcs gp4                 ; Sí, retorna.
gp3:    sec
        sbc #64
        bcs gp2
        lda #0
gp2:    tay
        lda letras+7,y          ; Indexa en puntuación
        sed
        clc
        adc puntos
        sta puntos
        lda puntos+1
        adc #0
        bcc gp1
        lda #$99
        sta puntos
gp1:    cld
        cmp puntos+1            ; ¿Cambio de centenas?
        beq gp4                 ; No, salta
        sta puntos+1
        lsr                     ; ¿200 puntos extras?
        bcs gp4
        lda vidas
        cmp #9                  ; ¿Vidas limitadas?
        beq gp4
        inc vidas               ; No, incrementa
gp4:    rts

        ;
        ; Selecciona el siguiente nivel e incrementa la dificultad
        ;
adelanta_nivel:
        lda dificultad
        clc
        adc #4
        bpl an1
        lda #$7f
an1:    sta dificultad
        inc nivel
        bcc sel_nivel

        ;
        ; Tabla que apunta a los ocho niveles del juego
        ;
niveles:
        .word espacio_1
        .word fortaleza_1
        .word espacio_2
        .word fortaleza_2
        .word espacio_3
        .word fortaleza_3
        .word espacio_4
        .word fortaleza_4

        ;
        ; Inicio de nivel cuando el jugador acaba de ser destruido
        ;
sel_nivel2:
        lda #$50        ; Valor 5.3
        sta gasolina
        lda #72         ; El jugador empieza arriba
        sta y_jugador   ; Coordenada Y mínima (72), Y máxima (32)
        ;
        ; Inicio de nivel
        ;
sel_nivel:
        lda nivel
        and #7
        asl
        tax
        lda niveles,x
        sta lector
        lda niveles+1,x
        sta lector+1
        lda #0
        ldx #2
sn6:    sta ola,x
        ;sta secuencia
        ;sta explosion
        sta ye3d1,x
        ;sta ye3d2
        ;sta ye3d3
        sta y_enemigo1,x
        ;sta y_enemigo2
        ;sta y_enemigo3
        sta sonido_efecto,x
        ;sta sonido_fondo
        ;sta sonido_ap1
        dex
        bpl sn6
        sta ye3d0
        sta sonido_ap2
        lda #10
        sta tiempo
        ldx #COLOR_ESPACIO      ; Espacio
        lda nivel
        lsr
        bcc sn5
        ldx #COLOR_FORTALEZA    ; Fortaleza
        lsr
        lsr
        bcc sn5
        ldx #COLOR_FORTALEZA2   ; Fortaleza
sn5:    stx fondo       ; Color de fondo
        lda #$25
        sta NUSIZ0      ; Tamaño de Player/Missile 0
        sta NUSIZ1      ; Tamaño de Player/Missile 1
        sta nucita
        ldx #8
        stx largo_sprite
        rts

        ;
        ; Muestra mensaje hasta que se oprime un botón
        ;
mensaje:
        ldx #mensaje_final>>8
        sta lector
        stx lector+1
        sty sonido_efecto
        iny
        sty sonido_ap1
        lda #0
        sta sonido_d1
        sta sonido_d2
        dey
        beq me14
        ldy #sonido_10-base_sonido
me14:   sty sonido_fondo
        iny
        sty sonido_ap2
        lda #32
        sta ola
me0:    ; VERTICAL_SYNC
        jsr toca_musica
        lda sonido_control2
        sta AUDC0
        lda sonido_frec2
        and #$1f
        sta AUDF0
        lda sonido_frec2
        beq me11
        rol
        rol
        rol
        ora #$08        ; Suma 8 al volumen
me11:   sta AUDV0
        lda sonido_control      ; 55
        sta AUDC1               ; 58
        lda sonido_frec         ; 61
        and #$1f                ; 63
        sta AUDF1               ; 66
        lda sonido_frec
        beq me12
        rol
        rol
        rol
        ora #$08        ; Suma 8 al volumen
me12:   sta AUDV1
        ;
        ; Inicio de gráficas
        ;
        ; Asume inicialización previa (inicio del juego)
        ; o que se llamó muestra_puntos (deja vars. iniciadas)
        ;
        lda cuadro
        lsr
        tax
        and #$10
        bne me3
        txa
        eor #$0e
        tax
me3:    txa
        and #$0e
        ora #COLOR_TITULO
        sta COLUP0
        eor #$0e
        sta COLUP1
        lda #$02
        sta CTRLPF
me1:
        lda INTIM
        bne me1
        tay
        sta VBLANK
        ldx #53
me4:    sta WSYNC
        dex
        bne me4
        ;
        ; Visualiza mensaje
        ;
me2:    sta WSYNC
        lda (lector),y
        sta PF0
        iny
        lda (lector),y
        sta PF1
        iny
        lda (lector),y
        sta PF2
        iny
        ldx #7
me6:    sta WSYNC
        dex
        bne me6
        cpy #33
        bne me2
        lda #0
        sta PF0
        sta PF1
        sta PF2
        ldx #53
me5:    sta WSYNC
        dex
        bne me5
        ;
        ;
        ;
        jsr muestra_puntos
        ;
        ; Fin de gráficas (200 líneas)
        ;
me7:    lda INTIM
        bne me7
        lda ola
        beq me9
        dec ola
        sta WSYNC
me10:   jmp me0

me9:    jsr generico
        jsr boton_disparo       ; ¿Botón oprimido?
        bpl me10
        jmp toca_musica

        ;
        ; Adelanta lector de nivel
        ;
adelanta_lector:
        inc lector
        bne al1
        inc lector+1
al1:    rts

        ;
        ; Obtiene botón de disparo.
        ; Se asegura de que el jugador no puede dejar oprimido el botón :>
        ;
boton_disparo:
        lda INPT4
        eor #$ff
        tax
        eor antirebote
        stx antirebote
        bpl bd1
        txa
bd1:    rts

        ; Servicio genérico
generico:
        sta WSYNC
        sta CXCLR       ; Limpia colisiones
        lda SWCHB
        lsr             ; ¿Reset?
        bcs bd1
        ldx #$ff
        txs
        jsr toca_musica
        jmp reinicio

        ;
        ; Visualiza puntuación, vidas y gasolina (sub-kernel)
        ; >>> EL NUCLEO DEBE CABER EN UNA PÁGINA DE 256 BYTES <<<
        ; >>> COMPROBAR CHECANDO EL ARCHIVO LST GENERADO POR DASM <<<
        ;
muestra_puntos:
        lda #1          ; 34
        sta CTRLPF      ; 37
        ldx #0          ; 39
        stx ENABL       ; 42
        stx GRP0        ; 45
        stx GRP1        ; 48
        stx ENAM0       ; 51
        stx ENAM1       ; 54
        lda #COLOR_GASOLINA      ; 56
        sta COLUPF      ; 59
        lda gasolina    ; 62
        clc             ; 64
        adc #7          ; 66
        lsr             ; 68
        lsr             ; 70
        sta WSYNC       ; 73
        sta HMOVE       ; 3
        stx COLUBK      ; 6
        lsr             ; 8
        tax             ; 10
        lda gas1,x      ; 14
        sta PF0         ; 17
        lda gas2,x      ; 21
        sta PF1         ; 24
        lda #COLOR_PUNTOS       ; 26
        sta COLUP0      ; 29
        sta COLUP1      ; 32
        lda #$03        ; 34    3 copias juntas
        ldx #$f0        ; 36
;
;       El código anterior reemplazó este código
;       ldx #6          ;
;       sta WSYNC       ;
;mp2:   dex             ; 2  7  12 17 22 27 32
;       bpl mp2         ; 5  10 15 20 25 30 34
;       nop             ; 36
;
        stx RESP0       ; 39
        stx RESP1       ; 42
        stx HMP0        ; 45
        sta NUSIZ0      ; 48
        sta NUSIZ1      ; 51
        lsr             ; 53
        sta VDELP0      ; 56
        sta VDELP1      ; 59
        sta WSYNC       ; 62
        sta HMOVE               ; 3
        lda #6
        sta linea_doble
mp1:    ldy linea_doble         ; 2
        lda (ap_digito),y       ; 7
        sta GRP0                ; 10
        sta WSYNC               ; 13 + 61 = 76
        lda (ap_digito+2),y     ; 5
        sta GRP1                ; 8
        lda (ap_digito+4),y     ; 13
        sta GRP0                ; 16
        lda (ap_digito+6),y     ; 21
        sta linea_jugador       ; 24
        lda (ap_digito+8),y     ; 29
        tax                     ; 31
        lda (ap_digito+10),y    ; 36
        tay                     ; 38
        lda linea_jugador       ; 41
        sta GRP1                ; 44
        stx GRP0                ; 47
        sty GRP1                ; 50
        sta GRP0                ; 53
        dec linea_doble         ; 58
        bpl mp1                 ; 60/61
mp3:
        ; Detecta código dividido entre dos páginas (usa un ciclo más)
        if (mp1&$ff00)!=(mp3&$ff00)
        lda megabug3    ; :P
        endif

        ldy #0                  ; 63
        sty VDELP0              ; 66
        sty VDELP1              ; 69

    if NTSC=1
        ldx #(21*76-14)/64
    else
        ldx #(46*76-14)/64
    endif
        lda #2
        sta WSYNC
        sta VBLANK              ; 3 Comienza VBLANK
        stx TIM64T              ; 6
        lda #$25                ; 8
        sta NUSIZ0              ; 11 Tamaño de Player/Missile 0
        lda nucita              ; 13
        sta NUSIZ1              ; 16 Tamaño de Player/Missile 1
        inc cuadro              ; 21
        ;
        ; Generador de números bien aleatorios :P
        ;
        lda rand                ; 24
        sec                     ; 26
        ror                     ; 28
        eor cuadro              ; 31
        ror                     ; 33
        eor rand                ; 36
        ror                     ; 38
        eor #9                  ; 40
        sta rand                ; 43
        sty PF1                 ; 46
        sty PF0                 ; 49
        sty GRP1                ; 52
        sty GRP0                ; 55
        rts                     ; 61

        ;
        ; Inicia explosión
        ;
inicia_explosion_sprite:
        jsr gana_puntos
inicia_explosion:
        ldx #3
ie1:    lda x_jugador
        sta xe3d0,x
        lda #$48
        sta offset0,x
        dex
        bne ie1
        sta offset9
        stx AUDV0       ; Quita sonido de motor
        stx x_bala
        stx y_bala
        stx x_bala2
        stx y_bala2
        stx yj3d2       ; Quita sombra
        stx ye3d0       ; Quita adorno
        lda yj3d
        sta ye3d2
        clc
        adc #8
        sta ye3d1
        sbc #15
        sta ye3d3
        lda #60         ; Duración de la explosión en cuadros
        sta explosion
        lda #8
        sta largo_sprite
        lda #sonido_3-base_sonido
        jmp efecto_sonido_prioridad

        ;
        ; Inicia sincronía vertical y ejecuta minireproductor de música
        ; (toma los datos de música y los anota para que otras rutinas
        ; los pongan en el audio)
        ;
toca_musica:
        ; VERTICAL_SYNC
        lda #2
        sta VSYNC       ; Inicia sincronía vertical
        sta WSYNC       ; 3 líneas de espera
        ldy sonido_fondo        ; 3
        beq s02d                ; 5
        dec sonido_d2           ; 10
        bpl s02c                ; 12
        ldx sonido_ap2          ; 15
        lda base_sonido,x       ; 19
        bne s02a                ; 21
        cpy #sonido_10-base_sonido      ; 23
        bne s02e                ; 26
        sta sonido_fondo
        tay
        beq s02d

s02e:   ldx sonido_fondo        ; 29
        inx                     ; 31
        lda base_sonido,x       ; 35
s02a:   sta sonido_d2           ; 38
        inx                     ; 40
        lda base_sonido,x       ; 44
        sta sonido_f2           ; 47
        inx                     ; 49
        stx sonido_ap2          ; 52
s02c:   lda base_sonido,y       ; 56
        sta sonido_control      ; 59
        ldy sonido_f2           ; 62
s02d:   sty sonido_frec         ; 65

s03:    sta WSYNC

        ldy sonido_efecto       ; 3
        beq s01                 ; 5
        dec sonido_d1           ; 10
        bpl s01b                ; 12
        ldx sonido_ap1          ; 15
        lda base_sonido,x       ; 19
        bne s01a                ; 22
        sta sonido_efecto
        tay
        beq s01

s01a:   sta sonido_d1           ; 25
        inx                     ; 27
        lda base_sonido,x       ; 31
        sta sonido_f1           ; 34
        inx                     ; 36
        stx sonido_ap1          ; 39
s01b:   lda base_sonido,y       ; 43
        sta sonido_control2     ; 46
        ldy sonido_f1           ; 49
s01:    sty sonido_frec2        ; 52
    if NTSC=1
        ldx #(37*76-14)/64
    else
        ldx #(62*76-14)/64
    endif
        lda #0
        sta WSYNC
        sta VSYNC       ; Detiene sincronía vertical
        ;
        stx TIM64T
        sta linea_jugador
        sta linea_doble
        rts

        ;
        ; Completa una pantalla en blanco para antes de Game Over
        ;
pantalla_en_blanco:
        clc
        adc #193
        tay
        ;
        ; Inicio de gráficas
        ;
espera_vblank:
        lda INTIM
        bne espera_vblank
        sta HMCLR               ; Evita movimiento posterior

        ;
        ; Inicia núcleo gráfico
        ;
;       lda #0          ; Innecesario
pan0:
        sta WSYNC
        sta HMOVE       ; 3
        sta VBLANK              ; Sale de VBLANK
        dey
        bne pan0
        jsr muestra_puntos
overscan2:
        lda INTIM
        bne overscan2
        jmp generico

        org $fcfe

        ; Espacio 1
espacio_1:
        .byte $f0       ; Planetoide
        .byte $38       ; Tres aviones por arriba
        .byte $39       ; Tres aviones por abajo
        .byte $3a,52    ; Avión loquito
        .byte $3b,72    ; Un avión a la vez
        .byte $3c,52    ; Un avión a la vez
        .byte $3d,32    ; Un avión a la vez
        .byte $c0       ; Satélite
        .byte $39       ; Tres aviones por abajo
        .byte $3b,32    ; Un avión a la vez
        .byte $3c,52    ; Un avión a la vez
        .byte $3d,72    ; Un avión a la vez
        .byte $38       ; Tres aviones por arriba
        .byte $3a,52    ; Avión loquito
        .byte $00       ; Fin de nivel

        ; En espacio:
        ; Satélite = $C0      10
        ; Avión grande = $30   3
        ; Avión medio = $38    3
        ;
        ; En fortaleza:
        ; Avión chico = $40    3
        ; Cañón girado = $50   2
        ; Agujero de misil = $60
        ; Cañón = $68          2
        ; Combustible = $70    2
        ; Antena = $78         2
        ; Alienígena = $90     3
        ; Misil = $98          5
        ; Robotote = $A0      25
        ; Electricidad = $B8
        ; Pared con agujero amplio = $c6
        ; Pared con agujero en col. 1 = $ce
        ; Pared con agujero en col. 2 = $d6
        ; Abismo de entrada = $df
        ; Abismo de salida = $e7
        ; Adorno de piso = $e8, sólo inmediatamente previo a $60
        ;
        ; bits 0-2 componen indice en tabla de coordenada (posición X 3D)

        ; Fortaleza 1 (46 bytes + 1 final)
fortaleza_1:
        .byte $df
        .byte $d6
        .byte $70
        .byte $71
        .byte $6b
        .byte $e9
        .byte $62
        .byte $e8
        .byte $63
        .byte $79
        .byte $68
        .byte $53
        .byte $e8
        .byte $61
        .byte $e8
        .byte $62
        .byte $70
        .byte $6a
        .byte $ea
        .byte $63
        .byte $79
        .byte $60
        .byte $ea
        .byte $63
        .byte $52
        .byte $72
        .byte $61
        .byte $6a
        .byte $78
        .byte $bc    ; Electricidad
        .byte $9b    ; Misil
        .byte $70
        .byte $73
        .byte $73
        .byte $79
        .byte $93    ; Alienígena
        .byte $6a
        .byte $51
        .byte $6b
        .byte $71
        .byte $60
        .byte $62
        .byte $78
        .byte $62
        .byte $c6
        .byte $e6
        .byte $00    ; Fin de nivel

        ; Espacio 2
espacio_2:
        .byte $f1       ; Planetoide
        .byte $3a,32    ; Avión loquito
        .byte $c0       ; Satélite
        .byte $3b,52    ; Un avión a la vez
        .byte $3c,52    ; Un avión a la vez
        .byte $3d,52    ; Un avión a la vez
        .byte $38       ; Tres aviones por arriba
        .byte $3a,72    ; Avión loquito
        .byte $39       ; Tres aviones por abajo
        .byte $3b,72    ; Un avión a la vez
        .byte $3c,52    ; Un avión a la vez
        .byte $3d,72    ; Un avión a la vez
        .byte $c0       ; Satélite
        .byte $39       ; Tres aviones por abajo
        .byte $3a,52    ; Avión loquito
        .byte $00       ; Fin de nivel y alineación

        ; Fortaleza 2 (48 bytes + 1 final)
fortaleza_2:
        .byte $df
        .byte $ce
        .byte $42
        .byte $43
        .byte $71
        .byte $71
        .byte $60
        .byte $ea
        .byte $63
        .byte $e8
        .byte $61
        .byte $7a
        .byte $68
        .byte $51
        .byte $6a
        .byte $6b
        .byte $79
        .byte $72
        .byte $9b    ; Misil
        .byte $bc    ; Electricidad
        .byte $e8
        .byte $61
        .byte $93    ; Alienígena
        .byte $60
        .byte $68
        .byte $bd    ; Electricidad
        .byte $73
        .byte $72
        .byte $78
        .byte $7b
        .byte $bc    ; Electricidad
        .byte $73
        .byte $72
        .byte $79
        .byte $9b    ; Misil
        .byte $bd    ; Electricidad
        .byte $40
        .byte $70
        .byte $93    ; Alienígena
        .byte $93    ; Alienígena
        .byte $93    ; Alienígena
        .byte $43
        .byte $7a
        .byte $71
        .byte $7b
        .byte $a3    ; Robotote
        .byte $ce
        .byte $e6
        .byte $00    ; Fin de nivel

        ; Espacio 3
espacio_3:
        .byte $3b,72    ; Un avión a la vez
        .byte $3c,52    ; Un avión a la vez
        .byte $3d,32    ; Un avión a la vez
        .byte $3a,52    ; Avión loquito
        .byte $c0       ; Satélite
        .byte $38       ; Tres aviones por arriba
        .byte $39       ; Tres aviones por abajo
        .byte $3a,52    ; Avión loquito
        .byte $39       ; Tres aviones por abajo
        .byte $3b,32    ; Un avión a la vez
        .byte $3c,52    ; Un avión a la vez
        .byte $3d,72    ; Un avión a la vez
        .byte $38       ; Tres aviones por arriba
        .byte $00       ; Fin de nivel

        ; Fortaleza 3 (46 bytes + 1 final)
fortaleza_3:
        .byte $df
        .byte $ce
        .byte $70
        .byte $6a
        .byte $ea
        .byte $63
        .byte $79
        .byte $60
        .byte $ea
        .byte $63
        .byte $52
        .byte $72
        .byte $61
        .byte $6a
        .byte $78
        .byte $bc    ; Electricidad
        .byte $9b    ; Misil
        .byte $70
        .byte $73
        .byte $73
        .byte $79
        .byte $93    ; Alienígena
        .byte $6a
        .byte $51
        .byte $6b
        .byte $71
        .byte $60
        .byte $62
        .byte $78
        .byte $62
        .byte $70
        .byte $71
        .byte $6b
        .byte $e9
        .byte $62
        .byte $e8
        .byte $63
        .byte $79
        .byte $68
        .byte $53
        .byte $e8
        .byte $61
        .byte $e8
        .byte $62
        .byte $c6
        .byte $e6
        .byte $00    ; Fin de nivel

        ; Espacio 4
espacio_4:
        .byte $3b,72    ; Un avión a la vez
        .byte $3c,52    ; Un avión a la vez
        .byte $3d,72    ; Un avión a la vez
        .byte $c0       ; Satélite
        .byte $39       ; Tres aviones por abajo
        .byte $3a,52    ; Avión loquito
        .byte $3a,32    ; Avión loquito
        .byte $3a,72    ; Avión loquito
        .byte $c0       ; Satélite
        .byte $3b,52    ; Un avión a la vez
        .byte $3c,52    ; Un avión a la vez
        .byte $3d,52    ; Un avión a la vez
        .byte $38       ; Tres aviones por arriba
        .byte $39       ; Tres aviones por abajo
        .byte $00       ; Fin de nivel y alineación

        ; Fortaleza 4 (48 bytes + 1 final)
fortaleza_4:
        .byte $df
        .byte $c6
        .byte $9b    ; Misil
        .byte $bc    ; Electricidad
        .byte $e8
        .byte $61
        .byte $93    ; Alienígena
        .byte $60
        .byte $68
        .byte $bd    ; Electricidad
        .byte $73
        .byte $72
        .byte $78
        .byte $7b
        .byte $bc    ; Electricidad
        .byte $73
        .byte $72
        .byte $79
        .byte $42
        .byte $43
        .byte $71
        .byte $71
        .byte $60
        .byte $ea
        .byte $63
        .byte $e8
        .byte $61
        .byte $7a
        .byte $68
        .byte $93    ; Alienígena
        .byte $51
        .byte $6a
        .byte $6b
        .byte $79
        .byte $72
        .byte $9b    ; Misil
        .byte $bd    ; Electricidad
        .byte $40
        .byte $70
        .byte $93    ; Alienígena
        .byte $93    ; Alienígena
        .byte $43
        .byte $7a
        .byte $71
        .byte $7b
        .byte $a3    ; Robotote
        .byte $c6
        .byte $e6
        .byte $00    ; Fin de nivel

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

base_sonido:
        ; Silencio
sonido_0:
        .byte $00       ; Debe usar un byte

        ; Disparo del jugador
sonido_1:
        .byte $08       ; Instrumento
        .byte 1,$80
        .byte 2,$82
        .byte 3,$85
        .byte 3,$45
        .byte 3,$05
        .byte 0

        ; Disparo enemigo
sonido_2:
        .byte $0e
        .byte 1,$e3
        .byte 1,$c1
        .byte 1,$a2
        .byte 1,$81
        .byte 1,$60
        .byte 0

        ; Explosión
sonido_3:
        .byte $08
        .byte 2,$84
        .byte 3,$e5
        .byte 3,$e6
        .byte 2,$a7
        .byte 2,$68
        .byte 2,$6c
        .byte 2,$70
        .byte 5,$78
        .byte 5,$1c
        .byte 5,$1f
        .byte 0

        ; Lanzamiento
sonido_4:
        .byte $08
        .byte 10,$9f
        .byte 10,$f0
        .byte 20,$ee
        .byte 0

        ; Los siguientes cuatro son sonidos de fondo continuos
        ; Satélite
sonido_5:
        .byte $01
        .byte 7,$41
        .byte 3,$43
        .byte 7,$81
        .byte 3,$83
        .byte 0

        ; Misil teledirigido
sonido_6:
        .byte $05
        .byte 1,$e0
        .byte 2,$e2
        .byte 3,$e3
        .byte 0

        ; Electricidad
sonido_7:
        .byte $0f
        .byte 2,$01
        .byte 1,$e0
        .byte 2,$82
        .byte 0

        ; Robotote
sonido_8:
        .byte $04
        .byte 5,$84
        .byte 5,$82
        .byte 5,$83
        .byte 5,$88
        .byte 5,$84
        .byte 3,$86
        .byte 0

        ; Música de Game Over (voz 1)
sonido_9:
        .byte $04
        .byte 12,$fd
        .byte 4,$1d
        .byte 8,$fd
        .byte 4,$1d
        .byte 8,$fd
        .byte 4,$1d
        .byte 48,$f7
        .byte 8,$17
        .byte 32,$f3
        .byte 8,$13
        .byte 32,$f0
        .byte 8,$10
        .byte 32,$f1
        .byte 8,$11
        .byte 48,$f3
        .byte 8,$13
        .byte 2,$12
        .byte 2,$11
        .byte 2,$10
        .byte 2,$0f
        .byte 2,$0e
        .byte 2,$0d
        .byte 2,$0c
        .byte 2,$0b
        .byte 2,$0a
        .byte 2,$09
        .byte 2,$08
        .byte 2,$07
        .byte 2,$06
        .byte 2,$05
        .byte 2,$04
        .byte 2,$03
        .byte 2,$02
        .byte 2,$01
        .byte 0

        ; Música de Game Over (voz 2)
sonido_10:
        .byte $04
        .byte 12,$f7
        .byte 4,$17
        .byte 8,$f7
        .byte 4,$17
        .byte 8,$f7
        .byte 4,$17
        .byte 48,$f2
        .byte 8,$12
        .byte 32,$ef
        .byte 8,$0f
        .byte 32,$ec
        .byte 8,$0c
        .byte 32,$ed
        .byte 8,$0d
        .byte 48,$ef
        .byte 8,$0f
        .byte 2,$0e
        .byte 2,$0d
        .byte 2,$0c
        .byte 2,$0b
        .byte 2,$0a
        .byte 2,$09
        .byte 2,$08
        .byte 2,$07
        .byte 2,$06
        .byte 2,$05
        .byte 2,$04
        .byte 2,$03
        .byte 2,$02
        .byte 2,$01
        .byte 0


        ; Avión chico = $40    2
        ; Cañón girado = $50   2
        ; Agujero de misil = $60
        ; Cañón = $68          2
        ; Combustible = $70    1
        ; Antena = $78         2
        ; Alienígena = $90     3
        ; Misil = $98          5
        ; Robotote = $A0      25
        ; Electricidad = $B8
        ; Pared con agujero amplio = $c6
        ; Pared con agujero en col. 1 = $ce
        ; Pared con agujero en col. 2 = $d6
        ; Abismo de entrada = $df
        ; Abismo de salida = $e7
        ; Adorno de piso = $e8, sólo inmediatamente previo a $60
        org $ff00
letras:
        .byte $00,$fe,$c6,$c6,$c6,$fe,$00,$02
        .byte $00,$78,$30,$30,$70,$30,$00,$00
        .byte $00,$fe,$c0,$fe,$06,$fe,$00,$02
        .byte $00,$fe,$06,$fe,$06,$fe,$00,$00
        .byte $00,$06,$06,$fe,$c6,$c6,$00,$00
        .byte $00,$fe,$06,$fe,$c0,$fe,$00,$02
        .byte $00,$fe,$c6,$fe,$c0,$fe,$00,$01
        .byte $00,$18,$18,$0c,$06,$fe,$00,$02
        .byte $00,$fe,$c6,$fe,$c6,$fe,$00,$00
        .byte $00,$fe,$06,$fe,$c6,$fe,$00,$01   ; Misil vertical
        .byte $00,$00,$00,$00,$00,$00,$00,$03
        .byte $0e,$e2,$ae,$aa,$aa,$ea,$80,$05
        .byte $00,$0a,$0a,$0a,$0a,$0e,$00,$25
        .byte $00,$ea,$aa,$ea,$2a,$ee,$00,$00
        .byte $00,$ee,$a8,$a8,$a8,$ee,$00,$00
        .byte $00,$ae,$a8,$ae,$aa,$ee,$80,$00
        .byte $00,$ee,$22,$ee,$88,$ee,$00,$10   ; Satélite

mensaje_titulo:
        .byte $70,$ee,$77
        .byte $10,$aa,$11
        .byte $70,$ee,$71
        .byte $40,$8a,$11
        .byte $70,$8a,$77
        .byte $00,$00,$00
        .byte $c0,$9e,$1d
        .byte $40,$52,$25
        .byte $c0,$9e,$25
        .byte $40,$52,$25
        .byte $40,$52,$1d

mensaje_final:
        .byte $f0,$7a,$7a
        .byte $10,$4b,$0b
        .byte $d0,$7b,$3b
        .byte $90,$4a,$0a
        .byte $f0,$4a,$7a
        .byte $00,$00,$00
        .byte $f0,$4b,$3b
        .byte $90,$4a,$48
        .byte $90,$4b,$39
        .byte $90,$32,$48
        .byte $f0,$33,$4b

gas1:   .byte $00,$40,$c0,$c0,$c0,$c0,$c0,$c0,$c0,$c0,$c0
gas2:   .byte $00,$00,$00,$80,$c0,$e0,$f0,$f8,$fc,$fe,$ff

        ; Offset Y de elementos en fortaleza
offset_y:
        .byte 35,45,55,65,81,105,113,107

        ; Antena animada
antena:
        .byte $78,$00,$08,$10,$18,$20,$20,$78

        org $fffc
        .word inicio    ; Posición de inicio al recibir RESET
        .word inicio    ; Posición para servir BRK
