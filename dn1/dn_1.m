clc;
clear all;

%naloga_1

filename1 = "naloga1_1.txt";
headerlinesIn = 2; 
delimiterIn = " ";
data = importdata(filename1, delimiterIn, headerlinesIn);
t = data.data(:, 1);

%naloga_2

filename2 = "naloga1_2.txt";
fid = fopen(filename2);
line = fgetl(fid);

stevke = [];
a = 1;

for i=1:1:length(line)
    if isstrprop(line(i), "digit")
        stevke(a) = char(line(i)) - '0'; 
        a = a + 1;
    end
end

st_vrstic = str2double(join(string(stevke), ''));

for i = 1:st_vrstic
  line1  = fgetl(fid);
  P(i) = str2double(line1);
end


plot(t, P, "r", "LineWidth", 2)
grid on
title("Graf P(t)");
xlabel("t [s]");
ylabel("P [W]");
ax = gca;
ax.FontSize = 15;

fclose(fid);

%naloga_3

trapz_f = trapz(t, P);

int = 0;

for i = 1:length(P)
    if i == 1
        int = int + P(i);
    elseif i == length(P)
        int = int + P(i);
        int = int * (t(2) - t(1)) / 2;
    else
        int = int + 2 * P(i);
    end
end

razlika = trapz_f - int;
