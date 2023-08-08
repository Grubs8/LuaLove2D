function love.load()
    wf = require 'libraries/windfield'

    world = wf.newWorld(0, 800)

    player = world:newRectangleCollider(350,100, 80, 80)
    ground = world:newRectangleCollider(100, 400, 600,100)
    ground:setType('static')
    
    

end

function love.update(dt)
    input()
    world:update(dt)
end

function love.draw()
    world:draw()
end

function input()

    local px, py = player:getLinearVelocity()
    player.speed = 3
    if love.keyboard.isDown('left') and px > -300 then
        player:applyForce(-5000,0)
    elseif love.keyboard.isDown('right') and px < 300 then
        player:applyForce(0,5000)
    end
    if love.keyboard.isDown('escape') then
        love.event.quit()
    end
    
end


function love.keypressed(key)
    if key == 'up' then
        player:applyLinearImpulse(0,-5000)
    end
end