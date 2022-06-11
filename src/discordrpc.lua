function descriptor()
	return {
		title = "Discord Rich Presence";
		version = "0.0.1";
		author = "Vinrobot";
		url = 'https://github.com/Vinrobot/VLC-DiscordRPC';
		shortdesc = "Discord Rich Presence";
		description = "Discord Rich Presence";
		capabilities = {"input-listener", "meta-listener", "playing-listener"}
	}
end

function activate()
	vlc.msg.dbg("[DiscordRPC] activate called")
	update_rpc()
	return true
end

function deactivate()
	vlc.msg.dbg("[DiscordRPC] deactivate called")
	return true
end

function input_changed()
	-- requires capabilities={"input-listener"}
	vlc.msg.dbg("[DiscordRPC] input_changed called")
	update_rpc()
end

-- Not working...
function playing_changed()
	-- requires capabilities={"playing-listener"}
	vlc.msg.dbg("[DiscordRPC] playing_changed called")
end

-- Not working...
function meta_changed()
	-- requires capabilities={"meta-listener"}
	vlc.msg.dbg("[DiscordRPC] meta_changed called")
end

function update_rpc()
	vlc.msg.dbg("[DiscordRPC] " .. tostring(vlc.input.is_playing()))
	local item = vlc.input.item()
	if item ~= nil then
		vlc.msg.dbg("[DiscordRPC] " .. item:uri())
		vlc.msg.dbg("[DiscordRPC] " .. item:name())
		vlc.msg.dbg("[DiscordRPC] " .. dump(getstatus()))
	else
		vlc.msg.dbg("[DiscordRPC] No item")
	end
end

function getstatus()
	local input = vlc.object.input()
	local item = vlc.input.item()
	local s = {}

	s.uri = item:uri()
	s.name = item:name()
	s.state = vlc.playlist.status()

	if input then
		s.time = math.floor(vlc.var.get(input, "time") / 1000000)
		s.position = vlc.var.get(input, "position")
	else
		s.time = 0
		s.position = 0
	end

	if item then
		s.duration = math.floor(item:duration())
	else
		s.duration = 0
	end

	return s
end

function dump(o)
	if type(o) == 'table' then
		local s = '{ '
		for k,v in pairs(o) do
			if type(k) ~= 'number' then
				k = '"'..k..'"'
			end
			s = s .. '['..k..'] = ' .. dump(v) .. ','
		end
		return s .. '} '
	else
		return tostring(o)
	end
end
