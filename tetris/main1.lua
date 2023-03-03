-- timer = require "lume.timer"
tetris = require("tetris")

-- json = require("json")
--one block move down 28 units
function love.load()
    -- math.randomseed(os.time())
    -- love.graphics.setDefaultFilter("nearest", "nearest")

    -- grid = tetris.newObject("grid.png")
    -- grid.x = 370
    -- grid.y = 420

    -- b1 = tetris.newObject("b1.png")
    -- b1.x = 335 
    -- b1.y = 123.3
    -- b1.yScale = 1  

    -- b2 = tetris.newObject("b2.png")
    -- b2.x = 321
    -- b2.y = 123.3  
    -- b2.xScale = 0.96

    -- fall = false 
    -- elapsed = 0
    -- isPaused = false
    
    -- isAlive = true
    state = "game"

    tile_width = 16
    tile_height = 16

    tilesetw = 80
    tileseth = 32

    local tilePath = "images/blockGrid.png"
    tiles = love.graphics.newImage(tilePath)

    local quadInfo = {{'b', 48, 16}, {'s', 16, 0}, {'z', 64, 0}, {'l', 32, 0}, {'j', 64, 16}, {'t', 48, 0}, {'o', 0, 0},
                      {'i', 16, 16}, {' ', 32, 16}, {'X', 0, 16}}

    Quads = {}
    for _, info in ipairs(quadInfo) do
        Quads[info[1]] = love.graphics.newQuad(info[2], info[3], tile_width, tile_height, tilesetw, tileseth)
    end
    settable()

end 

function settable()
    TileTable = {}
    for i = 1, gameh - 1, 1 do 
        local blankline = {'b',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ','b'}
        table.insert(TileTable, i, blankline)
    end
    local borderline = {'b','b','b','b','b','b','b','b','b','b','b','b'}
    table.insert(TileTable, gameh, borderline)
end

function printthetable()
    for i, l in ipairs(TileTable) do
        local line = ''
        for j, c in ipairs(l) do  
            line = line .. c
        end
        print(line)
    end
end

function tetcommit()
    for i, b in ipairs(blocks) do
        TileTable[b[2]][b[1] + 1] = tchar
    end
    tetload()
    if 
end

function love.update()   
    -- if isAlive then
    --     if love.keyboard.isDown('space') then
    --         fall = true
    --     end
    
    --     if fall then
    --         if elapsed >= 60 then
    --             elapsed = 0 
    --             b1.y = b1.y + 28   
    --             if b1.y >= 658.5 then
    --                 tetris.isCollided()
    --             end  
    --         end
             
    --     end
    --     elapsed = elapsed + 1 
    -- end
end

  
function love.draw()  
    if state == "game" then
        for columnIndex, column in ipairs(TileTable) do 
            for rowIndex, char in ipairs(column) do
                local y = (columnIndex - 1) * tile_width
                local x = (columnIndex - 1) * tile_height
                love.graphics.draw(tiles, Quads[char], x*scale, y*scale, 0, scale, scale)
            end
        end
    end
    -- tetris.drawImage(grid) 
    -- tetris.drawImage(b1)
    -- tetris.drawImage(b2)
end  