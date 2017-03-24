local function action_by_reply(arg, data)
local cmd = arg.cmd
if not tonumber(data.sender_user_id_) then return false end
    if data.sender_user_id_ then
    if cmd == "id" then
local function id_cb(arg, data)
    return tg.sendMessage(arg.chat_id, "", 0, "*"..data.id_.."*", 0, "md")
end
tdcli_function ({
    ID = "GetUser",
    user_id_ = data.sender_user_id_
  }, id_cb, {chat_id=data.chat_id_,user_id=data.sender_user_id_})
  end
else
  return tg.sendMessage(data.chat_id_, "", 0, "*User Not Found*", 0, "md")
   end
end
local function action_by_username(arg, data)
local cmd = arg.cmd
if not arg.username then return false end
   if data.id_ then
if data.type_.user_.username_ then
user_name = '@'..check_markdown(data.type_.user_.username_)
else
user_name = check_markdown(data.title_)
end
if cmd == "id" then
    return tg.sendMessage(arg.chat_id, "", 0, "*"..data.id_.."*", 0, "md")
end
else
  return tg.sendMessage(arg.chat_id, "", 0,"*User Not Found*", 0, "md")
   end
end
local function run(msg, matches)
local group = load_data('bot/group.json')
local chat = msg.chat_id_
local user = msg.sender_user_id_
if matches[1] == "id" and is_momod(msg) or is_owner(msg) then
if not matches[2] and tonumber(msg.reply_to_message_id_) == 0 then
--return "*Chat ID :* [`"..chat.."`]\n*User ID :* [`"..user.."`]\n"
pm = '*SuperGroup ID:* [_'..msg.chat_id_..'_]\n*User ID:* [_'..msg.sender_user_id_..'_]\n'			
tg.sendMessage(msg.chat_id_, 0, 1, pm, 1, 'md')
        end
if not matches[2] and tonumber(msg.reply_to_message_id_) ~= 0 then
    tdcli_function ({
      ID = "GetMessage",
      chat_id_ = msg.chat_id_,
      message_id_ = msg.reply_to_message_id_
    }, action_by_reply, {chat_id=msg.chat_id_,cmd="id"})
  end
if matches[2] and tonumber(msg.reply_to_message_id_) == 0 then
   tdcli_function ({
      ID = "SearchPublicChat",
      username_ = matches[2]
    }, action_by_username, {chat_id=msg.chat_id_,username=matches[2],cmd="id"})
      end
   end
end
return {
patterns ={
"^[!/#](id)$",
"^[!/#](id) (.*)$",
},
run=run,
}
