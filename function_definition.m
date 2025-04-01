function [a, b, f_handle] = function_definition()
    % 定义函数和区间
    a = 0;      % 区间左端点
    b = 2;      % 区间右端点
    
    % 定义目标函数
    f_handle = @(x) x.^3 - 2*x.^2;
    
    % 显示函数和区间信息
    fprintf('当前函数: f(x) = x^3 - 2*x^2\n');
    fprintf('搜索区间: [%.2f, %.2f]\n', a, b);
    
    % 调用求解器计算并输出结果
    [x_min, f_min] = minimization_solver(a, b, f_handle);
    fprintf('极小值点: x = %.6f\n', x_min);
    fprintf('极小值: f(x) = %.6f\n\n', f_min);
end