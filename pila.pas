UNIT pila;

INTERFACE

CONST nula=nil;

TYPE

  tDato=integer;
  tPos=^tNodo;
  tNodo=RECORD
         ABB:tABB;
         sig:tPos;
         ant:tPos;
        END;
  tPila=tPos;

Procedure Pila_vacia(VAR Pila:tPila);
Function Es_vacia(Pila:tPila):Boolean;
Function Insertar(VAR Pila:tCola;Datos:tDato):Boolean;
Function Primero(Pila:tPila):tPos;
Function Ultimo(Pila:tPila):tPos;
Function Sacar(VAR Pila:tPila; VAR d:tDato):Boolean;
Function Anterior(Posicion:tPos;Pila:tPila):tPos;
Function Siguiente(Posicion:tPos;Cola:tPila):tPos;
Function Arbol_Pos(Posicion:tPos;Pila:tPila):tABB;


IMPLEMENTATION

USES abb;

PROCEDURE Pila_vacia(VAR Pila:tPila);
BEGIN
 Cola:=nula;
END;


FUNCTION Es_vacia(Pila:tPila):Boolean;
BEGIN
 Es_vacia:=(Cola=nula);
END;


FUNCTION Insertar(VAR Pila:tPila;ABB:tABB):Boolean;
VAR q:tPos_c;
BEGIN
 IF SizeOf(Pila)>=Maxavail THEN Insertar:=FALSE
    ELSE Insertar:=TRUE;

 new(q);
 IF Es_vacia(Pila) THEN BEGIN
     q^.ABB:=ABB;
     q^.sig:=q;
     q^.ant:=q;
     Pila:=q;
     END
    ELSE BEGIN
          q^.ABB:=ABB;
          q^.sig:=Ultimo(Pila)^.sig;
          q^.ant:=Ultimo(Pila);
          Ultimo(Pila)^.sig:=q;
          Primero(Pila)^.ant:q;
          Pila:=Pila;
         END;
END;


FUNCTION Primero(Pila:tPila):tPos;
BEGIN
 IF Es_vacia(Pila) THEN Primero:=nula
   ELSE Primero:=Pila;
END;


FUNCTION Ultimo(Pila:tPila):tPos;
BEGIN
 IF Es_vacia(Pila) THEN Ultimo:=nula
   ELSE Ultimo:=Pila^.ant;
END;


FUNCTION Sacar(VAR Pila:tPila; VAR ABB:tABB):Boolean;
VAR q:tPos_c;
BEGIN
 IF Es_vacia(Pila) THEN Borrar:=False
    ELSE BEGIN
          new(q);
          q:=Ultimo(Pila);
          q^.sig^.ant:=q^.ant;
          q^.ant^.sig:=q^.sig;
          Pila:=q^.sig;
          ABB:=q^.ABB;
          dispose(q);
         END;
END;


FUNCTION Siguiente(Posicion:tPos;Pila:tPila):tPos;
BEGIN
IF Es_vacia(Pila) THEN Siguiente:=nula
   ELSE IF Posicion<>Ultimo(Pila) THEN Siguiente:=Posicion^.sig
           ELSE Siguiente:=nula;
END;


FUNCTION Arbol_Pos(Posicion:tPos_c;Pila:tPila):tABB;
BEGIN
 IF (Posicion<>nula) THEN Arbol_Pos:=Posicion^.ABB;
END;


END.
