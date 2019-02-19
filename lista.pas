{TITULO: Practicas de EDI
SUBTITULO: Bloque 2
AUTOR: Jesus Angel Perez-Roca Fernandez
LOGIN: infjpf02
GRUPO: E.I.
FECHA: 14/05/2001}

UNIT lista;

INTERFACE

USES cola;

TYPE

  tPos=^tNodo;
  tNodo=RECORD
         Cola_p:tCola;
         Pri:tPri;
         sig:tPos;
         ant:tPos;
        END;
  tLista=tPos;
  tPri=1,2,3; {1="baja", 2="media", 3="alta"}

VAR

  Lista:tLista;
  Cola_p:tCola;
  Posicion:tPos;
  Pri:tPri;

Procedure Lista_vacia(VAR Lista:tLista);
Function Es_vacia(Lista:tLista):Boolean;
Function Insertar_ordenado(Cola_p:tCola; Pri:tPri; VAR Lista:tLista):Boolean;
Function Primero(Lista:tLista):tPos;
Function Ultimo(Lista:tLista):tPos;
Function Existe_Pri(Pri:tPri;Lista:tLista):Boolean;
Function Localiza_Posicion(Pri:tPri;Lista:tLista):tPos;
Function Borrar(Posicion:tPos;VAR Lista:tLista):Boolean;
Function Siguiente(Posicion:tPos;Lista:tLista):tPos;
Function Cola_Posicion(Posicion:tPos;Lista:tLista):tCola;


IMPLEMENTATION

PROCEDURE Lista_vacia(VAR Lista:tLista);
{Objetivo: Crear una Lista vacia
 Entradas: Una Lista de tipo Lista
 Salidas: Una Lista vacia de tipo Lista}
BEGIN
 Lista:=nil;
END;


FUNCTION Es_vacia(Lista:tLista):Boolean;
{Objetivo: Determinar si una Lista esta vacia
 Entradas: Una Lista de tipo Lista
 Salidas: Devuelve verdadero si esta vacia y falso si no lo esta}
BEGIN
 Es_vacia:=(Lista=nil);
END;


FUNCTION Insertar_ordenado(Cola_p:tCola; Pri:tPri; VAR Lista:tLista):Boolean;
{Objetivo: Insertar una cola vacia con prioridad Pri dentro de la Lista siguiendo un orden
 decreciente de prioridad
 Entradas: Una Cola_p de tipo Cola y una Lista de tipo Lista
 Salidas: Devuelve verdadero si se ha podido modificar la Lista y devuelve falso si no hay
 memoria para modificarla
 Precondiciones: No se puede insertar una cola si ya existe una cola con su misma prioridad
 Poscondiciones: Tambien devuelve la Lista modificada. Si se intenta insertar una cola con una prioridad igual a una ya existente se mostrara un mensaje de error}
VAR q,r:tPos;
BEGIN
 IF SizeOf(Lista)>=Maxavail THEN Insertar_ordenado:=FALSE
    ELSE Insertar_ordenado:=TRUE;

 new(q);
 IF Es_vacia(Lista) THEN BEGIN
     q^.Cola_p:=Cola_p;
     q^.Pri:=Pri;
     q^.sig:=q;
     q^.ant:=q;
     Lista:=q;
     END
    ELSE IF not Existe_Pri(Pri) THEN BEGIN
            q^.Cola_p:=Cola_p;
            q^.Pri:=Pri;
            new(r);
            r:=Lista;
            WHILE (q^.Pri<r^.Pri) AND (r^.sig<>Lista) DO r:=r^.sig;
            IF (r=Lista) THEN BEGIN
                  q^.sig:=r;
                  q^.ant:=r^.ant;
                  r^.ant:=q;
                  r^.sig:=q;
                  Lista:=q;
                  END
               ELSE BEGIN
                     q^.sig:=r^.sig;
                     q^.ant:=r;
                     r^.sig:=q;
                     Lista:=Lista;
                    END;
             END
           ELSE WRITELN('Ya existe una cola con esa prioridad');
END;


FUNCTION Primero(Lista:tLista):tPos;
{Objetivo: Hallar la posicion del primer elemento de la Lista
 Entradas: Una Lista de tipo Lista
 Salidas: La posicion del primer elemento de la Lista
 Poscondiciones: Si la Lista esta vacia devuelve una posicion nula}
BEGIN
 IF Es_vacia(Lista) THEN Primero:=nil
   ELSE Primero:=Lista;
END;


FUNCTION Ultimo(Lista:tLista):tPos;
{Objetivo: Hallar la posicion del ultimo elemento de la Lista
 Entradas: Una Lista de tipo Lista
 Salidas: La posicion del ultimo elemento de la Lista
 Poscondiciones: Si la Lista esta vacia devuelve una posicion nula}
BEGIN
 IF Es_vacia(Lista) THEN Ultimo:=nil
   ELSE Ultimo:=Lista^.ant;
END;


FUNCTION Existe_Pri(Pri:tPri;Lista:tLista):Boolean;
{Objetivo: Determinar si existe un nodo con prioridad Pri en una Lista
 Entradas: Una Prioridad de tipo Pri y una Lista de tipo Lista
 Salida: Devuelve verdadero si existe el nodo y falso si no existe
 Poscondicion: Si la Lista esta vacia devuelve falso}
VAR q:tPos;
BEGIN
 IF Es_vacia(Lista) THEN Existe_Pri:=FALSE
   ELSE BEGIN
          new(q);
          q:=Lista;
          WHILE (q^.Pri<>Pri) AND (q^.sig<>Lista) DO q:=q^.sig;
          IF (q^.Pri=Pri) THEN Existe_Pri:=TRUE
             ELSE Existe_Pri:=FALSE;
        END;
END;


FUNCTION Localiza_Posicion(Pri:tPri;Lista:tLista):tPos;
{Objetivo: Localizar un nodo con prioridad Pri en una Lista
 Entradas: Una Prioridad de tipo Pri y una Lista de tipo Lista
 Salida: Devuelve el nodo con Prioridad Pri
 Poscondicion: Si no existe el nodo devuelve posicion nula}
VAR q:tPos;
BEGIN
 IF Es_vacia(Lista) THEN Existe_Pri:=nil
   ELSE BEGIN
          new(q);
          q:=Lista;
          WHILE (q^.Pri<>Pri) AND (q^.sig<>Lista) DO q:=q^.sig;
          IF (q^.Pri=Pri) THEN Existe_Pri:=q
             ELSE Existe_Pri:=nil;
        END;
END;


FUNCTION Borrar(Posicion:tPos;VAR Lista:tLista):Boolean;
{Objetivo: Eliminar de la Lista un nodo con cierta Posicion
 Entradas: Una Posicion y una Lista de tipo Lista
 Salidas: Devuelve verdadero si existe el nodo y falso si no existe
 Poscondiciones: Tambien devuelve la Lista ya sin el elemento con esa cierta Prioridad}
BEGIN
 IF Existe_Pri(Posicion^.Pri,Lista) THEN BEGIN
      Posicion^.sig^.ant:=Posicion^.ant;
      Posicion^.ant^.sig:=Posicion^.sig;
      dispose(Posicion);
      Borrar:=True;
      END
    ELSE Borrar:=False;
END;


FUNCTION Siguiente(Posicion:tPos;Lista:tLista):tPos;
{Objetivo: Hallar el nodo siguiente a un nodo con una cierta Posicion dentro de una Lista
 Entradas: Una Posicion y una Lista de tipo Lista
 Salidas: Devuelve la Posicion del nodo siguiente a un nodo con cierta Posicion dentro de
 una Lista o devuelve posicion nula si el nodo con esa Posicion es el ultimo de la Lista
 Poscondiciones: Tambien devuelve posicion nula si se le pasa una Posicion nula de una Lista
 vacia}
BEGIN
IF Es_vacia(Lista) THEN Siguiente:=nil
   ELSE IF Posicion<>Ultimo(Lista) THEN Siguiente:=Posicion^.sig
           ELSE Siguiente:=nil;
END;


FUNCTION Cola_Posicion(Posicion:tPos;Lista:tLista):tCola;
{Objetivo: Devolver la Cola que tiene una cierta Posicion
 Entradas: Una Posicion y una Lista de tipo Lista
 Salidas: La Cola de esa Posicion
 Poscondiciones: Si la Posicion es nula devuelve una posicion nula
 y un mensaje de advertencia}
BEGIN
 IF (Posicion=nil) THEN BEGIN
         Cola_Posicion:=nil;
         WRITELN('No existe ninguna cola en esa posicion');
         END
     ELSE Cola_Posicion:=Posicion^.Cola;
END;


END.
