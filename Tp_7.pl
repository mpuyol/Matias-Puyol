/*
Quien mata es porque odia a su víctima y no es más rico que ella. Además, quien mata debe vivir en la mansión Dreadbury.
-Tía Agatha, el carnicero y Charles son las únicas personas que viven en la mansión Dreadbury.
-Charles odia a todas las personas de la mansión que no son odiadas por la tía Agatha.
-Agatha odia a todos los que viven en la mansión, excepto al carnicero.
-Quien no es odiado por el carnicero y vive en la mansión, es más rico que tía Agatha
-El carnicero odia a las mismas personas que odia tía Agatha.


El programa debe resolver el problema de quién mató a la tía Agatha. 
Mostrar la consulta utilizada y la respuesta obtenida.

Agregar los mínimos hechos y reglas necesarios para poder consultar:
- Si existe alguien que odie a milhouse.
- A quién odia charles.
- El nombre de quien odia a agatha.
- Todos los odiadores y sus odiados.
- Si es cierto que el carnicero odia a alguien.
Mostrar las consultas utilizadas para conseguir lo anterior, junto con las respuestas obtenidas.


*/

viveEnLaMansion(agatha).
viveEnLaMansion(carnicero).
viveEnLaMansion(charles).

odia(agatha, Odiado):-
    viveEnLaMansion(Odiado),
    Odiado \= carnicero,
    Odiado \= agatha.

odia(charles, Odiado):-
    viveEnLaMansion(Odiado),
    not(odia(agatha, Odiado)),
    Odiado \= charles.

odia(carnicero, Odiado):-
    odia(agatha, Odiado),
    Odiado \= carnicero.

esMasRicoQue(Rico, agatha):-
    viveEnLaMansion(Rico),
    not(odia(carnicero, Rico)),
    Rico \= agatha.

mata(Asesino, Victima):-
    viveEnLaMansion(Asesino),
    viveEnLaMansion(Victima),
    odia(Asesino, Victima),
    not(esMasRicoQue(Asesino, Victima)).

/*
ASESINO DE AGATHA:

21 ?- mata(Quien,agatha).
Quien = charles.


CONSULTAS:

22 ?- odia(_,milhouse).
false.

23 ?- odia(charles,Quien). 
Quien = agatha ;
Quien = carnicero ;
false.

24 ?- odia(Quien,agatha).
Quien = charles .

25 ?- odia(Odiador, Odiado).
Odiador = agatha,
Odiado = charles ;
Odiador = charles,
Odiado = agatha ;
Odiador = charles,
Odiado = carnicero ;
Odiador = carnicero,
Odiado = charles.

26 ?- odia(carnicero,_).
true.
*/