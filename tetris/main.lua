block = require("block")



function love.load()
    love.graphics.setDefaultFilter("nearest", "nearest") 

    grid = {}
    cellSize = 32
    gridWidth = 10 --number of cells in x direction
    gridHeight = 20 --number of cells in y direction
    for i = 1, gridHeight do
        grid[i] = {}
        for j = 1, gridWidth do
            grid[i][j] = 0
        end
    end

    player = { 
        x = 96, 
        y = 64, 
        act_x = 200,
        act_y = 200, 
        speed = 10
    }
    

    fall = true 
    elapsed = 0
    
    canFlip = true --better be function ---> examine which condition it cant rotate
    flip = 1
    canMove = true

    j_shaped = newObject("block1.png")  
    j_shaped.x = 96
    j_shaped.y = 32 


    singleBlock = love.graphics.newImage("images/singleBlock.png")     
    --Default shape
    theShape = {
        {0,0}, 
    {1,0}, 
    {2,0}, 
    {2,-1}
    }

    original_shape = {
        {0,0}, 
    {1,0}, 
    {2,0}, 
    {2,-1}
    }
    rotation_count = 0
end

function love.update(dt) 

    player.act_y = player.act_y - ((player.act_y - player.y) * player.speed * dt)
    player.act_x = player.act_x - ((player.act_x - player.x) * dt)

    if fall then
        if elapsed >= 60 then 
            elapsed = 0  
            block.moveDown(1)
        end
    end
    elapsed = elapsed + 1 
end

--here!!!!!!! problem 
function love.keypressed(key) 
    if key == "down" then 
        block.moveDown(3) -- move down level 1
    elseif key == "up" then  
        -- block.generateNewBlock()  
        rotation_count = rotation_count + 1 
        block.rotate(rotation_count)
        block.rotate(rotation_count)  
        -- flip = flip + 1 
        -- j_shaped.y = j_shaped.y - 32  
        j_shaped.rotation = j_shaped.rotation + 90   
    elseif key == "left" then
        -- if j_shaped.x - 32 >= 32 then 
        --     j_shaped.x = j_shaped.x - 32
        -- end   
        for i = 1, 4 do 
            if theShape[i][1] > 0 then
                theShape[i][1] = theShape[i][1] - 1 
            else 
                break
            end
             
        end
          
    elseif key == "right" then   
        -- if j_shaped.x + 64 < 352 then 
        --     j_shaped.x = j_shaped.x + 32
        -- end 
        for i = 4, 1, -1 do
            if theShape[i][1] < 9 then    
                theShape[i][1] = theShape[i][1] + 1     
            else 
                break
            end
        end  
    end
end

function newObject(name)  
    local obj = {}
    obj.x = 0
    obj.y = 0
    obj.rotation = 0
    obj.xScale = 1
    obj.yScale = 1
    obj.image = love.graphics.newImage(name)
    -- obj.width = obj.image:getWidth() 
    -- obj.height = obj.image:getHeight() 
    -- obj.xOrgin = obj.width/2
    -- obj.yOrgin = obj.heigth/2
    obj.anchorX = 1
    obj.anchorY = 1
    obj.RotationCenter = {x = obj.x + 16, y = obj.y + 48}
    obj.red = 1
    obj.green = 1
    obj.blue = 1
    obj.alpha = 1  

    return obj
end

--problem bro :(
function flipShape()
    if canFlip then
        if flip == 1 then
            player.x = player.x + 32
        elseif flip == 2 then
            player.x = player.x + 32
        elseif flip == 3 then
            player.y = player.y + 32
        elseif flip == 4 then
            player.x = player.x - 32
            flip = 0 
        end
        
    end
end

function drawRotatedRectangle(mode, x, y, width, height, angle) 
    love.graphics.push()
	love.graphics.translate(x, y)
	love.graphics.rotate(angle)
	love.graphics.rectangle(mode, 0, 0, width, height) -- origin in the top left corner
--	love.graphics.rectangle(mode, -width/2, -height/2, width, height) -- origin in the middle
	love.graphics.pop()
end

function drawImage(obj)  
    love.graphics.setColor(obj.red, obj.green, obj.blue, obj.alpha)
    love.graphics.draw(obj.image, obj.x, obj.y, obj.rotation, obj.xScale, obj.yScale, obj.xOrigin, obj.yOrigin)
end 


function love.draw()   
    love.graphics.setColor(1,1,1)
    for i = 1, gridHeight do   
        for j = 1, gridWidth do 
            local x  = (j - 1)* cellSize -- + 32 to add ขอบ
            local y  = (i - 1)* cellSize
            love.graphics.rectangle("line", x, y, cellSize, cellSize) -- draw rectangle for each cell
            if grid[i][j] == 1 then 
                love.graphics.rectangle("fill", x, y, cellSize, cellSize) 
            end
        end
    end 

    for i = 1, 4 do      
        -- theShape = {{0,0},{1,0},{1,1},{2,0}} 
        -- theShape[i][0]*cellSize, theShape[i][1]*cellSize
        love.graphics.setColor(r, g, b) 
        -- love.graphics.draw(singleBlock, theShape[i][1]*cellSize, theShape[i][2]*cellSize, cellSize, cellSize)
        love.graphics.rectangle("fill",theShape[i][1]*cellSize, theShape[i][2]*cellSize, cellSize, cellSize) 
        -- love.graphics.draw(singleBlock, 100, 100)  
    end  
    -- drawImage(j_shaped) 
end 

-- randomshape() 
-- tetload()
-- tetdraw()
-- tetcheck()
-- tetcommit()
-- turncc()
-- turnc()
-- rowcheck()
-- harddrop() --
-- ghostdraw()
-- newgame()
-- settable()
-- printthetable() 