local function run(msg, matches)
local addgroup = group[tostring(msg.chat_id)]
if addgroup and not is_owner(msg) or not is_momod(msg) then
if is_momod(msg) or is_robot(msg) then
return false
else
local group = load_data('bot/group.json')

local group_lock_bot = group[tostring(msg.chat_id)]['settings']['lock_bot']
--if group_lock_bot == 'yes'  and  data.type_.ID == "UserTypeBot" then
if msg.content_.members_[0].username_ and msg.content_.members_[0].username_:match("[Bb][Oo][Tt]$") then   
if group_lock_bot == 'yes' then       
--tg.deleteMessages(msg.chat_id_, {[0] = msg.id_ })
 --kick_user(msg.chat_id_,msg.sender_user_id_)
 tg.chat_del_user(msg.chat_id_, msg.sender_user_id_)    
end
end
end
end
end

return {
  patterns = {
    "^(.*)$",
  },
  run = run
}
