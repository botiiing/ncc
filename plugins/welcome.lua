local function pre_process(msg)
    local chat = msg.chat_id_
    local user = msg.sender_user_id_
    local group = load_data('bot/group.json')
	local addgroup = group[tostring(msg.chat_id)]
	local function welcome_cb(arg, data)
        if group[arg.chat_id]['setwelcome'] then
            welcome = group[arg.chat_id]['setwelcome']
	        tg.sendMessage(msg.chat_id_, 0, 1, welcome, 1, "md")
        else
            welcome = "*Welcome* {name}"
	        tg.sendMessage(msg.chat_id_, 0, 1, welcome, 1, "md")
        end
        if data.username_ then
            user_name = "@"..check_markdown(data.username_)
        else
            user_name = ""
        end
		--local welcome = welcome:gsub("{rules}", rules)
		local welcome = welcome:gsub("{name}", check_markdown(data.first_name_))
		local welcome = welcome:gsub("{username}", user_name)
		tg.sendMessage(arg.chat_id, arg.msg_id, 0, welcome, 0, "md")
	end
	if addgroup and group[tostring(chat)]['settings'] then
	--local is_add_user = msg.text:match("!!!tdservice:")
	--if is_add_user then
		if msg.adduser then
			welcome = group[tostring(msg.chat_id_)]['settings']['welcome']
			if welcome == "yes" then
				tdcli_function ({
				ID = "GetUser",
				--user_id_ = is_add_user
				user_id_ = msg.adduser
				}, welcome_cb, {chat_id=chat,msg_id=msg.id_})
			else
				return false
			end
		end
		--local is_join_by_link = msg.text:match("!!!tddservice:")
		--if is_join_by_link then
		if msg.joinuser then
			welcome = group[tostring(msg.chat_id_)]['settings']['welcome']
			if welcome == "yes" then
				tdcli_function ({
				ID = "GetUser",
				--user_id_ = is_join_by_link
				user_id_ = msg.joinuser
				}, welcome_cb, {chat_id=chat,msg_id=msg.id_})
			else
				return false
			end
		end
	end
 end
 
local function run(msg, matches)
    local addgroup = group[tostring(msg.chat_id)]
    if addgroup and is_momod(msg) or is_owner(msg) then
        local group = load_data('bot/group.json')
        local chat = msg.chat_id_
        local user = msg.sender_user_id_
	    if matches[1] == "welcome" then
		    if matches[2] == "on" then
			    welcome = group[tostring(chat)]['settings']['welcome']
			    if welcome == "yes" then
                    pm = "*Group welcome is already enabled*"
		   	        tg.sendMessage(msg.chat_id_, 0, 1, pm, 1, "md")
			    else
		            group[tostring(chat)]['settings']['welcome'] = "yes"
	                save_data(_config.group.data, group)
                    pm1 = "*Group welcome has been enabled*"
                    tg.sendMessage(msg.chat_id_, 0, 1, pm1, 1, "md")
                end
		    end
		    if matches[2] == "off" then
			    welcome = group[tostring(chat)]['settings']['welcome']
			    if welcome == "no" then
                    pm2 = "*Group welcome is already disabled*"
                    tg.sendMessage(msg.chat_id_, 0, 1, pm2, 1, "md")
                else
		            group[tostring(chat)]['settings']['welcome'] = "no"
	                save_data(_config.group.data, group)
                    pm3 = "*Group welcome has been disabled*"
                    tg.sendMessage(msg.chat_id_, 0, 1, pm3, 1, "md")
		     	end
		    end
	    end
	    if matches[1] == "setwelcome" and matches[2] then
	     	group[tostring(chat)]['setwelcome'] = matches[2]
	        save_data(_config.group.data, group)
            pm4 = "*Welcome Message has been set to :\n*"..matches[2].."\n\n`{name}` ➣ *New Member First Name*\n`{username}` ➣ *New Member Username*"
            tg.sendMessage(msg.chat_id_, 0, 1, pm4, 1, "md")
	   end
    end
end

return {
patterns ={
	"^[!/#]([Ss]etwelcome) (.*)",
	"^[!/#]([Ww]elcome) (.*)$"
},
run=run,
pre_process = pre_process
}
