
function dydt = rhs(t,y,z,Fm,f,k,ft,bg,Fvar,tvar)
f = interp1(ft,f,t);
k = interp1(ft,k,t);
Fvar = interp1(tvar,Fvar,t);
dydt = [y(2);-2*z*y(2)-k*Backlash(y(1),bg)+f+Fm+Fvar];

%testB(y(1),bg)