clockseed

sysuse auto

svm foreign headroom gear_ratio weight, type(svc) gamma(0.4) c(51)
predict P
gen err = foreign != P
qui sum err
di "Training error rate: `r(mean)'"
drop P err

cv P svm foreign headroom gear_ratio weight, folds(`=floor(_N/5)') shuffle est(type(svc) gamma(0.4) c(51))
gen err = foreign != P
qui sum err
di "Cross-validated error rate: `r(mean)'"
