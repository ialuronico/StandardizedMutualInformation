% Script to compute the Mutual Information (MI) between two 
% clusterings.
% 
% 
% --------------------------------------------------------------------------
% INPUT: A contingency table T
%        OR
%        Cluster labels of the two clusterings in two vectors
%        eg: true_mem=[1 2 4 1 3 5]
%                 mem=[2 1 3 1 4 5]
%        Cluster labels are coded using positive integers. 
% OUTPUT: MI

function [MI_]=mi(true_mem,mem)
  if nargin==1
    T=true_mem; %contingency table pre-supplied
  elseif nargin==2
    %build the contingency table from membership arrays
    r=max(true_mem);
    c=max(mem);

    %identify & removing the missing labels
    list_t=ismember(1:r,true_mem);
    list_m=ismember(1:c,mem);
    T=Contingency(true_mem,mem);
    T=T(list_t,list_m);
  end

  [r c]=size(T);
  if (c == 1 || r == 1)
   error('Clusterings should have at least 2 clusters')
   return
  end
  
  N = sum(sum(T)); % total number of records
 
  % update the true dimensions
  a=sum(T,2)';
  b=sum(T);

  % calculate nLogn
  MI_=0;
  for i=1:r
    for j=1:c
      if T(i,j)>0 
          MI_ = MI_ + T(i,j)*log2(T(i,j)*N/a(i)/b(j));
      end;
    end
  end    
  MI_ = MI_/N;
  
end
%---------------------auxiliary functions---------------------

% create a contingecy table

function Cont=Contingency(Mem1,Mem2)
  if nargin < 2 || min(size(Mem1)) > 1 || min(size(Mem2)) > 1
     error('Contingency: Requires two vector arguments')
     return
  end

  Cont=zeros(max(Mem1),max(Mem2));

  for i = 1:length(Mem1);
     Cont(Mem1(i),Mem2(i))=Cont(Mem1(i),Mem2(i))+1;
  end
end
          