% CG Übung 5, Aufgabe 3

x_min = -10;
x_max = 10;
y_min = -5;
y_max = 5;
n = 1;
f = 101;

P = [2/(x_max-x_min), 0, 0, -(x_max+x_min)/(x_max-x_min);
    0, 2/(y_max-y_min), 0, -(y_max+y_min)/(y_max-y_min);
    0, 0, 2/(n-f), -(f+n)/(f-n);
    0, 0, 0, 1];

w = 1920;
h = 1080;
x_vp = 0;
y_vp = 0;

W = [w/2, 0, 0, x_vp + w/2;
    0, h/2, 0, y_vp + h/2;
    0, 0, (f-n)/2, (f+n)/2;
    0, 0, 0, 1];
