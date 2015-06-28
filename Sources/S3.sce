clear

M=10;
p=0.7;

nb_lancers = 5000;


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


function r=Xstarstar()
    has_coalescence = %F
    n = 0 //compteur n
    X = zeros(1,M+1)//On réserve la M+1e colonne pour indexation
    X(1,1:M) = [1:M];
    while ~has_coalescence    
         n= n+1
         K = grand(1,1,"uin",1,M);
         U = grand(1,1,"unf",0,1);
         has_coalescence = %T
         for j=1 : M // Calcul de toutes les trajectoires possibles
             X(n+1,j)= F(X(n,j),K,U);           
             if X(n+1,j)~= X(n+1,1) //Y a-t-il coalescence ?
                 has_coalescence = %F
             end
         end
    end
    T=n
    X(1:T+1,M+1)= [0:T]';
    r = X(T+1,1)
endfunction




for i=1 : nb_lancers
    results(i)=Xstarstar();
end
histplot(100,results,style=2)
binom = grand(1,nb_lancers,"bin",M,p);
histplot(100,binom,style=5)
