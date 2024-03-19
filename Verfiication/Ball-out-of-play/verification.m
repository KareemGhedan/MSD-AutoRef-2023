% This script verifies whether the ball out of play is accurate within 1.5
% cm. It assumes Gaussian distribution and a 95% confidence interval.

%% Set variables
sides = {'LeftSide', 'TopSide', 'RightSide', 'BotSide'};
positions = {'003', '004'};
speed = {'a', 'b', 'c', 'd'};

size_sides_long = size(sides);
size_sides = size_sides_long(1,2);

size_positions_long = size(positions);
size_positions = size_positions_long(1,2);

size_speed_long = size(speed);
size_speed = size_speed_long(1,2);

dataFolder = 'Data/';

% Calibration coordinates of the field
BottomLeftCoordinate = [6.099101, 4.136213]; 
TopLeftCoordinate = [-0.052894, 4.109017];
TopRightCoordinate = [-0.024971, -4.095252];
BottomRightCoordinate = [6.127486, -4.080578];

ballRadius = 10.9825e-2;
max_velocity = 9;

%% Load data and determine errors

error_list = [];
velocity_list = [];

for i = 1:size_sides
    for iii = 1:size_positions
        for ii = 1:size_speed
            wantedFileName = strcat(sides{i}, '_', speed{ii}, '_', positions{iii}, '.csv');
            dataTable = readtable(strcat(dataFolder, wantedFileName));
            side = sides{i};
            position = positions{iii};
            
            if strcmp(side, 'LeftSide') && strcmp(position, '002')
                cleanDataTable = rmmissing(dataTable(:,13:15));
                X_list = table2array(cleanDataTable(:,1));
                Y_list = table2array(cleanDataTable(:,2));
                Z_list = table2array(cleanDataTable(:,3));
            
            else
                cleanDataTable = rmmissing(dataTable);
                X_list = table2array(cleanDataTable(:,6));
                Y_list = table2array(cleanDataTable(:,7));
                Z_list = table2array(cleanDataTable(:,8));
                t_list = table2array(cleanDataTable(:,2));
                
                % Calculate velocity using finite difference approximation
                dx = diff(X_list); % Change in x
                dy = diff(Y_list); % Change in y
                dz = diff(Z_list); % Change in z
                
                dt = diff(t_list); % Change in time

                velocity = sqrt(dx.^2 + dy.^2 + dz.^2) ./ dt;           
            end
            
% Uncomment to show ball trajectory
%             figure
%             scatter(-Z_list, -X_list, 5, 'filled')
%             xlabel('z-coordinate [m]')
%             ylabel('x-coordinate [m]')
%             grid on
%             hold on
%             z_lines = [BottomLeftCoordinate(2), TopLeftCoordinate(2), TopRightCoordinate(2), BottomRightCoordinate(2), BottomLeftCoordinate(2)] - ballRadius;
%             x_lines = [BottomLeftCoordinate(1), TopLeftCoordinate(1), TopRightCoordinate(1), BottomRightCoordinate(1), BottomLeftCoordinate(1)] + ballRadius;
%             plot(-z_lines, -x_lines);
%             legend('Ball positions', 'Field lines')

            
            if strcmp(side, 'LeftSide')
                error = max(Z_list) + ballRadius - (TopLeftCoordinate(2) + BottomLeftCoordinate(2))/2;
                
            elseif strcmp(side, 'TopSide')
                error = min(X_list) - ballRadius - (TopLeftCoordinate(1) + TopRightCoordinate(1))/2;

            elseif strcmp(side, 'RightSide')
                error = min(Z_list) - ballRadius - (TopRightCoordinate(2) + BottomRightCoordinate(2))/2;

            elseif strcmp(side, 'BotSide')
                error = max(X_list) + ballRadius - (BottomLeftCoordinate(1) + BottomRightCoordinate(1))/2;
                
            end
            
            error_list = [error_list, error];
            velocity_list = [velocity_list, max(movmedian(velocity, 50))];
            
        end
    end
end

%% Perform Chi-squared test for normality
[h, p] = chi2gof(error_list);

% h = 0 indicates failure to reject the null hypothesis (data is normally distributed)
% h = 1 indicates rejection of the null hypothesis (data is not normally distributed)

disp(['Chi-square p-value:', num2str(p)]);
disp(['h:', num2str(h)]);

%% Fit normal distrubution
[muHat,sigmaHat,muCI,sigmaCI] = normfit(error_list)

%% Visualize average result

% Create a range of values for x (spanning +/- 4 standard deviations)
x = linspace(muHat - 4*sigmaHat, muHat + 4*sigmaHat, 1000);
% Calculate the corresponding values of the normal distribution
y = normpdf(x, muHat, sigmaHat);
% Plot the normal distribution
figure;
plot(x, y);
title('Measurements Average Normal Distribution');
xlabel('Error [m]');
ylabel('Probability Density');
% Overlay histogram of actual data
hold on;
histogram(error_list, 'Normalization', 'pdf');
hold off;

%% Visualize worst case result
muHat = min(muCI);
sigmaHat = max(sigmaCI);

% Create a range of values for x (spanning +/- 4 standard deviations)
x = linspace(muHat - 4*sigmaHat, muHat + 4*sigmaHat, 1000);
% Calculate the corresponding values of the normal distribution
y = normpdf(x, muHat, sigmaHat);
% Plot the normal distribution
figure;
plot(x, y);
title('95% CI Normal Distribution');
xlabel('Error [m]');
ylabel('Probability Density');
% Overlay histogram of actual data
hold on;
histogram(error_list, 'Normalization', 'pdf');
hold off;