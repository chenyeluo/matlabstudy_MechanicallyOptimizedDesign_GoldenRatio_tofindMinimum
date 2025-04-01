function [x_min, f_min] = minimization_solver(a, b, f)
    % 极小值求解主函数
    epsilon = 1e-6;  % 精度要求
    
    % 使用外推法确定初始区间
    [a1, b1] = extrapolation(a, b, f);
    fprintf('外推法确定的初始区间: [%.6f, %.6f]\n', a1, b1);
    
    % 使用0.618法搜索极小值点
    [x_min, f_min, iter] = golden_section(a1, b1, epsilon, f);
    
    fprintf('0.618法结果:\n');
    fprintf('极小值点: x = %.6f\n', x_min);
    fprintf('极小值: f(x) = %.6f\n', f_min);
    fprintf('迭代次数: %d\n', iter);
end

function [a, b] = extrapolation(a0, b0, f)
    % 外推法确定包含极小值的区间
    h = (b0 - a0)/10;
    x1 = a0;
    x2 = x1 + h;
    y1 = f(x1);
    y2 = f(x2);
    
    % 判断方向
    if y1 > y2
        x3 = x2 + h;
    else
        h = -h;
        x3 = x2;
        x2 = x1 + h;
    end
    
    y3 = f(x3);
    
    % 继续外推直到函数值开始增大
    while y2 > y3
        h = 2*h;
        x1 = x2;
        x2 = x3;
        x3 = x2 + h;
        y3 = f(x3);
    end
    
    % 确保a < b
    if x1 < x3
        a = x1;
        b = x3;
    else
        a = x3;
        b = x1;
    end
end

function [x_min, f_min, iter] = golden_section(a, b, epsilon, f)
    % 0.618法（黄金分割法）搜索极小值
    rho = (sqrt(5)-1)/2;  % 黄金分割比例
    iter = 0;
    
    a1 = a;
    b1 = b;
    x1 = a1 + (1-rho)*(b1 - a1);
    x2 = a1 + rho*(b1 - a1);
    f1 = f(x1);
    f2 = f(x2);
    
    while (b1 - a1) > epsilon
        iter = iter + 1;
        
        if f1 < f2
            b1 = x2;
            x2 = x1;
            f2 = f1;
            x1 = a1 + (1-rho)*(b1 - a1);
            f1 = f(x1);
        else
            a1 = x1;
            x1 = x2;
            f1 = f2;
            x2 = a1 + rho*(b1 - a1);
            f2 = f(x2);
        end
    end
    
    x_min = (a1 + b1)/2;
    f_min = f(x_min);
end