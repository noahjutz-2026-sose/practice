unitsize(1cm);
size(5cm, 10cm, keepAspect=false);

draw((-.1,0) -- (2,0));
draw((0,-.1) -- (0,2));
draw((0,0){up} .. (1,1) .. (2,sqrt(2)));
draw(unitcircle);
draw(polygon(5), blue);

for (int n = 3; n < 8; ++n) {
    draw(shift(2*n-6, -2) * unitcircle);
    draw(shift(2*n-6, -2) * polygon(n), red);
}
