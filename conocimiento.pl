% ############################################
% BASE DE CONOCIMIENTO – METAMORPHIA
% Petrología metamórfica clásica
% ############################################

% -------- TIPOS DE ROCAS METAMÓRFICAS --------

roca_metamorfica(pizarra).
roca_metamorfica(filita).
roca_metamorfica(esquisto).
roca_metamorfica(gneis).
roca_metamorfica(migmatita).
roca_metamorfica(marmol).
roca_metamorfica(cuarcita).
roca_metamorfica(anfibolita).
roca_metamorfica(hornfels).

% -------- PROTÓLITOS POSIBLES --------

% Sedimentarios
protolito(lutita).
protolito(arenisca).
protolito(caliza).

% Ígneos
protolito(granito).
protolito(diorita).
protolito(basalto).

% -------- MINERALES GUÍA (ÍNDICE) --------
% Basado en secuencia pelítica y metamorfismo regional

% PIZARRA – muy bajo grado
mineral_indice(pizarra, clorita).
mineral_indice(pizarra, sericita).

% FILITA – bajo grado
mineral_indice(filita, sericita).
mineral_indice(filita, moscovita).

% ESQUISTO – grado medio
mineral_indice(esquisto, biotita).
mineral_indice(esquisto, granate).

% GNEIS – alto grado
mineral_indice(gneis, feldespato).
mineral_indice(gneis, sillimanita).

% MIGMATITA – muy alto grado (anatexis parcial)
mineral_indice(migmatita, feldespato).
mineral_indice(migmatita, cuarzo_cristalino).

% NO FOLIADAS
mineral_indice(marmol, calcita).
mineral_indice(cuarcita, cuarzo).
mineral_indice(anfibolita, anfibol).
mineral_indice(hornfels, cuarzo).

% -------- PROTÓLITOS POSIBLES POR ROCA --------

% Serie pelítica clásica
protolito_posible(pizarra, lutita).
protolito_posible(filita, lutita).
protolito_posible(esquisto, lutita).

% GNEIS: para- y ortogneis
protolito_posible(gneis, lutita).     % paragneis
protolito_posible(gneis, granito).    % ortogneis
protolito_posible(gneis, diorita).

% MIGMATITA: metamorfismo extremo
protolito_posible(migmatita, gneis).

% NO FOLIADAS
protolito_posible(marmol, caliza).
protolito_posible(cuarcita, arenisca).
protolito_posible(anfibolita, basalto).