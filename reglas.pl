% ############################################
% REGLAS DE CLASIFICACIÓN
% ############################################

% --- Hechos dinámicos (entrada del usuario)
:- dynamic foliacion/1.
:- dynamic grano/1.
:- dynamic textura/1.
:- dynamic mineral/1.

% --------- CLASIFICACIÓN PRINCIPAL ---------

clasificar_roca(Roca, Grado, Protolitos) :-
    clasificar(Roca, Grado),
    findall(P, protolito_posible(Roca, P), Protolitos).

% --------- REGLAS POR ROCA ---------

% PIZARRA – muy bajo grado
clasificar(pizarra, muy_bajo) :-
    foliacion(si),
    grano(fino),
    mineral(M),
    mineral_indice(pizarra, M).

% FILITA – bajo grado
clasificar(filita, bajo) :-
    foliacion(si),
    grano(fino),
    textura(satinada),
    mineral(M),
    mineral_indice(filita, M).

% ESQUISTO – grado medio
clasificar(esquisto, medio) :-
    foliacion(si),
    grano(medio),
    mineral(M),
    mineral_indice(esquisto, M).

% GNEIS – alto grado (NO FORZAR PROTOLITO)
clasificar(gneis, alto) :-
    foliacion(si),
    grano(grueso),
    mineral(M),
    mineral_indice(gneis, M).

% MIGMATITA – muy alto grado
clasificar(migmatita, muy_alto) :-
    foliacion(si),
    grano(grueso),
    mineral(M),
    mineral_indice(migmatita, M).

% MÁRMOL – no foliada
clasificar(marmol, variable) :-
    foliacion(no),
    mineral(calcita).

% CUARCITA – no foliada
clasificar(cuarcita, variable) :-
    foliacion(no),
    mineral(cuarzo).

% ANFIBOLITA
clasificar(anfibolita, medio_alto) :-
    foliacion(si),
    mineral(anfibol).

% HORNFELS – metamorfismo de contacto
clasificar(hornfels, bajo) :-
    foliacion(no).