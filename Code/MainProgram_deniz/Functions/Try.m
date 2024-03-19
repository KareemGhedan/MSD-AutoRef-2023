%%

global game;
py.importlib.import_module('joblib');
py.importlib.import_module('sklearn.ensemble');
gameStateController();

% Connect to OptiTrack
nnc = setNNC('Unicast','192.168.6.51');

% Parameters unrelated to iteration
ball_radius = 11e-2;
field_z = [-4.08 4.08];
field_x = [-6.12 6.12];
robot_radius = 26e-2;

% Parameters related to iteration
dummy_count = 0; % count for multiple data points to be out of play
out_flag = false;
i = 0; % counting the iteration
ball_in = true;
out = 1; % index for times ball was out
pause_count = 0;

% Parameters to save data
match_track = [];
boop_details = [];
touch_track = zeros(4,3);
lt_team = 'None';



while (true)
    i = i+1;
    %Get the livestream data
    default_data = nncPollAll(nnc);
    ballID = 998;
    robotID = [1007 1002 1003 1004];

    % TOUCH OR NO TOUCH
    % Here we put touch detection and saving locs & times
    %for m = 1:4
    m = 1;
    table = makeBallTurtleTable(default_data, ballID, robotID(m));
    if(predict_touch(table))
        % a matrix where we save the locs & time if touch
        [~, rCol] = find(default_data == robotID(m));
        touch_track(m,1) = default_data(1,rCol);
        touch_track(m,2) = default_data(3,rCol);
        touch_track(m,3) = default_data(8,rCol);
    end
    %end

    % Ball position - for the ball_in session, save the data

    [~, bCol] = find(default_data == ballID);
    ball_track(i,2) = default_data(1, bCol);
    ball_track(i,1) = default_data(3, bCol);

    % BALL OUT OF PLAY
    if(i>1)
        [ball_in, margin, dummy_count] = BOOP(ball_track(i,1), ball_track(i,2),ball_track(i-1,1), ball_track(i-1,2),dummy_count);
    end
    if(~ball_in) % ball is out!
        if (~out_flag) % first time ball out since game 'START'

            % these are for tracking time and comparison to referee
            out_flag = true;
            ball_out_time = default_data(8, bCol);

        end

        % Saving the out coordinates - for the proof
        ball_out_track(out,1) = ball_track(i-margin,1);
        ball_out_track(out,2) = ball_track(i-margin,2);

        % SAVE THE 'LAST TOUCH'
        [~, idx] = max(touch_track(:,1));
        last_touch = touch_track(idx,:);
        if (idx > 3)
            lt_team = 'A';
        else
            lt_team = 'B';
        end

    end
        % PROOF AND RESET

    if (~game.gameState && ~ball_in)


        pause_count = pause_count+1;
        boop_details(pause_count) = ball_out_time;

        % Plots figure but doesn't display
        gfc = figure('Visible','off');
        plot(field_z,[field_x(1) field_x(1)],'k')
        hold on
        plot(field_z,[field_x(2) field_x(2)],'k')
        plot([field_z(1) field_z(1)], field_x, 'k')
        plot([field_z(2) field_z(2)], field_x, 'k')
        plot(field_z,[0 0], 'k')
        grid on
        ylim([-7 7])
        xlim([-7 7])
        plot(ball_track(:,1), ball_track(:,2), 'b--')
        plot(ball_out_track(:,1), ball_out_track(:,2),'*r')

        th = 0:pi/50:2*pi;
        xunit = robot_radius * cos(th) + last_touch(1,1);
        yunit = robot_radius * sin(th) + last_touch(1,2);
        plot(xunit, yunit, 'LineWidth',3,'Color',[0 0.45 0.74]);
        %set(gcf, 'visible', 'on');

        % Saves the figure
        saveas(gcf,strcat('Match Data\LastDay_output_decision_number_',int2str(pause_count),'.png'))
        saveas(gcf, 'Temp', 'fig')

        uiwait(soccerRefereeUI('Deniz'));

        while(~game.gameState)  
            disp('Game paused')
            clc
        end

        % reset the data for a fresh start
        close all
        clear ball_out_track ball_track ball_out_time lt_team touch_track
        ball_in = true;
        dummy_count = 0;
        out_flag = false;
        out = 1;
        i = 0;

    elseif(out_flag && default_data(8, bCol) - ball_out_time > 5)
        clear ball_out_track ball_out_time lt_team
        dummy_count = 0;
        out = 1;
        ball_in = true;
        out_flag = false;

    end
    pause(1)
end
