clc, clear, close all

% Permanent magnet synchronous machine constant parameters
motor = 'e-Tech 2024';
FWF = 0.85;
switch motor
    case 'e-Tech 2024'
        Ke = 0.13;                              % [V/(rad/s)] Mechanical speed constant
        n = 6;                                  % [ad] Number of poles 
        pp = n/2;                               % [ad] Number of pole pairs
        lambda_b = Ke / sqrt(3);                % [Wb] Base flux linkage
        lambda_b = 0.052615;                    % [Wb] PM flux linkage
        Ld =  0.1887e-3;                        % [H] d-axis inductance
        Lq =  0.2831e-3;                        % [H] q-axis inductance
        xi = Lq/Ld;                             % [ad] Saliency ratio
        Rs = 0.0201;                            % [Ohm] Stator phase resistance (phase-to-phase/2)
        P_max = 35e3;                           % [W] Maximum output power
        SpeedMax = 20000;                       % [rpm] Motor maximum angular speed
        Te_max = 26;                            % [N·m] Motor maximum angular torque
        Vdc = 540;                              % [V] Battery DC voltage
        V_base = FWF * Vdc / sqrt(3);           % [V] Maximum d-q voltage
        I_max = 107;                            % [A] Maximum d-q current (sqrt(i_d^2+i_q^2))
        I_base = lambda_b / Ld;                 % [A] Base current
        T_base = (3/2)*pp*I_base*lambda_b;      % [N·m] Base torque
        w_base = V_base/lambda_b;               % [rad/s] Base speed
        Te_command = 26;
        SpeedRef = 20000*2*pi/60;  
    case 'e-Tech 2017'
        Ke = 49.7e-3*60/(2*pi);                 % [Vrms,phph/(rad/s)] Speed constant, Vrms,phph/wm
        n = 8;                                  % [ad] Number of poles 
        pp = n/2;                               % [ad] Number of pole pairs
        lambda_b = Ke / (sqrt(3) * (n/2));      % [Wb] PM flux linkage, Vrms,phn/we
        Ld =  0.520e-3;                         % [H] d-axis inductance
        Lq =  1.265e-3;                         % [H] q-axis inductance
        xi = Lq/Ld;                             % [ad] Saliency ratio
        Rs = 0.104/2;                           % [Ohm] Stator phase resistance (phase-to-phase/2)
        P_max = 60e3;                           % [W] Maximum output power
        SpeedMax = 6000;                        % [rpm] Motor maximum angular speed
        Te_max = 150;                           % [N·m] Motor maximum angular torque
        Vdc = 580;                              % [V] Battery DC voltage
        V_base = FWF * Vdc / sqrt(3);           % [V] Maximum d-q voltage (Maximum Torque per Voltage Flux-Weakening strategy with speed limiter for PMSM drives, 2020)
        I_max = 200;                            % [A] Maximum d-q current (sqrt(i_d^2+i_q^2))
        I_base = lambda_b / Ld;                 % [A] Base current
        T_base = (3/2)*pp*I_base*lambda_b;      % [N·m] Base torque
        w_base = V_base/lambda_b;               % [rad/s] Base speed
        Te_command = 80;
        SpeedRef = 7500*2*pi/60;  
    case 'Silence'
        n = 40;                                 % [ad] Number of poles 
        pp = n/2;                               % [ad] Number of pole pairs
        lambda_b = 0.02282824;                  % [Wb] Base flux linkage
        Ld =  70e-6;                            % [H] d-axis inductance
        Lq =  79e-6;                            % [H] q-axis inductance
        xi = Lq/Ld;                             % [ad] Saliency ratio
        Rs = 0.017;                             % [Ohm] Stator phase resistance (phase-to-phase/2)
        SpeedMax = 1000;                        % [rpm] Motor maximum angular speed
        Te_max = 80;                            % [N·m] Motor maximum angular torque
        Vdc = 48;                               % [V] Battery DC voltage
        V_base = FWF * Vdc / sqrt(3);           % [V] Maximum d-q voltage (Maximum Torque per Voltage Flux-Weakening strategy with speed limiter for PMSM drives, 2020)
        I_max = 156;                            % [A] Maximum d-q current (sqrt(i_d^2+i_q^2))      
        I_base = lambda_b / Ld;                 % [A] Base current
        T_base = (3/2)*pp*I_base*lambda_b;      % [N·m] Base torque
        w_base = V_base/lambda_b;               % [rad/s] Base speed
        Te_command = 66;
        SpeedRef = 500*2*pi/60;
    case 'Caruso 2019'
        n = 6;                                  % [ad] Number of poles 
        pp = n/2;                               % [ad] Number of pole pairs
        lambda_b = 0.084;                       % [Wb] Base flux linkage
        Ld =  9.77E-3;                          % [H] d-axis inductance
        Lq =  14.94E-3;                         % [H] q-axis inductance
        xi = Lq/Ld;                             % [ad] Saliency ratio
        Rs = 2.21;                              % [Ohm] Stator phase resistance (phase-to-phase/2)
        SpeedMax = 4300;                        % [rpm] Motor maximum angular speed
        Te_max = 2;                             % [N·m] Motor maximum angular torque
        Vdc = 310;                              % [V] Battery DC voltage
        V_base = FWF * Vdc / sqrt(3);           % [V] Maximum d-q voltage (Maximum Torque per Voltage Flux-Weakening strategy with speed limiter for PMSM drives, 2020)
        I_max = 8.5;                            % [A] Maximum d-q current (sqrt(i_d^2+i_q^2))
        I_base = lambda_b / Ld;                 % [A] Base current
        T_base = (3/2)*pp*I_base*lambda_b;      % [N·m] Base torque
        w_base = V_base/lambda_b;               % [rad/s] Base speed
        Te_command = 1.8;
        SpeedRef = 380;

    case 'AMK'
        n = 10;                                 % [ad] Number of poles 
        pp = n/2;                               % [ad] Number of pole pairs
        kE = 18.8;                              % [Vrmsphn/krpm(wm)] Speed constant 
        lambda_b = kE*(60/(2*pi))/(1000*(n/2)); % [Wb] Base flux linkage
        Ld =  0.12e-3;                          % [H] d-axis inductance
        Lq =  0.24e-3;                          % [H] q-axis inductance
        xi = Lq/Ld;                             % [ad] Saliency ratio
        Rs = 0.135;                             % [Ohm] Stator phase resistance (phase-to-phase/2)
        SpeedMax = 20000;                       % [rpm] Motor maximum angular speed
        Te_max = 30;                            % [N·m] Motor maximum angular torque
        Vdc = 560;                              % [V] Battery DC voltage
        V_base = FWF * Vdc / sqrt(3);           % [V] Maximum d-q voltage (Maximum Torque per Voltage Flux-Weakening strategy with speed limiter for PMSM drives, 2020)
        I_max = 75;                             % [A] Maximum d-q current (sqrt(i_d^2+i_q^2))
        I_base = lambda_b / Ld;                 % [A] Base current
        T_base = (3/2)*pp*I_base*lambda_b;      % [N·m] Base torque
        w_base = V_base/lambda_b;               % [rad/s] Base speed
        Te_command = 21;
        SpeedRef = 25000*2*pi/60;
    otherwise
end

%% dq plot
idiq = figure;

axis([[-I_max*1.2, I_max*1.2], [-I_max*1.2, I_max*1.2]])             % [A] Current maximum values
xlabel('i_d [A], p.u.') 
ylabel('i_q [A], p.u.') 
grid on
ax = gca;
ax.DataAspectRatio = [1 1 1];
ax.GridLineStyle = '--';
ax.GridAlpha = 0.5;
ax.XAxisLocation="origin";
ax.YAxisLocation="origin";

%% Torque curves

hold on

tic
Te_vals = linspace(-Te_max, Te_max, 8); % [Nm] Torque values

syms id

for Te_val = 1:length(Te_vals)
    if Te_vals(Te_val) > 0
        tq_plot_pos = fplot(4*Te_vals(Te_val)/(3*n*(lambda_b+lambda_b/I_base*(1-xi)*id)), 'm', 'LineWidth', 2); % IPMSM torque equation, solved for iq
        text(-0.5, 4*Te_vals(Te_val)/(3*n*(lambda_b+lambda_b/I_base*(1-xi)*-0.5)), sprintf('%.1f N·m',Te_vals(Te_val)),'Color','magenta','FontSize',12)
    else 
        tq_plot_neg = fplot(4*Te_vals(Te_val)/(3*n*(lambda_b+lambda_b/I_base*(1-xi)*id)), 'r', 'LineWidth', 2); % IPMSM torque equation, solved for iq
        text(-0.5, 4*Te_vals(Te_val)/(3*n*(lambda_b+lambda_b/I_base*(1-xi)*-0.5)), sprintf('%.1f N·m',Te_vals(Te_val)),'Color','red','FontSize',12)
    end
end

clear id iq
toc
%% Current limit circle

alpha = linspace(0,2*pi);
i_lim_plot = plot(I_max*cos(alpha), I_max*sin(alpha), 'k', 'LineWidth',2);

clear alpha


hold on
%% MTPA curve



if xi > 1
    id_ref_MTPA = linspace(-I_max, 0, 1000);
    iq_ref_MTPA_pos = sqrt((lambda_b*id_ref_MTPA+lambda_b/I_base*(1-xi)*id_ref_MTPA.^2)/(lambda_b/I_base*(1-xi)));
    iq_ref_MTPA_pos(iq_ref_MTPA_pos > I_max | iq_ref_MTPA_pos < -I_max) = NaN;
    
    iq_ref_MTPA_neg = -sqrt((lambda_b*id_ref_MTPA+lambda_b/I_base*(1-xi)*id_ref_MTPA.^2)/(lambda_b/I_base*(1-xi)));
    iq_ref_MTPA_neg(iq_ref_MTPA_neg > I_max | iq_ref_MTPA_neg < -I_max) = NaN;
    
    % Eliminar NaN de ambos vectores
    valid_indices = ~isnan(iq_ref_MTPA_pos) & ~isnan(iq_ref_MTPA_neg);
    id_ref_MTPA = id_ref_MTPA(valid_indices);
    iq_ref_MTPA_pos = iq_ref_MTPA_pos(valid_indices);
    iq_ref_MTPA_neg = iq_ref_MTPA_neg(valid_indices);
elseif xi < 1
    id_ref_MTPA = linspace(I_max, 0, 1000);
    iq_ref_MTPA_pos = sqrt((lambda_b*id_ref_MTPA-lambda_b/I_base*(1-xi)*id_ref_MTPA.^2)/(lambda_b/I_base*(1-xi)));
    iq_ref_MTPA_pos(iq_ref_MTPA_pos > I_max | iq_ref_MTPA_pos < -I_max) = NaN;
    
    iq_ref_MTPA_neg = -sqrt((lambda_b*id_ref_MTPA-lambda_b/I_base*(1-xi)*id_ref_MTPA.^2)/(lambda_b/I_base*(1-xi)));
    iq_ref_MTPA_neg(iq_ref_MTPA_neg > I_max | iq_ref_MTPA_neg < -I_max) = NaN;
    
    % Eliminar NaN de ambos vectores
    valid_indices = ~isnan(iq_ref_MTPA_pos) & ~isnan(iq_ref_MTPA_neg);
    id_ref_MTPA = id_ref_MTPA(valid_indices);
    iq_ref_MTPA_pos = iq_ref_MTPA_pos(valid_indices);
    iq_ref_MTPA_neg = iq_ref_MTPA_neg(valid_indices);
elseif xi == 1
    id_ref_MTPA = [0, 0];
    iq_ref_MTPA_pos = [0, I_max];
    iq_ref_MTPA_neg = [-I_max, 0];
    
end

for i = 1:length(id_ref_MTPA)
    if sqrt(id_ref_MTPA(i)^2 + iq_ref_MTPA_pos(i)^2) >= I_max
        gamma_MTPA = abs(atan(iq_ref_MTPA_pos(i)/id_ref_MTPA(i))) + pi;
    end
end

MTPA_plot_pos = plot(id_ref_MTPA, iq_ref_MTPA_pos, 'g', 'LineWidth', 2);
MTPA_plot_neg = plot(id_ref_MTPA, iq_ref_MTPA_neg, 'c', 'LineWidth', 2);

clear id_ref_MTPA iq_ref_MTPA_pos iq_ref_MTPA_neg valid_indices id iq
%% Voltage ellipses


syms w_MTPA

eqn_w_MTPA = (I_base + I_max*cos(gamma_MTPA))^2 / (V_base / (w_MTPA * lambda_b / I_base))^2 + (I_max*sin(gamma_MTPA))^2 / (V_base / (xi * w_MTPA * lambda_b / I_base))^2 - 1;

w_MTPA = double(solve(eqn_w_MTPA, w_MTPA));

speed_vals = [linspace(pp*SpeedMax*2*pi/60/5, pp*SpeedMax*2*pi/60, 5), w_MTPA(w_MTPA>0), w_base]; % speed values

for i = 1:length(speed_vals)
    h_ellipse = -I_base;
    a_ellipse = V_base./(lambda_b/I_base*speed_vals(i));
    b_ellipse = V_base./(xi*lambda_b/I_base*speed_vals(i));
    
    t = linspace(0, 2*pi, 100);
    
    id = a_ellipse * cos(t) + h_ellipse;
    iq = b_ellipse * sin(t);
    
    if i < length(speed_vals) - 1
        voltageEllipse_plot = plot(id, iq, '--b','LineWidth',1);
        text(h_ellipse, min(iq), sprintf('%.f rpm',speed_vals(i)*60/(2*pi)/pp),'Color','blue','FontSize',12);
    elseif i == length(speed_vals) - 1
        MTPAEllipse_plot = plot(id, iq, '--g','LineWidth',1);
        text(h_ellipse, min(iq), sprintf('%.f rpm',speed_vals(i)*60/(2*pi)/pp),'Color','green','FontSize',12);
    else
        w0Ellipse_plot = plot(id, iq, '--c','LineWidth',1);
        text(h_ellipse, min(iq), sprintf('%.f rpm',speed_vals(i)*60/(2*pi)/pp),'Color','cyan','FontSize',12);

    end

end

clear h_ellipse a_ellipse b_ellipse id iq t 
%% Plot legend

legend([i_lim_plot(1), tq_plot_pos(1), tq_plot_neg(1), MTPA_plot_pos(1), MTPA_plot_neg(1), voltageEllipse_plot(1), MTPAEllipse_plot(1), w0Ellipse_plot(1)], 'Current limit [A]', 'Torque curves (traction) [N·m]', 'Torque curves (regen) [N·m]', 'MTPA hyperbola (traction)', 'MTPA hyperbola (regen)', 'Voltage limit ellipses [rpm, mechanical]', 'MTPA speed point ellipse [rpm, mechanical]', 'MTPA speed limit ellipse [rpm, mechanical]')