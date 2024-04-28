--dash spell, will move the player in the direction he is facing for a certain amount of time
local spell = Spell("instant")

local timeToMove = 55
local range = 4

function calculate_next_pos(direction, pos, step)
    if direction == 0 then
         return Position(pos.x, pos.y - step, pos.z)

    elseif direction == 1 then
         return Position(pos.x + step, pos.y, pos.z)

    elseif direction == 2 then
         return Position(pos.x, pos.y + step, pos.z)

    elseif direction == 3 then
         return Position(pos.x - step, pos.y, pos.z)

    elseif direction == 4 then
         return Position(pos.x - step, pos.y + step, pos.z)

    elseif direction == 5 then
            return Position(pos.x + step, pos.y + step, pos.z)

    elseif direction == 6 then
            return Position(pos.x - step, pos.y - step, pos.z)

    elseif direction == 7 then
            return Position(pos.x + step, pos.y - step, pos.z)
    end
end

--a function that will return a direction 90 degree to the right of the current direction
function turn_right(direction)
    if direction == 0 then
        return 1
    elseif direction == 1 then
        return 2
    elseif direction == 2 then
        return 3
    elseif direction == 3 then
        return 0
    end
end

function spell.onCastSpell(creature, variant)
    local startPos = creature:getPosition()
    
    for i = 1, range do

        local newPos = calculate_next_pos(creature:getDirection(), startPos, i)

        local tile = Tile(newPos)

        if tile and tile:getCreatureCount() == 0 and not tile:hasProperty(CONST_PROP_IMMOVABLEBLOCKSOLID) then -- these checks ensure we don't move into a creature or an obstacle
            addEvent(function()
                creature:teleportTo(newPos)
            end, i * timeToMove)
        else
            print("Can't move to position: " .. newPos.x .. ", " .. newPos.y)
            break
        end
    end

    local newDir = turn_right(creature:getDirection()) -- just for the test, to match the reference video
    addEvent(function()
        creature:setDirection(newDir)
    end, range * timeToMove)

    return true
end

spell:name("Dash")
spell:words("dash")
spell:cooldown(0)
spell:groupCooldown(0)
spell:level(1)
spell:mana(0)
spell:isSelfTarget(true)
spell:isPremium(false)
spell:register()