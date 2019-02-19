{TITULO: Practicas de EDI
SUBTITULO: Bloque 1
AUTOR: Jesus Angel Perez-Roca Fernandez
LOGIN: infjpf02
GRUPO: E.I.
FECHA: 17/04/2001}

UNIT polinom;

INTERFACE

TYPE

  tCoef=integer;
  tExp=integer;
  tInfo=RECORD
         coef:tCoef;
         exp:tExp;
        END;
  tPos=^tNodo;
  tNodo=RECORD
         Datos:tInfo;
         sig:tPos;
         ant:tPos;
        END;
  tPolinomio=tPos;

VAR

  Lista:tPolinomio;
  Datos:tInfo;
  n:integer;
  Posicion:tPos;

Procedure Lista_vacia(VAR Lista:tPolinomio);
Function Es_vacia(Lista:tPolinomio):Boolean;
Function Insertar_ordenado(Datos:tInfo; VAR Lista:tPolinomio):Boolean;
Function Primero(Lista:tPolinomio):tPos;
Function Ultimo(Lista:tPolinomio):tPos;
Function Existe_posicion(Posicion:tPos; Lista:tPolinomio):Boolean;
Function Existe_elemento(Datos:tInfo; Lista:tPolinomio):Boolean;
Function Localiza_elemento(Datos:tInfo; Lista:tPolinomio):tPos;
Function Borrar(Posicion:tPos; VAR Lista:tPolinomio):Boolean;
Procedure Vaciar_Lista(VAR Lista:tPolinomio);
Function Cardinal(Lista:tPolinomio):integer;
Function Copia(VAR Lista1:tPolinomio; Lista2:tPolinomio; Posicion:tPos; n:integer):Boolean;
Procedure Concatena(VAR Lista1:tPolinomio; Lista2:tPolinomio);
Procedure Visualizar(Lista:tPolinomio);
Function Siguiente(Posicion:tPos;Lista:tPolinomio):tPos;
Function Datos_posicion(Posicion:tPos;Lista:tPolinomio):tInfo;


IMPLEMENTATION

PROCEDURE Lista_vacia(VAR Lista:tPolinomio);
{Objetivo: Crear una Lista vacia
 Entradas: Una Lista de tipo Polinomio
 Salidas: Una Lista vacia de tipo Polinomio
 Poscondiciones: La Lista que se crea es circular doblemente enlazada}
BEGIN
 Lista:=nil;
END;


FUNCTION Es_vacia(Lista:tPolinomio):Boolean;
{Objetivo: Determinar si una Lista esta vacia
 Entradas: Una Lista de tipo polinomio
 Salidas: Devuelve verdadero si esta vacia y falso si no lo esta}
BEGIN
 Es_vacia:=(Lista=nil);
END;


FUNCTION Insertar_ordenado(Datos:tInfo; VAR Lista:tPolinomio):Boolean;
{Objetivo: Insertar un elemento de contenido Datos dentro de la Lista siguiendo un orden
 creciente de exponente
 Entradas: Unos Datos de tipo Info y una Lista de tipo Polinomio
 Salidas: Devuelve verdadero si se ha podido modificar la Lista y devuelve falso si no hay
 memoria para modificarla
 Poscondiciones: Tambien devuelve la Lista modificada. Si se introducen unos Datos cuyo
 exponente ya esta en los Datos de otro nodo de la Lista, en dicho nodo, el coeficiente
 pasara a ser la suma del coeficiente que habia en el nodo y el coeficiente contenido en los
 Datos introducidos}
VAR q,r:tPos;
BEGIN
 IF SizeOf(Lista)>=Maxavail THEN Insertar_ordenado:=FALSE
    ELSE Insertar_ordenado:=TRUE;

 new(q);
 IF Es_vacia(Lista) THEN BEGIN
     q^.Datos:=Datos;
     q^.sig:=q;
     q^.ant:=q;
     Lista:=q;
     END
    ELSE BEGIN
         q^.Datos:=Datos;
         new(r);
         r:=Lista;
         WHILE (q^.Datos.exp>r^.Datos.exp) AND (r^.sig<>Lista) DO r:=r^.sig;
         IF q^.Datos.exp<r^.Datos.exp THEN BEGIN
               q^.sig:=r;
               q^.ant:=r^.ant;
               r^.ant^.sig:=q;
               r^.ant:=q;
               IF r=Lista THEN Lista:=q;
               END
            ELSE IF q^.Datos.exp=r^.Datos.exp THEN BEGIN
                      r^.Datos.coef:=r^.Datos.coef+q^.Datos.coef;
                      Lista:=Lista;
                      END
                   ELSE BEGIN
                        q^.ant:=r;
                        q^.sig:=r^.sig;
                        r^.sig^.ant:=q;
                        r^.sig:=q;
                        Lista:=Lista;
                        END;
         END;
END;


FUNCTION Primero(Lista:tPolinomio):tPos;
{Objetivo: Hallar la posicion del primer elemento de la Lista
 Entradas: Una Lista de tipo Polinomio
 Salidas: La posicion del primer elemento de la Lista
 Poscondiciones: Si la Lista esta vacia devuelve una posicion nula}
BEGIN
 IF Es_vacia(Lista) THEN Primero:=nil
   ELSE Primero:=Lista;
END;


FUNCTION Ultimo(Lista:tPolinomio):tPos;
{Objetivo: Hallar la posicion del ultimo elemento de la Lista
 Entradas: Una Lista de tipo Polinomio
 Salidas: La posicion del ultimo elemento de la Lista
 Poscondiciones: Si la Lista esta vacia devuelve una posicion nula}
BEGIN
 IF Es_vacia(Lista) THEN Ultimo:=nil
   ELSE Ultimo:=Lista^.ant;
END;


FUNCTION Existe_posicion(Posicion:tPos;Lista:tPolinomio):Boolean;
{Objetivo: Determinar si existe un nodo con cierta Posicion en una Lista
 Entradas: Una posicion y una Lista de tipo Polinomio
 Salida: Devuelve verdadero si existe la Posicion y falso si no existe.
 Poscondicion: Si la Lista esta vacia devuelve falso}
VAR q:tPos;
BEGIN
 IF Es_vacia(Lista) THEN Existe_posicion:=FALSE
   ELSE BEGIN
          new(q);
          q:=Lista;
          WHILE (q<>Posicion) and (q^.sig<>Lista) DO q:=q^.sig;
          Existe_posicion:=(q=Posicion);
        END;
END;


FUNCTION Existe_elemento(Datos:tInfo;Lista:tPolinomio):Boolean;
{Objetivo: Determinar si existe un nodo con contenido Datos en una Lista
 Entradas: Unos Datos de tipo Info y una Lista de tipo Polinomio
 Salida: Devuelve verdadero si existe el nodo y falso si no existe.
 Poscondicion: Si la Lista esta vacia devuelve falso}
VAR q:tPos;
BEGIN
 IF Es_vacia(Lista) THEN Existe_elemento:=FALSE
   ELSE BEGIN
          new(q);
          q:=Lista;
          WHILE (q^.Datos.exp<>Datos.exp) AND (q^.sig<>Lista) DO q:=q^.sig;
          IF (q^.Datos.exp=q^.Datos.exp) THEN Existe_elemento:=(q^.Datos.coef=Datos.coef)
             ELSE Existe_elemento:=FALSE;
        END;
END;


FUNCTION Localiza_elemento(Datos:tInfo;Lista:tPolinomio):tPos;
{Objetivo: Localizar un elemento con contenido Datos dentro de una Lista
 Entradas: Unos Datos de tipo Info y una Lista de tipo Polinomio
 Salidas: Devuelve su posicion o posicion nula si no hay ningun nodo con ese contenido
 Poscondiciones: Si es vacia devuelve posicion nula}
VAR q:tPos;
BEGIN
 IF Es_vacia(Lista) THEN Localiza_elemento:=nil
    ELSE BEGIN
          new(q);
          q:=Lista;
          WHILE (q^.Datos.exp<>Datos.exp) AND (q^.sig<>Lista) DO q:=q^.sig;
          IF (q^.Datos.exp=q^.Datos.exp) AND (q^.Datos.coef=Datos.coef) THEN Localiza_Elemento:=q
             ELSE Localiza_Elemento:=nil;
         END;
END;


FUNCTION Borrar(Posicion:tPos;VAR Lista:tPolinomio):Boolean;
{Objetivo: Eliminar de la Lista un nodo con cierta Posicion
 Entradas: Una Posicion y una Lista de tipo Polinomio
 Salidas: Devuelve verdadero si existe la posicion y falso si no existe
 Poscondiciones: Tambien devuelve la Lista ya sin elemento con esa cierta Posicion}
BEGIN
 IF Existe_posicion(Posicion,Lista) THEN BEGIN
      Posicion^.sig^.ant:=Posicion^.ant;
      Posicion^.ant^.sig:=Posicion^.sig;
      dispose(Posicion);
      Borrar:=True;
      END
    ELSE Borrar:=False;
END;


PROCEDURE Vaciar_Lista(VAR Lista:tPolinomio);
{Objetivo: Eliminar todos los nodos de una Lista
 Entradas: Una Lista de tipo Polinomio
 Salidas: Una Lista vacia de tipo Polinomio
 Poscondiciones: La Lista que se devuelve es circular doblemente enlazada. Si es vacia no
 hace nada}
VAR q:tPos;
BEGIN
 IF not Es_vacia(Lista) THEN BEGIN
    new(q);
    q:=Ultimo(Lista);
    WHILE (q^.ant<>Lista) DO BEGIN
       q:=q^.ant;
       dispose(q^.sig);
       END;
    Lista:=nil;
    dispose(q);
  END;
END;


FUNCTION Cardinal(Lista:tPolinomio):integer;
{Objetivo: Devolver el numero de nodos que contiene una Lista
 Entradas: Una Lista de tipo Polinomio
 Salidas: El numero de nodos de la Lista
 Poscondiciones: Si la Lista es vacia devuelve 0}
VAR q:tPos;
BEGIN
 IF Es_vacia(Lista) THEN Cardinal:=0
    ELSE BEGIN
     Cardinal:=0;
     new(q);
     q:=Lista;
     WHILE (q^.sig<>Lista) DO BEGIN
       q:=q^.sig;
       Cardinal:=Cardinal+1;
       END;
     Cardinal:=Cardinal+1;
    END;
END;


FUNCTION Copia(VAR Lista1:tPolinomio;Lista2:tPolinomio;Posicion:tPos;n:integer):Boolean;
{Objetivo: Copiar en la Lista1 n elementos de la Lista2 a partir de la Posicion
 Entradas: Dos Listas de tipo polinomio, una Posicion y un numero entero n
 Salidas: Devuelve verdadero si se ha podido copiar y falso si no hay memoria suficiente
 para el copiado
 Precondiciones: La Lista1 debe de estar vacia. La Lista2 debe de tener n elementos a partir
 de la Posicion. n debe de ser un numero positivo mayor o igual que uno.
 Poscondiciones: Si n es 0 o un numero negativo no se copia nada, se vacia Lista1 y se
 devuelve falso. Si Lista1 no esta vacia se vaciara. Si Lista2 no tiene n elementos a partir
 de la Posicion, al llegar al ultimo elemnto de la lista se copiara el primero, luego el
 segundo y asi sucesivamente hasta copiar n elementos. En caso de haber elementos con igual
 exponente, los coeficientes se sumaran}
VAR q:tPos;
BEGIN
 IF n<=0 THEN Copia:=False;
 IF not Es_vacia(Lista1) THEN Vaciar_Lista(Lista1);
 WHILE (n>0) DO BEGIN
       new(q);
       q:=Posicion;
       Copia:=Insertar_ordenado(q^.Datos,Lista1);
       q:=q^.sig;
       n:=n-1;
      END;
END;


PROCEDURE Concatena(VAR Lista1:tPolinomio;Lista2:tPolinomio);
{Objetivo: Poner al final de la Lista1 los elementos de la Lista2
 Entradas: Dos listas de tipo Polinomio
 Salidas: Devuelve la Lista1 con los elementos de la Lista2 a continuacion del ultimo
 elemento de Lista1
 Poscondiciones: Si la Lista1 no esta vacia, la Lista1 que se devuelve puede no estar
 ordenada, con lo que la mayoria de las funciones y procedimientos de la Unit polinom no
 funcionarian correctamente al aplicarse a la Lista1 obtenida}
BEGIN
IF Es_vacia(Lista1) THEN Lista1:=Lista2
   ELSE BEGIN
        Ultimo(Lista1)^.sig:=Primero(Lista2);
        Primero(Lista1)^.ant:=Ultimo(Lista2);
        Lista1:=Primero(Lista1);
        END;
END;


PROCEDURE Visualizar(Lista:tPolinomio);
{Objetivo: Mostrar el contenido de una Lista
 Entradas: Una Lista de tipo Polinomio
 Salidas: Muestra en pantalla el contenido de la Lista
 Poscondiciones: Los terminos con coeficientes negativos van entre parentesis. X^ significa
 "X elevado a". Si la Lista es vacia no muestra nada. Si el primer elemento de la Lista, es
 decir, el ultimo en ser mostrado, tiene exponente 0 solo se mostrara el coeficiente}
VAR q:tPos;
BEGIN
 IF not Es_vacia(Lista) THEN BEGIN
    new(q);
    q:=Ultimo(Lista);
    WHILE q<>Primero(Lista) DO BEGIN
         IF q^.Datos.coef<>0 THEN IF q^.Datos.coef<0 THEN WRITE('(',q^.Datos.coef,'X^',q^.Datos.exp,') +')
            ELSE WRITE(q^.Datos.coef,'X^',q^.Datos.exp,'+');
         q:=q^.ant;
      END;
    IF q^.Datos.coef<>0 THEN IF q^.Datos.exp=0 THEN IF q^.Datos.coef<0 THEN WRITELN('(',q^.Datos.coef,')')
                                ELSE WRITELN(q^.Datos.Coef)
          ELSE IF q^.Datos.coef<0 THEN WRITELN('(',q^.Datos.coef,'X^',q^.Datos.exp,')')
            ELSE WRITELN(q^.Datos.coef,'X^',q^.Datos.exp);
    END;
END;


FUNCTION Siguiente(Posicion:tPos;Lista:tPolinomio):tPos;
{Objetivo: Hallar el nodo siguiente a un nodo con una cierta Posicion dentro de una Lista
 Entradas: Una Posicion y una Lista de tipo Polinomio
 Salidas: Devuelve la Posicion del nodo siguiente a un nodo con cierta posicion dentro de
 una Lista o devuelve posicion nula si el nodo con esa Posicion es el ultimo de la Lista
 Poscondiciones: Tambien devuelve posicion nula si se le pasa una Posicion nula de una Lista
 vacia}
BEGIN
IF Es_vacia(Lista) THEN Siguiente:=nil
   ELSE IF Posicion<>Ultimo(Lista) THEN Siguiente:=Posicion^.sig
           ELSE Siguiente:=nil;
END;


Function Datos_posicion(Posicion:tPos;Lista:tPolinomio):tInfo;
{Objetivo: Devolver los Datos almacenados en una cierta Posicion
 Entradas: Una Posicion y una Lista de tipo Polinomio
 Salidas: Los Datos almacenados en la Posicion}
BEGIN
 Datos_posicion.exp:=Posicion^.Datos.exp;
 Datos_posicion.coef:=Posicion^.Datos.coef;
END;


END.
