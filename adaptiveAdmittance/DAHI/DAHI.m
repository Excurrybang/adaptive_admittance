clear all;

t = 0.01;
m = 1; k =0;  b =65;
xc = 0; dxc= 0; ddxc = 0;
xe = 0; dxe = 0; ddxe= 0;
delta_dxc = 0; delta_dxe=0;
de=0;

fd = 50;
ke = 4000;  
phi_t = 0;
fe = 0;
delta_f = 0;

ddelta_f = 0;
sigma_recip = 0;
sigma_exp = 0;
sigma_ava = 0;

alpha = 1; beta = 1;% there is no commit about the selection of alpha and beta
U_limit = (m + b*t)/b * t;

for i=1 :200
    
    xe(i+1) = 2*sin(i*2*pi/200);
    dxe(i+1) = 2*pi/100*cos(i*2*pi/200);
    ddxe(i+1) = -2*(pi/100)^2*sin(i*2*pi/200);
    fe(i+1) = ke * (xe(i+1) - xc(i));

    % Read force sensors
    delta_f(i+1) = fe(i+1) - fd;
    ddelta_f(i+1) = (delta_f(i+1) - delta_f(i))/t;
    
    % Dynamic sigma
    sigma_recip(i+1) = 1/(alpha * abs(delta_f(i+1)) + beta*abs(ddelta_f(i+1)) + U_limit);
    sigma_exp(i+1) = 1/( exp(alpha*abs(delta_f(i+1))) + exp(beta*abs(ddelta_f(i+1))) + U_limit);

    % Compensation , sigma_recip or sigma_exp?
    sigma_ava(i+1) = (sigma_recip(i+1) + sigma_exp(i+1))/2;
    phi_t(i+1) = phi_t(i) + sigma_ava(i+1) * (-delta_f(i)) / b;

    % Solve impendace function, de(i+1) - de(i), if we dont present like
    % this, it will counter problem at i = 1;
    ddxc(i+1) = ddxe(i+1) + (delta_f(i+1) - b*(delta_dxc(i) - delta_dxe(i) + phi_t(i+1)) )/m;
    dxc(i+1) = dxc(i) + ddxc(i+1)*t;
    xc(i+1) = xc(i) + dxc(i+1)*t;

    delta_dxc(i+1) = dxc(i+1) - dxc(i);
    delta_dxe(i+1) = dxe(i+1) - dxe(i);
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
%plot(xe);

plot(xe,"color","r","LineStyle", "--"); %xe
title("xc");
subplot(2,2,3);
plot(dxc);
title("dxc");
subplot(2,2,4);
plot(ddxc);
title("ddxc");