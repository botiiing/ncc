local function run(msg, matches)
local group = load_data('bot/group.json')
local addgroup = group[tostring(msg.chat_id)]
	if matches[1] == 'leave' and is_sudo(msg) and addgroup or not addgroup then
	      --tg.changeChatMemberStatus(chat, robot, 'Left')
		  tg.changeChatMemberStatus(msg.chat_id_, 656565658, 'Left') 
    end
end	
return {
  patterns = {
   "^[/#!](leave)$",
  },
  run = run
}
