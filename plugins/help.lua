local function run(msg, matches)
local group = load_data('bot/group.json')	
local addgroup = group[tostring(msg.chat_id)]	
if matches[1] == 'help' and is_momod(msg) or is_owner(msg) and addgroup then
pm1 = [[◽️Help Bot Commands:
🔹!lock links  =>قفل لینک
🔹!lock edit =>قفل ویرایش پیام 
🔹!lock fwd  =>قفل فروارد 
🔹!lock spam  =>قفل اسپم 
🔹!lock inline  =>قفل اینلاین 
🔹!lock persian  =>قفل فارسی 
🔹!lock english => قفل انگلیسی
🔹!lock fosh => قفل فحش
🔹!lock username (@) => قفل یوزرنیم 
🔹!lock tag (#)  =>قفل تگ 
🔹!lock tgservice  =>قفل سرویس 
🔹!lock contact =>قفل شماره 
🔹!lock game => قفل بازی تحت وب 
🔹!mute all  => ممنوعیت گپ
🔹!mute audio  =>ممنوعیت آهنگ
🔹!mute voice => ممنوعیت صدا
🔹!mute photo  =>ممنوعیت عکس
🔹!mute gifs  =>ممنوعیت گیف
🔹!mute video  =>ممنوعیت فیلم
🔹!mute document  =>ممنوعیت فایل
🔹!mute sticker  =>ممنوعیت استیکر
◽️برای لغو لغو قفل ها به جای lock از کلمه unlock استفاده کنید    
◽️برای لغو ممنوعیت به جای  mute از کلمه unmte استفاده کنید

〰〰〰〰〰〰〰〰〰
    
◽️Help Owner Commands:
🔺!promote [id-reply] =>مدیر کردن فرد 
🔻!demote [id-reply] =>حذف فرداز مدیریت 
🔺!settings =>تنظیمات 
🔺!setlink [link] =>تنظیم لینک گروه
🔻!link =>دریافت لینک گروه
🔺!setrules [text] =>تنظیم قوانین گروه
🔻!rules =>دریافت قوانین گروه 
🔺!id =>دریافت شناسه عددی خود و گروه
🔻!id [reply-username] =>دریافت ایدی عددی فرد
]]
  tg.sendMessage(msg.chat_id_, 0, 1, pm1, 1, 'md')
end
end
	
return {
  patterns = {
  "^[/#!](help)$",
		
  },
  run = run
}
