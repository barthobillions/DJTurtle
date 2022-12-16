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
end

function main()
	rednet.open("back")
	while true do
		local _,file = rednet.receive()
		load_and_play_audiostream(file)
	end

end


main()