clear;

M=20;
p=0.8;


nb_lancers = 5000;

N_0 = 5;

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


function r=Xstar()
    N=N_0;
    K = grand(1,N,"uin",1,M);
    U = grand(1,N,"unf",0,1);
    
    has_coalescence = %f
    while ~has_coalescence  
        x_0 = 0;
        x_1 = M;  
        for j=N:-1 :1 //Calcul de F_0(F_-1(...(x_0)..)) resp. x_1
            x_0 = F(x_0,K(j),U(j))
            x_1 = F(x_1,K(j),U(j)) 
        end   
        if x_0 == x_1 //S'il y a coalescence, on renvoie x_0 (=x_1)
            r = x_0
            has_coalescence = %t
        else //Sinon, on double le tableau et on recommence
           K(N+1:2*N) = grand(1,N,"uin",1,M);
           U(N+1:2*N) = grand(1,N,"unf",0,1);     
           N=2*N
        end
        
    end
endfunction


for i=1 : nb_lancers
    results(i)=Xstar();
end
histplot(100,results,style=2)
binom = grand(1,nb_lancers,"bin",M,p);
histplot(100,binom,style=5)
