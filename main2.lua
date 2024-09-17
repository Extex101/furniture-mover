HC = require 'HC'

-- array to hold collision messages
local text = {}

function love.load()
    -- add a rectangle to the scene
    rect = HC.rectangle(200,400,400,20)
    D = {x=0,y=0}
    -- add a circle to the scene
    mouse = HC.rectangle(400,300,20, 70)
    mouse:moveTo(300, 400)
end

function love.update(dt)
    -- move circle to mouse position

    -- rotate rectangle
    rect:rotate(dt)

    -- check for collisions
    for shape, delta in pairs(HC.collisions(mouse)) do
        text[#text+1] = string.format("Colliding. Separating vector = (%s,%s)",
                                      delta.x, delta.y)
       D = delta
       mouse:moveTo(mouse._polygon.centroid.x + delta.x, mouse._polygon.centroid.y+delta.y)
    end

    while #text > 40 do
        table.remove(text, 1)
    end
end

function love.draw()
    -- print messages
    for i = 1,#text do
        love.graphics.setColor(255,255,255, 255 - (i-1) * 6)
        love.graphics.print(text[#text - (i-1)], 10, i * 15)
    end

    -- shapes can be drawn to the screen
    love.graphics.setColor(255,255,255)
    rect:draw('fill')
    mouse:draw('fill')

    love.graphics.setColor(1, 0, 0)
end
