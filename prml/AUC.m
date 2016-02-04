function auc = AUC(pf, pd)

[pf, index] = sort(pf);
pd = pd(index);
auc = trapz(pf, pd);

end