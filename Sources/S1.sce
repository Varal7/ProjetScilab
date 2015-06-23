M=10;
p=0.7;
nb_lancers = 5000;
nb_iterations = 10;
X = grand(1,nb_lancers,"bin",M,p);




//histplot(100,X)

function y=F(x,K,U)
    y=x;
    if (K>x) &(U<=p)  then
        y=x+1;
    elseif (K<=x)&(U>p) then
        y= x-1
    else
        y=x
    end
endfunction

for i =1 : nb_iterations
     for j=1 : nb_lancers
         K = grand(1,1,"uin",1,M);
         U = grand(1,1,"unf",0,1);
         X(j)= F(X(j),K,U);           
     end
end

histplot(100,X)
