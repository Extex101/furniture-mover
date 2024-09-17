Furniture = Object:extend()

function Furniture:new(x, y, w, h, r, col)
   self.x = x
   self.y = y
   self.w = w
   self.h = h
   self.r = r or 0
   self.col = col
   self.object = HC.rectangle(x, y, w, h)
   self.object:rotate(r)
end

function Furniture:rotate(a)
   self.object:rotate(math.rad(360/80)*a)
end

function Furniture:moveTo(x, y)
   self.object:moveTo(x, y)
   self.x = x
   self.y = y
end

function Furniture:move(x, y)
   self.object:move(x, y)
   self.x = self.x + x
   self.y = self.y + y
end

function Furniture:collide()
   for shape, delta in pairs(HC.collisions(self.object)) do
      if shape._type == "point" then goto next end
      self:moveTo(self.x + delta.x, self.y + delta.y)
      ::next::
   end
end

function Furniture:draw()
   love.graphics.setColor(self.col.r, self.col.g, self.col.b)
   self.object:draw("fill")
end
return Furniture
