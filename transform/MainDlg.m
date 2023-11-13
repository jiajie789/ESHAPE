% Copyright (c), IBCAS@2023
% All rights reserved.

addpath(genpath('../functions'));

chaincode=[5 4 1 2 3 4 3 0 0 1 0 1 0 0 0 7 7 1 1 0 7 5 4 5 4 5 0 6 5 4 1 3 4 4 4 4 6];
chaincode=repelem(chaincode,2);
axis=code2axis(chaincode, [0 0]);



figure
subplot(3,3,1)
plot(axis(:,1), axis(:,2),'-','LineWidth',2);
axis equal
hold on

subplot(3,3,2)
axis_move=code2axis(chaincode,[10 10]);
plot(axis_move(:,1), axis_move(:,2),'-','LineWidth',2);
axis equal
hold on

subplot(3,3,3)
[chaincode_rw,axis_rw]=chain_code_rotatew_func(axis);
plot(axis_rw(:,1), axis_rw(:,2),'-','LineWidth',2);
axis equal
hold on

subplot(3,3,4)
chain_zi=repelem(chaincode,2);
axis_zi=code2axis(chain_zi,[0 0]);
plot(axis_zi(:,1), axis_zi(:,2),'-','LineWidth',2);
axis equal
hold on


subplot(3,3,5)
chaincode_sta=chain_code_starting_func(chaincode,10000);
axis_sta=code2axis(chaincode_sta,[0 0]);
plot(axis_sta(:,1), axis_sta(:,2),'-','LineWidth',2);
axis equal
hold on


subplot(3,3,6)
chaincode_ysy=chain_code_ysysmmetry_func(chaincode);
axis_ysy=code2axis(chaincode_ysy,[0 0]);
plot(axis_ysy(:,1), axis_ysy(:,2),'-','LineWidth',2);
axis equal
hold on

subplot(3,3,7)
chaincode_xsy=chain_code_xsysmmetry_func(chaincode);
axis_xsy=code2axis(chaincode_xsy,[0 0]);
plot(axis_xsy(:,1), axis_xsy(:,2),'-','LineWidth',2);
axis equal
hold on

subplot(3,3,8)
chaincode_zo=chaincode(1:2:end);
axis_zo=code2axis(chaincode_zo,[0 0]);
plot(axis_zo(:,1), axis_zo(:,2),'-','LineWidth',2);
axis equal
hold on


subplot(3,3,9)
chaincode_rc=chain_code_rotatec_func(axis);
axis_rc=code2axis(chaincode_rc,[0 0]);
plot(axis_rc(:,1), axis_rc(:,2),'-','LineWidth',2);
axis equal
hold off






figure
subplot(3,3,1)
[output1,a1,b1,c1,d1] = fourier_approx_norm_modify(chaincode, 35, 400, 1, 0,[1 1 1 1 1 1 1]);
plot(output1(:,1), output1(:,2),'r-','LineWidth',2);
xlim([-3 3]); ylim([-3 3])
axis equal
hold on

subplot(3,3,2)
% axis_move=code2axis(chaincode,[10 10]);
% plot(axis_move(:,1), axis_move(:,2),'-','LineWidth',2);
% hold on
[output1,a2,b2,c2,d2] = fourier_approx_norm_modify(chaincode, 35, 400, 1, 0,[1 1 1 1 1 1 1]);
plot(output1(:,1), output1(:,2),'r-','LineWidth',2);
xlim([-3 3]); ylim([-3 3])
axis equal
hold on

subplot(3,3,3)
[chaincode_rw,axis_rw]=chain_code_rotatew_func(axis);
% plot(axis_rw(:,1), axis_rw(:,2),'-','LineWidth',2);
% hold on
[output1,a3,b3,c3,d3] = fourier_approx_norm_modify(chaincode_rw, 35, 400, 1, 0,[1 1 1 1 1 1 1]);
plot(output1(:,1), output1(:,2),'r-','LineWidth',2);
xlim([-3 3]); ylim([-3 3])
axis equal
hold on

subplot(3,3,4)
chain_zi=repelem(chaincode,2);
axis_zi=code2axis(chain_zi,[0 0]);
% plot(axis_zi(:,1), axis_zi(:,2),'-','LineWidth',2);
% hold on
[output1,a4,b4,c4,d4] = fourier_approx_norm_modify(chain_zi, 35, 400, 1, 0,[1 1 1 1 1 1 1]);
plot(output1(:,1), output1(:,2),'r-','LineWidth',2);
xlim([-3 3]); ylim([-3 3])
axis equal
hold on

subplot(3,3,5)
chaincode_sta=chain_code_starting_func(chaincode,10000);
axis_sta=code2axis(chaincode_sta,[0 0]);
% plot(axis_sta(:,1), axis_sta(:,2),'-','LineWidth',2);
% hold on
[output1,a5,b5,c5,d5] = fourier_approx_norm_modify(chaincode_sta, 35, 400, 1, 0,[1 1 1 1 1 1 1]);
plot(output1(:,1), output1(:,2),'r-','LineWidth',2);
xlim([-3 3]); ylim([-3 3])
axis equal
hold on

subplot(3,3,6)
chaincode_ysy=chain_code_ysysmmetry_func(chaincode);
axis_ysy=code2axis(chaincode_ysy,[0 0]);
% plot(axis_ysy(:,1), axis_ysy(:,2),'-','LineWidth',2);
% hold on
[output1,a6,b6,c6,d6] = fourier_approx_norm_modify(chaincode_ysy, 35, 400, 1, 0,[1 1 1 1 1 1 1]);
plot(output1(:,1), output1(:,2),'r-','LineWidth',2);
xlim([-3 3]); ylim([-3 3])
axis equal
hold on

subplot(3,3,7)
chaincode_xsy=chain_code_xsysmmetry_func(chaincode);
axis_xsy=code2axis(chaincode_xsy,[0 0]);
% plot(axis_xsy(:,1), axis_xsy(:,2),'-','LineWidth',2);
% hold on
[output1,a7,b7,c7,d7] = fourier_approx_norm_modify(chaincode_xsy, 35, 400, 1, 0,[1 1 1 1 1 1 1]);
plot(output1(:,1), output1(:,2),'r-','LineWidth',2);
xlim([-3 3]); ylim([-3 3])
axis equal
hold on

subplot(3,3,8)
chaincode_zo=chaincode(1:2:end);
axis_zo=code2axis(chaincode_zo,[0 0]);
% plot(axis_zo(:,1), axis_zo(:,2),'-','LineWidth',2);
% hold on
[output1,a8,b8,c8,d8] = fourier_approx_norm_modify(chaincode_zo, 35, 400, 1, 0,[1 1 1 1 1 1 1]);
plot(output1(:,1), output1(:,2),'r-','LineWidth',2);
xlim([-3 3]); ylim([-3 3])
axis equal
hold on

subplot(3,3,9)
chaincode_rc=chain_code_rotatec_func(axis);
axis_rc=code2axis(chaincode_rc,[0 0]);
% plot(axis_rc(:,1), axis_rc(:,2),'-','LineWidth',2);
% hold on
[output1,a9,b9,c9,d9] = fourier_approx_norm_modify(chaincode_rc, 35, 400, 1, 0,[1 1 1 1 1 1 1]);
plot(output1(:,1), output1(:,2),'r-','LineWidth',2);
% xlim([-2 2]); ylim([-2 2]); 
xlim([-3 3]); ylim([-3 3])
axis equal
hold on





figure
subplot(2,2,1);
plot(a1,':r', 'LineWidth', 2);
hold on;
plot(a2, 'LineWidth', 2);
hold on;
plot(a3, 'LineWidth', 2);
hold on;
plot(a4, 'LineWidth', 2);
hold on;
plot(a5, 'LineWidth', 2);
hold on;
plot(a6, 'LineWidth', 2);
hold on;
plot(a7, 'LineWidth', 2);
hold on;
plot(a8, 'LineWidth', 2);
hold on;
plot(a9,'color','#D87F81', 'LineWidth', 2);
ylim([-1 1])
xlim([1 35])
xticks([1 5 10 15 20 25 30 35])
% legend('i','ii','iii','iv','v', 'vi', 'vii','viii','ix','Times New Roman', 'FontSize', 20);
set(gca, 'FontName', 'Times New Roman', 'FontSize', 20);

% xlabel('harmonic coefficients-a', 'FontName', 'Times New Roman', 'FontSize', 20);
ylabel('Value', 'FontName', 'Times New Roman', 'FontSize', 20);
% legend('Ori','rer','ysy','xsy');
subplot(2,2,2);
plot(b1,':r', 'LineWidth', 2);
hold on;
plot(b2, 'LineWidth', 2);
hold on;
plot(b3, 'LineWidth', 2);
hold on;
plot(b4, 'LineWidth', 2);
hold on;
plot(b5, 'LineWidth', 2);
hold on;
plot(b6, 'LineWidth', 2);
hold on;
plot(b7, 'LineWidth', 2);
hold on;
plot(b8, 'LineWidth', 2);
hold on;
plot(b9,'color','#D87F81','LineWidth', 2);
ylim([-0.2 0.2]);
xlim([1 35])
xticks([1 5 10 15 20 25 30 35])
% legend('i','ii','iii','iv','v', 'vi', 'vii','viii','ix','Times New Roman', 'FontSize', 20);
set(gca, 'FontName', 'Times New Roman', 'FontSize', 20);

% xlabel('harmonic coefficients-b', 'FontName', 'Times New Roman', 'FontSize', 20);
% ylabel('Normalized Amplitude', 'FontName', 'Times New Roman', 'FontSize', 20);
% legend('Ori','rer','ysy','xsy');
subplot(2,2,3);
plot(c1,':r', 'LineWidth', 2);
hold on;
plot(c2, 'LineWidth', 2);
hold on;
plot(c3, 'LineWidth', 2);
hold on;
plot(c4, 'LineWidth', 2);
hold on;
plot(c5, 'LineWidth', 2);
hold on;
plot(c6, 'LineWidth', 2);
hold on;
plot(c7, 'LineWidth', 2);
hold on;
plot(c8, 'LineWidth', 2);
hold on;
plot(c9, 'color','#D87F81','LineWidth', 2);
ylim([-0.063290666124177,0.059874434724079]);
xlim([1 35])
xticks([1 5 10 15 20 25 30 35])
% legend('i','ii','iii','iv','v', 'vi', 'vii','viii','ix','Times New Roman', 'FontSize', 20);
set(gca, 'FontName', 'Times New Roman', 'FontSize', 20);

% xlabel('harmonic coefficients-c', 'FontName', 'Times New Roman', 'FontSize', 20);
ylabel('Value', 'FontName', 'Times New Roman', 'FontSize', 20);
% legend('Ori','rer','ysy','xsy');
subplot(2,2,4);
plot(d1,':r', 'LineWidth', 2);
hold on;
plot(d2, 'LineWidth', 2);
hold on;
plot(d3, 'LineWidth', 2);
hold on;
plot(d4, 'LineWidth', 2);
hold on;
plot(d5, 'LineWidth', 2);
hold on;
plot(d6, 'LineWidth', 2);
hold on;
plot(d7, 'LineWidth', 2);
hold on;
plot(d8, 'LineWidth', 2);
hold on;
plot(d9,'color','#D87F81', 'LineWidth', 2);
ylim([-2,2]);
xlim([1 35])
xticks([1 5 10 15 20 25 30 35])
legend('i','ii','iii','iv','v', 'vi', 'vii','viii','ix','Times New Roman', 'FontSize', 20);
set(gca, 'FontName', 'Times New Roman', 'FontSize', 20);

% xlabel('harmonic coefficients-d', 'FontName', 'Times New Roman', 'FontSize', 20);
% ylabel('Normalized Amplitude', 'FontName', 'Times New Roman', 'FontSize', 20);


