{TITULO: Practicas de EDI
SUBTITULO: Bloque 2
AUTOR: Jesus Angel Perez-Roca Fernandez
LOGIN: infjpf02
GRUPO: E.I.
FECHA: 14/05/2001}

UNIT cola;

INTERFACE

TYPE

  tDato=Real;
  tPos_c=^tNodo_c;
  tNodo_c=RECORD
           Datos:tDato;
           sig_c:tPos_c;
           ant_c:tPos_c;
          END;
  tCola=tPos_c;


VAR

  Cola_p:tCola;
  Pos_c:tPos_c;
  Datos:tDato;

Procedure Cola_vacia(VAR Cola:tCola);
Function Es_cola_vacia(Cola:tCola):Boolean;
Function Insertar_c(VAR Cola:tCola;Datos:tDato):Boolean;
Function Primero_c(Cola:tCola):tPos_c;
Function Ultimo_c(Cola:tCola):tPos_c;
Function Existe_Pos_c(Posicion:tPos_c;Cola:tCola):Boolean;
Function Borrar_c(VAR Cola:tCola; VAR d:tDato):Boolean;
Function Siguiente_c(Posicion:tPos_c;Cola:tCola):tPos_c;
Function Datos_Pos_c(Posicion:tPos_c;Cola:tCola):tDato;


IMPLEMENTATION

PROCEDURE Cola_vacia(VAR Cola:tCola);
{Objetivo: Crear una Cola vacia
 Entradas: Una Cola de tipo Cola
 Salidas: Una Cola vacia de tipo Cola}
BEGIN
 Cola:=nil;
END;


FUNCTION Es_cola_vacia(Cola:tCola):Boolean;
{Objetivo: Determinar si una Cola esta vacia
 Entradas: Una Cola de tipo Cola
 Salidas: Devuelve verdadero si esta vacia y falso si no lo esta}
BEGIN
 Es_cola_vacia:=(Cola=nil);
END;


FUNCTION Insertar_c(VAR Cola:tCola;Datos:tDato):Boolean;
{Objetivo: Insertar unos Datos dentro de la Cola
 Entradas: Una Cola de tipo Cola y unos Datos de tipo Dato
 Salidas: Devuelve verdadero si se ha podido modificar la Cola y devuelve falso si no hay
 memoria para modificarla
 Poscondiciones: Tambien devuelve la Cola modificada}
VAR q:tPos_c;
BEGIN
 IF SizeOf(Cola)>=Maxavail THEN Insertar_c:=FALSE
    ELSE Insertar_c:=TRUE;

 new(q);
 IF Es_cola_vacia(Cola) THEN BEGIN
     q^.Datos:=Datos;
     q^.sig_c:=q;
     q^.ant_c:=q;
     Cola:=q;
     END
    ELSE BEGIN
          q^.Datos:=Datos;
          q^.sig_c:=Ultimo(Cola)^.sig_c;
          q^.ant_c:=Ultimo(Cola);
          Ultimo(cola)^.sig_c:=q;
          Primero(Cola)^.ant_c:q;
          Cola:=Cola;
         END;
END;


FUNCTION Primero_c(Cola:tCola):tPos_c;
{Objetivo: Hallar la posicion del primer elemento de la Cola
 Entradas: Una Cola de tipo Cola
 Salidas: La posicion del primer elemento de la Cola
 Poscondiciones: Si la Cola esta vacia devuelve una posicion nula}
BEGIN
 IF Es_cola_vacia(Cola) THEN Primero_c:=nil
   ELSE Primero_c:=Cola;
END;


FUNCTION Ultimo_c(Cola:tCola):tPos_c;
{Objetivo: Hallar la posicion del ultimo elemento de la Cola
 Entradas: Una Cola de tipo Cola
 Salidas: La posicion del ultimo elemento de la Cola
 Poscondiciones: Si la Cola esta vacia devuelve una posicion nula}
BEGIN
 IF Es_cola_vacia(Cola) THEN Ultimo_c:=nil
   ELSE Ultimo_c:=Cola^.ant_c;
END;


FUNCTION Existe_Pos_c(Posicion:tPos_c;Cola:tCola):Boolean;
{Objetivo: Determinar si existe un nodo con una cierta Posicion en una Cola
 Entradas: Una Posicion de tipo Pos_c y una Cola de tipo Cola
 Salida: Devuelve verdadero si existe el nodo y falso si no existe
 Poscondicion: Si la Cola esta vacia devuelve falso}
VAR q:tPos_c;
BEGIN
 IF Es_cola_vacia(Cola) THEN Existe_Pos_c:=FALSE
   ELSE BEGIN
          new(q);
          q:=Cola;
          WHILE (q<>Posicion) AND (q^.sig_c<>Cola) DO q:=q^.sig_c;
          IF (q=Posicion) THEN Existe_Pos_c:=TRUE
             ELSE Existe_Pos_c:=FALSE;
        END;
END;


FUNCTION Borrar_c(VAR Cola:tCola; VAR d:tDato):Boolean;
{Objetivo: Eliminar de la Cola el primer nodo
 Entradas: Una Cola de tipo Cola y un Dato de tipo Dato
 Salidas: Devuelve verdadero si se ha podido eliminar el nodo y falso si no se ha podido. Tambien devuelve el Dato borrado de la cola o devuelve el dato d si no se ha podido borrar nada de la 
 cola
 Poscondiciones: Tambien devuelve la Cola ya sin el nodo eliminado. Da igual el Dato d introducido, siempre que sea de tipo Real}
VAR q:tPos_c;
BEGIN
 IF Es_cola_vacia(Cola) THEN Borrar:=False
    ELSE BEGIN
          new(q);
          q:=Primero(Cola);
          q^.sig^.ant:=q^.ant;
          q^.ant^.sig:=q^.sig;
          Cola:=q^.sig;
          d:=q^.Datos;
          dispose(q);
         END;
END;


FUNCTION Siguiente_c(Posicion:tPos_c;Cola:tCola):tPos_c;
{Objetivo: Hallar el nodo siguiente a un nodo con una cierta Posicion dentro de una Cola
 Entradas: Una Posicion de tipo Pos_c y una Cola de tipo Cola
 Salidas: Devuelve la Posicion del nodo siguiente a un nodo con cierta Posicion dentro de
 una Cola o devuelve posicion nula si el nodo con esa Posicion es el ultimo de la Cola
 Poscondiciones: Tambien devuelve posicion nula si se le pasa una Posicion nula de una Cola
 vacia}
BEGIN
IF Es_cola_vacia(Cola) THEN Siguiente:=nil
   ELSE IF Posicion<>Ultimo(Cola) THEN Siguiente:=Posicion^.sig_c
           ELSE Siguiente:=nil;
END;


FUNCTION Datos_Pos_c(Posicion:tPos_c;Cola:tCola):tDato;
{Objetivo: Devolver los Datos contenidos en un nodo con una cierta Posicion
 Entradas: Una Posicion de tipo Pos_c y una Cola de tipo Cola
 Salidas: Los Datos del nodo con esa Posicion
 Precondiciones: La Posicion no puede ser nula}
BEGIN
 IF (Posicion<>nil) THEN Datos_Pos_c:=Posicion^.Datos;
END;


END.
