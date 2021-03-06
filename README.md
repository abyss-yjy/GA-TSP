# 遗传算法解决旅行家问题

#### 介绍
用遗传算法解决旅行家问题，MATLAB与Python实现

### 旅行商问题
旅行商问题，即 TSP 问题（Traveling Salesman Problem）是数学领域中著名问题之一。
假设有一个旅行商人要拜访 n 个城市，他必须选择所要走的路径，路经的限制是每个城市只
能拜访一次，而且最后要回到原来出发的城市。路径的选择目标是要求得的路径路程为所有
路径之中的最小值。TSP 问题是一个组合优化问题。该问题可以被证明具有 NPC 计算复杂
性。因此，任何能使该问题的求解得以简化的方法，都将受到高度的评价和关注。

### 遗传算法
遗传算法的基本思想正是基于模仿生物界遗传学的遗传过程。它把问题的参数用基因代
表，把问题的解用染色体代表（在计算机里用二进制码表示），从而得到一个由具有不同染
色体的个体组成的群体。这个群体在问题特定的环境里生存竞争，适者有最好的机会生存和
产生后代。后代随机化地继承了父代的最好特征，并也在生存环境的控制支配下继续这一过
程。群体的染色体都将逐渐适应环境，不断进化，最后收敛到一族最适应环境的类似个体，
即得到问题最优的解。要求利用遗传算法求解 TSP 问题的最短路径。

### 博客
结果图可以查看我的博客www.abyss.website