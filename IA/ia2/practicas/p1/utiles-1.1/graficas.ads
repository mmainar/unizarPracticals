---------------------------------------------------------------------
-- Fichero:   graficas.ads
-- Autor:     J.D.Tardos
-- Version:   v1.3 1-3-2002
-- Proposito: Paquete para dibujar en una X-Window
---------------------------------------------------------------------
-- Utiliza el software de dominio publico ada-plotutil-2.3 de GNU
---------------------------------------------------------------------
-- Modificaciones:
-- v1.1, J.D.Tardos, 6-4-2000
--   - Agnadidas opciones al dibujar Puntos y Rectas
-- v1.2, J.D.Tardos, 9-5-2000
--   - Eliminado el "flash" blanco al abrir las ventanas
--   - Agnadidas funciones para calcular los ejes automaticamente
--   - Agnadida funcion Texto
-- v1.3, J.D.Tardos, 1-3-2002
--   - Funcion Texto pasada al package Textos
---------------------------------------------------------------------

with Geometria;
use  Geometria;

package Graficas is

---------------------------------------------------------------
-- Manejo de ventanas con graficas en pantalla 
---------------------------------------------------------------
  type Grafica is private;

  type ejes is record
    xmin, xmax, ymin, ymax: float;
  end record;

  function Calcular_Ejes(R: Rectas) return ejes;
  -- Calcula los limites de los ejes para que todas las rectas sean visibles
  
  function Calcular_Ejes(P: Puntos) return ejes;
  -- Calcula los limites de los ejes para que todos los puntos sean visibles
  
  function Crear_Grafica(titulo: string; xmin, xmax, ymin, ymax: float;
                        cuadrada: boolean := true;
                        xmarcas, ymarcas: integer := 10;
                        geometry: string:= "") return Grafica;
  -- Crea una X-Window para dibujar sobre ella
  -- La string geometry permite especificar el tamaño de ventana, 
  -- de la forma estandas en X-windows. Por ejemplo "500x500+0+0" sera
  -- una ventana de 500 x 500 pixels, en la esquina superior izquierda
  -- de la pantalla


  procedure Borrar_Grafica(G: Grafica);
  -- Borra la ventana, para poder volver a pintar sobre ella

  procedure Dejar_Grafica(G: Grafica);
  -- Termina la grafica actual. La ventana quedara en pantalla
  -- Para borrarla, basta con hacer clic sobre la ventana
  -- Lanza un proceso adicional para controlar la ventana, por lo que
  -- no debe abusarse de Dejar muchas graficas en la pantalla.
  -- Si no se llama a Dejar_Grafica, la ventana se cierra al terminar el programa

  function Ultima_Grafica return Grafica;
  -- Devuelve la ultima grafica creada 

---------------------------------------------------------------
-- Procedimientos de dibujo 
---------------------------------------------------------------

-- Dibujo de puntos sueltos con un redondelito
  procedure Dibujar(G: Grafica; P: punto;  gordo: boolean := false);
  procedure Dibujar(G: Grafica; P: Puntos; gordo: boolean := false);
  
-- Dibujo de lineas poligonales abiertas o cerradas, con o sin puntos  
  procedure Poligonal(G: Grafica; P: Puntos; 
                      con_puntos: boolean:= false;
                      cerrada:    boolean:= false);
  procedure Poligonal(G: Grafica; P: VPuntos; n: integer; 
                      con_puntos: boolean:= false;
                      cerrada:    boolean:= false);
                     
-- Dibujo de celdas rectangulares                     
  procedure Rectangulo(G: Grafica; xmin,xmax,ymin,ymax: float);

-- Dibujo de Rectas. Opcionalmente ee pueden marcar los extremos
  procedure Dibujar(G: Grafica; P1, P2: Punto; Extremos: boolean:= false);
  procedure Dibujar(G: Grafica; R: Recta;  Extremos: boolean:= false);
  procedure Dibujar(G: Grafica; R: Rectas; Extremos: boolean:= true;
                     Numeradas: boolean:= true);

-- Dibujo de Objetos
  procedure Dibujar(G: Grafica; Obj: Objeto);
  procedure Dibujar(G: Grafica; Objs: Objetos4);

-- Elige el color de lapiz y de relleno para los proximos dibujos 
  procedure Colores(G: Grafica; Lapiz: String; Relleno: String := "");

private
  max_graficas: constant := 60;
  type Grafica is new integer range 1..max_graficas;
end Graficas;
