% Deniz Akyazi - BOOP Initial Code
% 04/03/2024
% Offline Version

% Read the data table
 opts = detectImportOptions('MSD_Ballie_Trial.csv');
 opts.DataLines = 8;
 opts.VariableNamesLine = 7;

optitrack_data = readtable('MSD_Ballie_Trial.csv', opts);

ballie = rmmissing(optitrack_data(:,6:8));

% Set parameters
ball_in = true;
ball_radius = 11e-2;
err = 1.5e-3; % random for now
field_x = [-4.08 4.08];
field_z = [-6.12 6.12];

count = 1;
i = 1;

ballie_out = [];

% % Loop for offline setting - only first marker considered
%while (ball_in)
for count = 1:size(ballie.X_1)
    % Checking the boundaries
    if ballie(count,:).X_1-ball_radius > 6.12 || ballie(count,:).Z_1-ball_radius > 4.08 || ...
            ballie(count,:).Z_1+ball_radius < -4.08 || ballie(count,:).X_1+ball_radius < -6.12
        % Printing output if 
        ball_in = false;
        ballie_out(i,1) = ballie.Z_1(count);
        ballie_out(i,2) = ballie.X_1(count);
        ball_out_time = optitrack_data.Time_Seconds_(count);
        i = i+1;
    end
    % Next instance
    %count= count + 1;
end 

plot(field_x,[field_z(1) field_z(1)],'k')
hold on
plot(field_x,[field_z(2) field_z(2)],'k')
plot([field_x(1) field_x(1)], field_z, 'k')
plot([field_x(2) field_x(2)], field_z, 'k')
plot(field_x,[0 0], 'k')
grid on
ylim([-7 7])
xlim([-7 7])
plot(ballie.Z_1, ballie.X_1, 'b')
%plot(ballie_out(:,1), ballie_out(:,2),'*r')
%plot(ballie)

