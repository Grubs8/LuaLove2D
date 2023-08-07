-- push = require 'push'
WINDOW_HEIGHT = 720
WINDOW_WIDTH = 1280

function love.load()
    love.window.setMode(WINDOW_WIDTH, WINDOW_HEIGHT, {
        fullscreen = false,
        resizable = true,
        vsync = true
    })
    player = {}
    player.x = WINDOW_WIDTH / 2
    player.y = WINDOW_HEIGHT / 2
    player.speed = 3
    player.sprite = love.graphics.newImage('sprites/parrot.png')
    background = love.graphics.newImage('sprites/SkeletonWarrior.jpg')

    math.randomseed(os.time())

end

function love.update(dt)
    input()
end

function love.draw()
    love.graphics.draw(background, 0, 0)
    love.graphics.draw(player.sprite, player.x, player.y)

end

function input()

    if love.keyboard.isDown("right") then
        player.x = player.x + player.speed
    end
    if love.keyboard.isDown("left") then
        player.x = player.x - player.speed
    end
    if love.keyboard.isDown("up") then
        player.y = player.y - player.speed
    end
    if love.keyboard.isDown("down") then
        player.y = player.y + player.speed
    end
    if love.keyboard.isDown("escape") then
        love.event.quit()
    end
end

