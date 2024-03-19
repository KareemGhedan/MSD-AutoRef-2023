function isNextTo = checkWithinRadius(data1, data2, radius)
    % Return true if data1 and data 2 is within radius
    % Require 3 inputs
    % data1 = data from nncPollAll must have the same dimensions as data 2
    % data2 = data from nncPollAll must have the same dimensions as data 1

    switch nargin
        case 2
            radius = 0.08;      % based on max speed of ball * sampling time (8*1/100)
    end

    % Get number of rigid bodies
    nBodies = size(data1, 2);
    isNextTo = true;

    % Check if each body is within radius between the two data
    sliced_data1 = data1(1:3,:);
    sliced_data2 = data2(1:3,:);
    for i = 1:nBodies
        if radius <= norm(sliced_data1(:,i)-sliced_data2(:,i))
            isNextTo = false;
            break
        end
    end
end