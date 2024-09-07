chair_r = 220-55;
a = 0.55/(2*pi);
init_theta = 32*pi;
speed = zeros(223,301);
time = 0;
head_v = 1;
head_s = time * head_v;
lth = @(x) (a/2)*(x*sqrt(1+x.^2)+log(x+sqrt(1+x.^2)));
target_time = [0 60 120 180 240 300];
target_pos = [1 51 101 151 201];
theta_step = 0.0001;
delta_t = 0.01;
test_length = 0;
head_theta = 32*pi;
xtran = @(x) a*cos(x)*x;
ytran = @(x) a*sin(x) *x;
xfist_pos = zeros(223,1);yfist_pos = zeros(223,1);xsec_pos = zeros(223,1);ysec_pos = zeros(223,1);
for m=1:301
    m

    for k = 1:2 
        time = m-1;%先测试60s时候的
        if k==2
            time = m+delta_t-1;
        end
        init_s = head_v * time;
        while test_length < init_s
            head_theta = head_theta-theta_step;
            test_length = lth(32*pi)-lth(head_theta);
        end
        test_length = 0;
        special_length = (341-55)/100;
        special_theta = head_theta;special_r2 = 0;
        
        x1 = a * cos(head_theta) * head_theta; y1 = a * sin(head_theta) * head_theta;
        while special_r2 < special_length^2
            special_theta = special_theta+theta_step;
            x2 = xtran(special_theta);y2 = ytran(special_theta) ;
            special_r2 = (x2-x1)^2+(y2-y1)^2;
        end
        
        
        
        theta_list = zeros(224,1);
        theta_list(1) = head_theta;
        theta_list(2) = special_theta;
        i = 3;
        start_theta = 0;xa =0;xb=0;ya=0;yb=0;t_theta = 0;
        lim_r2 = 0; t_r2 = ((220-55)/100)^2;
        while i <225    %先拿第五十二个为例
            start_theta = theta_list(i-1);
            
            xa = xtran(start_theta);ya = ytran(start_theta);
            t_theta = start_theta;
            while lim_r2<t_r2
                t_theta = t_theta+theta_step;
                xb = xtran(t_theta);yb = ytran(t_theta) ;
                lim_r2 = (xb-xa)^2+(yb-ya)^2;
            end
            lim_r2 = 0;
            theta_list(i) = t_theta;
            i = i+1;
        end
        if k==1
            for g=1:224
                xfist_pos(g) = xtran(theta_list(g));
                yfist_pos(g) = ytran(theta_list(g));
            end
        end
        if k==2
            for g=1:224
                xsec_pos(g) = xtran(theta_list(g));
                ysec_pos(g) = ytran(theta_list(g));
            end
        end
    
    end
    
    for ii = 1:224
        speed(ii,m) = sqrt((xfist_pos(ii)-xsec_pos(ii))^2+(yfist_pos(ii)-ysec_pos(ii))^2)/delta_t;
    end

end

%speed(:,1)=10.*ones(223,1);









