chair_r = 220-55;
a = 0.55/(2*pi);
init_theta = 32*pi;
time = 0;
head_v = 1;
head_s = time * head_v;
lth = @(x) (a/2)*(x*sqrt(1+x.^2)+log(x+(1+x.^2)));
target_time = 0:300;
target_pos = 1:223;
theta_step = 0.00001;
filename = 'result1.xlsx';
%先测试60s时候的
result = zeros(223,2);

    time = 433;
    init_s = head_v * time;
    test_length = 0;
    head_theta = 32*pi;
    xtran = @(x) a*cos(x)*x;
    ytran = @(x) a*sin(x) *x;
    while test_length < init_s
        head_theta = head_theta-theta_step;
        test_length = lth(32*pi)-lth(head_theta);
    end
    special_length = (341-55)/100;
    special_theta = head_theta;special_r2 = 0;
    
    x1 = a * cos(head_theta) * head_theta; y1 = a * sin(head_theta) * head_theta;
    while special_r2 < special_length^2
        special_theta = special_theta+theta_step;
        x2 = xtran(special_theta);y2 = ytran(special_theta) ;
        special_r2 = (x2-x1)^2+(y2-y1)^2;
    end
    
    
    
    theta_list = zeros(220,1);
    theta_list(1) = head_theta;
    theta_list(2) = special_theta;
    i = 3;
    start_theta = 0;xa =0;xb=0;ya=0;yb=0;t_theta = 0;
    lim_r2 = 0; t_r2 = ((220-55)/100)^2;
    while i <224    %先拿第五十二个为例
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
    for i=1:223
        result(i,1) = xtran(theta_list(i));
        result(i,2) = ytran(theta_list(i));
    end
    
    
    [xtran(theta_list(1)),xtran(theta_list(2)),xtran(theta_list(52)),xtran(theta_list(102)),xtran(theta_list(152)),xtran(theta_list(202)),xtran(theta_list(223))]
    






[ytran(theta_list(1)),ytran(theta_list(2)),ytran(theta_list(52)),ytran(theta_list(102)),ytran(theta_list(152)),ytran(theta_list(202)),ytran(theta_list(223))]

%%
chair_r = 220-55;
a = 0.55/(2*pi);
init_theta = 32*pi;
speed = zeros(223,1);
time = 0;
head_v = 1;
head_s = time * head_v;
lth = @(x) (a/2)*(x*sqrt(1+x.^2)+log(x+(1+x.^2)));
target_time = [0 60 120 180 240 300];
target_pos = [1 51 101 151 201];
theta_step = 0.0001;
delta_t = 0.01;
test_length = 0;
head_theta = 32*pi;
xtran = @(x) a*cos(x)*x;
ytran = @(x) a*sin(x) *x;
xfist_pos = zeros(223,1);yfist_pos = zeros(223,1);xsec_pos = zeros(223,1);ysec_pos = zeros(223,1);

    for k = 1:2 
        time = 430;%先测试60s时候的
        if k==2
            time = 430+delta_t;
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
        
        
        
        theta_list = zeros(223,1);
        theta_list(1) = head_theta;
        theta_list(2) = special_theta;
        i = 3;
        start_theta = 0;xa =0;xb=0;ya=0;yb=0;t_theta = 0;
        lim_r2 = 0; t_r2 = ((220-55)/100)^2;
        while i <223    %先拿第五十二个为例
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
            for g=1:223
                xfist_pos(g) = xtran(theta_list(g));
                yfist_pos(g) = ytran(theta_list(g));
            end
        end
        if k==2
            for g=1:223
                xsec_pos(g) = xtran(theta_list(g));
                ysec_pos(g) = ytran(theta_list(g));
            end
        end
    
    end
    
    for ii = 1:223
        speed(ii) = sqrt((xfist_pos(ii)-xsec_pos(ii))^2+(yfist_pos(ii)-ysec_pos(ii))^2)/delta_t;
    end



%speed(:,1)=10.*ones(223,1);












