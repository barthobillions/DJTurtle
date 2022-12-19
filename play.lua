--Uses a wired modem to connect and play with speakers
local modem = peripheral.wrap("back")
modem.open(5)

--Resets the speakers by rebooting the pc and clearing out the speakers of buffered data
function reboot_speakers()
	print("CLEARING OUT SPEAKERS")
	local speakerLeft = peripheral.wrap("computer_12")
	local speakerRight = peripheral.wrap("computer_13")
	speakerLeft.reboot()
	speakerRight.reboot()
	sleep(3)
end

--Returns the slot that has a sign in the turtle's inventory
function find_sign()
	turtle.digUp()
	for slot = 1, 16 do
		turtle.select(slot)
		local item = turtle.getItemDetail()
		if item ~= nil then
			if string.find(item.name, "sign") ~= nil then
				return slot
			end
		end
	end
	return 0
end

--Takes in song to play at command line and will place a sign showing what is playing
--This is a work around to monitors not working properly with shaders
function main()
	sign_slot = find_sign()
	local file_name = arg[1]
	if sign_slot ~= 0 then
		turtle.placeUp("PLAYING:\n" .. file_name)
	end
	reboot_speakers()
	modem.transmit(5, 1, file_name .. ".dfpwm")
	term.clear()
	term.setCursorPos(1,1)
	--Formatting for output on the terminal screen
	local w, h = term.getSize()
	local screen_bar = ""
	local middle = ""
	for i = 1, w do
		screen_bar = screen_bar .. "-"
	end
	for i = 1, (h/2 - 2) do
		middle = middle .. "\n"
	end
	for i = 1, ((w/2) - #file_name/2) do
		middle = middle .. " "
	end

	middle = middle .. string.upper(file_name) .. "\n\n"

	print(screen_bar)
	print(middle)
	print(screen_bar)
end

main()