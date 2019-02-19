{TITULO: Practicas de EDI
SUBTITULO: Bloque 1
AUTOR: Jesus Angel Perez-Roca Fernandez
LOGIN: infjpf02
GRUPO: E.I.
FECHA: 17/04/2001}

PROGRAM principal;

USES polinom;

VAR
A,B:tPolinomio;
Opcion1,Opcion2,Opcion3:integer;
Datos:tInfo;

FUNCTION SumarPolinomio(A,B:tPolinomio):tPolinomio;
{Objetivo: Suma de dos polinomios
 Entradas: A,B. Punteros a los polinomios a sumar
 Salidas: Puntero al polinomio suma}
VAR q,r:tPos;
BEGIN
new(q);new(r); {Inicializacion de los punteros a nodos}
Lista_vacia(SumarPolinomio); {Inicializacion del Polinomio suma}
q:=A;
r:=B;
IF Es_vacia(A) THEN IF Es_Vacia(B) THEN SumarPolinomio:=SumarPolinomio
                                   ELSE SumarPolinomio:=B
               ELSE IF Es_Vacia(B) THEN SumarPolinomio:=A;
{Hasta ahora esta resuelto el problema de sumar A y B si al menos uno de los dos es una lista
 vacia. Ahora hay que resolverlo para el caso de que ninguno de los dos este vacio}
IF not Es_vacia(A) AND not Es_vacia(B) THEN BEGIN
   WHILE (q<>Ultimo(A)) DO BEGIN
         Insertar_ordenado(Datos_posicion(q,A),SumarPolinomio);
         q:=Siguiente(q,A);
         END;
{Hasta ahora inserta los elementos de A, menos el ultimo, en SumarPolinomio}
   Insertar_ordenado(Datos_posicion(q,A),SumarPolinomio);
{Ahora inserta el ultimo elemento de A en SumarPolinomio}
   WHILE (r<>Ultimo(B)) DO BEGIN
         Insertar_ordenado(Datos_posicion(r,B),SumarPolinomio);
         r:=Siguiente(r,B);
         END;
{Ahora inserta los elementos de B, menos el ultimo, en SumarPolinomio ordenados de forma
 creciente segun su exponente. Si hubiese algun elemento de B que tuviese el mismo exponente
 que otro de A se sumarian sus coeficientes}
   Insertar_ordenado(Datos_posicion(r,B),SumarPolinomio);
{Por ultimo inserta el ultimo elemento de B. Si ese elemento tuviese el mismo exponente que
 alguno de los de A se sumarian sus coeficientes}
    END;
{Ya se ha resuelto el problema de sumar dos polinomios cuando ninguno de ellos es nulo}
SumarPolinomio:=SumarPolinomio;
{Con esto: si A y B fuesen nulos la funcion devolveria una Lista vacia; si A fuese nulo y B
 no, devolveria B; si B fuese nulo y A no, devolveria A; y si ninguno fuese nulo, devolveria
 el valor de SumarPolinomio tras realizar todas las inserciones}
END; {Fin de la Funcion SumarPolinomio}


BEGIN
Lista_vacia(A); Lista_vacia(B); {Se crean dos listas vacias para almacenar los polinomios}
WRITELN('Escoge una opcion y presiona Enter:');
WRITELN('1. Escribir polinomio.');
WRITELN('2. Salir del programa.');
READLN(Opcion1);
WRITELN;
IF Opcion1<>1 THEN EXIT; {Si se escoge la opcion 2 o una opcion distinta a las ofrecidas se sale del programa}
WHILE (Opcion1=1) DO BEGIN
       WRITE('Escribe el coeficiente y presiona Enter: ');
       READLN(Datos.coef);
       WRITE('Escribe el exponente y presiona Enter: ');
       READLN(Datos.exp);
       Insertar_ordenado(Datos,A);
       WRITELN;
       WRITELN('Escoge una opcion y presiona Enter:');
       WRITELN('1. Seguir escribiendo polinomio A.');
       WRITELN('2. Escribir polinomio B.');
       WRITELN('3. Salir del programa.');
       READLN(Opcion2);
       WRITELN;
       IF Opcion2=1 THEN Opcion1:=1
          ELSE IF Opcion2=2 THEN Opcion1:=2 {No se sale del programa, sino del bucle WHILE}
                  ELSE EXIT; {Si se escoge la opcion 3 o una opcion distinta a las ofrecidas se sale del programa}
END;     
WHILE (Opcion2=2) DO BEGIN
       WRITE('Escribe el coeficiente y presiona Enter: ');
       READLN(Datos.coef);
       WRITE('Escribe el exponente y presiona Enter: ');
       READLN(Datos.exp);
       Insertar_ordenado(Datos,B);
       WRITELN;
       WRITELN('Escoge una opcion y presiona Enter:');
       WRITELN('1. Seguir escribiendo polinomio B.');
       WRITELN('2. Ver el resultado de la suma de A y B.');
       WRITELN('3. Salir del programa.');
       READLN(Opcion3);
       IF Opcion3=1 THEN Opcion2:=2
          ELSE IF Opcion3=2 THEN BEGIN
                    Opcion2:=1; {Se sale del bucle WHILE}
                    WRITE('El resultado de sumar A y B es: ');
                    Visualizar(SumarPolinomio(A,B));
                    END
                  ELSE EXIT;
END;

END. {Fin del programa}
