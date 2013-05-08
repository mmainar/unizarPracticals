-- MODULO DE IMPLEMENTACION DEL TAD 'diccionario',
-- ALMACENADO EN UN ARBOL 2-3 (ARBOL B DE GRADO 3)
--
-- Version: 3.0
-- Fecha: 15-I-04
-- Autor: Javier Campos Laclaustra (jcampos@unizar.es)
-- Cambios: se ha corregido un error en la línea 177
with ada.text_io, unchecked_deallocation;
use ada.text_io;
package body arbol_23 is

  procedure disponer is new unchecked_deallocation(nodo,ptNodo);

  procedure vacio(a:out a23) is
  begin
    a.numclaves:=0;
    a.nodos:=null;
  end vacio;

  procedure busca_rec(p:in ptNodo; clave:in tp_clave; 
                      exito:out boolean; valor:out tp_valor) is
  -- es la búsqueda en el arbol 
  -- (la pongo aquí porque se usa también en "=")
  begin
    if p.tipo=hoja then
      if clave=p.clave then --clave encontrada
        exito:=true;
        valor:=p.valor;
      else --clave no encontrada
        exito:=false;
      end if;
    else --p.tipo=interior
      if clave<p.minseg then --buscar en el primer subarbol
        busca_rec(p.pri,clave,exito,valor);
      else --buscar en el segundo o en el tercero
        if (p.ter=null) or (p.ter/=null and then clave<p.minter)
          then --buscar en el segundo subárbol
          busca_rec(p.seg,clave,exito,valor);
        else --buscar en el tercer subárbol
          busca_rec(p.ter,clave,exito,valor);
        end if;
      end if;
    end if;
  end busca_rec;

  procedure buscar(a:in a23; clave:in tp_clave; 
                   exito:out boolean; valor:out tp_valor) is
  begin
    if a.numclaves=0 then  --diccionario vacío
      exito:=false;
    else  --diccionario no vacío
      busca_rec(a.nodos,clave,exito,valor);
    end if;
  end buscar;

  procedure modificar(a:in out a23; 
                      clave:in tp_clave; valor:in tp_valor) is
    pAtras:ptNodo; --puntero al nuevo nodo devuelto por modif_rec
    menorAtras:tp_clave; --menor valor en el subárbol pAtras
    hayInsercion:boolean; --para saber si la clave no estaba
    pAux,pAux2:ptNodo;

    procedure modif_rec(p:in ptNodo; --aquí hay que insertar
                clave:in tp_clave; valor:in tp_valor; --a insertar
                pNuevo:out ptNodo; --pt. al nodo creado a la dch de p
                menor:out tp_clave; --clave mínima del subárbol pNuevo
                hayInsercion:in out boolean) is --la clave no estaba
    --inserta 'clave' en 'p';
    --'hayInsercion' vale verdad si el num. de claves ha aumentado 
    --(se usa para aumentar 'numclaves' en 'modificar' sólo cuando 
    --sea necesario);
    --'pNuevo' devuelve o null o un puntero a un árbol creado a la 
    --derecha de 'p' y que hay que enganchar al padre de 'p';
    --si 'pNuevo' es distinto de null, 'menor' es la menor clave 
    --del árbol 'pNuevo'
      pAtras:ptNodo;
      menorAtras:tp_clave;
      hijo:natural; --en realidad 1..3; indica qué hijo de p se sigue
                    --en la llamada recursiva (relacionado con w)
      w:ptNodo; --puntero al hijo de p en que se hará la inserción
    begin
      pNuevo:=null;
      if p.tipo=hoja then
        if p.clave=clave then --la clave ya estaba; se cambia el valor
          p.valor:=valor;
        else --crea una hoja nueva con la clave y devuelve este nodo
          hayInsercion:=true;
          pNuevo:=new nodo(hoja);
          if p.clave<clave then --pone la clave en el nuevo a la 
                                --dcha del actual
            pNuevo.clave:=clave;
            pNuevo.valor:=valor;
            menor:=clave;
          else --la clave está a la izq del elmto en el nodo actual
            pNuevo.clave:=p.clave;
            pNuevo.valor:=p.valor;
            p.clave:=clave;
            p.valor:=valor;
            menor:=pNuevo.clave;
          end if;
        end if;
      else -- p es un nodo interno
        --selecciona el hijo de p que se debe seguir
        if clave<p.minseg then
          hijo:=1;
          w:=p.pri;
        elsif p.ter=null or else clave<p.minter then --está en el 2º
          hijo:=2;
          w:=p.seg;
        else --la clave está en el tercer subárbol
          hijo:=3;
          w:=p.ter;
        end if;
        modif_rec(w,clave,valor,pAtras,menorAtras,hayInsercion);
        if pAtras/=null then --debe insertarse un nuevo hijo de nodo
          if p.ter=null then --p tiene 2 hijos, se inserta el nuevo 
                             --en su lugar
            if hijo=2 then
              p.ter:=pAtras;
              p.minter:=menorAtras;
            else --hijo=1
              p.ter:=p.seg;
              p.minter:=p.minseg;
              p.seg:=pAtras;
              p.minseg:=menorAtras;
            end if;
          else --p ya tiene 3 hijos
            pNuevo:=new nodo(interior);
            if hijo=3 then --pAtras y el hijo 3 se convierten en 
                           --hijos del nuevo nodo
              pNuevo.pri:=p.ter;
              pNuevo.seg:=pAtras;
              pNuevo.minseg:=menorAtras;
              menor:=p.minter;
              p.ter:=null;
            else --hijo<=2; pasa el 3 hijo de p a pNuevo
              pNuevo.seg:=p.ter;
              pNuevo.minseg:=p.minter;
              p.ter:=null;
              if hijo=2 then --pAtras se convierte en el primer hijo
                             --de pNuevo
                pNuevo.pri:=pAtras;
                menor:=menorAtras;
              else--hijo=1; el hijo 2 de p pasa a pNuevo; pAtras pasa
                  --a ser hijo 2 de p
                pNuevo.pri:=p.seg;
                menor:=p.minseg;
                p.seg:=pAtras;
                p.minseg:=menorAtras;
              end if;
            end if; --de if hijo=3
          end if; --de if p.ter=null
        end if; --de if pAtras/=null
      end if; --de if p.tipo=hoja
    end modif_rec;

  begin --de modificar
    if a.numclaves=0 then --era vacío; se crea con una sola clave
      a.numclaves:=1;
      a.nodos:=new nodo(hoja);
      a.nodos.clave:=clave;
      a.nodos.valor:=valor;
    elsif a.numclaves=1 then --era sólo una hoja
      if a.nodos.clave=clave then --la clave es igual que la que había
        a.nodos.valor:=valor;
      else --hay que crear una nueva hoja para la nueva clave
        a.numclaves:=2;
        pAux:=new nodo(hoja);
        pAux.clave:=clave;
        pAux.valor:=valor;
        if clave<a.nodos.clave then -- la nueva < la que había
          pAux2:=a.nodos;
          a.nodos:=new nodo(interior);
          a.nodos.pri:=pAux;
          a.nodos.seg:=pAux2;
          a.nodos.ter:=null;
 --       a.nodos.minseg:=a.nodos.clave; ESTA INSTRUCCIÓN ESTABA MAL
          a.nodos.minseg:=pAux2.clave;
        else --la nueva es mayor que la que había
          pAux2:=a.nodos;
          a.nodos:=new nodo(interior);
          a.nodos.pri:=pAux2;
          a.nodos.seg:=pAux;
          a.nodos.ter:=null;
          a.nodos.minseg:=clave;
        end if;
      end if;
    else --tenía al menos dos claves (inserción con el alg. recursivo)
      hayInsercion:=false;
      modif_rec(a.nodos,clave,valor,pAtras,menorAtras,hayInsercion);
      if pAtras/=null then --crea la nueva raíz; sus hijos están ahora
                           --apuntados por d y pAtras
        pAux2:=a.nodos;
        a.nodos:=new nodo(interior);
        a.nodos.pri:=pAux2;
        a.nodos.seg:=pAtras;
        a.nodos.ter:=null;
        a.nodos.minseg:=menorAtras;
      end if;
      if hayInsercion then
        a.numclaves:=a.numclaves+1;
      end if;
    end if;
  end modificar;

  procedure borrar(a:in out a23; clave:in tp_clave) is
    unHijo:boolean; 
    hayBorrado:boolean;
    pAux:ptNodo;
    menor:tp_clave;
    
    procedure borra_rec(p:in ptNodo; clave:in tp_clave; 
                        unHijo:out boolean; menor:out tp_clave; 
                        hayBorrado:in out boolean) is
    --borra 'clave' de 'p';
    --si 'p' se queda con un solo hijo devuelve verdad en 'unHijo';
    --si 'clave' es la menor de p entonces 'menor' devuelve la 
    --siguiente mas pequeña;
    --'hayBorrado' devuelve verdad si se ha borrado la clave 
    --(sirve sólo para disminuir el contador de número de claves)
      soloUno:boolean; w:ptNodo; hijo:natural;
    begin
      hayBorrado:=false;
      unHijo:=false;
      if p.pri.tipo=hoja then --los hijos de p son hojas
        if p.pri.clave=clave then --clave a borrar es el hijo 1 de p
          hayBorrado:=true;
          disponer(p.pri); --se borra
          p.pri:=p.seg;    --y se desplaza el 2º hacia la izquierda
          menor:=p.pri.clave; --se ha borrado la más pequeña; 
                              --ésta es la nueva más pequeña
          if p.ter=null then --ahora p tiene un solo hijo
            unHijo:=true;
            p.seg:=null;
          else --se desplaza el tercero hacia su izquierda
            p.seg:=p.ter;
            p.ter:=null;
            p.minseg:=p.minter;
          end if;
        elsif p.seg.clave=clave then --clave a borrar es 2º hijo de p
          hayBorrado:=true;
          disponer(p.seg);
          if p.ter=null then --ahora p tiene un solo hijo
            unHijo:=true;
            p.seg:=null;
          else --se desplaza el tercero hacia su izquierda
            p.seg:=p.ter;
            p.ter:=null;
            p.minseg:=p.minter;
          end if;
        elsif p.ter/=null and then p.ter.clave=clave then 
          --es el tercer hijo de p
          hayBorrado:=true;
          disponer(p.ter); --se borra
          p.ter:=null;
        end if;
      else --los hijos de p no son hojas
        --se selecciona el hijo de p en que hay que borrar
        if clave<p.minseg then --si está, está en el primer subárbol
          hijo:=1;
          w:=p.pri;
        elsif p.ter=null or else clave<p.minter then --si está, está
                                                     --en el segundo
          hijo:=2;
          w:=p.seg;
        else --si está, está en el tercer subárbol
          hijo:=3;
          w:=p.ter;
        end if;
        borra_rec(w,clave,soloUno,menor,hayBorrado);
        if soloUno then --arreglar los hijos de p (para que ninguno
                        --tenga menos de dos hijos)
          if hijo=1 then --el primer hijo de p sólo tiene un hijo
            if p.seg.ter/=null then --el 2º hijo de p tiene 3 hijos
              --pasar el 1er hijo del 2º de p a 2º hijo del 1º de p
              p.pri.seg:=p.seg.pri;
              p.pri.minseg:=p.minseg;
              p.minseg:=p.seg.minseg;
              p.seg.pri:=p.seg.seg;
              p.seg.seg:=p.seg.ter;
              p.seg.minseg:=p.seg.minter;
              p.seg.ter:=null;
            else --el segundo hijo de p tiene dos hijos
              --pasar el hijo de p.pri como 1er hijo del 2º hijo de p
              --y se elimina el primer hijo de p
              w:=p.pri; --se hace una copia para eliminarlo luego
              p.pri:=p.seg;
              p.seg:=p.ter;
              p.ter:=null;
              p.pri.ter:=p.pri.seg;
              p.pri.minter:=p.pri.minseg;
              p.pri.seg:=p.pri.pri;
              p.pri.minseg:=p.minseg;
              p.pri.pri:=w.pri;
              disponer(w);
              p.minseg:=p.minter;
              if p.seg=null then --ahora p sólo tiene un hijo
                unHijo:=true; 
              end if;
            end if;
          elsif hijo=2 then --el segundo hijo de p sólo tiene un hijo
            if p.pri.ter/=null then --el 1er hijo de p tiene 3 hijos
              --pasar el 3er hijo del 1º de p como 1er hijo de p.seg
              p.seg.seg:=p.seg.pri;
              if p.minseg=clave then --se ha borrado la clave menor 
                                     --de p.seg
                p.seg.minseg:=menor;
              else --no ha cambiado la clave menor de p.seg
                p.seg.minseg:=p.minseg;
              end if;
              p.seg.pri:=p.pri.ter;
              p.minseg:=p.pri.minter;
              p.pri.ter:=null;
            else --el primer hijo de p tiene dos hijos
              if p.ter/=null and then p.ter.ter/=null then 
                --el tercer hijo de p existe y tiene tres hijos;
                --se pasa el 1er hijo del 3º de p como 2º de p.seg
                p.seg.seg:=p.ter.pri;
                p.seg.minseg:=p.minter;
                p.minter:=p.ter.minseg;
                if p.minseg=clave then --se ha borrado la menor 
                                       --clave de p.seg
                  p.minseg:=menor;
                end if;
                p.ter.pri:=p.ter.seg;
                p.ter.seg:=p.ter.ter;
                p.ter.ter:=null;
                p.ter.minseg:=p.ter.minter;
              else --ningún otro hijo de p tiene tres hijos
                --el hijo de p.seg pasa a ser el 3º del 1º de p
                p.pri.ter:=p.seg.pri;
                if p.minseg=clave then --se ha borrado la menor 
                                       --clave de p.seg
                  p.pri.minter:=menor;
                else
                  p.pri.minter:=p.minseg;
                end if;
                disponer(p.seg);
                p.seg:=p.ter;
                p.ter:=null;
                p.minseg:=p.minter;
                if p.seg=null then --p se ha quedado con un solo hijo
                  unHijo:=true;
                end if;
              end if;  
            end if;
          else --hijo=3; el tercer hijo de p sólo tiene un hijo
            if p.seg.ter/=null then --el 2º hijo de p tiene 3 hijos
              --se pasa el 3er hijo del 2º de p como 1º de p.ter
              p.ter.seg:=p.ter.pri;
              if p.minter=clave then --se ha borrado la menor 
                                     --clave de p.ter
                p.ter.minseg:=menor;
              else
                p.ter.minseg:=p.minter;
              end if;
              p.ter.pri:=p.seg.ter;
              p.minter:=p.seg.minter;
              p.seg.ter:=null;
            else --el segundo hijo de p tiene dos hijos
              --el hijo de p.ter pasa como tercero del segundo de p
              p.seg.ter:=p.ter.pri;
              if p.minter=clave then --se ha borrado la menor clave 
                                     --de p.ter
                p.seg.minter:=menor;
              else
                p.seg.minter:=p.minter;
              end if;
              disponer(p.ter);
              p.ter:=null;
            end if;
          end if;
        else --soloUno=falso; todos los hijos de p tienen 2 ó 3 hijos
          --falta ver si hay que cambiar p.minseg o p.minter
          if hijo=2 then
            if p.minseg=clave then p.minseg:=menor; end if;
          elsif hijo=3 then
            if p.minter=clave then p.minter:=menor; end if;
          end if; --si hijo=1 no cambian minsec ni minter
        end if;
      end if;
    end borra_rec;
    
  begin --de borrar
    if a.numclaves>0 then --caso contrario el diccionario sigue vacío
      if a.numclaves=1 then --el diccionario es una sola hoja
        if a.nodos.clave=clave then --hay que borrarla
          disponer(a.nodos);
          a.nodos:=null;
          a.numclaves:=0;
        end if;
      else --el diccionario tiene más de un elemento
        borra_rec(a.nodos,clave,unHijo,menor,hayBorrado);
        if hayBorrado then 
          a.numclaves:=a.numclaves-1;
        end if;
        if unHijo then --la raíz sólo tiene un hijo; 
                       --hay que eliminar la raíz
          pAux:=a.nodos;
          a.nodos:=a.nodos.pri;
          disponer(pAux);
        end if;
      end if;
    end if;
  end borrar;
  
  function es_vacio(a:a23) return boolean is
  begin
    return a.numclaves=0;
  end es_vacio;
  
  procedure asignar(aout:out a23; ain:in a23) is
  
    procedure asignar_rec(pout:out ptNodo; pin:in ptNodo) is
      a1,a2,a3:ptNodo;
    begin
      if pin=null then  --es vacío
        pout:=null;
      elsif pin.tipo=hoja then --un solo nodo
        pout:=new nodo'(hoja,pin.clave,pin.valor);
      else --la raíz es un nodo interior
        asignar_rec(a1,pin.pri);
        asignar_rec(a2,pin.seg);
        if pin.ter/=null then
          asignar_rec(a3,pin.ter);
        end if;
        pout:=new nodo'(interior,a1,a2,a3,pin.minseg,pin.minter);
      end if;
    end asignar_rec;

  begin
    aout.numclaves:=ain.numclaves;
    asignar_rec(aout.nodos,ain.nodos);
  end asignar;
  
  function "="(a1,a2:in a23) return boolean is
  
    function incluido(p1,p2: ptNodo) return boolean is
    --devuelve verdad si y sólo si todas las claves de p1 están 
    --en p2 (con iguales valores)
      valor:tp_valor; exito,aux:boolean;
    begin
      if p1=null then
        return true; --trivialmente
      elsif p1.tipo=hoja then
        busca_rec(p2,p1.clave,exito,valor);
        return exito and then valor=p1.valor; --sólo hay una clave en
                                              --p1 y está en p2
      else --p1 es un nodo interior
        aux:=incluido(p1.pri,p2);
        if not aux then
          return false;
        else
          aux:=incluido(p1.seg,p2);
          if not aux then
            return false;
          elsif p1.ter/=null then
            aux:=incluido(p1.ter,p2);
            return aux;
          else
            return true;
          end if;
        end if;
      end if;
    end incluido;

  begin
    if a1.numclaves/=a2.numclaves then
      return false;
    else
      return incluido(a1.nodos,a2.nodos);
    end if;
  end "=";
  
  procedure liberar(a:in out a23) is
  
    procedure liberar_rec(p:in out ptNodo) is
    begin
      if p/=null then  --hay algo que liberar
        if p.tipo=hoja then --sólo una hoja
          disponer(p);
          p:=null;
        else --la raíz es un nodo interior
          liberar_rec(p.pri);
          liberar_rec(p.seg);
          liberar_rec(p.ter);
          disponer(p);
          p:=null;
        end if;
      end if;
    end liberar_rec;

  begin
    liberar_rec(a.nodos);
    a.numclaves:=0; 
  end liberar;
  
  procedure listado(a:in a23) is
  
    procedure listado_rec(p:in ptNodo) is
    begin
      if p/=null then  --hay algo que listar
        if p.tipo=hoja then --un solo nodo
          put_clave(p.clave);
          put(": ");
          put_valor(p.valor);
          new_line;
        else
          listado_rec(p.pri);
          listado_rec(p.seg);
          listado_rec(p.ter);
        end if;
      end if;
    end listado_rec;

  begin
    listado_rec(a.nodos);
  end listado;

end arbol_23;
