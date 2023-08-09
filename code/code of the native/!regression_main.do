**********************************************************************************
**********************************************************************************
**          这份代码中包含了利用本土文献进行复刻的全部图表	    				**
**         		 作者：黄倪远；秦子铉；姚宗庆；张嘉颢  			               	**
**       					                                                    **
**********************************************************************************
**********************************************************************************



***********************************
*** Table 1: Sample Composition ***
***********************************
use PanelData.dta, clear
encode stkcd, generate(id)
encode ind, generate(i_ind)
xtset id year
tsfill, full
// 线性插值法填补缺失数据
by id: ipolate cash1 year, gen(cash1_ip) epolate
by id: ipolate cash2 year, gen(cash2_ip) epolate
by id: ipolate cash3 year, gen(cash3_ip) epolate
by id: ipolate zcash year, gen(zcash_ip) epolate
// 在1%的水平上进行缩尾处理，保留1%-99%
winsor2 cash1_ip cash2_ip cash3_ip zcash_ip, replace cuts(1 99)trim
tab treat if post==0
tab treat if post==1
tab post if treat==0
tab post if treat==1



***********************************
*** Table 3: Summary Statistics ***
***********************************
use PanelData.dta, clear
encode stkcd, generate(id)
encode ind, generate(i_ind)
xtset id year
tsfill, full
// 线性插值法填补缺失数据
by id: ipolate cash1 year, gen(cash1_ip) epolate
by id: ipolate cash2 year, gen(cash2_ip) epolate
by id: ipolate cash3 year, gen(cash3_ip) epolate
by id: ipolate zcash year, gen(zcash_ip) epolate
// 在1%的水平上进行缩尾处理，保留1%-99%
winsor2 cash1_ip cash2_ip cash3_ip zcash_ip, replace cuts(1 99)trim
// 全样本描述性统计
tabstat cash1_ip cash2_ip cash3_ip zcash_ip treat post size lev ocf nwc capex grow div top1 board indrat ,s(mean sd p1 p25 p50 p75 p99 n) col(stat)


***********************************
*** Table 4: Summary Statistics ***
***********************************
use PanelData.dta, clear
encode stkcd, generate(id)
encode ind, generate(i_ind)
xtset id year
tsfill, full
// 线性插值法填补缺失数据
by id: ipolate cash1 year, gen(cash1_ip) epolate
by id: ipolate cash2 year, gen(cash2_ip) epolate
by id: ipolate cash3 year, gen(cash3_ip) epolate
by id: ipolate zcash year, gen(zcash_ip) epolate
// 在1%的水平上进行缩尾处理，保留1%-99%
winsor2 cash1_ip cash2_ip cash3_ip zcash_ip, replace cuts(1 99)trim
// A 处理组与控制组对比
ttest cash1_ip,by(treat)
ttest cash2_ip,by(treat)
ttest cash3_ip,by(treat)
ttest zcash_ip,by(treat)
//B 政策实施前后对比
ttest cash1_ip,by(post)
ttest cash2_ip,by(post)
ttest cash3_ip,by(post)
ttest zcash_ip,by(post)


******************************************
*** Table 5: Effects on Cash Retention ***
******************************************
use PanelData.dta, clear
encode stkcd, generate(id)
encode ind, generate(i_ind)
xtset id year
tsfill, full
// 线性插值法填补缺失数据
by id: ipolate cash1 year, gen(cash1_ip) epolate
by id: ipolate cash2 year, gen(cash2_ip) epolate
by id: ipolate cash3 year, gen(cash3_ip) epolate
by id: ipolate zcash year, gen(zcash_ip) epolate
// 在1%的水平上进行缩尾处理，保留1%-99%
winsor2 cash1_ip cash2_ip cash3_ip zcash_ip, replace cuts(1 99)trim
// 基准回归
reghdfe cash1_ip i.treat##i.post,absorb(i.id i.year) vce(cluster id)
reghdfe cash2_ip i.treat##i.post,absorb(i.id i.year) vce(cluster id)
reghdfe cash3_ip i.treat##i.post,absorb(i.id i.year) vce(cluster id)
reghdfe zcash_ip i.treat##i.post,absorb(i.id i.year) vce(cluster id)


****************************
*** Table 6: Pre-trends ***
****************************
use PanelData.dta, clear
encode stkcd, generate(id)
encode ind, generate(i_ind)
xtset id year
tsfill, full
// 线性插值法填补缺失数据
by id: ipolate cash1 year, gen(cash1_ip) epolate
by id: ipolate cash2 year, gen(cash2_ip) epolate
by id: ipolate cash3 year, gen(cash3_ip) epolate
by id: ipolate zcash year, gen(zcash_ip) epolate
// 在1%的水平上进行缩尾处理，保留1%-99%
winsor2 cash1_ip cash2_ip cash3_ip zcash_ip, replace cuts(1 99)trim
keep if year < 2018
reg cash1_ip i.treat size lev ocf nwc capex grow div dual top1 board indrat,robust
reg cash2_ip i.treat size lev ocf nwc capex grow div dual top1 board indrat,robust
reg cash3_ip i.treat size lev ocf nwc capex grow div dual top1 board indrat,robust
reg zcash_ip i.treat size lev ocf nwc capex grow div dual top1 board indrat,robust


*******************************************************************
*** Table 7: Robustness: Controlling for firm characteristics   ***
*******************************************************************
use PanelData.dta, clear
encode stkcd, generate(id)
encode ind, generate(i_ind)
xtset id year
tsfill, full
// 线性插值法填补缺失数据
by id: ipolate cash1 year, gen(cash1_ip) epolate
by id: ipolate cash2 year, gen(cash2_ip) epolate
by id: ipolate cash3 year, gen(cash3_ip) epolate
by id: ipolate zcash year, gen(zcash_ip) epolate
// 在1%的水平上进行缩尾处理，保留1%-99%
winsor2 cash1_ip cash2_ip cash3_ip zcash_ip, replace cuts(1 99)trim
// 回归
reghdfe cash1_ip i.treat##i.post size lev ocf nwc capex grow div dual top1 board indrat ,absorb(i.id i.year) vce(cluster id)
reghdfe cash2_ip i.treat##i.post size lev ocf nwc capex grow div dual top1 board indrat ,absorb(i.id i.year) vce(cluster id)
reghdfe cash3_ip i.treat##i.post size lev ocf nwc capex grow div dual top1 board indrat ,absorb(i.id i.year) vce(cluster id)
reghdfe zcash_ip i.treat##i.post size lev ocf nwc capex grow div dual top1 board indrat ,absorb(i.id i.year) vce(cluster id)

