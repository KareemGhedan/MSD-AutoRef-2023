% Deniz Akyazi - BOOP Initial Code
% 04/03/2024
% Offline Version

% Read the data table

table = 'Data/200-200.csv'; % Update table name here

% Edit the table to get rid of rows with no info
opts = detectImportOptions(table);
opts.DataLines = 8; % Start from 8 because upper part of table isn't relevant
opts.VariableNamesLine = 7; 
optitrack_data = readtable(table, opts);
ballie = rmmissing(optitrack_data(:,6:8));

% Parameters
ball_in = true;
ball_radius = 11e-2;

% Field size
field_x = [-4.08 4.08];
field_z = [-6.12 6.12];

% For compansating measurement errors
out_threshold = 4;
dummy_count = 0;
out = 1; % count for ball out of field data

% Array for saving scenarios
ballie_out = [];


% Loop for offline setting - only middle marker considered

for count = 1:size(ballie.X_1)
    % Checking the boundaries
    if count == 1
        %ballie_control(count,:) = [ballie(count,:).X_1 ballie(count,:).Z_1];
    elseif count ~= 1
        current_position = [ballie(count,:).X_1, ballie(count,:).Z_1];
        prev_position = [ballie(count-1,:).X_1, ballie(count-1,:).Z_1];
        intermediate_points = [prev_position; (current_position+prev_position)/2; current_position];

        for j = 1:3
            %if ballie(count,:).X_1-ball_radius > 6.12 || ballie(count,:).Z_1-ball_radius > 4.08 || ...
            %ballie(count,:).Z_1+ball_radius < -4.08 || ballie(count,:).X_1+ball_radius < -6.12
            if intermediate_points(j,1)-ball_radius > 6.12 || intermediate_points(j,2)-ball_radius > 4.08 || ...
               intermediate_points(j,2)+ball_radius < -4.08 || intermediate_points(j,1)+ball_radius < -6.12
        
         % Ensuring ball is out + compensate measurement errors
            dummy_count = dummy_count + 1;
                if(dummy_count > out_threshold)
                    ball_in = false;
                    ballie_out(out,1) = intermediate_points(j,2);
                    ballie_out(out,2) = intermediate_points(j,1);
                    ball_out_time = optitrack_data.Time_Seconds_(count-out_threshold);
                    out = out+1;
                    dummy_count = 0;
                    ball_in = false;
                end
            else % If the ball doesn't continue to be out of play, reset the counter
                dummy_count = 0;
            end
        end
    end
end 


% Plotting the scenarios
th = 0:pi/50:2*pi;
x = -1.37725;
y = 3.56945;
r = 0.26;
xunit = r * cos(th) + x;
yunit = r * sin(th) + y;
plot(xunit,yunit)
hold on
plot(field_x,[field_z(1) field_z(1)],'k')
plot(field_x,[field_z(2) field_z(2)],'k')
plot([field_x(1) field_x(1)], field_z, 'k')
plot([field_x(2) field_x(2)], field_z, 'k')
plot(field_x,[0 0], 'k')
grid on
ylim([-7 7])
xlim([-7 7])
plot(ballie.Z_1, ballie.X_1, 'b')
plot(ballie_out(:,1), ballie_out(:,2),'*r')


