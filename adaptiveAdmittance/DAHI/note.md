### Dynamic Adaptive Hybrid Impedance Control for Dynamic Contact Force Tracking in Uncertain Environments

HONGLI CAO, XIAOAN CHEN, YE HE, AND XUE ZHAO

这个论文是对于HI和AHI的改进，他的基本思想是在传统阻抗模式的后面加上一个积分环节，与段晋军的论文的区别在于积分系数的选择和积分加入阻抗模型的方式，主要的区别在于

1. 他的积分系数 $\sigma$ 是可变的，根据力的差值进行变化，具有两个模式 $Recip$ 和 $Exp$ ，两个模式的区别就是对接触力和期望力的差值的处理方式不同。处理过程中会涉及到两个参数 $\alpha$ 和 $\beta$ ， 论文 中对这两个参数没有具体的描述是怎么选取出来的，只是说了以后会继续研究

$$ Recip\ mode: \sigma = \frac{1}{\alpha|\Delta f|+\beta|\Delta f'|+U_{limt}}\\
~\\
Exp\ mode: \sigma = \frac{1}{e^{\alpha|\Delta f|}+e^{\beta|\Delta f'|}+U_{limt}}\\
~\\
U_{limt} = \frac{(m+bT)}{bT}
$$

2. 加入积分的方式，段的论文是通过 $\Delta b$ 代入，这个论文是直接加入再乘以 $b$。

#### 算法流程

![process](/robots/control/adaptiveAdmittance/DAHI/pic/process.png)

具体实验中给了大部分参数，但是并没有给出 $\alpha$ 和 $\beta$ 的参数，导致论文复现出的结果不是很成功

具体复现代码可在[DAHI](/robots/control/adaptiveAdmittance/DAHI/DAHI.m)中找到