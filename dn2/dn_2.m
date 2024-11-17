clc;
clear all;

%naloga 1

data = readmatrix('vozlisca_temperature_dn2.txt', 'NumHeaderLines', 4);
x = data(:,1); % x-koodrinate vozlisc
y = data(:,2); % y-koordinate vozlisc
T = data(:,3); % Temp v vozliščih

x1 = 0.403;
y1 = 0.503;

tic;

F = scatteredInterpolant(x, y, T, 'linear', 'none');
T1 = F(x1,y1);

time1 = toc;

%naloga 2

x_unique = unique(x);
y_unique = unique(y);

[X,Y] = ndgrid(x_unique, y_unique); 

Tr = reshape(T, length(x_unique), length(y_unique));

tic;

F2 = griddedInterpolant(X,Y,Tr, "linear");
T2 = F2(x1, y1); 

time2 = toc;

%naloga 3

tic;

x_min = max(x_unique(x_unique <= x1)); 
x_max = min(x_unique(x_unique >= x1));
y_min = max(y_unique(y_unique <= y1));
y_max = min(y_unique(y_unique >= y1));

T11 = T(x == x_min & y == y_min);
T21 = T(x == x_max & y == y_min);
T12 = T(x == x_min & y == y_max);
T22 = T(x == x_max & y == y_max);

K1 = (x_max - x1) / (x_max - x_min) * T11 + (x1 - x_min) / (x_max - x_min) * T21;
K2 = (x_max - x1) / (x_max - x_min) * T12 + (x1 - x_min) / (x_max - x_min) * T22;
T3 = (y_max - y1) / (y_max - y_min) * K1 + (y1 - y_min) / (y_max - y_min) * K2;

time3 = toc;

% naloga 4
fprintf('Čas, ki ga potrebuje scatteredInterpolant: %.5f sekund\n', time1);
fprintf('Temperatura, ki jo izračunamo je: %.5f °C\n', T1);
fprintf('Cas, ki ga potrebuje griddedInterpolant: %.5f sekund\n', time2);
fprintf('Temperatura, ki jo izračunamo je: %.5f °C\n', T2);
fprintf('Cas, ki ga potrebuje metoda bilinearne interpolacije: %.5f sekund \n', time3);
fprintf('Temperatura, ki jo izračunamo je: %.5f °C\n', T3);

% naloga 5
[max_temp, max_idx] = max(T);
max_x = x(max_idx);
max_y = y(max_idx);

fprintf('Maksimalna temperatura, ki se pojavi je %.2f stopinj in to v vozliscu (%.3f, %.3f).\n', max_temp, max_x, max_y);