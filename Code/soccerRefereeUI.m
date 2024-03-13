function fig = soccerRefereeUI(teamName)
    % Create a figure window
    fig = figure('Name', 'Robo Soccer Referee', 'NumberTitle', 'off', ...
                 'Position', [200, 200, 300, 150], 'MenuBar', 'none', ...
                 'ToolBar', 'none', 'Color', [0 0.5 0.5]);

    % Add text to display last touch information
    txtLastTouch = uicontrol('Style', 'text', 'String', 'Last Touch: None', ...
                             'Position', [50, 50, 200, 30], ...
                             'BackgroundColor', [0 0.5 0.5]);

    % Function to update UI with the last touch information
    function updateUI(teamName)
        set(txtLastTouch, 'String', ['Last Touch: ', teamName]);
    end

    % Call the updateUI function with the initial team name
    updateUI(teamName);
end

% % Add this when the referee call happens or ball goes out of play
% % Open the UI with initial team name
% % make this variable usable for closing functions too
% fig = soccerRefereeUI('Team 1');
% 
% % call this is close the figure once the game resumes
% % Close the figure
% close(fig);
% clear fig;


% function soccerRefereeUI(teamName)
%     % Create a figure window
%     fig = figure('Name', 'Robo Soccer Referee', 'NumberTitle', 'off', ...
%                  'Position', [200, 200, 300, 150], 'MenuBar', 'none', ...
%                  'ToolBar', 'none');
% 
%     % Add text to display last touch information
%     txtLastTouch = uicontrol('Style', 'text', 'String', 'Last Touch: None', ...
%                              'Position', [50, 50, 200, 30]);
% 
%     % Function to update UI with the last touch information
%     function updateUI(teamName)
%         set(txtLastTouch, 'String', ['Last Touch: ', teamName]);
%     end
% 
%     % Call the updateUI function with the initial team name
%     updateUI(teamName);
% 
%     % Close the figure after 20 seconds
%     pause(20);
%     close(fig);
% end

% % calling the functionto update with the team who touched it last time
% soccerRefereeUI('Team 1');

% function soccerRefereeUI(teamName)
%     % Create a figure window
%     fig = figure('Name', 'Robo Soccer Referee', 'NumberTitle', 'off', ...
%                  'Position', [200, 200, 300, 150], 'MenuBar', 'none', ...
%                  'ToolBar', 'none');
% 
%     % Add text to display last touch information
%     txtLastTouch = uicontrol('Style', 'text', 'String', 'Last Touch: None', ...
%                              'Position', [50, 50, 200, 30]);
% 
%     % Function to update UI with the last touch information
%     function updateUI(teamName)
%         set(txtLastTouch, 'String', ['Last Touch: ', teamName]);
%     end
% 
%     % Call the updateUI function with the initial team name
%     updateUI(teamName);
% 
%     % Return handle of the figure
%     varargout{1} = fig
% end
% 
% function closeFigure(fig)
%     % Close the figure
%     close(fig);
% end
% 
% % % Call soccerRefereeUI to create the UI window
% % % the function will return the figurehandle, and this is used to close
% % the image once the use is over
% % figHandle = soccerRefereeUI('Team 1'); 
% % 
% % % Wait for 20 seconds
% % pause(20);
% % 
% % % Call closeFigure to close the figure
% % closeFigure(figHandle);

