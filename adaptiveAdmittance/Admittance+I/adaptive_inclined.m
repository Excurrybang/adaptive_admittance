clear all;

t = 0.01;
m = 1; k =0;  b =60;
xc = 0; dxc= 0; ddxc = 0;
xe = 0; dxe = 0.1; ddxe= 0;
fd = 50;
ke = 2000;
epsilon = 10^(-8); sigma = 0.1; lambda = 1;
delta_b = 0;    
phi_t = 0;
fe = 0;
%fe = 0;
delta_f = 0;

for i=1:200
    xe(i+1) = 0.1*i;
    dxe(i+1) = 0.1;
    fe(i+1) = ke * (xe(i+1) - xc(i));
    delta_f(i+1) = fe(i+1) - fd;
    phi_t(i+1) = phi_t(i) + sigma * delta_f(i) / b; % 累积速度误差
    delta_b(i+1) = b/((dxc(i) - dxe(i+1)) + epsilon) * phi_t(i+1);  % 累积的速度误差变为力又变为b

    ddxc(i+1) = ddxe + (delta_f(i+1) - (b - delta_b(i+1))*(dxc(i) - dxe(i+1)))/m;
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
line([0,200],[0,20],"LineStyle", "--","color","r"); %xe
title("xc");
subplot(2,2,3);
plot(dxc);
title("dxc");
subplot(2,2,4);
plot(ddxc);
title("ddxc");