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
    gridPic = love.graphics.newImage("frame.png")
    for i = 1, gridHeight do
        grid[i] = {}
        for j = 1, gridWidth do 
            grid[i][j] = 0 
        end
    end

    for i = 1, gridHeight do
        coloredGrid[i] = {}
        for j = 1, gridWidth do
            coloredGrid[i][j] = 0
        end
    end
 
   nextPic = love.graphics.newImage("next.png")
   levelPic = love.graphics.newImage("level.png")
    
    theShape = { 
        {0,1}, 
    {1,1},  
    {2,0},  
    {2,1}
    }
 
    original_shape = theShape 
 
    rotatedShape = {} 
    rotation_count = 0

 
    --block 
    blockImgList = {}

    --for experiment 
    displayBlock = block.newImage("blocks/right_l.png", 370, 120, 0.6, 0.6)  
    deadBlockImgList = {}
    isActive = true


    --temporary 
    img = love.graphics.newImage("images/singleBlock.png")

    for i = 1, 4 do 
        newBlockImg = block.newBlock("images/singleBlock.png", theShape[i][1],theShape[i][2]) 
        blockImgList[#blockImgList+1] = newBlockImg
        deadBlockImgList[#deadBlockImgList+1] = newBlockImg
    end  
   
    fall = true 

    elapsed = 0
    
    canFlip = true --better be function ---> examine which condition it cant rotate
    flip = 1
    canMove = true
    moveRight = true
    moveLeft = true
    count = 4 

    
 
end

function love.update(dt) 
    -- checkBottom(theShape) 
    --add image to shape
    --before
    
    if fall and isActive then
        if elapsed >= 60 then 
            elapsed = 0    
            block.moveDown(1) 
        end 
    end
    elapsed = elapsed + 1  

     --Before
    -- for i = 4, 1, -1 do   
    --     if theShape[i][2] >= 19  then    
    --         -- coloredGrid[theShape[i][2]][theShape[i][1]] = 1 
    --         coloredGrid[theShape[i][2]][theShape[i][1]] = 1 
    --         count  = count - 1
    --         isActive = false
             
    --         if count == 1 then  
    --             isActive = true    
    --             canFlip = false   
    --             moveRight = false     
    --             moveLeft = false   
    --             count = 4   
    --             fall = false  
    --         end 
              
    --     end
    -- end    
    
    --After
 
    if theShape[1][2]  >= 19  then    
        isActive = false 
 
        for i = 1, 4 do     
        -- coloredGrid[theShape[i][2]][theShape[i][1]] = 1 
            coloredGrid[theShape[i][2]][theShape[i][1]] = 1  
        end 

        canFlip = false   
        moveRight = false     
        moveLeft = false    
        fall = false  
            
    end
  
 
    if fall == false then
        theShape = block.generateNewBlock()
        original_shape = theShape 
        fall = true 
        canFlip = true 
        moveRight = true 
        moveLeft = true  
        isActive = true  

    end
 
    
    

    --plot block
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
 



function drawImage(obj)  
    love.graphics.setColor(obj.red, obj.green, obj.blue, obj.alpha)
    love.graphics.draw(obj.image, obj.x, obj.y, obj.rotation, obj.xScale, obj.yScale, obj.xOrigin, obj.yOrigin)
end 

--here
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
            if coloredGrid[i][j] == 1 then 
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
    
    --draw moving block 

    -- drawShape(theShape)  
    love.graphics.draw(gridPic, 12,14) 
    love.graphics.draw(nextPic, 370,43)
    love.graphics.draw(levelPic, 370,225) 
    block.drawImage(displayBlock)
 
    for i = #blockImgList, 1, -1 do 
        blockImg = blockImgList[i] 
        block.drawImage(blockImg) 
    end 

    for i = #blockImgList, 1, -1 do 
        blockImg = blockImgList[i] 
        block.drawImage(blockImg) 
    end

    
    for n = 1, gridHeight do 
        for m = 1, gridWidth do 
            if coloredGrid[n][m] == 1 then
                -- drawShape(theShape)   
                -- love.graphics.draw(img, n, m) 
                for i = #deadBlockImgList, 1, -1 do    
                    block.addLog(#deadBlockImgList)
                    deadBlockImg = deadBlockImgList[i] 
                    deadBlockImg.x = (m+1) * cellSize 
                    deadBlockImg.y = (n+1) * cellSize  
                    block.drawImage(deadBlockImg)
                end         
            end
        end   
    end

    --draw stamped shape when reach bottom
    -- writeShape(theShape)      
    for i = 1, gridHeight do   
        for j = 1, gridWidth do  
            local x  = (j - 1)* cellSize + 32 --to add ขอบ
            local y  = (i - 1)* cellSize + 32  
            
            -- love.graphics.rectangle("line",x, y, cellSize, cellSize)  
        
        end    
    end     
    -- love.graphics.draw(img, 10, 20)   

    
       
end  

