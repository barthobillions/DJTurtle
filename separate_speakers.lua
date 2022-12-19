local dfpwm = require("cc.audio.dfpwm")
local speaker = peripheral.find("speaker")
local modem = peripheral.wrap("back")
modem.open(5)

--Takes in file path and reads its data
--The decoder converts its to data the speaker can play
function load_and_play_audiostream(file)
	local decoder = dfpwm.make_decoder()
	for chunk in io.lines(file, 16 * 1024) do
		local buffer = decoder(chunk)

		while not speaker.playAudio(buffer) do
			os.pullEvent("speaker_audio_empty")
		end
	end
end

--Waits for main turtle to transmit data through the modem
--Once something is recieved, it will load and play the songs
function main()
	while true do
		local _, _, _, _, file = os.pullEvent("modem_message")
		load_and_play_audiostream(file)
	end

end


main()