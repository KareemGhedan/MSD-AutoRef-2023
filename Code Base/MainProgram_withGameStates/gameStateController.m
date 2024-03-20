% UI for referee to start/pause game
% 18/03/2024
% Anshid Nuhman Pillat

function gameStateController()

    % Create the main figure window
    state_fig = uifigure('Name', 'Game State Controller', 'Position', [100 100 500 300],...
        'Color', [0.5 0 0.5]);

    % Create buttons for Play and Pause
    uibutton(state_fig, 'push', 'Text', 'Play', 'Position', [50 100 200 100], 'ButtonPushedFcn', @(playButton,event)changeGameState(1)); % play
    uibutton(state_fig, 'push', 'Text', 'Pause', 'Position', [250 100 200 100], 'ButtonPushedFcn', @(pauseButton,event)changeGameState(0)); % pause

    % Initialize game state
    global game;
    game = struct('gameState', 1); % Start with the game paused, 0 is pause and 1 is play

    % Function to change the game state
    function changeGameState(newState)
        % Update the game state
        game.gameState = newState;
        % Call the main function
    end

end
