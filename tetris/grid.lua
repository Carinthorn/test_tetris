
grid = {}

local colors = {}
local r,g,b
local w = 32
local theX
local theY

--Problem: how to get r,g,b 
function grid.fill(r,g,b)
    love.graphics.setColor(r,g,b)
end

function grid.rect(x, y, len, wid)
    love.graphics.rectangle("fill",x*cellSize + 32, y*cellSize + 32, len, wid)
end

-- function grid.writeShape(Shape)
--     for i = 1, gridHeight do   
--         for j = 1, gridWidth do  
--             local x2  = (j - 1)* cellSize + 32 --to add ขอบ
--             local y2  = (i - 1)* cellSize + 32 
--             for n = 1, 4 do
--                 theX = Shape[n][1]
--                 theY = Shape[n][2] 
--                 coloredGrid[theX][theY] = 1
    
--                 if coloredGrid[i][j] == 1 then
--                     love.graphics.rectangle("fill",x2, y2, cellSize, cellSize)  
--                 end
--             end
--         end
--     end
-- end

function grid.writeShape(shape)
    for i = 1, 4 do
        theX = shape[i][1] + 1
        theY = shape[i][2] + 1

        coloredGrid[theX][theY] = 1
    end
end

return grid
