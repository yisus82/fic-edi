UNIT arbol;

INTERFACE

USES pila;

TYPE

  tPosA=^tNodoA;
  tNodoA=RECORD
          Datos:tDato;
          De:tPosA;
          Iz:tPosA;
         END;
  tABB=tPosA;

Procedure Arbol_vacio(VAR ABB:tABB);
Function Es_vacio(ABB:tABB):Boolean;
Function Insertar_ABB(Datos:tDato; VAR ABB:tABB):Boolean;
Function Primero_ABB(ABB:tABB):tPosA;
Function Ultimo_ABB(ABB:tABB):tPosA;
Function HijoDe(ABB:tABB):tPosA;
Function HijoIz(ABB:tABB)tPosA;
Function Datos_Posicion(Posicion:tPos;ABB:tABB):tDatos;


IMPLEMENTATION

PROCEDURE Arbol_vacio(VAR ABB:tABB);
BEGIN
 ABB:=nula;
END;


FUNCTION Es_vacio(ABB:tABB):Boolean;
BEGIN
 Es_vacio:=(ABB=nula);
END;


FUNCTION Insertar_ABB(Datos:tDato; VAR ABB:tABB):Boolean;
VAR q,r:tPosA;
BEGIN
 IF SizeOf(ABB)>=Maxavail THEN Insertar_ABB:=FALSE
    ELSE Insertar_ABB:=TRUE;

 new(q);
 IF Es_vacio(ABB) THEN BEGIN
      q^.Datos:=Datos;
      q^.sig:=nula;
      q^.Iz:=nula;
      ABB:=q;
     END
    ELSE BEGIN
          q^.Datos:=Datos;
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
