% function gamestate = gameStateController()
% 
%     % Create the main figure window
%     fig = uifigure('Name', 'Game State Controller', 'Position', [100 100 300 150]);
% 
%     % Create buttons for Play and Pause
%     playButton = uibutton(fig, 'push', 'Text', 'Play', 'Position', [50 50 100 50], 'ButtonPushedFcn', @(playButton,event) changeGameState('play'));
%     pauseButton = uibutton(fig, 'push', 'Text', 'Pause', 'Position', [150 50 100 50], 'ButtonPushedFcn', @(pauseButton,event) changeGameState('pause'));
% 
%     % Function to change the game state
%     function gamestate = changeGameState(newState)
%         % Here, you can perform any additional actions you need
%         % For now, let's just display the new state
%         disp(['Game state changed to: ', newState]);
%         % You can also call a main function passing the new game state
%         main(newState);
%         gamestate = 1;
%     end
% 
%     % Example main function that receives the game state
%     function main(gameState)
%         % This is just an example function, replace it with your actual main function
%         disp(['Main function called with game state: ', gameState]);
%         % Perform actions based on the game state
%         gamestate = 0;
%     end
% 
% end



% function gameStateController()
% 
%     % Create the main figure window
%     fig = uifigure('Name', 'Game State Controller', 'Position', [100 100 300 150]);
% 
%     % Create buttons for Play and Pause
%     playButton = uibutton(fig, 'push', 'Text', 'Play', 'Position', [50 50 100 50], 'ButtonPushedFcn', @(playButton,event) changeGameState('play'));
%     pauseButton = uibutton(fig, 'push', 'Text', 'Pause', 'Position', [150 50 100 50], 'ButtonPushedFcn', @(pauseButton,event) changeGameState('pause'));
% 
%     % Initialize game state
%     gameState = 'pause'; % Start with the game paused
% 
%     % Function to change the game state
%     function changeGameState(newState)
%         % Update the game state
%         gameState = newState;
%         % Call the main function
%         main();
%     end
% 
%     % Example main function that uses the game state
%     function main()
%         % This is just an example function, replace it with your actual main function
%         disp(['Main function called with game state: ', gameState]);
%         % Perform actions based on the game state
%     end
% 
% end


% function gameStateController()
% 
%     % Create the main figure window
%     fig = uifigure('Name', 'Game State Controller', 'Position', [100 100 300 150]);
% 
%     % Create buttons for Play and Pause
%     playButton = uibutton(fig, 'push', 'Text', 'Play', 'Position', [50 50 100 50], 'ButtonPushedFcn', @(playButton,event) gameState = changeGameState('play'));
%     pauseButton = uibutton(fig, 'push', 'Text', 'Pause', 'Position', [150 50 100 50], 'ButtonPushedFcn', @(pauseButton,event) gameState = changeGameState('pause'));
% 
%     % Initialize game state
%     gameState = 'pause'; % Start with the game paused
% 
%     % Function to change the game state
%     function newGameState = changeGameState(newState)
%         % Update the game state
%         disp(['Game state changed to: ', newState]);
%         newGameState = newState;
%         % Call the main function
%         main(newGameState);
%     end
% 
%     % Example main function that uses the game state
%     function main(gameState)
%         % This is just an example function, replace it with your actual main function
%         disp(['Main function called with game state: ', gameState]);
%         % Perform actions based on the game state
% 
%         % Communicate with another function or script here
%         % For example:
%         % anotherFunction(gameState);
%     end
% 
% end

function gameStateController()

    % Create the main figure window
    fig = uifigure('Name', 'Game State Controller', 'Position', [100 100 500 300],...
        'Color', [0.5 0 0.5]);

    % Create buttons for Play and Pause
    playButton = uibutton(fig, 'push', 'Text', 'Play', 'Position', [50 100 200 100], 'ButtonPushedFcn', @(playButton,event) changeGameState('play'));
    pauseButton = uibutton(fig, 'push', 'Text', 'Pause', 'Position', [250 100 200 100], 'ButtonPushedFcn', @(pauseButton,event) changeGameState('pause'));

    % Initialize game state
    global data;
    data = struct('gameState', 'pause'); % Start with the game paused

    % Function to change the game state
    function changeGameState(newState)
        % Update the game state
        data.gameState = newState;
        % Call the main function
        main();
    end

    % Example main function that uses the game state
    function main()
        % This is just an example function, replace it with your actual main function
        gameState = data.gameState;
        disp(['Main function called with game state: ', gameState]);
        % Perform actions based on the game state

        % Communicate with another function or script here
        % For example:
        % anotherFunction(gameState);
    end

end
