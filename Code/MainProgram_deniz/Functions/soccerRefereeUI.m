function fig = soccerRefereeUI(teamName)
    % Create a figure window
    fig = figure('Name', 'Robo Soccer Assistant Referee', 'NumberTitle', 'off', ...
                 'Position', [200, 200, 500, 300], 'MenuBar', 'none', ...
                 'ToolBar', 'none', 'Color', [0 0.5 0.5], ...
                 'CloseRequestFcn', @closeRequestFcn); % Set background color to teal

    % Add text box to display last touch information
    txtLastTouch = uicontrol('Style', 'edit', 'String', ['Last Touch: ', teamName], ...
                             'Position', [50, 200, 400, 50], ...
                             'BackgroundColor', [1 1 1], 'FontSize', 12, 'FontWeight', 'bold', ...
                             'HorizontalAlignment', 'center', 'Enable', 'inactive'); % Set text background color to white, and make it read-only

    % Add button to display proof of decision
    btnProof = uicontrol('Style', 'pushbutton', 'String', 'Show Proof of Decision', ...
                         'Position', [50, 100, 200, 50], ...
                         'Callback', @showProofCallback);

    % Add button to close the window
    btnClose = uicontrol('Style', 'pushbutton', 'String', 'Close', ...
                         'Position', [300, 100, 150, 50], ...
                         'Callback', @closeCallback);

    % Function to update UI with the last touch information
    function updateLastTouch(teamName)
        set(txtLastTouch, 'String', ['Last Touch: ', teamName]);
    end

    % Function to display proof of decision (simple plot)
    function showProofCallback(~, ~)
        % % Generate sample data for plot
        % x = linspace(0, 10, 100);
        % y = sin(x);
        % 
        % % Plot the data
        % figure('Name', 'Proof of Decision', 'NumberTitle', 'off');
        % plot(x, y);
        % title('Proof of Decision');
        % xlabel('X-axis');
        % ylabel('Y-axis');
        % grid on;
        % 
        plot_fun();
        % Close the main UI window
        close(fig);
    end

    % Function to handle the close button
    function closeCallback(~, ~)
        % Close the main UI window
        close(fig);
    end

    % Function to handle the close request of the main UI window
    function closeRequestFcn(~, ~)
        % Close the figure
        closereq;
    end


    % Call the updateLastTouch function with the initial team name
    updateLastTouch(teamName);
end





function plot_fun(~,~)
% Generate sample data for plot
x = linspace(0, 10, 100);
y = sin(x);

% Plot the data
figure('Name', 'Proof of Decision', 'NumberTitle', 'off');
plot(x, y);
title('Proof of Decision');
xlabel('X-axis');
ylabel('Y-axis');
grid on;
end