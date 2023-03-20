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
    local obj = {} 
    obj.x = x * cellSize 
    obj.y = y * cellSize 
    obj.rotation = 0
    obj.xScale = 1
    obj.yScale = 1  
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
        displayBlock = block.newImage("blocks/square.png", 370, 120, 0.6, 0.6)
    elseif choice == 2 then
        shape =  left_L
        displayBlock = block.newImage("blocks/left_l.png", 370, 120, 0.6, 0.6)
    elseif choice == 3 then
        shape =  right_L
        displayBlock = block.newImage("blocks/right_l.png", 370, 120, 0.6, 0.6)

    elseif choice == 4 then
        shape = line
        displayBlock = block.newImage("blocks/line.png", 370, 120, 0.6, 0.6)

    elseif choice == 5 then
        shape = right_s
        displayBlock = block.newImage("blocks/r_s.png", 390, 70, 0.6, 0.6)

    elseif choice == 6 then
        shape = left_s
        displayBlock = block.newImage("blocks/l_s.png", 370, 120, 0.6, 0.61)
    elseif choice == 7 then
        shape = triangle
        displayBlock = block.newImage("blocks/tri.png", 370, 120, 0.6, 0.6)

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
-- function block.moveDown(moveDown)
--     for i = 1,4 do  
--         if moveDown > (19 - theShape[i][2]) then   
--             theShape[i][2] = theShape[i][2] + (19 - theShape[i][2])
--             break   
--         else 
--             theShape[i][2] = theShape[i][2] + moveDown  
--         end 
        
--     end
-- end

-- function block.moveDown(moveDown, shape)
--     for i = 1,4 do  
--         if moveDown > (19 - shape[i][2]) then   
--             shape[i][2] = shape[i][2] + (19 - shape[i][2])
--             break   
--         else 
--             shape[i][2] = shape[i][2] + moveDown  
--         end 
        
--     end
-- end


--before
function block.moveDown(moveDown)
    for i = 1,4 do  
        if moveDown > (19 - theShape[i][2]) then   
            theShape[i][2] = theShape[i][2] + (19 - theShape[i][2])
            break   
        else 
            theShape[i][2] = theShape[i][2] + moveDown  
        end 
        
    end
end

--after
-- function block.moveDown(obj, moveDown)
--     if moveDown > (19 - obj.y) then   
--         obj.y = obj.y + (19 - obj.y)   
--     else 
--         obj.y = obj.y + moveDown  
--     end 
        

-- end


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
-- function block.rotate(theShape, rotation_count)
--     local rotated_shape = {} 
--     local rows = 4 
--     local cols = 2
--     local original_shape = theShape
 
--     for r = 1, rows do 
--         rotated_shape[r] = {} 
--         for c = 1, cols do
--             rotated_shape[r][c] = 0 
--         end
--     end
 
--     if rotation_count % 4 == 0 then 
--         -- original_shape = theShape
--         for i = 1,4 do
--             rotated_shape[i][1] = original_shape[i][2]  - theShape[2][1] --deduct by middle
--             rotated_shape[i][2] = -original_shape[i][1] - theShape[2][2] 
--         end
--     elseif rotation_count % 4 == 1 then 
--         for i = 1,4 do
--             rotated_shape[i][1] = -original_shape[i][1] - theShape[2][1] 
--             rotated_shape[i][2] = -original_shape[i][2] - theShape[2][2] 
--         end 
--     elseif rotation_count % 4 == 2 then
--         for i = 1,4 do 
--             rotated_shape[i][1] = -original_shape[i][2] - theShape[2][1] 
--             rotated_shape[i][2] = original_shape[i][1] - theShape[2][2] 
--         end
--     elseif rotation_count % 4 == 3 then 
--         for i = 1,4 do
--             rotated_shape[i][1] = original_shape[i][1] - theShape[2][1] 
--             rotated_shape[i][2] = original_shape[i][2] - theShape[2][2] 
--         end 
--     end 
    
--     return rotated_shape 
-- end





-- function block.isCollided()

-- end

function block.addLog(text)
    block.debugList[#block.debugList + 1] = text
    if #block.debugList > 4 then
      table.remove(block.debugList, 1) 
    end
end 


function block.drawLog()
    love.graphics.setColor(1,1,1,1)
    for index = 1, #block.debugList, 1 do
        local debugText = block.debugList[index] 
        love.graphics.print(debugText, 0, 20*(index-1))
    end
end


return block 


