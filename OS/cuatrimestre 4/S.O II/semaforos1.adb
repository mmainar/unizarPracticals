--**********************************************************--
--Fich.:                semaforos1.adb
--Tema:         Implementaci'on de "semaforos.ads"
--Fecha:                Nov-00
--Fuente:       Propio
--Com.:
--**********************************************************--
package body semaforos1 is
       protected body semaforo is
               entry wait when valor>0 is
               begin
                       valor := valor-1;
               end wait;

               procedure send is
               begin
                       valor := valor+1;
               end send;
       end semaforo;

       protected body semaforoBinario is
               entry wait when valor>0 is
               begin
                       valor := valor-1;
               end wait;

               entry send when valor<1 is
               begin
                       valor := valor+1;
               end send;
       end semaforoBinario;
end semaforos1;