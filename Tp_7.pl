
viveEnLaMansion(agatha).
viveEnLaMansion(carnicero).
viveEnLaMansion(charles).

odia(agatha, Odiado):-
    viveEnLaMansion(Odiado),
    Odiado \= carnicero.
   

odia(charles, Odiado):-
    viveEnLaMansion(Odiado),
    not(odia(agatha, Odiado)).
    

odia(carnicero, Odiado):-
    odia(agatha, Odiado).
   

esMasRicoQue(Rico, agatha):-
    viveEnLaMansion(Rico),
    not(odia(carnicero, Rico)).
    

mata(Asesino, Victima):-
    viveEnLaMansion(Asesino),
    viveEnLaMansion(Victima),
    odia(Asesino, Victima),
    not(esMasRicoQue(Asesino, Victima)).

/*
ASESINO DE AGATHA:

21 ?- mata(Quien,agatha).
Quien = agatha.


CONSULTAS:

22 ?- odia(_,milhouse).
false.

23 ?- odia(charles,Quien). 
Quien = carnicero ;
false.

24 ?- odia(Quien,agatha).
Quien = agatha ;
Quien = carnicero.


8 ?- odia(Quien,AQuien).
Quien = AQuien, AQuien = agatha ;
Quien = agatha,
AQuien = charles ;
Quien = charles,
AQuien = carnicero ;
Quien = carnicero,
AQuien = agatha ;
Quien = carnicero,
AQuien = charles.

26 ?- odia(carnicero,_).
true ;
true.
*/