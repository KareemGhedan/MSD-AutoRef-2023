function logPosBallTurtles(data, touch_data, ballID, robot1ID, robot2ID, robot3ID, robot4ID)
    % Write position data to decisions_log directory for each rigid body
    % Format: [xb,yb,zb,idb, x1,y1,z1,id1,touch1, ...]
    % input data = pose data from nncPollAll function
    % input ballID = ID of the ball from OptiTrack
    % Require 2 input
    
    if ~exist('decisions_log','dir')
        mkdir('decisions_log');
    end
    
    currentTime = regexprep(string(datetime),'\s|:|-','_');
    name = convertStringsToChars(append(sprintf("Take_ball_robots"), "_", currentTime, ".csv"));
    naming = [pwd '\decisions_log\' name];

    [~, col] = find(default_data == ballID);
    ball_data = [default_data(1:3,col); default_data(9,col)];

    turtle_data = default_data;
    turtle_data(:,col) = [];
    turtle_data = [turtle_data(1:3,:); turtle_data(9,:);]

    nBodies = size(data,2);
    lineData = reshape(data,[1,numel(data)]);
    headerCSV = repmat({"x","y","z","qx","qy","qz","qw","ts","id"},[1,nBodies]);

    if ~isfile(naming)
        writecell(headerCSV,naming,"WriteMode","append")
    end
    
    writematrix(lineData,naming,"WriteMode","append");
    
end