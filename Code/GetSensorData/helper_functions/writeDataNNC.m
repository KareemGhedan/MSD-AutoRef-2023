function writeDataNNC(data, name)
    % Write pose data to position_logs directory for each rigid body
    % Format: [x,y,z,qx,qy,qz,qw, ts, id, x,y,z,qx,qy,qz,qw, ts, id, ...]
    % input data = pose data from nncPollAll function
    % input name = name of the file
    % Require 2 input

    if nargin ~= 2
        error("Error: Input must be 2")
    end
    
    if ~exist('position_logs','dir')
        mkdir('position_logs');
    end
    
    naming = [pwd '\position_logs\' name];

    nBodies = size(data,2);
    lineData = reshape(data,[1,numel(data)]);
    headerCSV = repmat({"x","y","z","qx","qy","qz","qw","ts","id"},[1,nBodies]);

    if ~isfile(naming)
        writecell(headerCSV,naming,"WriteMode","append")
    end
    
    writematrix(lineData,naming,"WriteMode","append");
    
end