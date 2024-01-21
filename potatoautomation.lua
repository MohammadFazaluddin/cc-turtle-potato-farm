--this is for checking the inventory
function IsInventoryFull() 
    for i = 1, 16
    do 
        turtle.select(i)
        count = turtle.getItemCount()
        if count <= 0 then
            turtle.select(1)
            return false;
        end
    end
    turtle.select(1)
    return true;
end

-- find any item present inside the inventory
function findItemInInventory(name)
    for i = 1, 16 do
        turtle.select(i) 
        item = turtle.getItemDetail()
        if item ~= nil then
            if item.name == name then
                return true;
            end
        end
    end
    turtle.select(1)
    return false;
end

harvest = 0
planted = 0
turns = 0

while 1 do
    
    --check for refuel
    if turtle.getFuelLevel() < 10 then
        coal = findItemInInventory('minecraft:coal')
        if coal then
            turtle.refuel()
            if turtle.getFuelLevel() < 40 then
                print('not enough fuel')
                break
            end
            turtle.select(1)
        else
            print('coal was not found')
            break
        end
    end

    block = turtle.detect()

    --standing infront of a block or not
    if block then
        x, y = turtle.inspect()
        if y.name == 'minecraft:potatoes' then
            if y.state.age >= 7 then
            
                while 1 do 
                    -- check if inventory is full
                    inventory = IsInventoryFull()
                    if inventory then
                        print('Inventory is full cannot store any item')
                        break
                    end

                    turtle.dig()
                
                    findItem = findItemInInventory('minecraft:potato')
                    if findItem then
                        plant = turtle.place()
                        if plant then
                            planted = planted + 1
                            print(planted..' item(s) planted')
                        else
                            print('no item to plant')
                            break
                        end
                        
                    end
                    harvest = harvest + 1
                    print(harvest..' item(s) farmed')

                    turtle.turnRight()
                    forward = turtle.forward()

                    if not forward then
                        turtle.turnRight()
                        break;
                    end

                    turtle.turnLeft()
                end
            else 
                os.sleep(5)
            end
        else
            turtle.turnLeft()
            turns = turns + 1
            if turns >= 3 then
                print('no plants were found')
                turns = 0
                break
            end
        end

       
    else 

        findItem = findItemInInventory('minecraft:potato')
        if findItem then
            plant = turtle.place()
            if plant then
                planted = planted + 1
                print(planted..' items planted')
            else
                print('could not plant')
            end
        else
           print('no potato to farm') 
           break
        end
        
    end
    
end
