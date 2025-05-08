-- based on https://github.com/rohieb/mpv-notify
lastcommand = nil
function string.shellescape(str)
   return "'"..string.gsub(str, "'", "").."'"
end
function do_notify(a,b)
   local command = ("dunstify -i $HOME/.icons/notif/radcast.svg -t 2200 -- %s %s"):format(a:shellescape(), 
                                                                                               b:shellescape())
   if command ~= lastcommand then
      os.execute(command)
      lastcommand = command
   end
end

function notify_current_track()   
   local title = mp.get_property("media-title")
   if title then
      -- this removes <[(> and limits string to be 35 characters.
      local title = string.sub(title:gsub("%b[]",""):gsub("%b()",""), 1, 80) 
      do_notify("listening to:", title)
   end
end

mp.register_event("file-loaded", notify_current_track)

-- Stopped Listening

function notify_shutdown()
   do_notify("Stopped Listening...", "")
end

mp.register_event("shutdown", notify_shutdown)
