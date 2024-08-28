clear all;

t = 0.01;
m = 0.15; k =80;  b =300;
kp = 0.9; ki = 0.23; kd = 0.25;
lambda = 0.8; miu = 0.8;

xc = 0; dxc= 0; ddxc = 0;
xe = 0; dxe = 0; ddxe= 0;

fd = 12;
ke = 5000;

fe = 0;

delta_f = 0;
delta_f_sum = 0;
ddelta_f = 0;

delta_f_pid = 0;

for i=1:200
    xe(i+1) = 0.01*sin(i*2*pi/200);
    dxe(i+1) = 0.01*pi/100*cos(i*2*pi/200);
    ddxe(i+1) = -0.01*(pi/100)^2*sin(i*2*pi/200);
    
    fe(i+1) = ke * (xe(i+1) - xc(i));
    %fe(i+1) = ke * (-xe(i+1) + xc(i));

    delta_f(i+1) = fe(i+1) - fd;
    %delta_f(i+1) = -fe(i+1) + fd;

    delta_f_sum(i+1) = delta_f_sum(i) + delta_f(i+1) * t;
    ddelta_f(i+1) = (delta_f(i+1) - delta_f(i))/t;
    
    delta_f_pid(i+1) = kp*delta_f(i+1) + ki*delta_f_sum(i+1)^lambda + kd * ddelta_f(i+1)^miu;

    ddxc(i+1) = ddxe(i+1) + (delta_f_pid(i+1) - b*(dxc(i)-dxe(i+1)) - k*(xc(i)-xe(i+1)))/m;
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