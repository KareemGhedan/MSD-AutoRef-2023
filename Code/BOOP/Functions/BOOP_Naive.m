% Deniz Akyazi - BOOP Naive Code ()
% 14/03/2024
% Considering pre-process done by the main code
function  [ball_in, dummy_count] = BOOP_Naive(x_current,z_current, dummy_count)

% Parameters
ball_radius = 11e-2;
field_z = [-4.08 4.08];
field_x = [-6.12 6.12];

% Measurement errors/Data points
    if x_current-ball_radius > field_x(1,2) || z_current-ball_radius > field_z(1,2)|| ...
    z_current+ball_radius < field_z(1,1) || x_current+ball_radius < field_x(1,1)

        ball_in = false;
    else 

        ball_in = true;
    end
end




