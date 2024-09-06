chair_r = 220-55;
a = 0.55/(2*pi);
init_theta = 32*pi;
time = 0;
head_v = 1;
head_s = time * head_v;
lth = @(x) (a/2)*(x*sqrt(1+x.^2)+log(x+(1+x.^2)));
target_time = 0:300;
target_pos = 1:224;
theta_step = 0.00001;
filename = 'result1.xlsx';
time = 330;%先测试60s时候的
result = zeros(301,224);
for kk =1:301
    kk

    time = target_time(kk);
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
    
    tt = 1;
    
    for tt=1:224
        result(kk,tt) = theta_list(target_pos(tt));
    end
    


end
posresult = zeros(448,301);
for i=1:301
    i
    for j = 1:224
        
        %xresult(i,j) = xtran(result(i,j));
        posresult(j*2-1,i) = xtran(result(i,j));
        %yresult(i,j) = ytran(result(i,j));
        posresult(j*2,i) = ytran(result(i,j));
        %xlswrite(filename,ytran(result(i,j)),'位置',[excelColumn(j*2+1) num2str(i+1)]);
    end
end
%round(xresult,6),round(yresult,6)







