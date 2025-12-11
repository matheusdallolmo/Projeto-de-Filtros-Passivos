% =========================================================================
% PROJETO FINAL - CIRCUITOS DE CORRENTE ALTERNADA (CC44CP)
% Autor: Matheus Dall Olmo
% UTFPR - Pato Branco
% =========================================================================

clear; clc; close all;

%% 1. PARÂMETROS DO PROJETO
R_L = 4;            % Impedância da carga em Ohms
fc = 3600;          % Frequência de corte em Hz
wc = 2 * pi * fc;   % Frequência angular em rad/s

fprintf('=== INÍCIO DO PROJETO ===\n');
fprintf('Aluno: Matheus Dall Olmo\n');
fprintf('Impedância da Carga (RL): %.1f Ohms\n', R_L);
fprintf('Freq. Corte (fc): %.1f Hz\n\n', fc);

%% 2. BANCO DE COMPONENTES COMERCIAIS
L_comercial = [0.10, 0.12, 0.15, 0.18, 0.22, 0.27, 0.33, 0.39, 0.47, ...
               0.56, 0.68, 0.82, 1.0, 1.2, 1.5, 1.8, 2.2, 2.7, 3.3, ...
               3.9, 4.7, 5.6, 6.8, 8.2, 10, 12, 15] * 1e-3;

C_comercial = [1.0, 1.2, 1.5, 1.8, 2.2, 2.7, 3.3, 3.9, 4.7, 5.6, 6.8, ...
               8.2, 10, 12, 15, 18, 22, 27, 33, 39, 47, 56, 68, 82, ...
               100] * 1e-6;

%% 3. CÁLCULO DOS VALORES IDEAIS
L_ideal = (R_L * sqrt(2)) / wc;
C_ideal = 1 / (R_L * wc * sqrt(2));

fprintf('--- VALORES IDEAIS ---\n');
fprintf('Indutor Ideal (L): %.6f mH\n', L_ideal * 1000);
fprintf('Capacitor Ideal (C): %.6f uF\n\n', C_ideal * 1e6);

%% 4. SELEÇÃO DOS COMPONENTES REAIS
[~, idx_L] = min(abs(L_comercial - L_ideal));
L_real = L_comercial(idx_L);

[~, idx_C] = min(abs(C_comercial - C_ideal));
C_real = C_comercial(idx_C);

fprintf('--- VALORES COMERCIAIS SELECIONADOS ---\n');
fprintf('Indutor Real: %.2f mH\n', L_real * 1000);
fprintf('Capacitor Real: %.2f uF\n', C_real * 1e6);

erro_L = abs((L_real - L_ideal)/L_ideal) * 100;
erro_C = abs((C_real - C_ideal)/C_ideal) * 100;
fprintf('Erro L: %.2f %%\n', erro_L);
fprintf('Erro C: %.2f %%\n\n', erro_C);

%% 5. CÁLCULO MATEMÁTICO DA RESPOSTA EM FREQUÊNCIA
% Cria um vetor de frequências de 100 Hz a 20 kHz
f_plot = logspace(2, log10(20000), 1000); 
w_plot = 2 * pi * f_plot;
s = 1i * w_plot;

% --- LPF (Woofer) ---
num_lpf_ideal = wc^2;
den_lpf_ideal = s.^2 + (wc*sqrt(2)).*s + wc^2;
H_LPF_Ideal = num_lpf_ideal ./ den_lpf_ideal;

num_lpf_real = 1 / (L_real * C_real);
den_lpf_real = s.^2 + (1/(R_L * C_real)).*s + (1/(L_real * C_real));
H_LPF_Real = num_lpf_real ./ den_lpf_real;

% --- HPF (Tweeter) ---
num_hpf_ideal = s.^2;
den_hpf_ideal = s.^2 + (wc*sqrt(2)).*s + wc^2;
H_HPF_Ideal = num_hpf_ideal ./ den_hpf_ideal;

num_hpf_real = s.^2;
den_hpf_real = s.^2 + (1/(R_L * C_real)).*s + (1/(L_real * C_real));
H_HPF_Real = num_hpf_real ./ den_hpf_real;

%% 6. GERAÇÃO DOS GRÁFICOS (BODE)
figure('Name', 'Projeto Crossover Passivo - Matheus Dall Olmo', 'Color', 'w');

% Plot LPF (Woofer)
subplot(2,1,1);
semilogx(f_plot, 20*log10(abs(H_LPF_Ideal)), 'b', 'LineWidth', 1.5); hold on;
semilogx(f_plot, 20*log10(abs(H_LPF_Real)), 'r--', 'LineWidth', 1.5);
grid on;
title('Resposta LPF (Woofer) - Ideal vs Real');
xlabel('Frequência (Hz)');
ylabel('Magnitude (dB)');
legend('LPF Ideal', 'LPF Real');
xlim([100 20000]);
ylim([-40 5]);

% Plot HPF (Tweeter)
subplot(2,1,2);
semilogx(f_plot, 20*log10(abs(H_HPF_Ideal)), 'b', 'LineWidth', 1.5); hold on;
semilogx(f_plot, 20*log10(abs(H_HPF_Real)), 'r--', 'LineWidth', 1.5);
grid on;
title('Resposta HPF (Tweeter) - Ideal vs Real');
xlabel('Frequência (Hz)');
ylabel('Magnitude (dB)');
legend('HPF Ideal', 'HPF Real');
xlim([100 20000]);
ylim([-40 5]);

sgtitle(['Crossover Butterworth 2a Ordem (fc = ' num2str(fc/1000) ' kHz)']);

fprintf('Gráficos gerados com sucesso!.\n');