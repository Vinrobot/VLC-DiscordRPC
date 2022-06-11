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
	else
		vlc.msg.dbg("[DiscordRPC] No item")
	end
end
