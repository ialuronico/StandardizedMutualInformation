clear all;
close all;
clc;

%
% Experiment in Section 4.1 of the paper.
%
% Start Matlab parallel environment with the command matlabpool.
%
% (around 2 weeks on a quadcore Intel Core-i7 2.9GHz PC for 5000 samples)

samples = 5000;

c_B = [2:4:22]; % number of clusters in B

N = 500; % Number of records
r = 10; % number of clusters for the reference clustering

AMIfrec = zeros(1,length(c_B));
MIfrec = zeros(1,length(c_B));
SMIfrec = zeros(1,length(c_B));

AMIvec = [];
MIvec = [];
SMIvec = [];
parfor s=1:samples
    disp(['sample ' num2str(s)]);          
    scores = zeros(3,length(c_B)); % collects the values for MI, AMI, SMI here
        
    % Generate reference clustering A
    A = zeros(1,N);        
    for j=1:N
        A(j) = randi(r);
    end            
    
    for k=1:length(c_B)
        % Generate clustering B with c clusters        
        B = zeros(1,N);        
        for j=1:N
            B(j) = randi(c_B(k));
        end    
        
        % Compute MI, AMI, SMI
        scores(1,k) = mi(A,B); 
        scores(2,k) = ami(A,B); 
        scores(3,k) = smi(A,B); 
    end

    % Compute which clustering gets higher score for each measure
    [~, win] = max(scores');
    
    MIvec = [MIvec win(1)];
    AMIvec = [AMIvec win(2)];
    SMIvec = [SMIvec win(3)];
end

% Compute the frequencies of selection

for u=MIvec
    MIfrec(u) = MIfrec(u) + 1;
end
for u=AMIvec
    AMIfrec(u) = AMIfrec(u) + 1;
end
for u=SMIvec
    SMIfrec(u) = SMIfrec(u) + 1;
end

h = figure;

subplot(3,1,1);
bar(c_B',SMIfrec'/samples,'r')
hold on;
plot(c_B,SMIfrec/samples,'ko--');
grid on;
title('SMI','Interpreter','latex','FontSize',12);

subplot(3,1,2);
bar(c_B',AMIfrec'/samples,'g')
hold on;
plot(c_B,AMIfrec/samples,'ko--');
grid on;
title('AMI','Interpreter','latex','FontSize',12);

ylabel('Probability of selection','Interpreter','latex','FontSize',12);

subplot(3,1,3);
bar(c_B',MIfrec'/samples,'w');
hold on;
plot(c_B, MIfrec/samples,'ko--');
grid on;
title('MI','Interpreter','latex','FontSize',12);

xlabel('Number of clusters $c$ in $\mathbf{B}$','Interpreter','latex','FontSize',12);

save('Experiment_4_1_results');
disp('Results saved.');
