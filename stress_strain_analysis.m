% Load data from CSV files
steel_data = readtable('steel_data.csv');
aluminum_data = readtable('aluminum_data.csv');

% Extract strain and stress data
strain_steel = steel_data.Strain;
stress_steel = steel_data.Stress;

strain_aluminum = aluminum_data.Strain;
stress_aluminum = aluminum_data.Stress;
% Plot raw data
figure;
plot(strain_steel, stress_steel, 'r-o','LineWidth',2,'DisplayName', 'Steel');
hold on;
plot(strain_aluminum, stress_aluminum, 'b-o','LineWidth',2, 'DisplayName', 'Aluminum');
xlabel('Strain (%)');
ylabel('Stress (MPa)');
title('Stress-Strain Curve');
legend(Location="best");
grid on;
hold off;
% Polynomial fitting for steel
degree = 2; % Quadratic fit
[p_steel, S_steel] = polyfit(strain_steel, stress_steel, degree);

% Polynomial fitting for aluminum
[p_aluminum, S_aluminum] = polyfit(strain_aluminum, stress_aluminum, degree);

% Generate fitted values
fitted_stress_steel = polyval(p_steel, strain_steel);
fitted_stress_aluminum = polyval(p_aluminum, strain_aluminum);
fprintf('Steel Polynomial Coefficients: %.2f %.2f %.2f\n', p_steel);
fprintf('Aluminum Polynomial Coefficients: %.2f %.2f %.2f\n', p_aluminum);
% Add fitted curves
hold on;
plot(strain_steel, fitted_stress_steel, 'r--', 'LineWidth',2,'DisplayName','Steel Fit');
plot(strain_aluminum, fitted_stress_aluminum, 'b--', 'LineWidth',2, 'DisplayName','Aluminum Fit');
legend;
hold off;
% Calculate error
error_steel = stress_steel - fitted_stress_steel;
error_aluminum = stress_aluminum - fitted_stress_aluminum;

% Compute Mean Squared Error (MSE)
mse_steel = mean(error_steel.^2);
mse_aluminum = mean(error_aluminum.^2);

% Display error metrics
fprintf('Mean Squared Error for Steel: %.2f\n', mse_steel);
fprintf('Mean Squared Error for Aluminum: %.2f\n', mse_aluminum);
% Save fitted coefficients
save('fitted_coefficients.mat', 'p_steel', 'p_aluminum');

% Save the plot as an image
saveas(gcf, 'stress_strain_curve.png');





