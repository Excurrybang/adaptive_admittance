### 机械臂接触力跟踪自适应变导纳控制方法

金锋扬，秦菲菲，郭振武，王斌锐

这个算法应该是前面那个段教授的算法的延续，本质是传统的导纳控制加上pid，pid应用在阻尼参数上，并且不把刚度设置为0

相对于段教授的算法，这个效果更好，但是需要调节的参数过多。

自适应参考轨迹的更新方程为
$$
环境参数估计值\\
~\\
\left\{
        \begin{array}{lr}
            \widehat{k}_e = k_{e0} + \Delta k_e \\
            ~\\
            \widehat{x}_e = x_{e0} + \Delta x_e\\
        \end{array}
\right.\\
~\\
\delta = \frac{1}{2}(f_r - \widehat{k}_e(x_c - \widehat{x}_e))\\
~\\
对\delta 分别关于\Delta k_e 和 \Delta x_e 求偏导\\
~\\
\left\{
        \begin{array}{lr}
            \frac{\partial\delta}{\partial\Delta k_e} = (f_r - \widehat{k}_ex_e+\widehat{k}_e\widehat{x}_e)(-x_c + \widehat{x}_e)\\
            ~\\
            \frac{\partial\delta}{\partial\Delta x_e} = (f_r-\widehat{k}_ex_e + \widehat{k}_e\widehat{x}_e)\widehat{k}_e
        \end{array}
\right.\\
~\\
利用梯度下降法更新\Delta k_e 和 \Delta x_e
~\\
\left\{
        \begin{array}{lr}
            \Delta k_e = \Delta k_e - \lambda_1 \frac{\partial\delta}{\partial\Delta k_e}\\
            ~\\
            \Delta x_e = \Delta x_e - \lambda_2 \frac{\partial\delta}{\partial\Delta x_e}
        \end{array}
\right.\\
~\\
最后算出机械臂的参考轨迹估计值\widetilde{x}_r
~\\
\widetilde{x}_r  = \widehat{x}_e + \frac{f_r}{\widehat{k}_e}
$$
算出的参考轨迹估计值可用来展示机械臂的轨迹

自适应导纳参数的控制方程为
$$  \Delta f(t) = m\ddot{e}(t) + b_0\dot{e}(t) + ke(t) - b_p\Delta f(t) - b_i\int_0^t\Delta f(\tau)d\tau -b_d\Delta\dot{f}(t)\\
~\\
\ddot{e}(t) = \Delta f(t) - b_0\dot{e} - ke(t)+ b_p\Delta f(t) + b_i\int_0^t\Delta f(\tau)d\tau + b_d\Delta\dot{f}(t)
$$

实现详见[admittancePID](/robots/control/adaptiveAdmittance/AdmittancePID/admittancePID.m)