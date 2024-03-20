function T_ball_turtle = makeBallTurtleTable(default_data, ballID, robotID)
    % return ball-turtle table with 1 row and column ['x_ball', 'y_ball', 'z_ball', 'x_turtle', 'y_turtle', 'z_turtle', 'x_dist', 'y_dist', 'z_dist', 'dist']
    % Input must be 3
    % Input default_data = matrix from nncPollAll
    % Input ballID = ball ID defined in Motive
    % Input robotID = robot ID defined in Motive

    headerTable = {'X_dist', 'Y_dist', 'Z_dist', 'distance'};

    % Get ball data
    [~, col] = find(default_data == ballID);
    ball_pos = default_data(1:3,col);      % [x y z]'

    % Get robot data
    [~, col] = find(default_data == robotID);
    robot_pos = default_data(1:3,col);  % [x y z]'
    
    % Table
    x_dist = ball_pos(1) - robot_pos(1);
    y_dist = ball_pos(2) - robot_pos(2);
    z_dist = ball_pos(3) - robot_pos(3);
    dist = sqrt(x_dist.^2 + y_dist.^2 + z_dist.^2);
    T_ball_turtle = array2table([x_dist y_dist z_dist dist],'VariableNames',headerTable);
end