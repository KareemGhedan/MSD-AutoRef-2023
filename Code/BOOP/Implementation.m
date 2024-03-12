% Dummy main program to show how ballie_track is implemented
% 11/03/2024
% Deniz Akyazi

% Connect to OptiTrack
natnetclient = natnet;
natnetclient.HostIP = '192.168.5.101';
natnetclient.ClientIP = '192.168.6.51';
natnetclient.ConnectionType = 'Unicast';
natnetclient.connect;

% Get the model
model = natnetclient.getModelDescription;

% Parameters to control the code nicely
dummy_count = 0; % count for multiple data points to be out of play
out_flag = false;
i = 1; % counting the iteration
ball_in = true;
out = 0; % index for times ball was out
field_x = [-4.08 4.08];
field_z = [-6.12 6.12];

% Parameters to save data
match_track = [];
boop_details = [];

while (true)

% Something to get game-state 
%%%%%% Goes here %%%%%%%%%%%

% Get the livestream data
data = natnetclient.getFrame;

% Ball position - for the ball_in session, save the data
ball_track(i,2) = data.RigidBodies(1).x;
ball_track(i,1) = data.RigidBodies(1).z;


% Last touch check algorithm comes here
%%%%%%%%%%% Exactly here  or line 59 %%%%%%%%%%%%%%%%


    % We check ball_in every 2 data points, and interpolate them so there
    % is no overlap
    if(~rem(i,2))
        [ball_in, margin] = BOOP(ball_track(i,2), ball_track(i,1),ball_track(i-1,2), ball_track(i-1,1), dummy_count);
    end
        if(~ball_in) % ball is out!
            if (~out_flag) % first time ball out since game 'START'
                
                % these are for tracking time and comparison to referee
                out_flag = true;
                ball_out_check = i;
                ball_out_time = data.fTimestamp;

            end
            
            % Saving the out coordinates - for the proof
            ball_out_track(out,1) = ball_track(i-margin,1);
            ball_out_track(out,2) = ball_track(i-margin,1);

            % Last Touch - with our confirmed index
            %%%%%%%%%%%%% Yeah, here %%%%%%%%%%%%%%

            % Send decision to referee
            displ('Ball out');

        end

            % Show proof - if game state is false already
           % if(~game_state)
        if(data.fTimestamp - ball_out_time > 1) % for tomorrow's trial
                
                disp('Last touch was done by that guy!')

                plot(field_x,[field_z(1) field_z(1)],'k')
                hold on
                plot(field_x,[field_z(2) field_z(2)],'k')
                plot([field_x(1) field_x(1)], field_z, 'k')
                plot([field_x(2) field_x(2)], field_z, 'k')
                plot(field_x,[0 0], 'k')
                grid on
                ylim([-7 7])
                xlim([-7 7])
                plot(ball_track(:,1), ball_track(:,2), 'b')
                plot(ball_out_track(:,1), ball_out_track(:,2),'*r')
                
                % reset the data from a fresh start
                clear ball_out_track ball_track ball_out_check ball_out_time
                dummy_count = 0;
                ball_in = true;
                out_flag = false;
                i = 1;

                % while(~game_state)
                %     % we get game_state here too
                % end
                java.lang.Thread.sleep( 9996 );
                close all

            % Data resets itself if referee took no action for x seconds

            % elseif(out_flag & data.fTimestamp - ball_out_time > 5)
            %     clear ball_out_track ball_track ball_out_check ball_out_time
            %     dummy_count = 0;
            %     out = 0;
            %     ball_in = true;
            %     out_flag = false;
            %     i = 1;
        end
    
end

