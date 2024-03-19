function LastTouch_plot(t, last_touch_data, last_touch, ballID, robot1ID, robot2ID, robot3ID, robot4ID)
    % Create subplot to figure 2nd axis
    % Require 8 inputs
    % Input t = TiledChartLayout object
    % Input last_touch_data = last data from nncPollAll when touch
    % Input last_touch = last 1-by-4 array from touch prediction
    % Input ballID = ball id from OptiTrack
    % Input robot{n}ID = {n} robot id from OptiTrack

    switch nargin
        case 5
            robot2ID = 0;
            robot3ID = 0;
            robot4ID = 0;
        case 6
            robot3ID = 0;
            robot4ID = 0;
        case 7
            robot4ID = 0;
    end

    % Get ball pos
    [~, col] = find(last_touch_data == ballID);
    ball_pos = last_touch_data(1:3,col);
    
    % Get robots pos and rearrange it to [Robot1 Robot2 Robot3 Robot4]
    robots_pos = [last_touch_data(1:3,:); last_touch_data(9,:)];
    robots_pos(:,col) = [];
    switch size(last_touch,2)
        case 1
            [~, Rcol1] = find(robots_pos == robot1ID);
            data = [robots_pos(:,Rcol1)];
        case 2
            [~, Rcol1] = find(robots_pos == robot1ID);
            [~, Rcol2] = find(robots_pos == robot2ID);
            data = [robots_pos(:,Rcol1) robots_pos(:,Rcol2)];
        case 3
            [~, Rcol1] = find(robots_pos == robot1ID);
            [~, Rcol2] = find(robots_pos == robot2ID);
            [~, Rcol3] = find(robots_pos == robot3ID);
            data = [robots_pos(:,Rcol1) robots_pos(:,Rcol2) robots_pos(:,Rcol3)];
        case 4
            [~, Rcol1] = find(robots_pos == robot1ID);
            [~, Rcol2] = find(robots_pos == robot2ID);
            [~, Rcol3] = find(robots_pos == robot3ID);
            [~, Rcol4] = find(robots_pos == robot4ID);
            data = [robots_pos(:,Rcol1) robots_pos(:,Rcol2) robots_pos(:,Rcol3) robots_pos(:,Rcol4)];
    end
    rplt = [data; last_touch];
    
    % Create names of robots and dist
    names = cell(1,size(rplt,2)+sum(last_touch == 1));
    
    % Select tile
    ax = nexttile(t,2);
    
    % plot ball
    hold on
    plot3(ball_pos(1),ball_pos(3),ball_pos(2),'om','LineWidth',2);
    
    % plot robots
    for i = 1:size(rplt,2)
        plot3(rplt(1,i), rplt(3,i), rplt(2,i), 'diamond', 'LineWidth', 2)
        if rplt(4,i) == robot1ID
            names{i} = 'Robot 1';
        elseif rplt(4,i) == robot2ID
            names{i} = 'Robot 2';
        elseif rplt(4,i) == robot3ID
            names{i} = 'Robot 3';
        elseif rplt(4,i) == robot4ID
            names{i} = 'Robot 4';
        end
    end
    
    % plot dist for robot who touch the ball
    [~, Tcol] = find(last_touch == 1);
    idx = 0;
    for j = Tcol
        idx = idx + 1;
        plot3([ball_pos(1) rplt(1,j)], [ball_pos(3) rplt(3,j)], [ball_pos(2) rplt(2,j)], 'LineWidth', 1)
        names{idx+size(rplt,2)} = 'dist';
    end
    
    % set axes limits
    grid on
    ylim([-5 5])
    xlim([-7 7])
    zlim([0 5])
    
    % set default view, and add title, labels, and legend
    view(ax,45,60)
    title('Last Touch Proof')
    xlabel('[meter] at x-axis')
    ylabel('[meter] at z-axis')
    zlabel('[meter] at y-axis')
    legend([{'ball position'} names]);
end