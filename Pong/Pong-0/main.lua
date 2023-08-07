--[[
    GD50 2018
    Pong Remake

    pong-0
    "the Day-0 Update"

    -- Main Program --- 
    
    Author: Andrew Gibson
    ajgibb89@gmail.com

    Priginally programmed by Atari in 1972. Features two
     paddles, controlled by players, with the goal of getting
      the ball past your opponent's edge. First to 10 points wins.
]] WINDOW_WIDTH = 1280;
WINDOW_HEIGHT = 720;

--[[
    Runs when the game first starts up, only once; used to initialize the game.
]]
function love.load()
    love.window.setMode(WINDOW_WIDTH, WINDOW_HEIGHT, {
        fullscreen = false,
        resizable = true,
        vsync = true
    })
end

--[[
    Called after update by LOVE2D, used to draw anything to the screen, updated or otherwise.
]]
function love.draw()
    love.graphics.printf('Hello Pong!', 0, WINDOW_HEIGHT / 2 - 6, WINDOW_WIDTH, 'center');
end

