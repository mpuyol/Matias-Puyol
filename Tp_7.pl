
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