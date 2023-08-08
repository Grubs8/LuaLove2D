-- push = require 'push'
WINDOW_HEIGHT = 720
WINDOW_WIDTH = 1280

function love.load()
    -- Imported Libraries
    anim8 = require 'libraries/anim8'
    sti = require 'libraries/sti'
    camera = require 'libraries/camera'
    wf = require 'libraries/windfield'
    world = wf.newWorld(0,0)
    

    -- setting up default window settings
    love.graphics.setDefaultFilter("nearest", "nearest")
    love.window.setMode(WINDOW_WIDTH, WINDOW_HEIGHT, {
        fullscreen = false,
        resizable = true,
        vsync = true
    })

    -- calling the player function which mainly consists of the player's sprite and starting postition
    player()
    -- calling the animations 
    animations()
    -- camera variable
    cam = camera()
    -- loading the map
    map()
    sound()

    math.randomseed(os.time())

end

function love.update(dt)
    input()
    player.anim:update(dt)
    cam:lookAt(player.x,player.y)
    map()
    world:update(dt)
    player.x = player.collider:getX()
    player.y = player.collider:getY()
end

function love.draw()
    cam:attach()
    gameMap:drawLayer(gameMap.layers["Background"])
    gameMap:drawLayer(gameMap.layers["Trees"])
    gameMap:drawLayer(gameMap.layers["Buildings"])
    player.anim:draw(player.spriteSheet, player.x, player.y, nil, 6, nil, 6, 9)
    world:draw()
    cam:detach()
end

function input()

    local isMoving = false
    local isInBound = true

    local vx = 0
    local vy = 0

    if love.keyboard.isDown("right") then
        vx = player.speed
        player.anim = player.animations.right
        isMoving = true
    end
    if love.keyboard.isDown("left") then
        vx =  player.speed * -1
        player.anim = player.animations.left
        isMoving = true

    end
    if love.keyboard.isDown("up") then
        vy = player.speed  * -1
        player.anim = player.animations.up
        isMoving = true

    end
    if love.keyboard.isDown("down") then
        vy = player.speed
        player.anim = player.animations.down
        isMoving = true

    end
    if (player.x < 0 or player.x > WINDOW_WIDTH) then
        isInBound = false

    end

    player.collider:setLinearVelocity(vx,vy)

    if isMoving == false then
        player.anim:gotoFrame(2)
    end
    if love.keyboard.isDown("escape") then
        love.event.quit()
    end
end

function animations()
    -- player.animations.down= love.update(dt)
    player.animations = {}
    player.animations.down = anim8.newAnimation(player.grid('1-4', 1), 0.1)
    player.animations.left = anim8.newAnimation(player.grid('1-4', 2), 0.1)
    player.animations.right = anim8.newAnimation(player.grid('1-4', 3), 0.1)
    player.animations.up = anim8.newAnimation(player.grid('1-4', 4), 0.1)

    player.anim = player.animations.down

end

function player()
    player = {}
    player.collider = world:newBSGRectangleCollider(400,250,50,100,10)
    player.collider:setFixedRotation(true)
    player.x = WINDOW_WIDTH / 2
    player.y = WINDOW_HEIGHT / 2
    player.speed =400
    player.sprite = love.graphics.newImage('sprites/parrot.png')
    player.spriteSheet = love.graphics.newImage('sprites/player-sheet.png')
    player.grid = anim8.newGrid(12, 18, player.spriteSheet:getWidth(), player.spriteSheet:getHeight())

end

function map()
    background = love.graphics.newImage('sprites/background.png')
    gameMap = sti('maps/testmap.lua')

    local w = love.graphics.getWidth()
    local h = love.graphics.getHeight()
    local mapW = gameMap.width * gameMap.tilewidth
    local mapH = gameMap.height * gameMap.tileheight

    walls = {}
   --[[ if gameMap.layers["Ellipse"] then
        for i, obj in pairs(gameMap.layers["Ellipse"].objects) do
            local ellipse = world:newEllipseCollider(obj.x, obj.y, obj.width,obj.height)
        end
    end 
    --]]
    if gameMap.layers["Walls"]then
        for i, obj in pairs(gameMap.layers["Walls"].objects) do
            local wall = world:newRectangleCollider(obj.x, obj.y, obj.width, obj.height)
             wall:setType('static')
             table.insert(walls,wall)
        end
    end

    -- left player border
    if  player.x < 18 then
        player.x = 18
    end
    -- right player border
    if  player.x > (mapW - 12) then
        player.x = (mapW -6)
    end
    -- top player border
    if  player.y < 18 then
        player.y = 18
    end
    -- bottom player border
    if  player.y > (mapH -12) then
        player.y = (mapH - 6)
    end

    -- left border
    if cam.x < w/2 then
        cam.x = w/2
    end
    -- right border
    if cam.x > (mapW - w/2) then
        cam.x = (mapW - w/2)
    end
    -- top border
    if cam.y < h/2 then
        cam.y = h/2
    end
    -- bottom border
    if cam.y > (mapH - h/2) then
        cam.y = (mapH - h/2)
    end

end

function sound()
    sounds = {}
    sounds.blip = love.audio.newSource("sounds/blip.wav","static")
    sounds.music = love.audio.newSource("sounds/music.mp3","stream")
    sounds.music:setLooping(true)
    isPlaying = true
    sounds.music:play()
end


function love.keypressed(key)
    if key == "space" then
        sounds.blip:play()
    end

    if key == "z" then
       
    
    end

end