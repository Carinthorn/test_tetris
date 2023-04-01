local block = {}
local width
local colors = {}
local theX
local theY
block.debugList = {}
isActive = true
r = 100
g = 155
b = 30
rotate = 0
-- local w = gridWidth/10
 
for i = 1, 20 do
    colors[i] = {}
    for j = 1, 10 do
        colors[i][j] = {}
        for n = 1, 3 do
            colors[i][j][n] = 1
        end 
    end
end

isActive = true
square = {
    {0,1},
    {0,0},
    {1,0},
    {1,1}
}

left_L = { 
    {0,1},
    {0,0},
    {1,1},
    {2,1}
    
}

right_L = {
    {0,1}, 
    {1,1},  
    {2,0},  
    {2,1}
}

line = {
    {0,0}, 
    {1,0}, 
    {2,0}, 
    {3,0}
}

right_s = {
    {0,1}, 
    {1,0}, 
    {1,1}, 
    {2,0}
} 

left_s = {
    {1,1}, 
    {1,0}, 
    {0,0}, 
    {2,1}
}

triangle = {
    {0,1}, 
    {1,1}, 
    {1,0}, 
    {2,1}
}
--before
function block.newBlock(name, x, y)
    local obj1 = {} 
    obj1.x = x * cellSize 
    obj1.y = y * cellSize 
    obj1.rotation = 0
    obj1.xScale = 1
    obj1.yScale = 1  
    obj1.image = love.graphics.newImage(name)
    obj1.width = 32
    obj1.height = 32
    -- obj.xOrigin = obj.x 
    -- obj.yOrigin = obj.y
    obj1.red = 1
    obj1.green = 1
    obj1.blue = 1
    obj1.alpha = 1

    return obj1
end

function block.newImage(name, x, y, xScale, yScale)
    local obj = {} 
    obj.x = x 
    obj.y = y 
    obj.rotation = 0
    obj.xScale = xScale
    obj.yScale = yScale
    obj.image = love.graphics.newImage(name)
    obj.width = 32
    obj.height = 32
    -- obj.xOrigin = obj.x 
    -- obj.yOrigin = obj.y
    obj.red = 1
    obj.green = 1
    obj.blue = 1
    obj.alpha = 1 

    return obj
end

--after

-- function block.newBlock(name,x,y)
--     local obj = {} 
--     obj.x = x * cellSize + 32
--     obj.y = y * cellSize + 32
--     obj.rotation = 0
--     obj.xScale = 1
--     obj.yScale = 1  
--     obj.image = love.graphics.newImage(name)
--     obj.width = 32
--     obj.height = 32
--     -- obj.xOrigin = obj.x 
--     -- obj.yOrigin = obj.y
--     obj.red = 1
--     obj.green = 1
--     obj.blue = 1
--     obj.alpha = 1 

--     return obj
-- end

function block.drawImage(obj)
    love.graphics.setColor(obj.red, obj.green, obj.blue, obj.alpha)
    love.graphics.draw(obj.image, obj.x, obj.y, obj.rotation, obj.xScale, obj.yScale, obj.xOrigin, obj.yOrigin)
end 



-- function block.generateNewBlock() 
--     if math.random(1,7) == 1 then
--         return square
--     elseif math.random(1,7) == 2 then
--         return left_L
--     elseif math.random(1,7) == 3 then
--         return right_L
--     elseif math.random(1,7) == 4 then
--         return line
        
--     elseif math.random(1,7) == 5 then
--         return right_s
        
--     elseif math.random(1,7) == 6 then
--         return left_s
--     elseif math.random(1,7) == 7 then
--         return triangle
    
--     end 
-- end

function block.generateNewBlock() 
    local choice = math.random(1,7)
    local shape = {}
    if choice == 1 then
        shape = square
        displayBlock = block.newImage("blocks/square1.png", 370, 120, 0.6, 0.6)
    elseif choice == 2 then
        shape =  left_L
        displayBlock = block.newImage("blocks/left_l1.png", 370, 120, 0.6, 0.6)
    elseif choice == 3 then
        shape =  right_L
        displayBlock = block.newImage("blocks/right_l1.png", 370, 120, 0.6, 0.6)

    elseif choice == 4 then
        shape = line
        displayBlock = block.newImage("blocks/line1.png", 370, 120, 0.6, 0.6)

    elseif choice == 5 then
        shape = right_s
        displayBlock = block.newImage("blocks/r_s1.png", 390, 70, 0.6, 0.6)

    elseif choice == 6 then
        shape = left_s
        displayBlock = block.newImage("blocks/l_s1.png", 370, 120, 0.6, 0.61)
    elseif choice == 7 then
        shape = triangle
        displayBlock = block.newImage("blocks/tri1.png", 370, 120, 0.6, 0.6)

    end 

    return shape
end

function block.addShape(currentShape)
    for i = 1, 4 do 
        theX = currentShape[i][1]
        theY = currentShape[i][2]
        --write shape color
        colors[theX][theY][1] =  0--currentShape.r
        colors[theX][theY][2] =  0--currentShape.g
        colors[theX][theY][3] =  0--urrentShape.b
    end
end

function block.drawShape()
    block.addShape(theShape)
end


--receive level as param
--important

--before
-- function block.moveDown(moveDown) 

--     for n = 1, gridHeight do       
--         for m = 1, gridWidth do      
--             if coloredGrid[n][m] == 1 then
--                 for i = 1, 4 do 
--                     if theShape[i][1] == m then 
--                         if moveDown > ((n-1) - theShape[i][2]) then   
--                             theShape[i][2] = theShape[i][2] + ((n-1) - theShape[i][2])
--                             -- break    
--                         else 
--                             theShape[i][2] = theShape[i][2] + moveDown  
--                         end 
--                     end
--                 end
--             else
--                 for i = 1, 4 do 
--                     if moveDown > (19 - theShape[i][2]) then   
--                         theShape[i][2] = theShape[i][2] + (19 - theShape[i][2])
--                         -- break   
--                     else 
--                         theShape[i][2] = theShape[i][2] + moveDown  
--                     end 
--                 end
--             end
       
--         end
--     end 

-- end

--after 
function block.moveDown(moveDown) 
    for i = 1,4 do  
        -- moveDown > 19
        if moveDown > (19 - theShape[i][2]) then   
            theShape[i][2] = theShape[i][2] + (19 - theShape[i][2])
            -- break   
        else 
            theShape[i][2] = theShape[i][2] + moveDown  
        end 
        
    end
end


--before
function block.rotate(rotation_count)
    local rotated_shape = {} 
    local rows = 4 
    local cols = 2
    
    for r = 1, rows do 
        rotated_shape[r] = {} 
        for c = 1, cols do
            rotated_shape[r][c] = 0 
        end
    end
 
    -- original_shape = {
    --         {0,-1}, 
    --         {0,0}, 
    --         {1,0}, 
    --         {2,0}
    --     }
    -- for r = 1, 4 do 
    --     original_shape[r] = {} 
    --     for c = 1, cols do
    --         original_shape[r][c] = theShape[r][c]
    --     end
    -- end
    -- original_shape = theShape
    
    

    if rotation_count % 4 == 0 then 
        
        -- original_shape = {
        --     {0,-1}, 
        --     {0,0}, 
        --     {1,0}, 
        --     {2,0}
        -- }
        for i = 1,4 do
            rotated_shape[i][1] = original_shape[i][2]  - theShape[2][1] --deduct by middle
            rotated_shape[i][2] = -original_shape[i][1] - theShape[2][2] 
        end
    elseif rotation_count % 4 == 1 then 
        for i = 1,4 do
            rotated_shape[i][1] = -original_shape[i][1] - theShape[2][1] 
            rotated_shape[i][2] = -original_shape[i][2] - theShape[2][2] 
        end 
    elseif rotation_count % 4 == 2 then
        for i = 1,4 do 
            rotated_shape[i][1] = -original_shape[i][2] - theShape[2][1] 
            rotated_shape[i][2] = original_shape[i][1] - theShape[2][2] 
        end
    elseif rotation_count % 4 == 3 then 
        for i = 1,4 do
            rotated_shape[i][1] = original_shape[i][1] - theShape[2][1] 
            rotated_shape[i][2] = original_shape[i][2] - theShape[2][2] 
        end 
    end 
    
    theShape = rotated_shape 
end

--after 
function block.isLineOne(row)
        if coloredGrid[row][0] == 1 and coloredGrid[row][1] == 1 and coloredGrid[row][2] == 1 and coloredGrid[row][3] == 1 and coloredGrid[row][4] == 1 and coloredGrid[row][5] == 1 and coloredGrid[row][6] == 1 and coloredGrid[row][7] == 1 and coloredGrid[row][8] == 1 and coloredGrid[row][9] == 1 then 
            return true
        else 
            return false
        end 
end

function block.clearLine(row) 
    for i = #deadBlockImgList, 1, -1 do    
        deadBlock = deadBlockImgList[i]
        width = deadBlock.x/cellSize
        if coloredGrid[row][width] == 1 then 
            deadBlock.alpha = 0 
        end 
    end 

end



function block.checkCollided(bg)
    for i = 1, 4 do 
        x = theShape[i][1]
        y = theShape[i][2]
    end 

end

function block.addLog(text)
    block.debugList[#block.debugList + 1] = text
    if #block.debugList > 4 then
      table.remove(block.debugList, 1) 
    end
end 


function block.drawLog(list)
    love.graphics.setColor(1,1,1,1)
    for index = 1, #list, 1 do
        local debugText = list[index] 
        -- love.graphics.print(debugText, 0, 20*(index-1))
        love.graphics.print(debugText, 440, 20*index)
    end
end



return block 


