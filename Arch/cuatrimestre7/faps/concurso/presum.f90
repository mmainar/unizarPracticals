SUBROUTINE PRESUM(vector, tam)
  !!!
  ! Realiza la suma prefija de vec hasta tam
  !!!
  INTEGER tam, i
  REAL vector(tam)
  
  DO i = 2,tam
    vector(i) = vector(i) + vector(i-1)
  END DO
  
  RETURN
END

SUBROUTINE PRESUM2D(vector, tam)
  !!!
  ! Realiza la suma prefija de vec hasta tam
  ! con un desenrrollado de bucle GRADO 2 SEGURO (tam % 2 = ¿0?)
  !!!
  INTEGER tam, i
  REAL vector(tam)
  
  DO i = 2,tam-1,2
    vector(i) = vector(i) + vector(i-1)
    vector(i+1) = vector(i+1) + vector(i)
  END DO
  
  IF (MOD(TAM,2) .EQ. 0) THEN
    vector(tam) = vector(tam) + vector(tam-1)    
  END IF
  
  RETURN
END

