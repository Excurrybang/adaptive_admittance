clear all;

t = 0.05;
m = 1; k =0;  b =10;
xc = 0.2; dxc= 0; ddxc = 0;
xe = 0.1; dxe = 0; ddxe= 0;
fd = 5;
ke = 800;
epsilon = 10^(-8); sigma = 0.01; lambda = 1;
delta_b = 0;    
phi_t = 0;
fe = ke * (-0.1);
%fe = 0;
delta_f = 0;

for i=1:200
    fe(i+1) = ke * (xe - xc(i));
    delta_f(i+1) = fe(i+1) - fd;
    phi_t(i+1) = phi_t(i) + sigma * delta_f(i+1) / b;
    delta_b(i+1) = b/(dxc(i) - dxe + epsilon) * phi_t(i+1);

    ddxc(i+1) = ddxe + (delta_f(i+1) - (b - delta_b(i+1))*(dxc(i) - dxe))/m;
    dxc(i+1) = dxc(i) + ddxc(i+1)*t;
    xc(i+1) = xc(i) + dxc(i+1)*t;

    if i < 100
        ke = 800;
    elseif 100<i && i<150 
        ke = 950;
    else
        ke = 1100;
    end
end

y = 1:200;
figure(4);
subplot(2,2,1)
hold on;
plot(fe);
line([0,200],[5,5],"LineStyle", "--","color","r");
title("fe");
subplot(2,2,2);
hold on;
plot(xc);
line([0,200],[0.1,0.1],"LineStyle", "--","color","r");
title("xc");
subplot(2,2,3);
plot(dxc);
title("dxc");
subplot(2,2,4);
plot(ddxc);
title("ddxc");