--Prints out playable songs to the user
function main()
	term.clear()
	term.setCursorPos(1,1)
	local w, h = term.getSize()
	local screen_bar = ""
	for i = 1, w do
		screen_bar = screen_bar .. "-"
	end
	print("Available songs...")
	print(screen_bar)
	for line in io.lines("data.txt") do
	    io.write(line .. "  ")
	end
	print("\n" .. screen_bar)
end

main()