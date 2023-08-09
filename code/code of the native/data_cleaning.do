cap log close
cd "C:\Users\qzx\Desktop\金融计量模型大作业\本土文献代码和数据\wind数据"
log using log1, text replace
set seed 1

//1 数据处理
use datasetv1.dta, replace
gen stkcd_num = real(substr(stkcd, 1, length(stkcd)-3))
xtset stkcd_num date
drop if substr(comp, 1, 3)=="*ST"
drop if substr(comp, 1, 2)=="ST"
drop if substr(comp, 1, 2)=="PT"
gen cash1 = cash/100000000
gen cash2 = cash/( tot_assest-cash)
gen cash3 = cash/oper_rev
bys date industry: egen cash_mean = mean(cash)
bys date industry: egen cash_sd = sd(cash)
gen zcash = (cash-cash_mean)/cash_sd
gen post = 1
replace post = 0 if date <2018
tab post
gen size = log( tot_assest)
gen lev = tot_debt/ tot_assest
gen ocf = net_cash_flows_oper/ tot_assest
gen nwc= (tot_cur_assets - tot_cur_liab - cash)/ tot_assest
gen capex = cash_pay_acq_const_fiolta / tot_assest
gen grow = oper_income_rate
gen div = div_cashaftertax / ( net_profit / share_totaltradable )
gen top1 = holder_pct
gen board = log( employee_board)
gen indrat = employee_indpdirector / employee_board
gen year = date
gen ind = industry
keep stkcd comp year ind cash1 cash2 cash3 zcash treat post size lev ocf nwc capex grow div dual top1 board indrat
order stkcd comp year ind cash1 cash2 cash3 zcash treat post size lev ocf nwc capex grow div dual top1 board indrat
