--check point = rotation press w

block = require("block")
-- grid = require("grid")
function love.load()
    love.graphics.setDefaultFilter("nearest", "nearest") 

    grid = {}
    gridX = 0
    gridY = 0
    coloredGrid = {}
    cellSize = 32
    gridWidth = 10 --number of cells in x direction
    gridHeight = 20 --number of cells in y direction
    for i = 1, gridHeight do
        grid[i] = {}
        for j = 1, gridWidth do
            grid[i][j] = 0
        end
    end

    for i = 1, 20 do
        coloredGrid[i] = {}
        for j = 1, 10 do
            coloredGrid[i][j] = 0
        end 
    end
    
    theShape = { 
        {0,-1}, 
        {0,0},  
        {1,0}, 
        {2,0}
    }  
    original_shape = theShape 
    rotation_count = 0


    --block
    blockImgList = {}
    for i = 1, 4 do  
        newBlockImg = block.newBlock("images/singleBlock.png", theShape[i][1],theShape[i][2]) 
        blockImgList[#blockImgList+1] = newBlockImg
    end  
  
    fall = true 
    --tem
    -- fall2 = false
    -- fall3 = false
    -- fall4 = false
    -- fall5 = false
    -- fall6 = false
    -- fall7 = false

    elapsed = 0
    
    canFlip = true --better be function ---> examine which condition it cant rotate
    flip = 1
    canMove = true
    moveRight = true
    moveLeft = true
    



    -- for i = #blockImgList, 1 ,-1 do 
    --     blockImg = blockImgList[i]
    --     for n = 1, 4 do  
    --         blockImg.x = theShape[n][1] 
    --         blockImg.y = theShape[n][2]
    --     end
    -- end  
end

function love.update(dt) 
    -- checkBottom(theShape) 
    --add image to shape

    --before
    if fall then
        if elapsed >= 60 then 
            elapsed = 0    
            block.moveDown(1) 
        end
    end
    elapsed = elapsed + 1  
 
    
 
    for i = 1, 4 do   
        if theShape[i][2] >= 19 then 
            canFlip = false
            moveRight = false 
            moveLeft = false  
            isActive = false
            fall = false 
            --important
            -- block.generateNewBlock() 

            -- change grid value to 1
            -- grid[theShape[i][1]][theShape[i][2]] = 1 
        end
    end
 
    --important
    -- if isActive == false then
    --     theShape = block.generateNewBlock() 
    --     isActive = true 
    --     fall = true
    -- end

    
  
end

--here!!!!!!! problem  
function love.keypressed(key) 
    if key == "s" then   
        block.moveDown(3) -- move down level 1
    elseif key == "w" then   
        if canFlip then
            --before
            rotation_count = rotation_count + 1  
            block.rotate(rotation_count)    
            block.rotate(rotation_count)   
            

        end
        
    elseif key == "a" then
        if moveLeft then  
            for i = 1, 4 do 
                if theShape[i][1] > 0 then
                    theShape[i][1] = theShape[i][1] - 1 
                else 
                    break
                end 
                    
            end
        end
          
    elseif key == "d" then   
        if moveLeft then   
            for i = 4, 1, -1 do
                if theShape[i][1] < 9 then    
                    theShape[i][1] = theShape[i][1] + 1     
                else 
                    break
                end
            end  
        end
    end  

    --colored grid
   

    
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
	love.graphics.pop()
end

function drawImage(obj)  
    love.graphics.setColor(obj.red, obj.green, obj.blue, obj.alpha)
    love.graphics.draw(obj.image, obj.x, obj.y, obj.rotation, obj.xScale, obj.yScale, obj.xOrigin, obj.yOrigin)
end 

-- function writeShape(Shape)
--      -- original_shape = {
--         --     {0,-1},  
--         --     {0,0}, 
--         --     {1,0},  
--         --     {2,0}
--         -- }
--     for i = 1, gridHeight do   
--         for j = 1, gridWidth do  
--             local x  = (j - 1)* cellSize + 32 --to add ขอบ
--             local y  = (i - 1)* cellSize + 32 
--             for n = 1, 4 do
--                 theX = Shape[n][1] 
--                 theY = Shape[n][2]   
--                 coloredGrid[theX][theY] = 1
     
--             end
--             if coloredGrid[i][j] ~= 0 then
--                 love.graphics.rectangle("fill",theX*cellSize + 32, theY*cellSize + 32, cellSize, cellSize)  
--             end
--         end
--     end
-- end

--new
function checkBottom(shape)
    if(shape.isActive == false) then 
        writeShape(shape)
        onDeckShape = block.generateNewBlock()
        shape = onDeckShape 
        shape.isActive = true
    end
end 

function fill(r,g,b)
    love.graphics.setColor(r,g,b)
end

function rect(x, y, len, wid)
    love.graphics.rectangle("fill",x*cellSize + 32, y*cellSize + 32, len, wid)
end

----important
function writeShape(shape)
    for i = 1, 4 do
        theX = shape[i][1]
        theY = shape[i][2]
        love.graphics.rectangle("fill",(theX*cellSize)+32, (theY*cellSize)+32, cellSize, cellSize)
    end  
end



--tem
function drawShape(shape)
    for i = 1, 4 do         
        -- theShape = {{0,0},{1,0},{1,1},{2,0}}   
        love.graphics.rectangle("fill",shape[i][1]*cellSize + 32, shape[i][2]*cellSize + 32, cellSize, cellSize) 
    end 
end

 
function love.draw()  
    

    -- for i = 1, 4 do 
    --     blockImg = blockImgList[i]  
    --     block.drawImage(blockImg)
    -- end
    
    
    
    -- love.graphics.setColor(1,1,1)  
    -- for i = 1, 20 do     
    --     for j = 1, 10 do  
    --         fill(1,1,1) 
    --         writeShape(theShape)
    --         --  
    --         --     theX = theShape[n][1] 
    --         --     theY = theShape[n][2] 
    --         --     if love.keyboard.isDown('p') then 
    --         --         love.graphics.rectangle("fill",(theX*cellSize)+32, (theY*cellSize)+32, cellSize, cellSize)
    --         --     end
    --         -- end
    --     end
    -- end    

    for n = 1, gridHeight do
        for m = 1, gridWidth do 
            if grid[n][m] == 1 then
                love.graphics.rectangle("fill", (n * cellSize)+32, (m * cellSize)+32, cellSize, cellSize)
            end
        end
    end
  
    if isActive == false then  
        writeShape(theShape)   
    end
    
  

    --draw stamped shape when reach bottom
    -- writeShape(theShape)    
    for i = 1, gridHeight do   
        for j = 1, gridWidth do  
            local x  = (j - 1)* cellSize + 32 --to add ขอบ
            local y  = (i - 1)* cellSize + 32  
            
            love.graphics.rectangle("line",x, y, cellSize, cellSize)  
                -- love.graphics.rectangle("fill",theShape[i][1]*cellSize + 32, theShape[i][2]*cellSize + 32, cellSize, cellSize) 
                -- grid.fill(r,g,b, coloredGrid[i][1],coloredGrid[i][2])
            -- if coloredGrid[i][j][n] == 1 then
            --     love.graphics.rectangle("fill",coloredGrid[i][1]*cellSize + 32, coloredGrid[i][2]*cellSize + 32, cellSize, cellSize) 
            -- end  
        end   
    end  
 
    
    --draw moving block
    --important  
    for i = 1, 4 do           
        -- theShape = {{0,0},{1,0},{1,1},{2,0}}   
        love.graphics.rectangle("line",theShape[i][1]*cellSize + 32, theShape[i][2]*cellSize + 32, cellSize, cellSize) 
        love.graphics.rectangle("fill",theShape[i][1]*cellSize + 32, theShape[i][2]*cellSize + 32, cellSize, cellSize) 
    end   

    --tem  
    -- drawShape(theShape)
    -- drawShape(theShape2) 
    -- drawShape(theShape3)
    -- drawShape(theShape4)
    -- drawShape(theShape5) 
    -- drawShape(theShape6)
end  

