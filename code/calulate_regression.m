function [w,stats]=calculate_regression(y,x1,x2)
X=[x1;x2];
[w,bint,r,rint,stats]=regress(y,X);

end