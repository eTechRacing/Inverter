%% Temperature sensing LUT calculation for DFS05HF12EYR1
clc, clear
%% Initial variables
temperatures = 0:10:120; % Temperature array, 0.01ºC resolution [ºC]

%% NTC Parameters

% DFS05HF12EYR1 internal NTC
% Beta is a function of temperature

%beta_values = [3375, 3411, 3433]; % Beta values for different temperatures [K]
%beta_temps = [50, 80, 100]; % Temperatures for the different beta values [ºC]

% CAB016M12FM3 internal NTC
% Beta is a function of temperature
beta_values = [3380, 3468, 3523]; % Beta values for different temperatures [K]
beta_temps = [50, 80, 100]; % Temperatures for the different beta values [ºC]

% Both very similar, interchangable

beta_coeffs = polyfit(beta_temps, beta_values, 1); % Fit the beta deviation with linear regression

beta_temp = polyval(beta_coeffs,log(temperatures+1e-9)); % Beta is evaluated for all temperatures, avoiding 0ºC [K]

T_0 = 25; % T at which NTC = R0 [ºC]

R_0 = 5e3; % NTC resistance value at T_0 [Ω]

%% Calculations

% NTC resistance value for all temperatures, with varying beta
NTC = R_0*exp(-beta_temp.*(1./(273.15+25)-1./(273.15+temperatures))); % NTC resistance with no errors [Ω]

% Reading using UCC21732 isolated analog reading. 200uA current source (https://www.ti.com/lit/ds/symlink/ucc21710-q1.pdf?ts=1701352389228&ref_url=https%253A%252F%252Fwww.google.com%252F)
R_filt = 10e3; % Filter resistance, in series with the NTC [Ω]

I_AIN = 200e-6; % Internal current source [A]
V_AIN = I_AIN * (R_filt + NTC); % Sensed voltage [V]

D = -20 * V_AIN + 100; % Duty cycle out [%]

VCC_GD = 5; % GD supply voltage [V]
V_read = VCC_GD * D/100; % Voltage read by ADC [V] (filtered with ideal RC)

VCC_ADC = 3.3; % MCU/ADC supply voltage [V]
bits = 12; % ADC bits [b]

bits_read = ceil(V_read * (2^bits) / VCC_ADC); % MCU/ADC read bits [b]
bits_read(bits_read>2^bits)=2^bits; % Saturation to 2^bits
bits_read(bits_read<0)=0; % Saturation to 0

% Create the plot
figure;
plot(temperatures, bits_read, 'LineWidth', 4);

% Add labels and title
xlabel('Temperature (°C)', 'FontSize', 12);
ylabel('Bits Read', 'FontSize', 12);
title('Bits Read vs. Temperature', 'FontSize', 14);

% Add grid and adjust limits
grid on;
xlim([min(temperatures)-5, max(temperatures)+5]);
ylim([min(bits_read)-50, max(bits_read)+50]);

% Customize the appearance
set(gca, 'FontSize', 10); % Adjust font size for axis labels
set(gca, 'LineWidth', 1.5); % Adjust axis line width

OUTPUT_LUT = [temperatures; bits_read];