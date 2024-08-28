### 非结构环境下的机器人自适应变阻抗力跟踪控制方法,

甘亚辉, 段晋军, 戴先中

主要思想为设置**刚度K**为零，然后对**阻尼B**引入自适应阻抗参数 **$\Delta b$** 以对阻尼参数进行自适应调节

$$  f_e - f_d = m(\ddot{x_c} - \ddot{x_e}) + b(\dot{x_c} - \dot{x_e}) = m\ddot{e} + b\dot{e} $$

复杂曲面的 $x_e$ 为时变函数，$\dot{x}_e\neq 0$ 或者 $\ddot{x}_e \neq 0$ 则需要对环境进行预估，假设预估值为 $\hat{x}_e = x_e - \delta x_e$ 则对应的轨迹误差为 $\hat{e} = e + \delta x_e $ 代入得到阻抗方程
$$ f_e - f_d = m\ddot{\hat{e}}+b\dot{\hat{e}} = m(\ddot{e}+\delta \ddot{x}_e)+b(\dot{e}+\delta \dot{x}_e) $$

因为修改质量系数容易引起系统的震荡，则引入自适应阻抗参数来补偿时变的误差,综合考虑系统的稳定性,对阻抗参数中的阻尼系数进行自适应调节，即 $\Delta b(t)$ 动态补偿 $m\delta\ddot{x}_e+b\delta \dot{x}_e $

原论文为
$$ f_e(t) - f_d(t) = m\ddot{\hat{e}}(t) + (b + \Delta b(t))\dot{\hat{e}}(t)$$

感觉有点问题，带入之后不应该为 $\hat{e}$, 应该为$e$, 所以我改为如下

**$$f_e(t) - f_d(t) = m\ddot{e}(t) + (b + \Delta b(t))\dot{e}(t)$$**

#### 主要过程

自适应参数更新
$$\phi(t) = \phi(t-\lambda) + \sigma\frac{f_e(t-\lambda) - f_d(t-\lambda)}{b} $$

$$\Delta b(t) = \frac{b}{\dot{\hat{e}}(t) + \epsilon}\phi(t)$$
改为
$$\Delta b(t) = \frac{b}{\dot{e}(t) + \epsilon}\phi(t)$$

$\sigma = 10^{-8}$ 防止分母为零, $\lambda$ 为采样率, $\sigma$ 为更新率

自适应控制过程
$$
    \ddot{x}_c(t) = \ddot{x}_e(t) + \frac{1}{m}[\Delta f(t) - b(t)(\dot{x}_c(t-1)-\dot{x}_e(t))]\\
    \dot{x}_c = \dot{x}_c(t-1) + \ddot{x}_c(t) \times T\\
    x_c(t) = x_c(t-1) + \dot{x}_c(t)\times T\\
    ~\\
    with \quad \Delta f = f_e - f_d\\
     f_e = k_e(x_e - x_c)\\
    \hat{e} = e + \delta x_e = x_c - x_e + \delta x_e
$$

结论：

    于平面而言,即使环境刚度不确定,定阻抗能够达到预期的力跟踪效果,但是对于斜面或是更为复杂的未知曲面而言,定阻抗基本不可能实现预期的力跟踪效果,而自适应变阻抗经过前期的短暂调整后,可以达到预期的力跟踪效果.

    针对环境刚度的不确定性,对经典的阻抗模型进行变形,并提出了一种新的阻抗模型,使之能够适应任何环境刚度;针对环境位置信息的动态变化情况,提出了一种基于力反馈的在线调整阻抗参数的控制策略,使之能够补偿环境动态变化的未知性. 


$\Delta b$ 的动态补偿看起来像是加了个积分项，使用对力的误差的积分来补偿

加速度的更新可以看为，将刚度K设置为零之后，用 $ \Delta b \dot{e} $ 来动态补偿环境中的变化。
在第一步中 由于 $\phi (t - \lambda)$ 刚开始为零，并且 $\epsilon$ 只是用来防止分母为0的补偿，则 $\Delta b$ 可表达为

$$ \Delta b(t) = \frac{b}{\dot{e} + \epsilon}(\phi(t-\lambda) + \sigma\frac{f_e(t-\lambda) - f_d(t-\lambda)}{b})\\
    =\frac{b}{\dot{e}}\cdot\sigma\frac{f_e(t-\lambda) - f_d(t-\lambda)}{b}\\
    =\sigma\frac{f_e(t-\lambda) - f_d(t-\lambda)}{\dot{e}}\\
$$
根据阻尼公式 $f = cv$ , $c$ 为阻尼系数，$v$ 为速度，则 $\Delta b$ 可化简为
$$ \Delta b (t) = \sigma\frac{f_e(t-\lambda) - f_d(t-\lambda)}{\dot{e}}\\
    = \sigma\frac{f_e(t-\lambda) - f_d(t-\lambda)}{\dot{x_c} - \dot{x_e}}\\
$$
这里是第一步 $\phi(t-\lambda)$ 为0的时候，之后不为零的时候就变为了误差的累计，也就是积分

## 注意

原公式

**$$f_e(t) - f_d(t) = m\ddot{e}(t) + (b + \Delta b(t))\dot{e}(t)$$**

中的 $b + \Delta b$ 经过matlab仿真测试应改为 $b - \Delta b$, 原公式变为

**$$f_e(t) - f_d(t) = m\ddot{e}(t) + (b - \Delta b(t))\dot{e}(t)$$**