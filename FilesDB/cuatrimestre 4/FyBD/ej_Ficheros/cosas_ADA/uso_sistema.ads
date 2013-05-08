--***************************************************************
--Fichero:      uso_sistema.ads
--Tema:         m'odulo para llamadas al S.O.
--Fecha:                Enero-97
--Autor:                Propio
--Com.:         Uso en ADA de funciones de stdlib (C)
--***************************************************************

package uso_sistema is
        subtype ticks is integer range 0..integer'last;
        type clock_t is private;
        type regTMS is private;
        -------------------------------------------------------------
        procedure sistema(laOrden: in string);
        -- Pre: 'laOrden' contiene un string con una orden
        --                      UNIX
        --      Post:   hace que el S.O. ejecute la instrucci`on
        -- Com: ejemplo de uso: 'sistema("ls -al")' presenta
        --                      en salida standard un listado de los ficheros
        --                      del actual directorio
        -------------------------------------------------------------
        procedure marca(m:out ticks);
        --      Pre:    TRUE
        -- Post:        asigna a 'm' un entero, contado en 'ticks'
        --                      (fracci'on de segundo cuyo valor depende
        --                      del sistema)
        --      Com:    indica el tiempo de CPU (procesamiento)
        --                      usado por el sistema desde un cierto
        --                      instante tomado como inicial (instante de comienzo
        --                      de la ejecuci`on del proceso).
        --                      La forma de saber el tiempo que un conjunto
        --                      de instrucciones necesita para ejecutarse
        --                      consiste en 'marcar' antes y despu`es de su
        --                      ejecuci`on. El tiempo que ha necesitado es la
        --                      diferencia. Ejemplo: supongamos que deseamos
        --                      conocer el tiempo de ejecuci`on de una invocaci`on
        --                      al siguiente procedimiento para el valor n=100
        --                              procedure proc(n:in integer);
        --                      La forma de hacerlo podr`ia ser:
        --                              ......
        --                              t1,t2:ticks;
        --                              ......
        --                              marca(t1);      --t1=tiempo transcurrido desde origen
        --                                                              --hasta este momento
        --                              proc(100);
        --                              marca(t2);      --t2=tiempo transcurrido desde origen
        --                                                              --hasta este momento
        --                              ......
        --                              put("Tiempo necesitado (en ticks)");
        --                              put(t2-t1);     --tiempo transcurrido entre los instantes
        --                                                              --t1 y t2
        --      Importante: Aunque en la especificaci'on se habla de "tiempo"
        --                      en realidad se mide el n'umero de"ticks", que es una
        --                      proporci`on del tiempo. La constante de proporci`on
        --                      depende del sistema.
        -------------------------------------------------------------
private
        type clock_t is new integer;
        type regTMS is record
                uTime:clock_t;
                sTime:clock_t;
                cuTime:clock_t;
                csTime:clock_t;
        end record;
end uso_sistema;
