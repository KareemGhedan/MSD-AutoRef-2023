
global game;
gameStateController();

while (true)

if(game.gameState)
    disp('Currently playing');
else
    disp('Currently paused');
end

pause(1)
end
