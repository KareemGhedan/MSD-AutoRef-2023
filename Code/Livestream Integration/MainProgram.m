% Dummy main program to show how ballie_track is implemented
% It turned into main program
% 11/03/2024
% Deniz Akyazi

clc
clear
py.importlib.import_module('joblib');
py.importlib.import_module('sklearn.ensemble');

% Connect to OptiTrack
natnetclient = natnet;
natnetclient.HostIP = '192.168.5.101';
natnetclient.ClientIP = '192.168.6.51';
natnetclient.ConnectionType = 'Unicast';
natnetclient.connect;
if ( natnetclient.IsConnected == 0 )
		fprintf( 'Client failed to connect\n' )
end

% Get the model
model = natnetclient.getModelDescription;

% Parameters to control the code nicely
dummy_count = 0; % count for multiple data points to be out of play
out_flag = false;
i = 0; % counting the iteration
ball_in = true;
out = 1; % index for times ball was out
ball_radius = 11e-2;
field_z = [-4.08 4.08];
field_x = [-6.12 6.12];
k = true;
pause_count = 0;

% Parameters to save data
match_track = [];
boop_details = [];
touch_track = zeros(5,3);
lt_team = 'None';

while (k)
i = i+1;
% Something to get game-state 
%%%%%% Goes here %%%%%%%%%%%

% Get the livestream data
data = natnetclient.getFrame;

% Ball position - for the ball_in session, save the data
ball_track(i,2) = data.RigidBodies(1).x;
ball_track(i,1) = data.RigidBodies(1).z;

% Last touch check algorithm comes here
% Here we put touch detection and saving locs & times
    for m = 1:5
        if(predict_touch(matlabTable))
            % a matrix where we save the locs & time if touch
            touch_track(m,1) = data.RigidBodies(m+1).z;
            touch_track(m,2) = data.RigidBodies(m+1).x;
            touch_track(m,3) = data.fTimestamp;
        end
    end


    % We check ball_in every 2 data points, and interpolate them so there
    % is no overlap
    if(i>1)
        [ball_in, margin, dummy_count] = BOOP(ball_track(i,1), ball_track(i,2),ball_track(i-1,1), ball_track(i-1,2),dummy_count);
    end
        if(~ball_in) % ball is out!
            if (~out_flag) % first time ball out since game 'START'
                
                % these are for tracking time and comparison to referee
                out_flag = true;
                ball_out_time = data.fTimestamp;

            end
            
            % Saving the out coordinates - for the proof
            ball_out_track(out,1) = ball_track(i-margin,1);
            ball_out_track(out,2) = ball_track(i-margin,2);

            % Last Touch - with our confirmed index
            % Look up who is last touch
            [~, idx] = max(touch_track(:,1));
            last_touch = touch_track(x,:);
            if (idx > 3)
                lt_team = 'A';
            else
                lt_team = 'B';
            end

        end

            
            %if(~game_state)
                
            if(~ball_in)
            if(data.fTimestamp - ball_out_time > 1) % for tomorrow's trial
                
                soccerRefereeUI(lt_team);
                pause_count = pause_count+1; 
                disp('Last touch was done by...!')
                
                % Functionize this
                figure()
                plot(field_z,[field_x(1) field_x(1)],'k')
                hold on
                plot(field_z,[field_x(2) field_x(2)],'k')
                plot([field_z(1) field_z(1)], field_x, 'k')
                plot([field_z(2) field_z(2)], field_x, 'k')
                plot(field_z,[0 0], 'k')
                grid on
                ylim([-7 7])
                xlim([-7 7])
                plot(ball_track(:,1), ball_track(:,2), 'b--')
                plot(ball_out_track(:,1), ball_out_track(:,2),'*r')
                
                
                saveas(gcf,strcat('Match Data\13.03.24_output_decision_number_',int2str(pause_count),'.png'))
                boop_details(pause_count) = ball_out_time;
                

                % while(~game_state)
                %     % we get game_state here too
                % end
                java.lang.Thread.sleep( 996 );

                % reset the data from a fresh start
                close all
                clear ball_out_track ball_track ball_out_time
                ball_in = true;
                dummy_count = 0;
                out_flag = false;
                out = 1;
                i = 1;
        

            % Data resets itself if referee took no action for x seconds

             % elseif(out_flag & data.fTimestamp - ball_out_time > 5)
             %     clear ball_out_track ball_out_time
             %     dummy_count = 0;
             %     out = 1;
             %     ball_in = true;
             %     out_flag = false;
                
            end
            end
end
