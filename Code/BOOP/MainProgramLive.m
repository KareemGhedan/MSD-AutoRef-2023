% Deniz Akyazi - BOOP Livestream Code ()
% 07/03/2024
% Livestream Version

% Parameters
ball_in = true;
ball_radius = 11e-2;
game_state = true;

% Field size
field_x = [-4.08 4.08];
field_z = [-6.12 6.12];

% For compansating measurement errors
out_threshold = 4;
dummy_count = 0;
out = 1; % count for ball out of field data
count = 1;
was_played_flag = false;

% Array for saving scenarios
ballie_out = [];
ballie_track = [];


while true

     % A line somehow to get the game-state from refbox

    if game_state
    was_played_flag = true;
    data = natnetclient.getFrame;
    % Checking the boundaries
    if count ~= 1
        ballie_track(count) = [data.RigidBodies(1).x data.RigidBodies(1).z];
        intermediate_points = [ballie_track(count-1,:); (ballie_track(count,:)+ballie_track(count-1,:))/2; ballie_track(count,:)];

        for j = 1:3
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
                ball_in = true;
            end
        end
    end
    count = count + 1;
    game_state = false;
    elseif (was_played_flag)
    plot(field_x,[field_z(1) field_z(1)],'k')
    hold on
    plot(field_x,[field_z(2) field_z(2)],'k')
    plot([field_x(1) field_x(1)], field_z, 'k')
    plot([field_x(2) field_x(2)], field_z, 'k')
    plot(field_x,[0 0], 'k')
    grid on
    ylim([-7 7])
    xlim([-7 7])
    plot(ballie_track(:,2), ballie_track(:,1), 'b')
    plot(ballie_out(:,1), ballie_out(:,2),'*r')
    was_played_flag = false;
    else
    clear dummy_count out count ballie_out ballie_track
    end
end 






