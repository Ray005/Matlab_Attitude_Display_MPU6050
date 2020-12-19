%依赖于RX、RY、RZ函数
point_a = [1,0,0]';
point_b = [0,-1,0]';
point_c = [0,1,0]';
point_d = point_b - 0.5 * (point_b - point_c);  
s_x = [point_a(1,1), point_b(1,1), point_c(1,1), point_a(1,1);
       point_a(1,1), point_c(1,1), point_d(1,1), point_a(1,1)];
s_y = [point_a(2,1), point_b(2,1), point_c(2,1), point_a(2,1);
       point_a(2,1), point_c(2,1), point_d(2,1), point_a(2,1)];
s_z = [point_a(3,1), point_b(3,1), point_c(3,1), point_a(3,1);
       point_a(3,1), point_c(3,1), point_d(3,1), point_a(3,1)];

phi=0;
theta=0;
psi=0;
for i= 1:1:100
phi = phi + pi/2/100;      %phi滚转缓增大
%theta = theta + pi/2/180;  %theta俯仰缓增
%psi = psi + pi/2/100;      %psi偏航缓增
point_a = RZ(RY(RX([1,0,0]',phi),theta),psi);
point_b = RZ(RY(RX([0,-1,0]',phi),theta),psi);
point_c = RZ(RY(RX([0,1,0]',phi),theta),psi);
                    
point_d = point_b - 0.5 * (point_b - point_c);
s_x = [point_a(1,1), point_b(1,1), point_c(1,1), point_a(1,1);
point_a(1,1), point_c(1,1), point_d(1,1), point_a(1,1)];
s_y = [point_a(2,1), point_b(2,1), point_c(2,1), point_a(2,1);
point_a(2,1), point_c(2,1), point_d(2,1), point_a(2,1)];
s_z = [point_a(3,1), point_b(3,1), point_c(3,1), point_a(3,1);
point_a(3,1), point_c(3,1), point_d(3,1), point_a(3,1)];

h4 = surf(s_x, s_y, s_z);
grid on
xlim([-1 1])
ylim([-1 1])
zlim([-1 1])

h4.XData = s_x;
h4.YData = s_y;
h4.ZData = s_z;
pause(0.05);
end


