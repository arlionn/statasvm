// Setup
webuse highschool

local split = floor(_N/2)
local train = "1/`=`split'-1'"
local test = "`split'/`=_N'"  

// Regression is invoked with type(epsilon_svr) or type(nu_svr).
// Notice that you can expand factors (categorical predictors) into sets of indicator (boolean) columns
// with standard i. syntax, and you can record which observations were chosen as support vectors with sv().
svm weight height i.race i.sex in `train', type(epsilon_svr) sv(Is_SV)

// Examine which observations were SVs. Ideally, a small number are enough.
tab Is_SV in `train'

predict P in `test'

// Compute error rate.
// since this is regression, we use - instead of !=
gen err = abs(weight - P) in `test'
sum err
