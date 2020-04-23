### 同步整形电路
对于异步输入信号，通常要进行时钟同步，此外为了获取稳定的脉冲信号，还要对输入的异步信号进行整形处理，将不规则的输入信号提取为具有**一个时钟周期**长的稳定信号

基本方法是对输入信号进行两级采样，将两次采样通过逻辑电路整合输出最终的输出信号

为什么需要同步整形？
同步、整形，如果输入信号稳定，就不需要整形了，有时候输入信号并不能保持满一个时钟周期，比如按键输入，保持按键时间的时长会影响对输入的采样，此时就可以通过同步整形电路对不足一个时钟周期的信号整形为一个时钟周期的稳定信号