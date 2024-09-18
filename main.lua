HC = require "HC"
Object = require "classic"
Furniture = require "furniture"
function love.conf(t)
  t.console = true
end
--[[
24 ft wide
38 ft long
]]


polygon = HC.polygon
rect = HC.rectangle

function ptable(val, name, skipnewlines, depth)
    skipnewlines = skipnewlines or false
    depth = depth or 0

    local tmp = string.rep(" ", depth)

    if name then tmp = tmp .. name .. " = " end

    if type(val) == "table" then
        tmp = tmp .. "{" .. (not skipnewlines and "\n" or "")

        for k, v in pairs(val) do
            tmp =  tmp .. ptable(v, k, skipnewlines, depth + 1) .. "," .. (not skipnewlines and "\n" or "")
        end

        tmp = tmp .. string.rep(" ", depth) .. "}"
    elseif type(val) == "number" then
        tmp = tmp .. tostring(val)
    elseif type(val) == "string" then
        tmp = tmp .. string.format("%q", val)
    elseif type(val) == "boolean" then
        tmp = tmp .. (val and "true" or "false")
    else
        tmp = tmp .. "\"[inserializeable datatype:" .. type(val) .. "]\""
    end

    return tmp
end
function love.load()
   local hw = 5.5/2
   OFFSET = 12*13
   walls = {
      polygon(
      294.75+OFFSET, 106.5+OFFSET,
      333.748+OFFSET, 106.159+OFFSET,
      345.91+OFFSET, 91.561+OFFSET,
      346.667+OFFSET, 43.316+OFFSET,
      376.66+OFFSET, 43.42+OFFSET,
      375.81+OFFSET, 92.412+OFFSET,
      369.81+OFFSET, 92.401+OFFSET,
      337.732+OFFSET, 130.494+OFFSET,
      294.24+OFFSET, 129.658+OFFSET
      ),
      polygon(
         1000, 1000, -- Bulk bottom right 1
         38*12+OFFSET, 24*12+OFFSET, -- Bottom right 2
         0+OFFSET, 24*12+OFFSET, -- Bottom left3
         0+OFFSET, 0+OFFSET, -- Top Left 4
         38*12+OFFSET, 0+OFFSET, -- Top Right 5
         42*12+OFFSET, 12*12+OFFSET, -- Point Right 6
         38*12+OFFSET, 24*12+OFFSET, -- Return to bottom right
         1000, 1000, --Bulk Bottom Right
         1000, 0, -- Bulk Point
         1000, -1000, --Bulk Top Right
         -1000, -1000, --Bulk Top Left
         -1000, 1000 --Bulk Bottom Left
      ),
      rect(0+OFFSET, 12*12 - hw+OFFSET, 9.8*12 - 24, hw*2), -- Girls room / Guest room seperator

      rect(9.8*12 + 9*12 + hw*4+OFFSET, 12*12 - hw+OFFSET, 5.5, 5.5), -- Post
      rect(12*12+OFFSET, 12*12-hw+OFFSET, hw*2, 12*12 + hw), -- Girls / Stairs wall
      rect(12*12 + 37+OFFSET, 12*12-hw+OFFSET, 4, 12*12 + hw), -- Girls / Stairs wall

      rect(12*12 - hw+OFFSET, 0+OFFSET, hw*2, 8*12), -- Guest wardrobe/bathroom wall
      rect(12*12 + 8*12 - hw+OFFSET, 0+OFFSET, hw*2, 8*12), -- bathroom/kitchen wall
      rect(12*12 + 8*12 + hw+OFFSET, 0+OFFSET, 75+0.5+35, 27), -- kitchen counter
      rect(12*12 + 8*12 + hw + 75+OFFSET, 27+OFFSET, 35, 1.5), -- kitchen counter+

      rect(12*12 + 8*12 + hw+1+OFFSET, 28+OFFSET, 24, 31), -- Stove

      rect(12*12 + 8*12 + hw+1+OFFSET, 60+OFFSET, 32, 3*12), -- Fridge
      rect(12*12 + 8*12 - 20-hw*2+OFFSET, 8*12 - 38+OFFSET, 22, 37), -- BRSInk

      rect(12*12 + hw+1+OFFSET, 35+OFFSET, 22, 60), -- Bathroom Cupboard
      rect(12*12 + hw+1+OFFSET, 1+OFFSET, 32.5, 33), -- Water Heater Box

      rect(12*12 - hw+OFFSET, 8*12+OFFSET, 3*12, hw*2), -- bathroom door wall left
      rect(12*12 - hw - 18 - 40+OFFSET, 8*12+OFFSET, 40, hw*2), -- bathroom door wall left
      rect(12*12 - hw*2 - 18+OFFSET, 0+OFFSET, hw, 8*12), -- bathroom door wall left
      rect(12*12 - hw - 18+OFFSET, 7*12+OFFSET, 18, hw), -- bathroom door wall left
      rect(12*12 + 5*12 - hw+OFFSET, 8*12+OFFSET, 3*12 + hw*2, hw*2), -- bathroom door wall right
      rect(12*12 + 8*12 + hw+OFFSET, 8*12+OFFSET, 31, hw*2), -- fridge wall

      polygon(
         408.5+OFFSET, 288+OFFSET,
         408.377+OFFSET, 278+OFFSET,
         397.66+OFFSET, 261.113+OFFSET,
         448.694+OFFSET, 225.906+OFFSET,
         460.251+OFFSET, 242.228+OFFSET,
         469.844+OFFSET, 245.051+OFFSET,
         457.164+OFFSET, 289.269+OFFSET
      ), -- Fireplace

      rect(12*12 + 4*12 + OFFSET, 24*12 - 40 + OFFSET, 40, 40),
      rect(12*12 + 4*12 + 39 + 40 + OFFSET, 24*12 - 2 + OFFSET, 3, 2),
      rect(12*12 + 4*12 + 39 + 43 + 58 + OFFSET, 24*12 - 2 + OFFSET, 70, 2),

   }

   local loungeDef = {
      -- {w=17, h=24, n="Charge station", col={r=237, g=119, b=45}},--
      -- {w=24, h=24, n="Side Table", col={r=99, g=91, b=78}},--
      -- {w=28, h=28, n="Fishy Tank", col={r=0,g=0,b=0}},
      -- {w=29, h=36, n="Rocking Chair1", col={r=122, g=140, b=145}},--
      -- {w=29, h=36, n="Rocking Chair2", col={r=122, g=140, b=145}},--
      --{w=35, h=41, n="Mum Chair"},
      --{w=33, h=48, n="Rocking Chair"},
      -- {w=38, h=56, n="Susan Chair", col={r=227, g=175, b=132}},--
      -- {w=38, h=87, n="Imaginary Lounge", col={r=0,g=0,b=0}},
      -- {w=23, h=17, n="Table", col={r=99, g=91, b=78}},

      
      {w=18, h=21, n="Drawers", col={r=214, g=188, b=146}},
      
      {w=25, h=40, n="Coffee Station", col={r=197, g=232, b=231}},
      
      {w=17, h=57, n="Religious bookshelf", col={r=112, g=66, b=69}},
      {w=17, h=58, n="New Pat", col={r=240, g=167, b=122}},
      {w=38, h=87, n="Girl Lounge", col={r=222, g=73, b=35}},
      {w=38, h=88, n="Mum lounge", col={r=90, g=120, b=79}},
      {w=58, h=67, n="Dining Table", col={r=240, g=167, b=122}},
      {w=47, h=18.5, n="Cupboard", col={r=232, g=114, b=46}},
      {w=15, h=17, n="Metal Light Shelf", col={r=150, g=150, b=150}},

      {w=17, h=23, n="(1)\nTiny\nTable", col={r=173, g=156, b=100}},
      {w=17, h=23, n="(2)\nTiny\nTable", col={r=173, g=156, b=100}},
      {w=20, h=26, n="Side\nTable\nDrawer",  col={r=99, g=91, b=78}},
      {w=35, h=43, n="Reclining\nChair",  col={r=153, g=85, b=56}},
      {w=28, h=46, n="Coffee\nTable",  col={r=237, g=119, b=45}},
      {w = 37, h = 85, n = "White\nLounge\n(STAR)", col = {r = 180, g = 180, b = 180}},
   }
   list = {}
   mouse = HC.point(0,0)

   released = false
   rclick = false
   clicked = false
   clicking = false
   target = 0

   presets = {
      {r = 0, x = 350, y = 325},
      {r = -0.31415926535898, x = 626.39, y = 239.2},
      {r = 1.5707963267949, x = 389, y = 267},
      {r = 0, x = 349.5, y = 364.5},
      {r = 1.5707963267949, x = 431.5, y = 422.20053779604},
      {r = 1.5707963267949, x = 519, y = 421.887},
      {r = 0.31415926535898, x = 597, y = 325},
      {r = -1.8849555921539, x = 612.8, y = 188.38},
      {r = 0.31415926535898, x = 622, y = 385},
      {r = 0.94247779607694, x = 567, y = 382},
      {r = 0.94247779607694, x = 543, y = 377},
      {r = 6.6613381477509e-16, x = 401.5, y = 327},
      {r = 6.6613381477509e-16, x = 514, y = 329},
      {r = -1.5707963267949, x = 466, y = 382},
      {r = -1.5707963267949, x = 454, y = 329},
   }

   -- local offset = 100
   for i, obj in ipairs(loungeDef) do
      table.insert(list,
      Furniture(
         presets[i].x-(obj.w/2),
         presets[i].y-(obj.h/2),
         obj.w,
         obj.h, 0, {r=obj.col.r/255, g=obj.col.g/255, b=obj.col.b/255})
      )
      list[i].object:setRotation(presets[i].r)
      -- offset = offset + obj.w
      list[i].object.e_index = i
   end
   for _, obj in ipairs(list) do
      for shape, delta in pairs(HC.collisions(obj.object)) do
         -- obj.object:move(delta.x, delta.y)
      end
   end

   hand = love.mouse.getSystemCursor("hand")
   width = love.graphics.getWidth()
   height = love.graphics.getHeight()
   X = 0
   Y = 0
   hover = 0
   scroll = 0
   PRINT = ""
end

function dist(x1,y1,x2,y2) return math.sqrt((x2 - x1) ^ 2 + (y2 - y1) ^ 2) end

function love.update(dt)
   if love.mouse.isDown(1) then
      if not clicking then
         clicked = true
      end
      clicking = true
   elseif not love.mouse.isDown(1) then
      clicking = false
   end

   if target > 0 and target <= #list then
      local obj = list[target]
      obj:moveTo(mouse:center())
      for shape, delta in pairs(HC.collisions(obj.object)) do
         if shape._type ~= "point" and obj.x and obj.y and delta then
            obj:moveTo(obj.x + delta.x, obj.y + delta.y)
         end
      end
   end

   if target > 0 then
      local mx, my = mouse:center()
      local tx, ty = list[target].object:center()
      if dist(mx, my, tx, ty) > 0.5 then
         -- love.mouse.setPosition(tx, ty)
      end
   end

   if target > 0 then
      local x = 0
      local y = 0
      for shape, delta in pairs(HC.collisions(list[target].object)) do
         list[target]:move(delta.x, delta.y)
      end
      love.mouse.setCursor(hand)

      goto afterHand
   end

   hover = 0
   for shape, delta in pairs(HC.collisions(mouse)) do
      if not shape.e_index then goto afterHand end

      hover = shape.e_index
      local obj = list[shape.e_index]
      if clicked and target == 0 then
         target = shape.e_index
      end
      if scroll ~= 0 then
         obj:rotate(-scroll)
         for shape, delta in pairs(HC.collisions(obj.object)) do
            obj:move(delta.x, delta.y)
         end
      end
      love.mouse.setCursor(hand)
      goto afterHand
   end



   love.mouse.setCursor()
   ::afterHand::

   released = false
   rclick = false
   scroll = 0
end

function love.draw()
   -- Translate Offset
   love.graphics.push()
   love.graphics.translate(X, Y)
   mouse:moveTo(love.graphics.inverseTransformPoint(love.mouse.getPosition()))


   mouse:draw("fill")

   love.graphics.setColor(0, 1, 0, 0.5)
   for _, wall in ipairs(walls) do
      wall:draw("fill")
   end

   for _, obj in ipairs(list) do
      obj:draw()
   end

   love.graphics.setColor(1, 0, 0, 0.5)
   if target > 0 then
      list[target].object:draw("fill")
      goto afterhl
   end
   if hover > 0 then
      list[hover].object:draw("fill")
   end
   ::afterhl::
   love.graphics.setColor(1, 1, 1, 0.1)
   love.graphics.setLineWidth(1)
   love.graphics.setLineStyle("rough")
   for x = 0, 100 do
      love.graphics.line(x*12, 0, x*12, height)
      love.graphics.line(0, x*12, width, x*12)
   end
   love.graphics.pop()

   love.graphics.setColor(1, 1, 1)
   love.graphics.print(PRINT, 100, 100)
end

function love.wheelmoved(x, y)
   scroll = y
end

function love.mousereleased(x, y, button, isTouch)
   if button == 1 then
      released = true
   elseif button == 2 then
      rclick = true
      local printlist = {}
      for _, obj in ipairs(list) do
         local o = obj.object
         local x, y = o:center()
         table.insert(printlist, {x = x, y = y, r = o._rotation})
      end
      print(ptable(printlist))
   end
   dragging = false
   clicked = false
   target = 0
end

function love.mousepressed(x, y, button, istouch, presses)
   if hover == 0 then
      dragging = true
   end
end


function love.mousemoved(x, y, dx, dy)
   if dragging then
      -- X = X + dx
      -- Y = Y + dy
   end
end
