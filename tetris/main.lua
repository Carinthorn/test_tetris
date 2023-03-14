--check point = draw shape when it reach the bottom aka change grid value to 1 

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
 
    -- theShape = { 
    --     {0,-2},  
    -- {1,-2},  
    -- {1,-3},  
    -- {2,-2} 
    -- }
    -- theShape = { 
    --     {1,-1}, 
    --     {1,0},  
    --     {2,0},  
    --     {3,0}
    -- }    

    theShape = {  
        {0,-1}, 
        {0,0},  
        {1,0}, 
        {2,0}
    } 
    original_shape = theShape 

    rotatedShape = {} 
    rotation_count = 0


    --block 
    blockImgList = {}
    deadBlock = {}


    --temporary 
    img = love.graphics.newImage("images/singleBlock.png")

    for i = 1, 4 do 
        newBlockImg = block.newBlock("images/singleBlock.png", theShape[i][1],theShape[i][2]) 
        blockImgList[#blockImgList+1] = newBlockImg
    end  
   
    fall = true 

    elapsed = 0
    
    canFlip = true --better be function ---> examine which condition it cant rotate
    flip = 1
    canMove = true
    moveRight = true
    moveLeft = true
 
    --Default shape
   
    --tem
    -- theShape2 = {
    --     {2,-2}, 
    -- {3,-2}, 
    -- {4,-2},   
    -- {5,-2}
    -- }

    -- theShape3 = {
    --     {0,-2}, 
    --     {1,-2}, 
    --     {2,-2},  
    --     {0,-3}  
    -- } 

    -- theShape4 = {
    --     {8,-3},
    -- {9,-3}, 
    -- {8,-2},  
    -- {9,-2} 
    -- }

    -- theShape5 = {
        
    --     {7,-3}, 
    -- {8,-3}, 
    -- {9,-3}, 
    -- {9,-2} 
    -- }

    -- --s
    -- theShape6 = {
    --     {4,-3}, 
    -- {5,-4}, 
    -- {5,-3}, 
    -- {6,-4}
    -- }

    -- theShape7 = {
    --     {0,0},  
    -- {1,0}, 
    -- {1,1}, 
    -- {2,1}
        
    -- }
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
            
 
            -- important
            -- grid[theShape[i][2]][theShape[i][1]] = 1 
            coloredGrid[theShape[i][2]][theShape[i][1]] = 1 
            
        end
    end 

    -- if fall == false then
    --     theShape = block.generateNewBlock()
    --     original_shape = theShape 
    --     fall = true
    --     canFlip = true 
    --     moveRight = true 
    --     moveLeft = true  
    --     isActive = true  
    --     fall = true 

    -- end 
    

    for i = 1, 4 do 
        blockImg =  blockImgList[i] 
        blockImg.x = theShape[i][1] * 32 + 32
        blockImg.y = theShape[i][2] * 32 + 32
    end  

    

    --after: block falling 
    -- if fall then
    --     if elapsed >= 60 then 
    --         elapsed = 0    
    --         for i = #blockImgList, 1, -1 do 
    --             blockImg = blockImgList[i]  
    --             blockImg.y = (blockImg.y + 1) * 32
    --                 if blockImg.y > 19*32 then 
    --                     fall = false
    --                 end  
    --         end
    --     end
    -- end
    -- elapsed = elapsed + 1  
 
    
 
    

    --important
    -- if isActive == false then
    --     theShape = block.generateNewBlock() 
    --     isActive = true 
    --     fall = true
    -- end
 

    --before
    -- for i = #blockImgList, 1 ,-1 do 
    --     blockImg = blockImgList[i]
    --     for n = 1, 4 do  
    --         blockImg.x = theShape[n][1] 
    --         blockImg.y = theShape[n][2]
    --     end
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

            --after
            -- rotatedShape = block.rotate(theShape, rotation_count)
            -- rotatedShape = block.rotate(theShape, rotation_count)
            -- block.rotate(theShape, rotation_count)
            -- block.rotate(theShape, rotation_count)
            -- for i = #blockImgList, 1, -1 do 
            --     blockImg = blockImgList[i]  
            --     for n = 1, 4 do 
            --         blockImg.x = rotatedShape[1][n] 
            --         blockImg.y = rotatedShape[2][n] 
            --     end 
            -- end
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
        love.graphics.rectangle("fill",(theX*cellSize), (theY*cellSize), cellSize, cellSize)
    end  
end



--tem
function drawShape(shape)
    for i = 1, gridHeight do
        for j = 1, gridWidth do
            if grid[i][j] == 1 then 
                for n = 1, 4 do          
                    -- theShape = {{0,0},{1,0},{1,1},{2,0}}   
                    love.graphics.rectangle("fill",shape[n][1]*cellSize + 32, shape[n][2]*cellSize + 32, cellSize, cellSize) 
                end 
            end 
        end
    end
end

 
function love.draw()   
    -- drawShape(theShape) 
    
 
    for i = #blockImgList, 1, -1 do 
        blockImg = blockImgList[i] 
        block.drawImage(blockImg)
    end 
     
    for n = 1, gridHeight do
        for m = 1, gridWidth do 
            if grid[n][m] == 1 then
                drawShape(theShape)
                -- love.graphics.draw(img, n, m)       
            end
        end  
    end

    
    -- drawShape(theShape)  

     
    -- love.graphics.setColor(1,1,1)  
    -- for i = 1, 20 do     
    --     for j = 1, 10 do  
    --         fill(1,1,1) 
    --         writeShape(theShape)
    --         -- for n = 1, 4 do 
    --         --     theX = theShape[n][1] 
    --         --     theY = theShape[n][2] 
    --         --     if love.keyboard.isDown('p') then 
    --         --         love.graphics.rectangle("fill",(theX*cellSize)+32, (theY*cellSize)+32, cellSize, cellSize)
    --         --     end
    --         -- end
    --     end
    -- end    

    
  
    --draw shape
    
     
  

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
                    -- love.graphics.rectangle("fill",coloredGrid[i][1]*cellSize + 32, coloredGrid[i][2]*cellSize + 32, cellSize, cellSize) 
                -- end 
        end   
    end  
 
    
    --draw moving block
    --important
    -- for i = 1, 4 do         
    --     -- theShape = {{0,0},{1,0},{1,1},{2,0}}   
    --     love.graphics.rectangle("fill",theShape[i][1]*cellSize + 32, theShape[i][2]*cellSize + 32, cellSize, cellSize) 
    -- end   
end  

