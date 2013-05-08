PROGRAM PREFIXSUM
      IMPLICIT NONE
      !INTEGER, PARAMETER:: TAM=67108864, BLOQUE=131072	! 2^26 y 2^17
      ! las versiones paralelas no funcionan con vectores tan grandes
      INTEGER, PARAMETER:: TAM=8388608, BLOQUE=131072	! 2^23 y 2^17
      INTEGER, PARAMETER:: NUM_HILOS=4, NUM_TRABAJOS=12
      INTEGER, PARAMETER:: CARGA = (TAM/(5*NUM_TRABAJOS))
      INTEGER indice, i, j, ios1, res
      INTEGER MY_THREAD, NUM_THREADS, Barrera, ALLOC_BARRIER, WAIT_BARRIER
      INTEGER count1, count2, t1, t2, tid
      REAL valor, SSUM, suma(5*NUM_TRABAJOS)
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
      END DO
      DO i = 1, 5*NUM_TRABAJOS
         suma(i) = 0.0
      END DO

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

      res = ALLOC_BARRIER(Barrera)

      ! Ponemos en marcha el cronometro
      CALL system_clock(count = count1) ! start timing

      !$DIR PARALLEL_PRIVATE(i,j,t1,t2,tid,res), PARALLEL(MAX_THREADS = NUM_HILOS)
        tid = MY_THREAD()

        DO j=1,((NUM_TRABAJOS)*5),5
	  SELECT CASE (tid)
	    CASE (0)
              vector(((j-1)*CARGA)+1)=vector(((j-1)*CARGA)+1)+suma(j-1)
    	      CALL PRESUM(vector(((j-1)*CARGA)+1),CARGA)
              suma(j) = vector(j*CARGA) 
	    CASE (1)
	      suma(j+1) = SSUM(CARGA,vector((j*CARGA)+1),1) !BLAS
	    CASE (2)
	      suma(j+2) = SSUM(CARGA,vector(((j+1)*CARGA)+1),1) !BLAS
	    CASE (3)
	      suma(j+3) = SSUM(CARGA,vector(((j+2)*CARGA)+1),1) !BLAS
	  END SELECT
          res = WAIT_BARRIER(Barrera,NUM_HILOS)

	  SELECT CASE (tid)
	    CASE (0)
              vector(((j+3)*CARGA)+1)=vector(((j+3)*CARGA)+1) + suma(j) + suma(j+1) + suma(j+2) + suma(j+3)
              IF (j > ((NUM_TRABAJOS-1)*5)) THEN
                CALL PRESUM(vector(((j+3)*CARGA)+1),(TAM-((j+3)*CARGA)))
              ELSE
    	        CALL PRESUM(vector(((j+3)*CARGA)+1),CARGA)
                suma(j+4) = vector((j+4)*CARGA)
              END IF
	    CASE (1)
              vector((j*CARGA)+1)=vector((j*CARGA)+1) + suma(j)
    	      CALL PRESUM(vector((j*CARGA)+1),CARGA) 
	    CASE (2)
              vector(((j+1)*CARGA)+1)=vector(((j+1)*CARGA)+1) + suma(j) + suma(j+1)
    	      CALL PRESUM(vector(((j+1)*CARGA)+1),CARGA)
	    CASE (3)
              vector(((j+2)*CARGA)+1)=vector(((j+2)*CARGA)+1) + suma(j) + suma(j+1) + suma(j+2)
    	      CALL PRESUM(vector(((j+2)*CARGA)+1),CARGA)    
	  END SELECT
          res = WAIT_BARRIER(Barrera,NUM_HILOS)
        END DO
      !$DIR END_PARALLEL

      CALL system_clock(count=count2) ! stop timing
      PRINT *,"system_clock =", (count2-count1),"msg (", 1e-3*(TAM-1)/(count2-count1), "MFLOPs )"
      PRINT *,"elemento(", TAM,") = ", vector(TAM)

      PRINT *, 'Escribiendo resultado ...'

      ! volcado de resultados en fichero
      ! cambiad nip por vuestro identificador para evitar confusiones con los resultados de vuestros compañeros
      OPEN(10, FILE='./tmp/553004', ACTION='WRITE', FORM='FORMATTED', IOSTAT=ios1, ERR=90)
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
