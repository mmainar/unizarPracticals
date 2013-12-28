TITLE Juego
DOSSEG
Model Small
.Stack 100h


.Data

  ; Definici¢n de las diferentes pantallas del juego


  escenario1              db         '                                   contra                                       '
                          db         '                                                                                '
                          db         '                                                                                '
                          db         '                                   RELOJ: 00                                    '
                          db         '                                                                                '
                          db         '²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²'
                          db         '²     ²       ²          ²       ²     ²²     ²       ²          ²       ²     ²'
                          db         '²     ²       ²          ²       ²     ²²     ²       ²          ²       ²     ²'
                          db         '²     ²       ²    ²²    ²       ²            ²       ²    ²²    ²       ²     ²'
                          db         '²     ²  ²²²  ²    ²²    ²  ²²²  ²            ²  ²²²  ²    ²²    ²  ²²²  ²     ²'
                          db         '²          ²  ²          ²  ²                      ²  ²          ²  ²          ²'
                          db         '²          ²  ²²²      ²²²  ²                      ²  ²²²      ²²²  ²          ²'
                          db         '²  ²²²²²²  ²                ²  ²²²²²²      ²²²²²²  ²                ²  ²²²²²²  ²'
                          db         '²          ²                ²                      ²                ²          ²'
                          db         '²          ²    ²²²²²²²²    ²                      ²    ²²²²²²²²    ²          ²'
                          db         '²          ²    ²²²²²²²²    ²                      ²    ²²²²²²²²    ²          ²'
                          db         '²          ²                ²                      ²                ²          ²'
                          db         '²  ²²²²²²  ²                ²  ²²²²²²      ²²²²²²  ²                ²  ²²²²²²  ²'
                          db         '²          ²  ²²²      ²²²  ²                      ²  ²²²      ²²²  ²          ²'
                          db         '²          ²  ²          ²  ²                      ²  ²          ²  ²          ²'
                          db         '²     ²  ²²²  ²    ²²    ²  ²²²  ²            ²  ²²²  ²    ²²    ²  ²          ²'
                          db         '²     ²       ²    ²²    ²       ²            ²       ²    ²²    ²  ²²²  ²     ²'
                          db         '²     ²       ²          ²       ²     ²²     ²       ²          ²       ²     ²'
                          db         '²     ²       ²          ²       ²     ²²     ²       ²          ²       ²     ²'
                          db         '²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²'



  escenario2              db         '                                   contra                                       '
                          db         '                                                                                '
                          db         '                                                                                '
                          db         '                                   RELOJ: 00                                    '
                          db         '                                                                                '
                          db         '²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²'
                          db         '²                                    ²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²'
                          db         '²                                    ²²²²²²²²                ²²²²²²²²²²²²²²²²²²²'
                          db         '²  ²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²  ²²²²²²²²                              ²²²²²'
                          db         '²  ²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²  ²²  ²  ²                              ²²²²²'
                          db         '²                                    ²²  ²  ²                ²²²  ²²²  ²²  ²²²²²'
                          db         '²                                                            ²²²  ²²²  ²²  ²²²²²'
                          db         '²  ²²²²²²²²²²²    ²²²²²²²²²²²²²²                 ²²                        ²²²²²'
                          db         '²  ²²²²²²²²²²²    ²²²²²²²²²²²²²²                 ²²                        ²²²²²'
                          db         '²                                    ²²²²²²²²    ²²                        ²²²²²'
                          db         '²                                    ²²²²²²²²    ²²                        ²²²²²'
                          db         '²  ²²²²²²²²²²²    ²²²²²²²²²²²²²²                   ²²²                       ²²²'
                          db         '²  ²²²²²²²²²²²    ²²²²²²²²²²²²²²                   ²²²²²                     ²²²'
                          db         '²                                                  ²²²²²²²                   ²²²'
                          db         '²                                                  ²²²²²²²²²       ²²²²²²    ²²²'
                          db         '²     ²²²²²²      ²²²²      ²²²²²²²²²²²²     ²²²²  ²²²²                ²²      ²'
                          db         '²     ²²²²²²²²                                                                 ²'
                          db         '²     ²²²²²²²²²²                                                               ²'
                          db         '²       ²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²             ²'
                          db         '²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²'



 escenario3               db         '                                   contra                                       '
                          db         '                                                                                '
                          db         '                                                                                '
                          db         '                                   RELOJ: 00                                    '
                          db         '                                                                                '
                          db         '²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²'
                          db         '²                                                                              ²'
                          db         '²                                                                              ²'
                          db         '²                                                                              ²'
                          db         '²                                                                              ²'
                          db         '²                                                                              ²'
                          db         '²                                                                              ²'
                          db         '²                                                                              ²'
                          db         '²                                                                              ²'
                          db         '²                                                                              ²'
                          db         '²                                                                              ²'
                          db         '²                                                                              ²'
                          db         '²                                                                              ²'
                          db         '²                                                                              ²'
                          db         '²                                                                              ²'
                          db         '²                                                                              ²'
                          db         '²                                                                              ²'
                          db         '²                                                                              ²'
                          db         '²                                                                              ²'
                          db         '²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²'



 escenario4               db         '                                   contra                                       '
                          db         '                                                                                '
                          db         '                                                                                '
                          db         '                                   RELOJ: 00                                    '
                          db         '                                                                                '
                          db         '²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²'
                          db         '²                    ²                 ²²²²²²²²²²²²    ²²²²  ²²²²      ²²  ²²  ²'
                          db         '²                    ²                                                 ²²  ²²  ²'
                          db         '²  ²²²²²²²²²²²²²²²       ²²      ²²                                    ²²  ²²  ²'
                          db         '²                        ²²      ²²                    ²²²²  ²²²²²²²²  ²²  ²²  ²'
                          db         '²                        ²²  ²²  ²²    ²²        ²²                        ²²  ²'
                          db         '²  ²²²²²²²²²²²²²²²       ²²  ²²  ²²    ²²        ²²                        ²²  ²'
                          db         '²  ²²²²²²²²²²²²²²²   ²   ²²      ²²    ²²²²    ²²²²                        ²²  ²'
                          db         '²                    ²   ²²      ²²²²  ²²²²²  ²²²²²    ²²²²  ²²²²²²²²²²²²  ²²  ²'
                          db         '²                    ²   ²²  ²²  ²²²²  ²²²²²  ²²²²²                            ²'
                          db         '²                    ²   ²²  ²²  ²²    ²²²²    ²²²²                            ²'
                          db         '²  ²²²²²²²  ²²²²²²²²²²   ²²      ²²    ²²        ²²    ²²²²²²²²²²²²²²²²²²  ²²  ²'
                          db         '²                        ²²      ²²    ²²        ²²        ²²      ²²      ²²  ²'
                          db         '²                        ²²  ²²²²²²    ²²        ²²        ²²      ²²      ²²  ²'
                          db         '²  ²²²²²²    ²²²²²²²     ²²      ²²    ²²        ²²    ²²      ²²      ²²  ²²  ²'
                          db         '²  ²²²²²²    ²²²²²²²     ²²      ²²    ²²        ²²    ²²      ²²      ²²  ²²  ²'
                          db         '²  ²²²²²²    ²²²²²²²     ²²²²²²  ²²    ²²        ²²    ²²²²²²²²²²²²²²²²²²  ²²  ²'
                          db         '²                                                                              ²'
                          db         '²                                                                              ²'
                          db         '²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²'




  pantGanaJug1            db         '                 ____         _____   ____           ____   _     ____          '
                          db         '        |     | |    |       |       |    | |\    | |    | | \   |    |         '
                          db         '        |     | |    |       |       |    | | \   | |    | |  \  |    |         '
                          db         '        |-----| |----|       |   __  |----| |  \  | |----| |   | |    |         '
                          db         '        |     | |    |       |     | |    | |   \ | |    | |  /  |    |         '
                          db         '        |     | |    |       |_____| |    | |    \| |    | |_/   |____|         '
                          db         '                                                                                '
                          db         '                                                                                '
                          db         '         ____              ______         ____   ____   _    ____   ____        '
                          db         '        |      |              |   |    | |      |    | | \  |    | |    |       '
                          db         '        |____  |              |   |    | |  __  |____| |  \ |    | |____|       '
                          db         '        |      |           \  |   |    | |    | |    | |  / |    | |   \        '
                          db         '        |____  |____        \_|   |____| |____| |    | |_/  |____| |    \       '
                          db         '                                                                                '
                          db         '                                                                                '
                          db         '                                                                                '
                          db         '                                    /|                                          '
                          db         '                                   / |                                          '
                          db         '                                     |                                          '
                          db         '                                     |                                          '
                          db         '                                     |                                          '
                          db         '                                   __|__                                        '
                          db         '                                                                                '
                          db         '                                                                                '
                          db         '               ... Pulsa escape para salir o 1 para volver a jugar...           '


  pantGanaJug2            db         '                 ____         _____   ____           ____   _     ____          '
                          db         '        |     | |    |       |       |    | |\    | |    | | \   |    |         '
                          db         '        |     | |    |       |       |    | | \   | |    | |  \  |    |         '
                          db         '        |-----| |----|       |   __  |----| |  \  | |----| |   | |    |         '
                          db         '        |     | |    |       |     | |    | |   \ | |    | |  /  |    |         '
                          db         '        |     | |    |       |_____| |    | |    \| |    | |_/   |____|         '
                          db         '                                                                                '
                          db         '                                                                                '
                          db         '         ____              ______         ____   ____   _    ____   ____        '
                          db         '        |      |              |   |    | |      |    | | \  |    | |    |       '
                          db         '        |____  |              |   |    | |  __  |____| |  \ |    | |____|       '
                          db         '        |      |           \  |   |    | |    | |    | |  / |    | |   \        '
                          db         '        |____  |____        \_|   |____| |____| |    | |_/  |____| |    \       '
                          db         '                                                                                '
                          db         '                                                                                '
                          db         '                                     ____                                       '
                          db         '                                         |                                      '
                          db         '                                        /                                       '
                          db         '                                       /                                        '
                          db         '                                      /                                         '
                          db         '                                     /_____                                     '
                          db         '                                                                                '
                          db         '                                                                                '
                          db         '                                                                                '
                          db         '               ... Pulsa escape para salir o 1 para volver a jugar              '


   empate                 db         '                                                                                '
                          db         '                                                                                '
                          db         '                                                                                '
                          db         '                                                                                '
                          db         '                                                                                '
                          db         '                                                                                '
                          db         '                                                                                '
                          db         '                                                                                '
                          db         '                     ____          ____    ____  _____  ____                    '
                          db         '                    |      |\  /| |    |  |    |   |   |                        '
                          db         '                    |____  | \/ | |____|  |____|   |   |____                    '
                          db         '                    |      |    | |       |    |   |   |                        '
                          db         '                    |____  |    | |       |    |   |   |____                    '
                          db         '                                                                                '
                          db         '                                                                                '
                          db         '                                                                                '
                          db         '                                                                                '
                          db         '                                                                                '
                          db         '                                                                                '
                          db         '                                                                                '
                          db         '                                                                                '
                          db         '                                                                                '
                          db         '                                                                                '
                          db         '                                                                                '
                          db         '               ... Pulsa escape para salir o 1 para volver a jugar              '


  eleccion1               db          '     .                     ___   ___        ___           ___                   '
                          db          '     |\                   |   | |   | |  / |    |\    /| |   | |\      |        '
                          db          '     |  \.,,,_________    |___| |   | |/   |___ |  \/  | |   | |  \    |        '
                          db          '    /             _!!/    |     |   | |\   |    |      | |   | |    \  |        '
                          db          '   | (%)    (%)   \       |     |___| |  \ |___ |      | |___| |      \|        '
                          db          '   ()    .     () |                                                             '
                          db          '    \   ,.,       /                                                             '
                          db          '    /             \                                                             '
                          db          ' \"/        \''\  |       El juego consiste en capturar al otro pokemon         '
                          db          '   \            <_/       estando s¢lo uno de los 2 pokemon evolucionado.       '
                          db          '    \          <_,|       La evoluci¢n dura 5 segundos y se consigue tras       '
                          db          '     .,..,,/"/,  /\\      coger una bola de evoluci¢n, momento en el que        '
                          db          '     \  |  \____/  \\     nos volvemos m s r pidos.                             '
                          db          '      ""         __//     Si al cabo de un minuto ningun jugador ha conseguido  '
                          db          '          _____ ||''       alcanzar al otro, la partida termina en empate.      '
                          db          '         /  / \\||                                                              '
                          db          '        /  /   \ |        CONTROLES JUGADOR 1:      Arriba:    Q                '
                          db          '       |__|     \/          (Salir: Escape)         Abajo:     A                '
                          db          '                                                    Izquierda: X                '
                          db          '                                                    Derecha:   C                '
                          db          '                                                                                '
                          db          '             Pulsa una tecla para elegir el pokemon del jugador 1               '
                          db          '                                                                                '
                          db          '      1 - Pikachu       2 - Bulbasaur       3 - Charmander       4 - Squirtle   '
                          db          '                                                                                '

  eleccion2               db          '     .                     ___   ___        ___           ___                   '
                          db          '     |\                   |   | |   | |  / |    |\    /| |   | |\      |        '
                          db          '     |  \.,,,_________    |___| |   | |/   |___ |  \/  | |   | |  \    |        '
                          db          '    /             _!!/    |     |   | |\   |    |      | |   | |    \  |        '
                          db          '   | (%)    (%)   \       |     |___| |  \ |___ |      | |___| |      \|        '
                          db          '   ()    .     () |                                                             '
                          db          '    \   ,.,       /                                                             '
                          db          '    /             \                                                             '
                          db          ' \"/        \''\  |       El juego consiste en capturar al otro pokemon         '
                          db          '   \            <_/       estando s¢lo uno de los 2 pokemon evolucionado.       '
                          db          '    \          <_,|       La evoluci¢n dura 5 segundos y se consigue tras       '
                          db          '     .,..,,/"/,  /\\      coger una bola de evoluci¢n, momento en el que        '
                          db          '     \  |  \____/  \\     nos volvemos m s r pidos.                             '
                          db          '      ""         __//     Si al cabo de un minuto ning£n jugador ha conseguido  '
                          db          '          _____ ||''       alcanzar al otro, la partida termina en empate.      '
                          db          '         /  / \\||                                                              '
                          db          '        /  /   \ |        CONTROLES JUGADOR 1:      Arriba:    O                '
                          db          '       |__|     \/          (Salir: Escape)         Abajo:     L                '
                          db          '                                                    Izquierda: N                '
                          db          '                                                    Derecha:   M                '
                          db          '                                                                                '
                          db          '             Pulsa una tecla para elegir el pokemon del jugador 2               '
                          db          '                                                                                '
                          db          '      1 - Pikachu       2 - Bulbasaur       3 - Charmander       4 - Squirtle   '
                          db          '                                                                                '

  elegirEscenario         db          '                                                                                '
                          db          '                                                                                '
                          db          '                                                                                '
                          db          '                                                                                '
                          db          '                             ELIGE UN ESCENARIO DE JUEGO                        '
                          db          '                                                                                '
                          db          '                                                                                '
                          db          '                                                                                '
                          db          '                                                                                '
                          db          '                                                                                '
                          db          '             1 - BOSQUE                 3 - MUERTE SéBITA                       '
                          db          '                                                                                '
                          db          '                                                                                '
                          db          '             2 - MAR                    4 - AIRE                                '
                          db          '                                                                                '
                          db          '                                                                                '
                          db          '                                                                                '
                          db          '                                                                                '
                          db          '                                                                                '
                          db          '                                                                                '
                          db          '                                                                                '
                          db          '                                                                                '
                          db          '                                                                                '
                          db          '                                                                                '
                          db          '                                                                                '



  pant                    equ        0B800h ; @ de memoria de la pantalla
  areaPantalla            equ        80*25  ; 25 filas x 80 columnas
  color                   dw         ?      ; Color del escenario actual
  fila                    dw         962    ;
  columna                 db         2      ;
  posicion1               dw         962    ; Posici¢n inicial pokemon 1
  posicion2               dw         3674   ; Posici¢n inicial pokemon 2
  colorEscenario1         dw         56h    ; Colores de los diferentes
  colorEscenario2         dw         36h    ; escenarios del juego
  colorEscenario3         dw         76h
  colorEscenario4         dw         01h
  pikachu                 db         '==oo'
  colorPikachu            equ        0E0h
  bulbasaur               db         '^^@@'
  colorBulbasaur          equ        29h
  charmander              db         '//DD'
  colorCharmander         equ        4Eh
  squirtle                db         '~~OO'
  colorSquirtle           equ        1Eh
  bolaEvolucion           db         'X'
  colorBolaEvolucion      equ        0Fh
  pokemonJug1             db         ?
  pokemonJug2             db         ?
  evolucionJug1           db         0
  evolucionJug2           db         0
  colorPantallaPres1      equ        04h
  colorPantallaPres2      equ        01h
  pokemon1aux             dw         ?
  color1aux               db         ?
  pokemon2aux             dw         ?
  color2aux               db         ?
  escape                  equ        1
  datoTeclado             equ        60h
  strobe                  equ        61H
  IRQ0                    equ        4*8
  IRQ1                    equ        4*9
  duracion                dw         60*18 ; 60 sg/min * 18 int/sg
  max_18                  dw         0 ; contador de tics
  tiempoEvolucion1        db         0
  tiempoEvolucion2        db         0
  csIntOriginalTeclado    dw         ?
  ipIntOriginalTeclado    dw         ?
  csIntOriginalReloj      dw         ?
  ipIntOriginalReloj      dw         ?
  terminar                db         0
  escenarioElegido        db         0
  tecla1                  equ        2h
  tecla2                  equ        3h
  tecla3                  equ        4h
  A                       equ        1EH
  C                       equ        2Eh
  Q                       equ        10h
  X                       equ        2Dh
  O                       equ        18h
  L                       equ        26h
  N                       equ        31h
  M                       equ        32h
  mensajePikachu          db         'PIKACHU'
  lmensajePikachu         equ        $ - mensajePikachu
  mensajeBulbasaur        db         'BULBASAUR'
  lmensajeBulbasaur       equ        $ - mensajeBulbasaur
  mensajeCharmander       db         'CHARMANDER'
  lmensajeCharmander      equ        $ - mensajeCharmander
  mensajeSquirtle         db         'SQUIRTLE'
  lmensajeSquirtle        equ        $ - mensajeSquirtle
  mensajeEvolucion        db         'EVOLUCION'
  lmensajeEvolucion       equ        $ - mensajeEvolucion
  colorMensajeEvolucion   equ        6Fh
  mensajeRaichu           db         'RAICHU'
  lmensajeRaichu          equ        $ - mensajeRaichu
  mensajeVenusaur         db         'VENUSAUR'
  lmensajeVenusaur        equ        $ - mensajeVenusaur
  mensajeCharizard        db         'CHARIZARD'
  lmensajeCharizard       equ        $ - mensajeCharizard
  mensajeBlastoise        db         'BLASTOISE'
  lmensajeBlastoise       equ        $ - mensajeBlastoise
  casilla1                dw         ?
  casilla2                dw         ?
  pokemonEvolucionado     dw         ?


.Code
               ; ------------------------------
                  pintarPantalla proc near
               ; ------------------------------
               ; algoritmo pintarPantalla(offset_pant punt: texto; color: nat)

                    push bp     ; Guardamos todos
                    mov bp,sp   ; los registros
                    push ax     ; que vamos a usar
                    push bx
                    push cx
                    push si
                    push dx
                    mov si,4[bp] ; mueve a SI la direccion efectiva
                                 ; de la pantalla que se quiere pintar
                    mov dx,6[bp] ; mueve a DX el color que se quiere para
                                 ; el pintado de la pantalla
                    mov cx,areaPantalla
                    mov bx,pant
                    mov es,bx
                    mov bx,0

          bucle:    mov ax,[si]
                    mov es:[bx],ax   ; Pintamos el car cter ASCII
                    mov es:1[bx],dl  ; Pintamos su atributo de color
                    inc si
                    add bx,2
                    loop bucle

                    pop dx    ; Recuperamos
                    pop si    ; los registros
                    pop cx    ; guardados
                    pop bx
                    pop ax
                    pop bp
                    ret 4     ; Retorno
               ; -------------------------------------
                    pintarPantalla endp
               ; -------------------------------------


               ; -------------------------------------
                    cambiarTablaInt proc near
               ; -------------------------------------
               ; algoritmo cambiarTablaInt

                    push ax  ; Guardamos los registros
                    push es  ; que vamos a usar

                    ; Primero salvamos la direcci¢n
                    ; de la interrupci¢n original
                    ; del teclado
                    xor ax,ax
                    mov es,ax
                    mov si,IRQ1
                    mov ax,es:[si]
                    mov word ptr ipIntOriginalTeclado, ax
                    mov ax,es:2[si]
                    mov word ptr csIntOriginalTeclado, ax

                    ; Hacemos lo mismo con la interrupcion
                    ; de reloj
                    mov si, IRQ0
                    mov ax, es:[si]
                    mov word ptr ipIntOriginalReloj, ax
                    mov ax,es:2[si]
                    mov word ptr csIntOriginalReloj, ax

                    ; Modificamos la rutina original
                    ; del teclado introduciendo la direcci¢n
                    ; de la nuestra

                    cli ; Deshabilitamos las interrupciones
                    mov si,IRQ1
                    mov word ptr es:[si], offset intTeclado
                    mov es:2[si],cs

                    ; Ahora hacemos lo mismo con la rutina
                    ; original de la interrupci¢n de reloj

                    mov si,IRQ0
                    mov word ptr es:[si], offset intReloj
                    mov es:2[si],cs
                    sti ; Volvemos a habilitar las interrupciones

                    pop es   ; Recuperamos los
                    pop ax   ; registros guardados
                    ret      ; Retorno
               ; -----------------------------------------
                    cambiarTablaInt endp
               ; -----------------------------------------


               ; -----------------------------------------
                    restaurarTablaInt proc near
               ; -----------------------------------------
                    push ax   ; Guardamos los registros
                    push bx   ; que vamos a usar

                    ; Restauramos la interrupci¢n original del teclado
                    xor ax, ax
                    mov es,ax
                    mov si,IRQ1
                    mov ax,word ptr ipIntOriginalTeclado
                    mov bx, word ptr csIntOriginalTeclado
                    cli ; Deshabilitamos las interrupciones
                    mov es:[si],ax
                    mov es:2[si],bx
                    sti ; Volvemos a habilitar las interrupciones

                    ; Restauramos la interrupcion original de reloj
                    mov si, IRQ0
                    mov ax, word ptr ipIntOriginalReloj
                    mov bx, word ptr csIntOriginalReloj
                    cli; Deshabilitamos las interrupciones
                    mov es:[si],ax
                    mov es:2[si],bx
                    sti; Volvemos a habilitar las interrupciones

                    pop bx  ; Recuperamos los
                    pop ax  ; registros guardados
                    ret     ; Retorno
               ; -------------------------------------------
                    restaurarTablaInt endp
               ; -------------------------------------------


               ; ---------------------------------------------
                  intTeclado proc far
               ; ---------------------------------------------

                 ; Programamos nuestra propis rutina de
                 ; gesti¢n de la interrupci¢n de teclado (far)
                 ; y controlamos las pulsaciones de las teclas
                 ; que nos interesan en el juego.

      principio:    push ax ; Guardamos los registros
                    push cx ; que vamos a usar

                    in al,datoTeclado  ; Leemos la tecla pulsada
                    cmp al,escape  ; šSe ha pulsado escape?
                    jne teclaA     ; Si no, comprobamos la siguiente tecla
                    mov terminar,1 ; Si se ha pulsado escape, fin del juego
                    jmp seguir2
        teclaA:     cmp al,A    ; šSe ha pulsado la tecla A?
                    jne teclaC  ; Si no, pasamos a comprobar la
                                ; siguiente tecla
                    mov cx,1        ; Se mueve jugador 1
                                    ; que se encuentra en posicion1.
                    push cx         ; Pasamos los par metros necesarios
                    push posicion1  ; a la subrutina moverAbajo.
                    call moverAbajo ; Nos movemos hacia abajo
                    cmp evolucionJug1,1  ; šEst  evolucionado jugador 1?
                    je evolA        ; Si lo estamos, nos moveremos de nuevo
                    jmp seguir2     ; Si no, seguimos
         evolA:     mov cx,1        ; Se mueve el jugador 1
                                    ; cuya posici¢n es posicion1.
                    push cx         ; Paso de par metros
                    push posicion1  ; a la subrutina moverAbajo.
                    call moverAbajo ; Nos movemos hacia abajo otra vez
                    jmp seguir2
         teclaC:    cmp al,C     ; šSe ha pulsado la tecla C?
                    jne teclaX   ; Si no, pasamos a comprobar la
                                 ; siguiente tecla.
                    mov cx,1            ; Se mueve jugador 1
                                        ; cuya posici¢n es posicion 1.
                    push cx             ; Paso de par metros
                    push posicion1      ; a la subrutina moverDerecha.
                    call moverDerecha   ; Nos movemos hacia la derecha
                    cmp evolucionJug1,1 ; šEst  evolucionado jugador 1?
                    je evolC      ; Si lo estamos, nos movemos de nuevo
                    jmp seguir2
         evolC:     mov cx,1          ; Se mueve jugador 1
                                      ; cuya posici¢n es posicion1.
                    push cx           ; Paso de par metros
                    push posicion1    ; a la subrutina moverDerecha.
                    call moverDerecha ; Nos movemos de nuevo hacia la derecha
                    jmp seguir2

         teclaX:    cmp al,X    ; šSe ha pulsado la tecla X?
                    jne teclaQ  ; Si no, comprobamos la siguiente tecla
                    mov cx,1             ; Se mueve jugador 1
                                         ; que est  en posicion1.
                    push cx              ; Paso de par metros
                    push posicion1       ; a la subrutina moverIzquierda.
                    call moverIzquierda  ; Nos movemos hacia la izquierda
                    cmp evolucionJug1,1  ; šEst  evolucionado jugador 1?
                    je evolX     ; Si lo estamos, nos movemos de nuevo
                    jmp seguir2
         evolX:     mov cx,1             ; Se mueve jugador 1
                                         ; que est  en posici¢n 1.
                    push cx              ; Paso de par metros
                    push posicion1       ; a la subrutina moverIzquierda.
                    call moverIzquierda  ; Nos movemos hacia la izquierda
                    jmp seguir2
         teclaQ:    cmp al,Q     ; šSe ha pulsado la tecla Q?
                    jne teclaO   ; Si no, comprobamos la siguiente tecla
                    mov cx,1     ; Se mueve jugador 1 cuya posici¢n
                                 ; es posicion1
                    push cx
                    push posicion1
                    call moverArriba     ; Nos movemos hacia arriba
                    cmp evolucionJug1,1  ; šEst  evolucionado jugador 1?
                    je evolQ
                    jmp seguir2
         evolQ:     mov cx,1
                    push cx
                    push posicion1
                    call moverArriba
                    jmp seguir2
         teclaO:    cmp al,O
                    jne teclaL
                    mov cx,2
                    push cx
                    push posicion2
                    call moverArriba
                    cmp evolucionJug2,1
                    je evolO
                    jmp seguir2
         evolO:     mov cx,2
                    push cx
                    push posicion2
                    call moverArriba
                    jmp seguir2
         teclaL:    cmp al,L
                    jne teclaN
                    mov cx,2
                    push cx
                    push posicion2
                    call moverAbajo
                    cmp evolucionJug2,1
                    je evolL
                    jmp seguir2
         evolL:     mov cx,2
                    push cx
                    push posicion2
                    call moverAbajo

                    jmp seguir2
         teclaN:    cmp al,N
                    jne teclaM
                    mov cx,2
                    push cx
                    push posicion2
                    call moverIzquierda
                    cmp evolucionJug2,1
                    je evolN
                    jmp seguir2
         evolN:     mov cx,2
                    push cx
                    push posicion2
                    call moverIzquierda

                    jmp seguir2
         teclaM:    cmp al,M
                    jne seguir2
                    mov cx,2
                    push cx
                    push posicion2
                    call moverDerecha
                    cmp evolucionJug2,1
                    je evolM
                    jmp seguir2
         evolM:     mov cx,2
                    push cx
                    push posicion2
                    call moverDerecha

       seguir2:     in al,strobe  ; Realizamos el strobe de teclado
                    or al,80h     ; Forzamos a 1
                    out strobe,al
                    and al,7Fh    ; Forzamos a 0
                    out strobe,al

           fin:     cli          ; Deshabilitamos las interrupciones
                    mov al,20h   ; End of
                    out 20h, al  ; Interruption.
                    sti          ; Volvemos a habilitar las interrupciones

                    pop cx  ; Recuperamos los registros
                    pop ax  ; guardados
                    iret
               ; ---------------------------
                  intTeclado endp
               ; ---------------------------


               ; -------------------------------
                  pintarBolaEvolucion proc near
               ; -------------------------------
                    push ax  ; Guardamos
                    push bx  ; todos los
                    push cx  ; registros que
                    push dx  ; vamos a usar.
                    push si
                    push di

                    ; Generador de n£meros pseudoaleatorios
                    ; para situar la bola de evolucion
                    ; utilizando el temporizador del sistema

                    xor al,al    ; Limpiamos al
                    out 43h,al   ; Congelar contador 0
                    in al,40h    ; Obtenci¢n del LSB
                    xchg ah,al   ; Intercambiamos
                    in al,40h    ; Obtenci¢n del MSB
                    xchg ah,al   ; en AX se dispone del numero aleatorio

                    mov bx,pant
                    mov es,bx

                    xor dx,dx    ; Limpiamos dx
                    mov bx,2238  ; Nos situamos en las posiciones de memoria
                    div bx       ; correspondientes a la pantalla donde
                    mov bx,dx    ; podemos pintar la bola de evoluci¢n
                    add bx,960

      comprobar1:   mov ax,es:[bx]
                    cmp al,20h   ; šHay espacio donde vamos a pintar?
                    je correcto  ; Si hay espacio, puede pintar ah¡
                    inc bx       ; Si no, vamos a la posici¢n siguiente
                    jmp comprobar1

          correcto: mov dx,color
                    and dx,11110000b
                    or dx,colorBolaEvolucion
                    or dl,10000000b
                    mov si, offset BolaEvolucion
                    mov ax,[si]
                    mov es:[bx],ax  ; Pintamos la bola con su color
                    mov es:1[bx], dl

                    pop di   ; Recuperamos
                    pop si   ; todos los
                    pop dx   ; registros que
                    pop cx   ; habiamos guardado
                    pop bx
                    pop ax
                    ret
               ; ----------------------------------------
                 pintarBolaEvolucion endp
               ; ----------------------------------------


               ; ----------------------------------------
                  intReloj proc far
               ; ----------------------------------------
                   ; Programamos nuestra propia rutina de
                   ; gesti¢n de la interrupci¢n de reloj (far)
                   ; para controlar el tiempo de juego
                   ; y la aparici¢n de bolas y mensajes
                   ; de evoluci¢n

                    push ax
                    ;dec duracion
                    inc max_18      ; Incrementamos contador de tics
                    cmp max_18, 18  ; šYa ha pasado un segundo?
                    je un_seg
                    jmp fin_rel_1
          un_seg:   mov max_18, 0   ; Ponemos a 0 el contador de tics

                    cmp evolucionJug1,1    ; šEst  evolucionado jugador 1?
                    jne noEvolucionJug1    ; Si no, seguimos
                    cmp tiempoEvolucion1,5 ; šHan pasado ya los 5 segundo
                                           ; de la evoluci¢n?
                    jne noFinEvolucion     ; Si no, continuamos
                    mov tiempoEvolucion1,0   ; Ponemos el tiempo de evoluci¢n
                                             ; del jugador 1 a 0.
                    mov evolucionJug1,0      ; Quitamos la evoluci¢n
                    and color1aux,01111111b  ; Dejamos de parpadear
                    push pokemon1aux
                    xor ax,ax
                    mov al,color1aux
                    push ax
                    push posicion1
                    call pintarPokemon

                    call pintarBolaEvolucion ; Pintamos una nueva bola
                                             ; de evoluci¢n.
                    ; Quitamos el mensaje de evoluci¢n
                    ; que aparece por pantalla.
                    mov bx,pant
                    mov es,bx
                    mov bx,480
                    mov cx, lmensajeEvolucion
                    mov dx, color  ; Guardamos el color del escenario actual
  bucle_men_evol:   mov es:[bx],byte ptr ' '  ; Pintamos espacios en blanco
                    mov es:1[bx], dl          ; con el color del escenario
                    add bx,2
                    loop bucle_men_evol

                    call pintarMensajePokemon ;  Volvemos a pintar el nombre
                                              ;  del pokemon original


  noFinEvolucion:   inc tiempoEvolucion1   ; Incrementamos el tiempo que
                                           ; lleva evolucionado jugador 1

  noEvolucionJug1:  cmp evolucionJug2,1  ; šEst  evolucionado jugador 2?
                    jne noEvolucionJug2
                    cmp tiempoEvolucion2,5  ; šHan pasado ya los 5 segundos
                                            ; del tiempo de evoluci¢n?
                    jne noFinEvolucion2
                    mov tiempoEvolucion2,0  ; Ponemos el tiempo de evoluci¢n
                                            ; del jugador 2 a 0.
                    mov evolucionJug2,0     ; Quitamos la evoluci¢n
                    and color2aux,01111111b ; Quitamos el parpadeo

                    push pokemon2aux  ; Primero el
                    xor ax,ax
                    mov al,color2aux  ; pokemon 1
                    push ax
                    push posicion2    ; donde corresponde.
                    call pintarPokemon

                    call pintarBolaEvolucion
                    ; Quitamos el mensaje de evoluci¢n
                    ; que aparece por pantalla.
                    mov bx,pant
                    mov es,bx
                    mov bx,622
                    mov cx, lmensajeEvolucion
                    mov dx,color
  bucle_men_evol2:  mov es:[bx],byte ptr ' '
                    mov es:1[bx],dl
                    add bx,2
                    loop bucle_men_evol2
                    ; Volvemos a pintar el nombre del pokemon
                    ; original, es decir, sin evolucionar
                    call pintarMensajePokemon

 noFinEvolucion2:   inc tiempoEvolucion2

                    ; Pintamos el reloj por pantalla
 noEvolucionJug2:   push es
                    push bx
                    mov bx,pant
                    mov es, bx
                    mov bx, 566
                    mov al, es:[bx]
                    cmp al, '9'
                    je mod_10
                    inc al
                    mov es:[bx], al
                    jmp fin_rel_2

          mod_10:   mov byte ptr es:[bx], '0'
                    mov bx,564
                    add es:[bx],byte ptr 1
                    cmp es:[bx],byte ptr '6'
                    jne fin_rel_2
                    mov terminar,1
                    mov evolucionJug1,0
                    mov evolucionJug2,0

       fin_rel_2:   pop bx  ; Recuperamos los
                    pop es  ; registros guardados
       fin_rel_1:   mov al, 20h   ; End of
                    out 20h, al   ; Interruption
                    pop ax   ; Recuperamos el registro ax
                    iret
              ; ---------------------------------------------
                  intReloj endp
              ; ---------------------------------------------


              ; ---------------------------------------------
                  pintarMensajeEvolucion proc near
              ; ---------------------------------------------
              ; algoritmo pintarMensajeEvolucion (pokemon: nat)

                    push bp    ; Salvamos
                    mov bp,sp  ; los registros
                    push ax    ; que vamos a usar
                    push bx
                    push cx
                    push dx
                    push si
                    push di

                    mov bx,pant
                    mov es,bx
                    mov ax,4[bp] ; Guardamos el par metro de entrada
                                 ; que informa de qu pokemon hay que
                                 ; pintar su mensaje de evoluci¢n, 1 ¢ 2.
                    cmp ax,1     ; šHay que pintar el del pokemon 1?
                    jne el2
                    mov bx,480   ; Posici¢n en pantalla del mensaje de
                                 ; evoluci¢n del pokemon 1
                    jmp continu
      el2:          mov bx,622   ; Posici¢n en pantalla del mensaje de
                                 ; evoluci¢n del pokemon 2

      continu:      mov cx,lmensajeEvolucion
                    lea si,mensajeEvolucion
                    mov dx,color

   bucle_evol:      mov ax,[si]
                    mov es:[bx],ax
                    mov es:1[bx], dl
                    inc si
                    add bx,2
                    loop bucle_evol

                    pop di  ; Recuperamos los
                    pop si  ; registros
                    pop dx  ; guardados
                    pop cx
                    pop bx
                    pop ax
                    pop bp
                    ret 2
              ; ---------------------------------
                  pintarMensajeEvolucion endp
              ; ---------------------------------


              ; ----------------------------------------
                 pintarMensajePokemonEvolucion proc near
              ; ----------------------------------------
              ; algoritmo pintarMensajePokemonEvolucion
              ;            (pokemon, evolucion: natural)

                    push bp    ; Salvamos los registros
                    mov bp,sp  ; que vamos a usar
                    push ax
                    push bx
                    push cx
                    push si
                    push dx

                    mov ax,4[bp]   ; Guardamos el par metro de entrada
                    cmp al,tecla1  ; šEs pikachu?
                    jne esVenusaur
                    mov si,offset mensajeRaichu
                    mov cx,lmensajeRaichu
                    mov dl,colorPikachu
                    and dl,11110000b
                    push ax
                    push cx
                    xor cx,cx
                    mov ax,color
                    and al,11110000b
                    mov cl,4
                    ror dl,cl ; Rotamos 4 bits
                    or dl,al
                    pop cx
                    pop ax
                    jmp quienEvoluciona
      esVenusaur:   cmp al,tecla2  ; šEs Bulbasaur?
                    jne esCharizard
                    mov si,offset mensajeVenusaur
                    xor dx,dx
                    mov dl,colorBulbasaur
                    and dl,00001111b
                    push ax
                    mov ax,color
                    and al,11110000b
                    or dl,al
                    pop ax

                    mov dl,colorBulbasaur
                    mov cx,lmensajeVenusaur
                    mov dl,colorBulbasaur
                    and dl,11110000b
                    push ax
                    push cx
                    xor cx,cx
                    mov ax,color
                    and al,11110000b
                    mov cl,4
                    ror dl,cl
                    or dl,al
                    pop cx
                    pop ax

                    jmp quienEvoluciona
    esCharizard:    cmp al,tecla3
                    jne esBlastoise
                    mov si,offset mensajeCharizard
                    xor dx,dx
                    mov dl,colorCharmander
                    mov cx,lmensajeCharizard
                    and dl,11110000b
                    push ax
                    push cx
                    xor cx,cx
                    mov ax,color
                    and al,11110000b
                    mov cl,4
                    ror dl,cl
                    or dl,al
                    pop cx
                    pop ax

                    jmp quienEvoluciona
     esBlastoise:   mov si,offset mensajeBlastoise
                    xor dx,dx
                    mov dl,colorSquirtle
                    mov cx,lmensajeBlastoise
                    and dl,11110000b
                    push ax
                    push cx
                    xor cx,cx
                    mov ax,color
                    and al,11110000b
                    mov cl,4
                    ror dl,cl
                    or dl,al
                    pop cx
                    pop ax


   quienEvoluciona: mov bx,6[bp]  ; Guardamos el segundo par metro de
                                  ; entrada que informa de si evoluciona
                                  ; el pokemon1(1) o el pokemon2 (2).
                    cmp bx,1
                    jne evolucionaElOtro
                    mov di,0
                    jmp pintamos

 evolucionaElOtro:  xor di,di
                    push ax
                    xor ax,ax
                    mov al,80
                    sub al,cl
                    mov bl,2
                    mul bl
                    mov di,ax
                    pop ax

    pintamos:       mov bx,pant
                    mov es,bx
                    cmp di,0
                    je pintada
                    sub di,2
                    mov ax,[si]
                    mov es:[di],byte ptr ' '
                    mov es:1[di],dl

       pintada:     mov ax,[si]
                    mov es:[di],ax
                    mov es:1[di], dl
                    inc si
                    add di,2
                    loop pintada

                    mov es:[di],byte ptr ' '
                    mov es:1[di],dl

                    pop dx
                    pop si
                    pop cx
                    pop bx
                    pop ax
                    pop bp
                    ret 4
               ; -------------------------------------
                  pintarMensajePokemonEvolucion endp
               ; -------------------------------------


               ; -------------------------------------
                  comprobarMovimiento proc near
               ; -------------------------------------
               ; algoritmo comprobarMovimiento(casilla1, casilla2: natural)
               ;               devuelve hayMovimiento;

                    push bp  ; Salvamos los registros
                    mov bp,sp
                    push ax
                    push bx
                    push cx
                    push si
                    push dx

                    mov ax,6[bp] ; ax <- casilla1
                    cmp al,' ' ; šEspacio?
                    jne eti1
                    ; En este punto, en la casilla1 hay un espacio
                    ; Comprobamos qu es lo que hay en la casilla2
                    mov ax,4[bp] ; ax <- casilla2
                    cmp al,'X' ; šBola?
                    jne esEspacio
                    jmp evolucionar
     esEspacio:     cmp al,' ' ; šEspacio?
                    jne esMuro
                    xor ax, ax
                    mov ax,1 ; Se realizara el movimiento
                    mov 8[bp],ax ; Se guarda el valor a devolver.
                    jmp acaba ; Acabamos el procedimiento
     esMuro:        cmp al,0B2H ; šMuro?
                    jne esPokemon
                    xor ax,ax   ; No se realizara el movimiento
                    mov 8[bp],ax ; Guardamos el parametro de salida(0)
                    jmp acaba   ; Acabamos el procedimiento
      esPokemon:    jmp comprobarEvol

                    ; En el caso de que en la casilla1 no haya un espacio
                    ; comprobamos otras posibilidades

          eti1:     mov ax,6[bp] ; ax <- casilla1
                    cmp al,'X' ; šBola?
                    jne eti2
                    ; En este punto, en la casilla1 hay una bola
                    ; Comprobamos que es lo que hay en la casilla2
                    mov ax,4[bp] ; ax <- casilla2
                    cmp al,' ' ; šEspacio?
                    jne esBola2
                    jmp evolucionar
         esBola2:   cmp al,'X'
                    jne esMuro2
                    call pintarBolaEvolucion
                    jmp evolucionar
         esMuro2:   cmp al,0B2H ; šMuro?
                    jne esPokemon2
                    xor ax,ax   ; No se realizara el movimiento
                    mov 8[bp],ax ; Guardamos el valor a devolver
                    jmp acaba ; Fin del procedimiento
       esPokemon2:  jmp comprobarEvol

                    ; En el caso de que en la casilla1 no haya un espacio
                    ; ni una bola comprobamos otras posibilidades
        eti2:       mov ax,6[bp] ; ax <- casilla1
                    cmp al, 0B2H ; šMuro?
                    jne eti3
                    ; En este punto, en la casilla1 hay un muro
                    xor ax,ax    ; No se realizara el movimiento
                    mov 8[bp],ax ; Guardamos el valor a devolver
                    jmp acaba  ; Fin del procedimiento

                    ; En el caso de que en la casilla1 no haya un espacio
                    ; ni una bola, ni un muro, habr  un pokemon.

       eti3:        mov ax,4[bp] ; ax <- casilla2
                    cmp al, 0B2H ; šMuro?
                    jne esEspacio3
                    jmp acaba
     esEspacio3:    cmp al, ' '
                    jne esBola3
                    jmp comprobarEvol
     esBola3:       cmp al,'X'  ; šBola?
                    jne esPokemon3
                    xor ax,ax    ; No nos moveremos
                    mov 8[bp],ax ; Guardamos el valor a devolver
                    jmp acaba ; Fin del procedimiento
     esPokemon3:    jmp comprobarEvol


      evolucionar:  mov dx,26[bp]
                    cmp dx,1  ; Vemos que pokemon va a evolucionar
                    jne evoluciona2
                    cmp evolucionJug1,1
                    jne noEvol1
                    call pintarBolaEvolucion
                    mov tiempoEvolucion1,0
                    jmp acaba
         noEvol1:   mov evolucionJug1,1 ; Jugador 1 evoluciona
                    or color1aux,10000000b  ; Parpadea el pokemon
                    ; Pintamos mensaje de evoluci¢n por pantalla
                    xor bx,bx
                    mov bx,1
                    push bx
                    call pintarMensajeEvolucion
                    push bx
                    xor ax,ax
                    mov al,pokemonJug1
                    push ax
                    call pintarMensajePokemonEvolucion
                    xor ax,ax
                    mov ax,1  ; Nos vamos a mover
                    mov 8[bp],ax  ; Guardamos el valor a devolver
                    jmp acaba ; Fin del procedimiento
       evoluciona2: cmp evolucionJug2,1
                    jne noevol2
                    call pintarBolaEvolucion
                    mov tiempoEvolucion2,0
                    jmp acaba
        noEvol2:    mov evolucionJug2,1 ; Jugador 2 evoluciona
                    or color2aux,10000000b ; Parpadea el pokemon
                    xor bx,bx
                    mov bx,2
                    push bx
                    call pintarMensajeEvolucion
                    push bx
                    xor ax,ax
                    mov al,pokemonJug2
                    push ax
                    call pintarMensajePokemonEvolucion
                    xor ax,ax
                    mov ax,1  ; Nos vamos a mover
                    mov 8[bp],ax  ; Guardamos el valor a devolver
                    jmp acaba ; Fin del procedimiento


    comprobarEvol:  mov al,evolucionJug2
                    cmp evolucionJug1,al
                    jne ganaAlguien
                    xor ax,ax    ; No nos moveremos
                    mov 8[bp],ax ; Guardamos el valor a devolver
                    jmp acaba ; Fin del procedimiento
    ganaAlguien:    mov terminar,1
                    xor ax,ax    ; No nos moveremos
                    mov 8[bp],ax ; Guardamos el valor a devolver
                    jmp acaba ; Fin del procedimiento

       acaba :      pop dx
                    pop si
                    pop cx
                    pop bx
                    pop ax
                    pop bp
                    ret 4
               ; -----------------------------------------
                    comprobarMovimiento endp
               ; -----------------------------------------


               ; ------------------------------------------
                    moverAbajo proc near
               ; ------------------------------------------
               ; algoritmo moverAbajo

                    push bp
                    mov bp,sp
                    push ax
                    push bx
                    push dx
                    push es
                    push si

                    mov bx,pant
                    mov es, bx
                    mov bx,4[bp]
                    add bx, 320
                    mov ax,es:[bx]
                    mov casilla1,ax
                    add bx,2
                    mov ax,es:[bx]
                    mov casilla2,ax

                    sub sp,2      ; Hacemos hueco en la pila para el valor
                                  ; que devolver  comprobarMovimiento
                    push casilla1 ; Introducimos los 2 par metros
                    push casilla2 ; de entrada del algoritmo
                    call comprobarMovimiento
                    pop ax ; Guardamos el resultado devuelto
                    cmp ax,1
                    je moverLoQueSea
                    jmp muro

                    ; Mueve el pokemon

                    ; Actualizamos la pantalla
                    ; Primero, repintamos escenario
                    ; donde estaba el pokemon
    moverLoQueSea:  mov bx,4[bp]
                    mov dx,color
                    mov es:[bx],byte ptr ' '
                    mov es:1[bx],byte ptr dl
                    add bx,2
                    mov es:[bx],byte ptr ' '
                    mov es:1[bx],byte ptr dl
                    ; Despues pintamos el pokemon
                    ; en su nueva posicion
                    mov ax,6[bp]
                    cmp ax,1
                    jne jprov2
                    add posicion1,160
                    mov si,pokemon1aux
                    mov dl,color1aux
                    jmp sig
       jprov2:      add posicion2,160
                    mov si,pokemon2aux
                    mov dl,color2aux
       sig:         mov bx,4[bp]
                    add bx,160
                    mov ax,[si]
                    mov es:[bx],ax
                    mov es:1[bx], dl
                    add si,1
                    mov ax,[si]
                    add bx,2
                    mov es:[bx],ax
                    mov es:1[bx], dl
                    add si,1
                    mov ax,[si]
                    add bx,158
                    mov es:[bx],ax
                    mov es:1[bx], dl
                    add si,1
                    mov ax,[si]
                    add bx,2
                    mov es:[bx],ax
                    mov es:1[bx], dl

                    ; Fin de mover el pokemon

         muro:      pop si
                    pop es
                    pop dx
                    pop bx
                    pop ax
                    pop bp
                    ret 4
               ; ---------------------------------------------------
                    moverAbajo endp
               ; --------------------------------------------------


               ; ---------------------------------------------------
                    moverDerecha proc near
               ; ----------------------------------------------------

                    push bp
                    mov bp,sp
                    push ax
                    push bx
                    push dx
                    push es
                    push si

                    mov bx,pant
                    mov es, bx
                    mov bx,4[bp]
                    add bx, 4
                    mov ax,es:[bx]
                    mov casilla1,ax
                    add bx,160
                    mov ax,es:[bx]
                    mov casilla2,ax

                    sub sp,2       ; Hacemos hueco en la pila para valor
                                   ; devuelto por comprobarMovimiento
                    push casilla1  ; Introducimos los par metros de
                    push casilla2  ; entrada de comprobarMovimiento
                    call comprobarMovimiento
                    pop ax ; Guardamos el resultado devuelto
                    cmp ax,1
                    je moverLoQueSea2
                    jmp muro2

                    ; Mueve el pokemon

                    ; Actualizamos la pantalla
                    ; Primero, repintamos escapeenario
                    ; donde estaba el pokemon

 moverLoQueSea2:    mov bx,4[bp]
                    mov dx,color
                    mov es:[bx],byte ptr ' '
                    mov es:1[bx],dl
                    add bx,160
                    mov es:[bx],byte ptr ' '
                    mov es:1[bx],dl
                    ; Despues pintamos el pokemon
                    ; en su nueva posicion
                    mov ax,6[bp]
                    cmp ax,1
                    jne pok2
                    mov si,pokemon1aux  ; Offset pokemon 1 pintado
                    mov dl,color1aux    ; Color pokemon 1 pintado
                    add posicion1,2
                    jmp sig2

       pok2:        mov si,pokemon2aux
                    mov dl,color2aux
                    add posicion2,2

       sig2:        mov bx,4[bp]
                    add bx,4
                    mov ax,[si]
                    mov es:[bx],ax
                    mov es:1[bx],byte ptr dl
                    add si,2
                    mov ax,[si]
                    add bx,160
                    mov es:[bx],ax
                    mov es:1[bx],byte ptr dl

            muro2:  pop si
                    pop es
                    pop dx
                    pop bx
                    pop ax
                    pop bp
                    ret 4

               ; ------------------------------------------------
                    moverDerecha endp
               ; ------------------------------------------------


               ; ------------------------------------------------
                    moverIzquierda proc near
               ; ------------------------------------------------
                    push bp
                    mov bp,sp
                    push ax
                    push bx
                    push dx
                    push es
                    push si

                    mov bx,pant
                    mov es, bx
                    mov bx,4[bp]
                    sub bx,2
                    mov ax,es:[bx]
                    mov casilla1,ax
                    add bx,160
                    mov ax,es:[bx]
                    mov casilla2,ax

                    sub sp,2       ; Hacemos hueco en la pila para el valor
                                   ; devuelto por comprobarMovimiento
                    push casilla1  ; Introducimos los par metros de
                    push casilla2  ; entrada de comprobarMovimiento
                    call comprobarMovimiento
                    pop ax ; Guardamos el resultado devuelto
                    cmp ax,1
                    je moverLoQueSea3
                    jmp muro3

                    ; Mueve el pokemon

                    ; Actualizamos la pantalla
                    ; Primero, repintamos escapeenario
                    ; donde estaba el pokemon


   moverLoQueSea3:  mov bx,4[bp]
                    add bx,2
                    mov dx,color
                    mov es:[bx],byte ptr ' '
                    mov es:1[bx],dl
                    add bx,160
                    mov es:[bx],byte ptr ' '
                    mov es:1[bx],dl
                    ; Despues pintamos el pokemon
                    ; en su nueva posicion
                    mov ax,6[bp]
                    cmp ax,1
                    jne pok3
                    mov si,pokemon1aux  ; Offset pokemon 1 pintado
                    mov dl,color1aux    ; Color pokemon 1 pintado
                    sub posicion1,2
                    jmp sig3

       pok3:        mov si,pokemon2aux
                    mov dl,color2aux
                    sub posicion2,2

        sig3:       mov bx,4[bp]
                    sub bx,2
                    mov ax,[si]
                    mov es:[bx],ax
                    mov es:1[bx],dl
                    add si,2
                    mov ax,[si]
                    add bx,160
                    mov es:[bx],ax
                    mov es:1[bx],dl

           muro3:   pop si
                    pop es
                    pop dx
                    pop bx
                    pop ax
                    pop bp
                    ret 4
               ; ---------------------------------------------------
                    moverIzquierda endp
               ; ---------------------------------------------------


               ; ---------------------------------------------------
                    moverArriba proc near
               ; ---------------------------------------------------

                    push bp
                    mov bp,sp
                    push ax
                    push bx
                    push dx
                    push es
                    push si

                    mov bx,pant
                    mov es, bx
                    mov bx,4[bp]
                    sub bx,160
                    mov ax,es:[bx]
                    mov casilla1,ax
                    add bx,2
                    mov ax,es:[bx]
                    mov casilla2,ax

                    sub sp,2       ; Hacemos hueco en la pila para el valor
                                   ; que devolver  comprobarMovimiento.
                    push casilla1  ; Introducimos los par metros de
                    push casilla2  ; entrada de comprobarMovimiento
                    call comprobarMovimiento
                    pop ax ; Guardamos el resultado devuelto
                    cmp ax,1
                    je moverLoQueSea4
                    jmp muro4

                    ; Mueve el pokemon

                    ; Actualizamos la pantalla
                    ; Primero, repintamos escapeenario
                    ; donde estaba el pokemon

 moverLoQueSea4:    mov bx,4[bp]
                    add bx,160
                    mov dx,color
                    mov es:[bx],byte ptr ' '
                    mov es:1[bx],dl
                    add bx,2
                    mov es:[bx],byte ptr ' '
                    mov es:1[bx],dl
                    ; Despues pintamos el pokemon
                    ; en su nueva posicion
                    mov ax,6[bp]
                    cmp ax,1
                    jne pok4
                    mov si,pokemon1aux  ; Offset pokemon 1 pintado
                    mov dl,color1aux    ; Color pokemon 1 pintado
                    sub posicion1,160
                    jmp sig4

       pok4:        mov si,pokemon2aux
                    mov dl,color2aux
                    sub posicion2,160

        sig4:       mov bx,4[bp]
                    add si,2
                    mov ax,[si]
                    mov es:[bx],ax
                    mov es:1[bx],dl
                    add si,1
                    mov ax,[si]
                    add bx,2
                    mov es:[bx],ax
                    mov es:1[bx],dl
                    sub si,3
                    mov ax,[si]
                    mov bx, 4[bp]
                    sub bx,160
                    mov es:[bx],ax
                    mov es:1[bx],dl
                    add si,1
                    mov ax,[si]
                    add bx,2
                    mov es:[bx],ax
                    mov es:1[bx], dl

           muro4:   pop si
                    pop es
                    pop dx
                    pop bx
                    pop ax
                    pop bp
                    ret 4
               ; ---------------------------------------
                    moverArriba endp
               ; ---------------------------------------


               ; --------------------------------------
                   pintarPokemon proc near
               ; --------------------------------------
                    push bp
                    mov bp,sp
                    push ax
                    push bx
                    push cx
                    push dx
                    push si

                    mov bx,4[bp] ; Posici¢n donde empezamos a pintar
                    mov dx,6[bp] ; Color del pokemon a pintar (en dl)
                    mov si,8[bp] ; Offset del pokemon a pintar
                    mov cx,pant
                    mov es,cx
                    mov cx,2

     parteAlta:     mov ax,[si]
                    mov es:[bx],ax
                    mov es:1[bx],dl
                    add bx,2
                    inc si
                    loop parteAlta

                    add bx,156
                    mov cx,2

       parteBaja:   mov ax,[si]
                    mov es:[bx],ax
                    mov es:1[bx],dl
                    add bx,2
                    inc si
                    loop parteBaja

                    pop si
                    pop dx
                    pop cx
                    pop bx
                    pop ax
                    pop bp
                    ret 6
               ; ---------------------------------------
                    pintarPokemon endp
               ; ---------------------------------------


               ; -----------------------------------
                  pintarMensajePokemon proc near
               ; -----------------------------------
                    push bp
                    mov bp,sp
                    push ax
                    push bx
                    push cx
                    push dx
                    push si

                    cmp pokemonJug1,tecla1
                    jne esBulbasaur1
                    mov bx,offset pikachu
                    mov pokemon1aux,bx
                    xor bx,bx
                    mov bl,colorPikachu
                    mov color1aux,bl

                    mov si, offset mensajePikachu
                    mov bx, pant
                    mov es, bx
                    mov bx,0
                    mov cx, lmensajePikachu
                    mov dl,color1aux
                    and color1aux,01111111b
                    and dl,11110000b
                    push ax
                    push cx
                    xor cx,cx
                    mov ax,color
                    and al,11110000b
                    mov cl,4
                    ror dl,cl
                    or dl,al
                    pop cx
                    pop ax

        buclePik:   mov ax, [si]
                    mov es:[bx],ax
                    mov es:1[bx], dl
                    add bx,2
                    inc si
                    loop buclePik

                    jmp jugador2
      esBulbasaur1: cmp pokemonJug1,tecla2
                    jne esCharmander1
                    mov bx, offset bulbasaur
                    mov pokemon1aux,bx
                    xor bx,bx
                    mov bl, colorBulbasaur
                    mov color1aux,bl
                    mov si, offset mensajeBulbasaur
                    mov bx, pant
                    mov es, bx
                    mov bx,0
                    mov cx, lmensajeBulbasaur
                    mov dl,color1aux
                    and dl,11110000b
                    push ax
                    push cx
                    xor cx,cx
                    mov ax,color
                    and al,11110000b
                    mov cl,4
                    ror dl,cl
                    or dl,al
                    pop cx
                    pop ax
        bucleBul:   mov ax, [si]
                    mov es:[bx],ax
                    mov es:1[bx],dl
                    add bx,2
                    inc si
                    loop bucleBul

                    jmp jugador2
     esCharmander1: cmp pokemonJug1,tecla3
                    jne esSquirtle1
                    mov bx, offset charmander
                    mov pokemon1aux,bx
                    xor bx,bx
                    mov bl, colorCharmander
                    mov color1aux,bl
                    mov si, offset mensajeCharmander
                    mov bx, pant
                    mov es, bx
                    mov bx,0
                    mov cx, lmensajeCharmander
                    mov dl,color1aux
                    and dl,11110000b
                    push ax
                    push cx
                    xor cx,cx
                    mov ax,color
                    and al,11110000b
                    mov cl,4
                    ror dl,cl
                    or dl,al
                    pop cx
                    pop ax

        bucleChar:  mov ax, [si]
                    mov es:[bx],ax
                    mov es:1[bx],dl
                    add bx,2
                    inc si
                    loop bucleChar

                    jmp jugador2
       esSquirtle1: mov bx, offset squirtle
                    mov pokemon1aux,bx
                    xor bx,bx
                    mov bl,colorSquirtle
                    mov color1aux,bl
                    mov si, offset mensajeSquirtle
                    mov bx, pant
                    mov es, bx
                    mov bx,0
                    mov cx, lmensajeSquirtle
                    mov dl,color1aux
                    and dl,11110000b
                    push ax
                    push cx
                    xor cx,cx
                    mov ax,color
                    and al,11110000b
                    mov cl,4
                    ror dl,cl
                    or dl,al
                    pop cx
                    pop ax

   bucleSquirtle:   mov ax, [si]
                    mov es:[bx],ax
                    mov es:1[bx],dl
                    add bx,2
                    inc si
                    loop bucleSquirtle
                    mov es:[bx],byte ptr ' '
                    mov es:1[bx],dl

        jugador2:   cmp pokemonJug2,tecla1
                    jne esBulbasaur2
                    mov bx, offset pikachu
                    mov pokemon2aux,bx
                    xor bx,bx
                    mov bl,colorPikachu
                    mov color2aux,bl
                    mov si, offset mensajePikachu
                    mov bx, pant
                    mov es, bx
                    mov bx,146 ; (80 - lmensajePikachu)*2
                    mov cx, lmensajePikachu
                    mov dl,color2aux
                    and color2aux,01111111b
                    and dl,11110000b
                    push ax
                    push cx
                    xor cx,cx
                    mov ax,color
                    and al,11110000b
                    mov cl,4
                    ror dl,cl
                    or dl,al
                    pop cx
                    pop ax

       buclePik2:   mov ax, [si]
                    mov es:[bx],ax
                    mov es:1[bx],dl
                    add bx,2
                    inc si
                    loop buclePik2

                    jmp siguiente
      esBulbasaur2: cmp pokemonJug2,tecla2
                    jne esCharmander2
                    mov bx, offset bulbasaur
                    mov pokemon2aux,bx
                    xor bx,bx
                    mov bl,colorbulbasaur
                    mov color2aux,bl
                    mov si, offset mensajeBulbasaur
                    mov bx, pant
                    mov es, bx
                    mov bx,142
                    mov cx, lmensajeBulbasaur
                    mov dl,color2aux
                    and dl,11110000b
                    push ax
                    push cx
                    xor cx,cx
                    mov ax,color
                    and al,11110000b
                    mov cl,4
                    ror dl,cl
                    or dl,al
                    pop cx
                    pop ax

        bucleBul2:  mov ax, [si]
                    mov es:[bx],ax
                    mov es:1[bx],dl
                    add bx,2
                    inc si
                    loop bucleBul2

                    jmp siguiente
   esCharmander2:   cmp pokemonJug2,tecla3
                    jne esSquirtle2
                    mov bx, offset charmander
                    mov pokemon2aux, bx
                    xor bx,bx
                    mov bl,colorCharmander
                    mov color2aux,bl
                    mov si, offset mensajeCharmander
                    mov bx, pant
                    mov es, bx
                    mov bx,140
                    mov cx, lmensajeCharmander
                    mov dl,color2aux
                    and dl,11110000b
                    push ax
                    push cx
                    xor cx,cx
                    mov ax,color
                    and al,11110000b
                    mov cl,4
                    ror dl,cl
                    or dl,al
                    pop cx
                    pop ax
       bucleChar2:  mov ax, [si]
                    mov es:[bx],ax
                    mov es:1[bx],dl
                    add bx,2
                    inc si
                    loop bucleChar2

                    jmp siguiente
       esSquirtle2: mov bx, offset squirtle
                    mov pokemon2aux, bx
                    xor bx,bx
                    mov bl,colorSquirtle
                    mov color2aux, bl
                    mov si, offset mensajeSquirtle
                    mov bx, pant
                    mov es, bx
                    mov bx,140
                    mov dx,color
                    mov es:[bx],byte ptr ' '
                    mov es:1[bx],dl
                    add bx,2
                    mov es:[bx],byte ptr ' '
                    mov es:1[bx],dl
                    add bx,2
                    mov cx, lmensajeSquirtle
                    mov dl,color2aux
                    and dl,11110000b
                    push ax
                    push cx
                    xor cx,cx
                    mov ax,color
                    and al,11110000b
                    mov cl,4
                    ror dl,cl
                    or dl,al
                    pop cx
                    pop ax

        bucleSq2:   mov ax, [si]
                    mov es:[bx],ax
                    mov es:1[bx],dl
                    add bx,2
                    inc si
                    loop bucleSq2

       siguiente:   pop si
                    pop dx
                    pop cx
                    pop bx
                    pop ax
                    pop bp
                    ret
               ; -----------------------------------
                  pintarMensajePokemon endp
               ; -----------------------------------


principal:          mov ax,@data
                    mov ds,ax

                    ; Pintamos la pantalla inicial del juego

                    push colorPantallaPres1 ; Introducimos los par metros
                    push offset eleccion1   ; de entrada del procedimiento
                    call pintarPantalla

                    mov bx,1  ; bx se va a utilizar como contador
                              ; para las teclas que nos interesan
                              ; y que ya han sido pulsadas
                    xor ax,ax
                    ; ----------------------------------------
                    ; Manejo de teclado por encuesta(polling)
                    ; ----------------------------------------

       consulta:    in al,64H
                    test al,1 ; šDato disponible?
                    jz consulta

                    ; Leemos la tecla pulsada
                    in al,datoTeclado

                    ; Realizamos el strobe de teclado
                    push ax          ; Guardamos la tecla pulsada
                    in al,strobe
                    or al,80h        ; Forzamos a 1
                    out strobe,al
                    and al,01111111b ; 7Fh
                    out strobe,al    ; Forzamos a 0
                    and al,11111100b ; NO sonido
                    out strobe,al    ; NO sonido
                    pop ax           ; Recuperamos la tecla pulsada

                    cmp bx,2  ; šYa se ha elegido pokemon para el jugador 1?
                    je tratamiento2  ; S¡, ahora vamos a elegir el
                                     ; pokemon del jugador 2.
                    cmp bx,3  ; šYa se ha elegido pokemon para el jugador 2?
                    je tratamiento3  ; S¡, vamos a elegir escenario.

   tratamiento:     cmp al,5     ; šSe ha pulsado Escape o alguna
                                 ; tecla de elecci¢n de pokemon?
                    ja consulta  ; Si no, volvemos a consultar
                    test al,80h  ; šTecla pulsada o soltada?
                    jz bajada    ; Se ha pulsado la tecla
                    jmp consulta ; Si se ha soltado, volvemos a consultar

      bajada:       cmp al,escape      ; šSe ha pulsado Escape?
                    jne teclaEleccion  ; Se ha pulsado una tecla
                                       ; de elecci¢n de pokemon.
                    jmp volverAlDos    ; Se ha pulsado Escape, vamos al DOS
  teclaEleccion:    mov pokemonJug1,al ; Almacena la tecla pulsada,
                                       ; que corresponde al pokemon
                                       ; elegido por el jugador 1.
                    inc bx             ; Incrementamos el contador
                                       ; de teclas pulsadas v lidas.
                    ; Pintamos la pantalla de elecci¢n de Pokemon
                    ; del jugador 2
                    push colorPantallaPres2 ; Introducimos los par metros
                    push offset eleccion2   ; de entrada del procedimiento
                    call pintarPantalla
                    jmp consulta

      tratamiento2: cmp al,5      ; šSe ha pulsado Escape o alguna
                                  ; tecla de elecci¢n de pokemon?
                    ja consulta   ; Si no, volvemos a consultar
                    test al,80h   ; šTecla pulsada o soltada?
                    jz bajada2    ; Se ha pulsado la tecla
                    jmp consulta  ; Si se ha soltado, volvemos a consultar
       bajada2:     cmp al,escape ; šSe ha pulsado Escape?
                    jne teclaEleccion2  ; Se ha pulsado una tecla de
                                        ; elecci¢n de pokemon.
                    jmp volveralDos  ; Se ha pulsado Escape, vamos al DOS
 teclaEleccion2:    mov pokemonJug2,al   ; almacena la tecla pulsada
                    inc bx  ; Incrementamos el contador
                            ; de teclas pulsadas v lidas.

                    ; Ya han elegido los 2 jugadores pokemon
                    ; Pintamos la pantalla de eleccion de escenarios

                    push colorPantallaPres1
                    push offset elegirEscenario
                    call pintarPantalla
                    jmp consulta

   tratamiento3:    cmp al,5    ; šSe ha pulsado Escape o alguna tecla
                                ; de elecci¢n de pokemon?
                    jna pulsada
                    jmp consulta ; Si no, volvemos a consultar
     pulsada:       test al,80h ; šTecla pulsada o soltada?
                    jz bajada3  ; Se ha pulsado la tecla

     bajada3:       cmp al,escape  ; šSe ha pulsado escape?
                    jne teclaEleccion3 ; Si no se ha pulsado escape..
                    jmp volverAlDos  ; Se ha pulsado escape, volvemos al DOS
   teclaEleccion3:  cmp al,tecla1  ; šSe ha pulsado la tecla1?
                    jne esEscenario2
                    mov bx,colorEscenario1
                    mov color,bx
                    push color
                    push offset escenario1
                    call pintarPantalla
                    jmp comienzo
     esEscenario2:  cmp al,tecla2
                    jne esEscenario3
                    mov bx,colorEscenario2
                    mov color,bx
                    push color
                    push offset escenario2
                    call pintarPantalla
                    jmp comienzo
     esEscenario3:  cmp al,tecla3
                    jne esEscenario4
                    mov bx,colorEscenario3
                    mov color,bx
                    push color
                    push offset escenario3
                    call pintarPantalla
                    jmp comienzo
      esEscenario4: mov bx,colorEscenario4
                    mov color,bx
                    push color
                    push offset escenario4
                    call pintarPantalla

   comienzo:        call pintarMensajePokemon

               ; Pintamos los pokemon por pantalla

                    push pokemon1aux  ; Primero el
                    xor ax,ax
                    mov al,color1aux  ; pokemon 1
                    push ax
                    push posicion1    ; donde corresponde.
                    call pintarPokemon
                    push pokemon2aux   ; Y a continuaci¢n
                    xor ax,ax
                    mov al,color2aux   ; el pokemon 2
                    push ax
                    push posicion2     ; en la posici¢n de pantalla
                    call pintarPokemon ; que le corresponde.


                    call pintarBolaEvolucion ; Pintamos la pokeball
                    call cambiarTablaInt     ; Modificamos vector de int.
                    call pintarBolaEvolucion ; Pintamos otra pokeball (extra)

      sigue:        cmp terminar,1
                    jne sigue

                    mov al,evolucionJug2
                    cmp evolucionJug1,al
                    jne ganaJug1
                    push colorCharmander
                    push offset empate
                    call pintarPantalla
                    jmp acabar
       ganaJug1:    cmp evolucionJug1,1
                    jne ganaJug2
                    push colorCharmander
                    push offset pantGanaJug1
                    call pintarPantalla
                    jmp acabar
        ganaJug2:   push colorCharmander
                    push offset pantGanaJug2
                    call pintarPantalla

        acabar:     mov bx,1
                    xor ax,ax
        rest:       call restaurarTablaInt  ; Restauramos el vector de
                                            ; interrupciones original.


       consultaFin: in al,64H
                    test al,1 ; šDato disponible?
                    jz consultaFin

                    in al,datoTeclado  ; Leemos la tecla pulsada

                    push ax     ; Strobe de teclado
                    in al,strobe
                    or al,80h
                    out strobe,al
                    and al,7Fh
                    out strobe,al
                    and al,11111100b ; NO sonido
                    out strobe,al    ; NO sonido
                    pop ax

                    test al,80h
                    jne consultaFin
      bajada4:      cmp al,escape
                    je volverAlDos
                    cmp al,tecla1
                    jne consultaFin
                    ; Reiniciamos las variables
                    mov terminar,0
                    mov evolucionJug1,0
                    mov evolucionJug2,0
                    mov posicion1,962
                    mov posicion2,3674
                    jmp principal


                    ; Retornamos al DOS
   volverAlDos:     xor ax, ax
                    mov ah,4Ch   ; Trap del sistema operativo
                    int 21h      ; para devolver el control


   End principal

