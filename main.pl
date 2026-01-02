% ############################################
% MAIN – METAMORPHIA
% ############################################

:- encoding(utf8).
:- consult(conocimiento).
:- consult(reglas).

% Predicado de resolución principal (para el chatbot)
resolver(Roca, Grado, Protolitos) :-
    clasificar_roca(Roca, Grado, Protolitos),
    !.

% Punto de entrada para pruebas en consola
iniciar :-
    clasificar_roca(Roca, Grado, Protolitos),
    write('Roca identificada: '), writeln(Roca),
    write('Grado metamórfico: '), writeln(Grado),
    write('Protolitos posibles: '), writeln(Protolitos).
