
grid = {}

local colors = {}
local r,g,b
local w = 32

function grid.fill(r,g,b,num1,num2)
    love.graphics.setColor(r,g,b)
    love.graphics.rectangle("fill",num1*cellSize + 32, num2*cellSize + 32, cellSize, cellSize)
end
