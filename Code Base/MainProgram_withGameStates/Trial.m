
global game;

gameStateController();
pause(1)

while true
    if(~game.gameState)
        disp('Game paused.')
    else
        disp('Game continues.')
    end
    pause(1)
end