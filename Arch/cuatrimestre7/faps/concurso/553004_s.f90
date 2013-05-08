! f90 -v -o c2009 c2009.f90
! ./c2009 /disco4/faps/entrada

PROGRAM PREFIXSUM
      IMPLICIT NONE
      INTEGER, PARAMETER:: TAM=67108864, BLOQUE=131072	! 2^26 y 2^17
      ! las versiones paralelas no funcionan con vectores tan grandes
      !INTEGER, PARAMETER:: TAM=8388608, BLOQUE=131072	! 2^23 y 2^17
      INTEGER indice, i, j, ios1
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

      ! cálculo
      ! NOTA: Toda la carga de optimizacion reside en la compilacion
      ! DESENROLLADO: Lo realiza el compilador. GRADO 4
      ! cálculo
      DO i = 2,TAM
	vector(i) = vector(i) + vector(i-1)
      END DO

      CALL system_clock(count=count2) ! stop timing
      PRINT *,"system_clock =", (count2-count1),"msg (", 1e-3*(TAM-1)/(count2-count1), "MFLOPs )"
      PRINT *,"elemento(", TAM,") = ", vector(TAM)

      PRINT *, 'Escribiendo resultado ...'

      ! volcado de resultados en fichero
      ! cambiad nip por vuestro identificador para evitar confusiones con los resultados de vuestros compañeros
      OPEN(10, FILE='/tmp/553004', ACTION='WRITE', FORM='FORMATTED', IOSTAT=ios1, ERR=90)
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
