local block = {}
local width
local colors = {}
local theX
local theY
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
local square = {
    {0,0},
    {1,0},
    {0,1},
    {1,1}
}

local left_L = { 
    {0,0},
    {1,0},
    {2,0},
    {0,-1}
}

local right_L = {
    {0,0}, 
    {1,0}, 
    {2,0}, 
    {2,1}
}

local line = {
    {0,0}, 
    {1,0}, 
    {2,0}, 
    {3,0}
}

local right_s = {
    {0,0}, 
    {1,0}, 
    {1,1}, 
    {2,1}
}

local left_s = {
    {0,1}, 
    {1,0}, 
    {1,1}, 
    {2,0}
}

local triangle = {
    {0,0}, 
    {1,0}, 
    {1,-1}, 
    {2,0}
}

function block.newBlock()
    local obj = {} 
    obj.x = 0
    obj.y = 300 
    obj.rotation = 0
    obj.xScale = 1
    obj.yScale = 1  
    -- obj.image = love.graphics.newImage(name)
    obj.width = 32
    obj.height = 32
    obj.xOrigin = obj.width/2 
    obj.yOrigin = obj.height/2
    obj.red = 1
    obj.green = 1
    obj.blue = 1
    obj.alpha = 1 

    return obj
end

function block.drawImage(obj)
    love.graphics.setColor(obj.red, obj.green, obj.blue, obj.alpha)
    love.graphics.draw(obj.image, obj.x, obj.y, obj.rotation, obj.xScale, obj.yScale, obj.xOrigin, obj.yOrigin)
end 



function block.generateNewBlock() 
    if math.random(1,7) == 1 then
        theShape = square
        r = 155
    elseif math.random(1,7) == 2 then
        theShape = left_L
        g = 155
    elseif math.random(1,7) == 3 then
        theShape = right_L
        b = 155
    elseif math.random(1,7) == 4 then
        theShape = line
        r = 155
        g = 155
    elseif math.random(1,7) == 5 then
        theShape = right_s
        r = 155
        b = 200
        g = 60
    elseif math.random(1,7) == 6 then
        theShape = left_s
        r = 30
    elseif math.random(1,7) == 7 then
        theShape = triangle
        g = 100
    end 
    
    
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




-- function block.isCollided()

-- end


return block 


