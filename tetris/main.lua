
--problem: 
--Randomization: bug when generate 8th block 1
--press down = break the shape 1
--Scoring system && levelup  
--Eliminate block complate row 11, when destroy = row dissapear the block above fall 11
--lose/win  11
--add sound effect

-- Clear row
--main: 193, 195
--block: 345, 353
 
--press  
--block: 242

 
--broke piece 11

block = require("block")
-- grid = require("grid")
function love.load() 
    text = "not found"
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
    -- theShape = { 
    --     {-1,1}, 
    -- {0,1},   
    -- {1,0},  
    -- {1,1}
    -- }
 
 
    original_shape = theShape 
 
    rotatedShape = {}  
    rotation_count = 0

 
    --block 
    blockImgList = {}

    --for experiment 
    displayBlock = block.newImage("blocks/right_l1.png", 370, 120, 0.6, 0.6)  
    deadBlockImgList = {}
    isActive = true


    isClearRow = false

    --temporary 
    img = love.graphics.newImage("images/singleBlock.png")

    --before
    for i = 1, 4 do 
        newBlockImg = block.newBlock("images/singleBlock.png", theShape[i][1],theShape[i][2]) 
        newBlockImg2 = block.newBlock("images/singleBlock.png", theShape[i][1],theShape[i][2]) 
        blockImgList[#blockImgList+1] = newBlockImg
        deadBlockImgList[#deadBlockImgList+1] = newBlockImg2 
    end  

   
    fall = true  
    elapsed = 0
    
    canFlip = true --better be function ---> examine which condition it cant rotate
    flip = 1
    canMove = true
    moveRight = true
    moveLeft = true
    fallFast = true
    count = 4 
    problem = 0
  
end

function love.update(dt) 
    -- checkBottom(theShape) 
    --add image to shape
    --before
    if coloredGrid[19][0] == 1 then 
        problem = 1
    end 
    if fall and isActive then
        if elapsed >= 60 then 
            elapsed = 0    
            block.moveDown(1) 
        end  
    end 
    elapsed = elapsed + 1   
     
    
    if fall == false then
        --added
        -- for i = 1, 4 do 
        --     newBlockImg = block.newBlock("images/singleBlock.png", theShape[i][1],theShape[i][2]) 
        --     deadBlockImgList[#deadBlockImgList+1] = newBlockImg
        -- end  

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

     
 
    --colliding code
    for n = 1, gridHeight do       
        for m = 1, gridWidth do     
            if coloredGrid[n][m] == 1 then    
               

                for k = 1, 4 do  
                    --unable to press 
                    if theShape[k][2]+3 == n then     
                        fallFast = false 
                    else  
                        fallFast = true  
                    end 

                    if theShape[k][2]+1 == n and theShape[k][1] == m and coloredGrid[theShape[k][2]+1][m] == 1 then    
                    -- if coloredGrid[theShape[k][2]+1][m] == 1 and coloredGrid[theShape[k][2]+2][m] == 1 then    
  
                        isActive = false  
                        
                        for i = 1, 4 do      
                            coloredGrid[theShape[i][2]][theShape[i][1]] = 1  
                        end  
                 
                        canFlip = false    
                        moveRight = false      
                        moveLeft = false        
                        fall = false
 
                    
                    end
                end  
            else   
                for k = 1, 4 do
                    if theShape[k][2] >= 19  then        
                        isActive = false  
                        
                        for i = 1, 4 do     
                            coloredGrid[theShape[i][2]][theShape[i][1]] = 1  
                            grid[theShape[i][2]][theShape[i][1]] = 1  
                        end  
                 
                        canFlip = false   
                        moveRight = false     
                        moveLeft = false      
                        fall = false    

                        --after
                    end
                end
            end 
        end 
    end

    fallFast = true 
  
    for n = 1, gridHeight do   
        if block.isLineOne(n) then
            block.clearLine(n) 
            -- text = "found one line " .. n 
        end   

    end
end 
   

--here!!!!!!! problem   
function love.keypressed(key)  
    if key == "s" then     
        if fallFast then  
            block.moveDown(5)     
        end
 
        --before
        -- for n = 1, gridHeight do       
        --     for m = 1, gridWidth do     
        --         if coloredGrid[n][m] == 1 then  
        --             for i = 1, 4 do 
        --                 if theShape[i][1] == m then 
        --                     block.moveDown(n - theShape[i][2])   
        --                 else  
        --                     block.moveDown(17)   
        --                 end 
        --             end 
        --         end
        --     end
        -- end 

        --after 
        
     
    elseif key == "w" then  
        if canFlip then
            --before
            rotation_count = rotation_count + 1 
            block.rotate(rotation_count)  
            block.rotate(rotation_count)    
 
        end
        
    elseif key == "a" then
        if moveLeft then  
            moveRight =true
            for i = 1, 4 do 
                if theShape[i][1] >= 1 then
                    theShape[i][1] = theShape[i][1] - 1 
                else 
                    moveLeft = false 
                    break 
                end 
            end
        end
           
    elseif key == "d" then   
        if moveRight then   
            moveLeft = true 
            for i = 4, 1, -1 do
                if theShape[i][1] < 9 then    
                    theShape[i][1] = theShape[i][1] + 1     
                else 
                    moveRight =false  
                    break
                end
            end   
        end 
    end  
end
 
 --11, 9

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
    
    --weird 
    love.graphics.setColor(1, 1, 1, 1)  

    love.graphics.draw(gridPic, 12,14) 
    love.graphics.draw(nextPic, 370,43)
    love.graphics.draw(levelPic, 370,225)  
    block.drawImage(displayBlock)
 
    for i = #blockImgList, 1, -1 do 
        blockImg = blockImgList[i] 
        block.drawImage(blockImg) 
    end 


    --way of drawing deadblock
    for n = 1, gridHeight do 
        for m = -1, gridWidth do 
            if coloredGrid[n][m] == 1 then 
                for i = #deadBlockImgList, 1, -1 do  
                -- for i = 1, 4 do   
                    deadBlockImg = deadBlockImgList[i]
                    deadBlockImg.x = (m+1) * cellSize  
                    deadBlockImg.y = (n+1) * cellSize   
                    block.drawImage(deadBlockImg)
                end         
            end
        end   
    end 

    -- alternative 
    -- for n = 1, gridHeight do 
    --     for m = -1, gridWidth do  
    --         if coloredGrid[n][m] == 1 then 
    --             for i = #deadBlockImgList, 1, -1 do 
    --                 deadBlockImg = deadBlockImgList[i] 
    --                 block.drawImage(deadBlockImg)
    --             end 
    --         end  
    --     end 
    -- end 


    --draw stamped shape when reach bottom
    for i = 1, gridHeight do   
        for j = 1, gridWidth do    
            local x  = (j - 1)* cellSize + 32 --to add ขอบ
            local y  = (i - 1)* cellSize + 32  
                    
        end      
    end     

    love.graphics.print(#deadBlockImgList, 10, 20)  
    -- love.graphics.print(text, 10, 20)  
    for i = #deadBlockImgList, 1, -1 do     
        deadBlock = deadBlockImgList[i] 
        love.graphics.print(deadBlock.x/32, 10, 30*i)   
        love.graphics.print(deadBlock.y/32, 20, 30*i) 
    end 
     
       

end

