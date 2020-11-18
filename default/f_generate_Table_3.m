function biao=f_generate_Table_3
pmin = 1e-6;
p1st = 1e-5;
p2nd = 1e-4;
p3rd = 1e-3;
p4th = 1e-2;
p5th = 0.1;
pmax = 1/3;
x1 = linspace(pmin, p1st, 50);
x2 = linspace(p1st, p2nd, 50);
x3 = linspace(p2nd, p3rd, 50);
x4 = linspace(p3rd, p4th, 100);
x5 = linspace(p4th, p5th, 150);
x6 = linspace(p5th, pmax, 300);
x = [x1,x2,x3,x4,x5,x6];
y = log((1./x)-2); 
z = (1./x);
biao=[x;y;z];   