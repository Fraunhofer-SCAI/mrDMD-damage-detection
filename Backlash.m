function x = Backlash(y,b)
x = zeros(size(y));
for i = 1:length(y)
    
   if (y(i)>b)
       x(i) = (y(i)-b);
   end
   if (y(i)>=-b) && (y(i)<=b)
       x(i) = (0);
   end
   if (y(i)<-b)
       x(i) = (y(i)+b);
   end
   
   
end   