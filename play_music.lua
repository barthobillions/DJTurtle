local dfpwm = require("cc.audio.dfpwm")
local speaker = peripheral.find("speaker")

function load_and_play_audiostream(file)
	local decoder = dfpwm.make_decoder()
	for chunk in io.lines(file, 16 * 1024) do
		local buffer = decoder(chunk)

		while not speaker.playAudio(buffer) do
			os.pullEvent("speaker_audio_empty")
		end
	end
	print("END OF SONG")
end


function main()
	local files = {}
	local file_names = {}
	for argu = 1, #arg do
		files[argu] = arg[argu]
	end

	for file = 1, #files do
		local file_name = ""
		for i = 0, #files[file] do
			local char = files[file]:sub(i,i)
			if char == "." then
				break
			else
				file_name = file_name .. char
			end
		end
		file_names[file] = file_name
	end

	for song = 1, #files do
		term.clear()
		term.setCursorPos(1,5)
		print("----------PLAYING---------")
		term.setCursorPos(6,7)
		print(file_names[song])
		print("--------------------------")

		load_and_play_audiostream(files[song])
		sleep(5)
	end
end


main()