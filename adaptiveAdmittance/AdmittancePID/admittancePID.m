clear all;

t = 0.01;
m = 40; b =100; k =100;
xc = 0; dxc= 0; ddxc = 0;
xe = 0; dxe = 0; ddxe= 0;
fd = 50;
ke = 5000;

fe = 0;

delta_f = 0;
delta_f_sum = 0;
ddelta_f = 0;
delta_f_pid = 0;

bp = 40; bi = 120; bd = 0.8;

for i=1:200
    xe(i+1) = 0.1*sin(i*2*pi/200);
    dxe(i+1) = 0.1*pi/100*cos(i*2*pi/200);
    ddxe(i+1) = -0.1*(pi/100)^2*sin(i*2*pi/200);
    fe(i+1) = ke * (xe(i+1) - xc(i));
    delta_f(i+1) = fe(i+1) - fd;

    delta_f_sum(i+1) = delta_f_sum(i) + delta_f(i+1) * t;
    ddelta_f(i+1) = (delta_f(i+1) - delta_f(i))/t;

    delta_f_pid(i+1) = bp*delta_f(i+1) + bi*delta_f_sum(i+1) + bd * ddelta_f(i+1);

    ddxc(i+1) = ddxe(i+1) + (delta_f(i+1) - b*(dxc(i)-dxe(i+1)) - k*(xc(i)-xe(i+1)) + delta_f_pid(i+1))/m;
    dxc(i+1) = dxc(i) + ddxc(i+1)*t;
    xc(i+1) = xc(i) + dxc(i+1)*t;
end

y = 1:200;
figure(4);
subplot(2,2,1)
hold on;
plot(fe);
line([0,200],[fd,fd],"LineStyle", "--","color","r"); %fd
title("fe");
subplot(2,2,2);
hold on;
plot(xc);
plot(xe,"color","r","LineStyle", "--"); %xe
title("xc");
subplot(2,2,3);
plot(dxc);
title("dxc");
subplot(2,2,4);
plot(ddxc);
title("ddxc");