dis = 0.4;
chair_r = 220-55;
a = dis/(2*pi);
init_theta = 32*pi;
time = 0;
head_v = 1;
head_s = time * head_v;
lth = @(x) (a/2)*(x*sqrt(1+x.^2)+log(x+(1+x.^2)));
target_time = 0:300;
target_pos = 1:223;
theta_step = 0.00001;
th = 0:0.01:32*pi;
r = 4.5;
xr = r*cos(th);
yr = r*sin(th);
%figure;
%plot(xr,yr);hold on;
xl = a.*th.*cos(th);
yl = a.*th.*sin(th);
%plot(xl,yl);
init_theta
while dis>0.3

end