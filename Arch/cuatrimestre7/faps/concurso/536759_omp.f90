! f90 -v +O3 +U77 +Oopenmp +Oreport=all +Oinfo -o 536759_p 536759_p.f90
! OMP_NUM_THREADS=4 ./536759_p /disco4/faps/entrada
!
! AUTOR: Jorge Mena Ramirez (536759)
!
! Cambios respecto a 536759_s.f90:
!    Se han annadido las directivas OpenMP correctas
!    Se ha eliminado el zig-zag de recorrido del vector y se ha aumentado el unroll
!    Se usa el vector pequenno
!
! Problemas en la implementacion:
!    No se permite vectorizacion para que el compilador no annada secciones "MASTER"
!       en las partes paralelizadas con OpenMP
!    El tiempo de ejecucion no varia, independientemente del valor de la variable
!       "OMP_NUM_THEADS", lo que sugiere que no se paraleliza. No entiendo
!       por que no se ejecuta en paralelo
!
! Salida normal:
!
!  Inicializando vector ...
!  Leyendo valores de fichero...
!  Longitud del vector:  8388608
!  Calculando vector resultado ...
!  system_clock = 215 msg ( 39.01678 MFLOPs )
!  elemento( 8388608 ) =  130031744.0
!  Escribiendo resultado ...
! STOP Fin de programa

!

PROGRAM PREFIXSUM
      IMPLICIT NONE
      !INTEGER, PARAMETER:: TAM=67108864, BLOQUE=131072 ! 2^26 y 2^17
      ! las versiones paralelas no funcionan con vectores tan grandes
      INTEGER, PARAMETER:: TAM=8388608, BLOQUE=131072  ! 2^23 y 2^17
      INTEGER, PARAMETER:: SEGMENTACION=131072 ! Tamanno de bloques de trabajo en los que
                                              ! se ejecuta el algoritmo. 131072 * 8 B = 1 MB
      INTEGER indice, i, j, ios1

      INTEGER stride, stride_medios, pos, ini, fin, ultimo
      ! stride y stride_medios: se usan como desplazamiento en el "arbol"
      ! pos: posicion actual en el vector
      ! ini y fin: delimitan el bloque segmentado actual
      ! ultimo: la ultima suma del bloque segmentado. Se annade al primer elemento del siguiente
      !                 segmento a iterar

      INTEGER count1, count2
      REAL valor
      ! save para ubicar el vector en el segmento de datos en lugar de en la pila
      ! (hay mas restriccion de espacio en la pila)
      REAL, SAVE :: vector(TAM)
      ! arg_str is the character array to be written to by IGETARG
      CHARACTER(LEN=32) :: arg_str

      ! parametro 1: nombre del fichero a leer
      CALL GETARG(1, arg_str)

      PRINT *, 'Inicializando vector ...'
      DO i = 1, TAM
         vector(i) = 0.0
      ENDDO

      ! intento leer 131072 valores de fichero (/disco4/faps/entrada)
      OPEN(UNIT=9, FILE=arg_str, ACTION='READ', FORM='FORMATTED', IOSTAT=ios1, ERR=90)
      PRINT *, 'Leyendo valores de fichero...'

      indice = 0
      READ(9, '(F)', IOSTAT=ios1, ERR=92) valor
      DO WHILE ((ios1 >= 0) .AND. (indice < BLOQUE))
             indice = indice + 1
             vector(indice) = valor
             READ(9, '(F)', IOSTAT=ios1, ERR=92) valor
      END DO
      CLOSE(9)

      ! no puedo crear ficheros muy grandes
      ! asi que replico el vector leido
      DO i = 1, TAM/BLOQUE - 1
        DO j = 1, BLOQUE
             indice = indice + 1
             vector(indice) = vector(j)
        END DO
      END DO

      PRINT *, 'Longitud del vector: ', TAM
      PRINT *, 'Calculando vector resultado ...'

      ! Ponemos en marcha el cronometro
      CALL system_clock(count = count1) ! start timing

      ultimo = 0 ! se lo sumaremos al primer elemento del segmento
      ini = 1
      fin = SEGMENTACION
      DO WHILE (fin <= TAM) ! realizamos una segmentacion para evitar fallos en
                            ! cache. Este bucle separa el trabajo en segmentos
        ! FASE 1
        stride = 1
        vector(ini) = vector(ini) + ultimo ! al primer elemento del segmento le
                                           ! sumo el ultimo del segmento anterior

        ! Loop unroll
        DO WHILE (stride * 16 < SEGMENTACION)
          stride_medios = stride
          stride = stride * 2

          !$OMP PARALLEL DEFAULT(SHARED) PRIVATE(pos,indice)
          !$OMP DO
          !FPP$ NODEPCHK
          DO pos =  stride + ini - 1, fin, stride * 8
          ! iter 1 -> stride=2) 2 4 6 8 10 12...
          ! iter 2 -> stride=4) 4 8 12 16 20...
          ! iter 3 -> stride=8) 8 16 24 32...
            indice = pos
            vector(pos) = vector(pos) + vector(pos - stride_medios)
            indice = pos + stride
            vector(indice) = vector(indice) + vector(indice - stride_medios)
            indice = indice + stride
            vector(indice) = vector(indice) + vector(indice - stride_medios)
            indice = indice + stride
            vector(indice) = vector(indice) + vector(indice - stride_medios)
            indice = indice + stride
            vector(indice) = vector(indice) + vector(indice - stride_medios)
            indice = indice + stride
            vector(indice) = vector(indice) + vector(indice - stride_medios)
            indice = indice + stride
            vector(indice) = vector(indice) + vector(indice - stride_medios)
            indice = indice + stride
            vector(indice) = vector(indice) + vector(indice - stride_medios)
          END DO
          !$OMP END DO
          !$OMP END PARALLEL

        END DO

        ! Iteraciones restantes con menos de 8 ciclos en el bucle interno
        DO WHILE (stride < SEGMENTACION)
          stride_medios = stride
          stride = stride * 2

          DO pos =  stride + ini - 1, fin, stride
            vector(pos) = vector(pos) + vector(pos - stride_medios)
          END DO

        END DO
        ultimo = vector(fin) ! para el siguiente segmento

        !FASE 2
        stride = (SEGMENTACION)/2 ! "/2" para ignorar las iteraciones que no
                               ! realizan modificaciones en el vector
        stride_medios = stride/2

        ! Loop unroll
         DO WHILE (stride > 8)

          !$OMP PARALLEL DEFAULT(SHARED) PRIVATE(pos,indice)
          !$OMP DO
          !FPP$ NODEPCHK
          DO pos = fin - stride_medios, ini + stride, stride * 8 ! se ignora el primer "impar" del bucle
            indice = pos
            vector(pos) = vector(pos) + vector(pos - stride_medios)
            indice = pos - stride
            vector(pos) = vector(pos) + vector(pos - stride_medios)
            indice = indice - stride
            vector(pos) = vector(pos) + vector(pos - stride_medios)
            indice = indice - stride
            vector(pos) = vector(pos) + vector(pos - stride_medios)
            indice = indice - stride
            vector(pos) = vector(pos) + vector(pos - stride_medios)
            indice = indice - stride
            vector(pos) = vector(pos) + vector(pos - stride_medios)
            indice = indice - stride
            vector(pos) = vector(pos) + vector(pos - stride_medios)
            indice = indice - stride
            vector(pos) = vector(pos) + vector(pos - stride_medios)
          END DO
          !$OMP END DO
          !$OMP END PARALLEL

           stride = stride_medios
           stride_medios = stride_medios/2
         END DO


        ! Iteraciones restantes con menos de 8 ciclos en el bucle interno
        DO WHILE (stride > 1)

          DO pos = ini + stride, fin - stride_medios, -stride ! se ignora el primer "impar" del bucle
            vector(pos) = vector(pos) + vector(pos - stride_medios)
          END DO

          stride = stride_medios
          stride_medios = stride_medios/2
        END DO
        ini = ini + SEGMENTACION
        fin = fin + SEGMENTACION
      END DO


      CALL system_clock(count=count2) ! stop timing
      PRINT *,"system_clock =", (count2-count1),"msg (", 1e-3*(TAM-1)/(count2-count1), "MFLOPs )"
      PRINT *,"elemento(", TAM,") = ", vector(TAM)

      PRINT *, 'Escribiendo resultado ...'

      ! volcado de resultados en fichero
      ! cambiad nip por vuestro identificador para evitar confusiones con los resultados de vuestros companeros
      OPEN(10, FILE='/tmp/536759', ACTION='WRITE', FORM='FORMATTED', IOSTAT=ios1, ERR=90)
      DO i = 1, TAM
          IF (MODULO(i, BLOQUE) == 0) THEN
              WRITE(10, *, IOSTAT=ios1, ERR=94) vector(i)
          END IF
      END DO
      CLOSE(10)

      STOP 'Fin de programa'

   90 PRINT *, "Open error = ", ios1
   92 PRINT *, "Read error = ", ios1
   94 PRINT *, "Write error = ", ios1

END PROGRAM PREFIXSUM
