rednet.open("back")
print("CLEARING OUT SPEAKERS")
local speakerLeft = peripheral.wrap("computer_12")
local speakerRight = peripheral.wrap("computer_13")
speakerLeft.reboot()
speakerRight.reboot()

sleep(4)

local file_name = arg[1]

rednet.broadcast(file_name .. ".dfpwm")
term.clear()
term.setCursorPos(1,6)
print("----------------------PLAYING----------------------")
print()
print()
print("                 " .. string.upper(file_name)
print()
print()
print("---------------------------------------------------")