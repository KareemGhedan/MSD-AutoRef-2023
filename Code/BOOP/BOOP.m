% Deniz Akyazi - BOOP Livestream Code ()
% 07/03/2024
% Livestream Version
function  [ball_in, which] = BOOP(x_current,z_current, x_prev, z_prev, dummy_count)

% Parameters
ball_radius = 11e-2;
field_x = [-4.08 4.08];
field_z = [-6.12 6.12];
ballie_track = [x_current z_current];
ballie_prev_track = [x_prev z_prev];
which = 4;


% Measurement errors/Data points
out_threshold = 4;

% Interpolation
intermediate_points = [ballie_prev_track; (ballie_track+ballie_prev_track)/2; ballie_track];

        for j = 1:3
            
            if intermediate_points(j,1)-ball_radius > field_z(1,2) || intermediate_points(j,2)-ball_radius > field_x(1,2)|| ...
            intermediate_points(j,2)+ball_radius < field_x(1,1) || intermediate_points(j,1)+ball_radius < field_z(1,1)
            
                % Ensuring ball is out + compensate measurement errors
                dummy_count = dummy_count + 1;

                if(dummy_count > out_threshold)
                    ball_in = true;
                    dummy_count = 0;

                    if (j-1 < which)
                        which = j-1;
                    end   
                end

            else % If the ball doesn't continue to be out of play, reset the counter
                dummy_count = 0;
                ball_in = false;

            end
        end
end




