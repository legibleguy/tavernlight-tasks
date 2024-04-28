local window = g_ui.createWidget('Window', rootWidget)
window:setText("Test Window")

local button = g_ui.createWidget('Button', window)
button:setText("Jump!")

local jumpEvent
local moveEvent

-- set initial button position at the right end of the window
button:setPosition({x = window:getWidth() - button:getWidth(), y = 0})

-- resets the button position to the right end of the window at a random height
local function jump()
  local pos = button:getPosition()
  pos.x = window:getWidth() - button:getWidth()
  pos.y = math.random(button:getHeight(), window:getHeight() - button:getHeight() - 10)
  button:setPosition(pos)
end

local function moveButtonLeft()
  local pos = button:getPosition()
  pos.x = pos.x - 10
  button:setPosition(pos)

  print("Button position: " .. pos.x)

  if pos.x <= 0 then
    jump()
  end
end

moveEvent = cycleEvent(moveButtonLeft, 100)

button.onClick = function()
  jump()
end