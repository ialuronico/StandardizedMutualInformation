clear;
close all;
clc;

% Plot results from Experiment 4_2

load('Experiment_4_2_results');

h = figure;

subplot(3,1,1);
bar(N_B',SMIfrec'/samples,'r')
hold on;
plot(N_B,SMIfrec/samples,'ko--');
grid on;
title('SMI','Interpreter','latex','FontSize',12);

subplot(3,1,2);
bar(N_B',AMIfrec'/samples,'g')
hold on;
plot(N_B,AMIfrec/samples,'ko--');
grid on;
title('AMI','Interpreter','latex','FontSize',12);

ylabel('Probability of selection','Interpreter','latex','FontSize',12);

subplot(3,1,3);
bar(N_B',MIfrec'/samples,'w');
hold on;
plot(N_B, MIfrec/samples,'ko--');
grid on;
title('MI','Interpreter','latex','FontSize',12);

xlabel('Number of records $N$','Interpreter','latex','FontSize',12);

set(h, 'Position', [150 150 820 575])
set(h,'PaperSize',[19.5 15],'PaperPositionMode','auto');
saveas(h,'Ex42','pdf');