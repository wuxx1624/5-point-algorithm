function Evec = calibrated_fivepoint_GrLex( Q1,Q2)

Q1 = Q1';
Q2 = Q2';

% Q = [Q1(:,1).*Q2(:,1) , ...
%      Q1(:,2).*Q2(:,1) , ...
%      Q1(:,3).*Q2(:,1) , ... 
%      Q1(:,1).*Q2(:,2) , ...
%      Q1(:,2).*Q2(:,2) , ...
%      Q1(:,3).*Q2(:,2) , ...
%      Q1(:,1).*Q2(:,3) , ...
%      Q1(:,2).*Q2(:,3) , ...
%      Q1(:,3).*Q2(:,3) ] ; 

Q = [Q2(:,1).*Q1(:,1) , ...
     Q2(:,2).*Q1(:,1) , ...
     Q2(:,3).*Q1(:,1) , ... 
     Q2(:,1).*Q1(:,2) , ...
     Q2(:,2).*Q1(:,2) , ...
     Q2(:,3).*Q1(:,2) , ...
     Q2(:,1).*Q1(:,3) , ...
     Q2(:,2).*Q1(:,3) , ...
     Q2(:,3).*Q1(:,3) ] ; 


[U,S,V] = svd(Q,0);
EE = V(:,6:9);


A = grobner_coefficient_GrLex( EE ) ;
A = A(:,1:10)\A(:,11:20);
M = -A([1 2 3 4 5 6], :);
   
M(7,1) = 1;
M(8,2) = 1;
M(9,3) = 1;
M(10,7) = 1;

[V,D] = eig(M );
SOLS =   V(7:9,:)./(ones(3,1)*V(10,:));

Evec = EE*[SOLS ; ones(1,10 ) ]; 
Evec = Evec./ ( ones(9,1)*sqrt(sum( Evec.^2)));

I = find(not(imag( Evec(1,:) )));
Evec = Evec(:,I);