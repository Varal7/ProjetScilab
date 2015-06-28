M=10;
p=0.7;
nb_lancers = 3;
nb_iterations = 50;
X = zeros(nb_iterations+1,nb_lancers)//initialisation de la matrice
X(1,:) = grand(1,nb_lancers,"bin",M,p);//choix des conditions initiales


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
    //Choix d'une même réalisation de la suite F_n 
    //pour les différentes conditions initiales
     K = grand(1,1,"uin",1,M);
     U = grand(1,1,"unf",0,1);
     for j=1 : nb_lancers
         X(i+1,j)= F(X(i,j),K,U);           
     end
end



plot(1:(nb_iterations+1),X(:,1)','mo--')
plot(1:(nb_iterations+1),X(:,2)','ro--')
plot(1:(nb_iterations+1),X(:,3)','d--')

