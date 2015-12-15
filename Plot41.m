clear;
close all;
clc;

% Plot results from Experiment 4_1

load('Experiment_4_1_results');

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

set(h, 'Position', [150 150 820 575])
set(h,'PaperSize',[19.5 15],'PaperPositionMode','auto');
saveas(h,'Ex41','pdf');