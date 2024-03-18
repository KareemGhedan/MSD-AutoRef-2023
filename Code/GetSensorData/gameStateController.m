function gameStateController()

    % Create the main figure window
    fig = uifigure('Name', 'Game State Controller', 'Position', [100 100 500 300],...
        'Color', [0.5 0 0.5]);

    % Create buttons for Play and Pause
    playButton = uibutton(fig, 'push', 'Text', 'Play', 'Position', [50 100 200 100], 'ButtonPushedFcn', @(playButton,event) changeGameState(true)); % play
    pauseButton = uibutton(fig, 'push', 'Text', 'Pause', 'Position', [250 100 200 100], 'ButtonPushedFcn', @(pauseButton,event) changeGameState(false)); % pause

    % Initialize game state
    persistent gameState;
    gameState = false; % Start with the game paused, false is pause and true is play

    % Function to change the game state
    function changeGameState(newState)
        % Update the game state
        gameState = newState;
        % Call the main function
        main();
    end

    % Example main function that uses the game state
    function main()
        disp(['Main function called with game state: %i\n', gameState]);
        % Perform actions based on the game state
        runMainProgram(gameState)
    end

end
