function  ball_in = BOOP_Naive(ball_pos, field_corners, ball_radius)
    % Return boolean. If ball is inside, return 1, else 0
    % Require 1 input, 2 optional inputs; Unit in meters
    % Input ball_pos = x and z position of the ball in [x z]
    % Input field_size = 4 points of the field in [z_left z_right;x_bot x_top]
    % Input ball_size = radius of ball in double

    if nargin > 3
        error("Error: Too many inputs")
    end

    switch nargin
        case 1
            field_corners = [-4.08 4.08;-6.12 6.12];
            ball_radius = 11e-2;
        case 2
            ball_radius = 11e-2;
    end
    
    % Measurement errors/Data points
    cond1 = (ball_pos(1)-ball_radius) > field_corners(2,2);
    cond2 = (ball_pos(2)-ball_radius) > field_corners(1,2);
    cond3 = (ball_pos(2)-ball_radius) > field_corners(1,1);
    cond4 = (ball_pos(1)-ball_radius) > field_corners(2,1);

    if cond1 || cond2 || cond3 || cond4
        ball_in = false;
    else 
        ball_in = true;
    end
end




