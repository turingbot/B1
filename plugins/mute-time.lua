do
local function pre_process(msg)
 local hash = 'muteall:'..msg.to.id
  if redis:get(hash) and msg.to.type == 'channel' and not is_mod(msg)  then
    tdcli.deleteMessages(msg.chat_id_, {[0] = msg.id_})
       end
    return msg
 end
 
local function run(msg, matches)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
 if matches[1] == 'close' and matches[2] == 'group' and is_mod(msg) or matches[1] == 'Close' and matches[2] == 'group' and is_mod(msg) or matches[1] == 'تعطیل' and matches[2] == 'گروه' and is_mod(msg) then
       local hash = 'muteall:'..msg.to.id
       if not matches[3] then
              redis:set(hash, true)
			 if not lang then
             return "Closed group has been enabled"
			 else
			 return "تعطیل کلی گروه فعال شد"
			 end
 else
local hour = string.gsub(matches[3], 'h', '')
local num1 = tonumber(hour) * 3600
local minutes = string.gsub(matches[4], 'm', '')
local num2 = tonumber(minutes) * 60
local second = string.gsub(matches[5], 's', '')
local num3 = tonumber(second) 
local num4 = tonumber(num1 + num2 + num3)
redis:setex(hash, num4, true)
if not lang then
 return "Closed all has been enabled for \n⏺ hours : "..matches[3].."\n⏺ minutes : "..matches[4].."\n⏺ seconds : "..matches[5].."\n@TuringTeam"
 elseif lang then
 return "تعطیل کردن فعال شد در \n⏺ ساعت : "..matches[3].."\n⏺ دقیقه : "..matches[4].."\n⏺ ثانیه : "..matches[5].."\n@TuringTeam"
 end
 end
 end
 if matches[1] == 'close' and matches[2] == 'hours' and is_mod(msg) or matches[1] == 'Close' and matches[2] == 'hours' and is_mod(msg) or matches[1] == 'تعطیل' and matches[2] == 'ساعت' and is_mod(msg) then
       local hash = 'muteall:'..msg.to.id
       if not matches[3] then
              redis:set(hash, true)
			 if not lang then
             return "Closed all has been enabled"
			 else
			 return "تعطیل کلی گروه فعال شد"
			 end
 else
local hour = string.gsub(matches[3], 'h', '')
local num1 = tonumber(hour) * 3600
local num4 = tonumber(num1)
redis:setex(hash, num4, true)
if not lang then
 return "Closed all has been enabled for \n⏺ hours : "..matches[3].."\n@TuringTeam"
 elseif lang then
 return "تعطیل کردن فعال شد در \n⏺ ساعت : "..matches[3].."\n@TuringTeam"
 end
 end
 end
  if matches[1] == 'close' and matches[2] == 'minutes' and is_mod(msg) or matches[1] == 'Close' and matches[2] == 'minutes' and is_mod(msg) or matches[1] == 'تعطیل' and matches[2] == 'دقیقه' and is_mod(msg) then
       local hash = 'muteall:'..msg.to.id
       if not matches[3] then
              redis:set(hash, true)
			 if not lang then
             return "Closed all has been enabled"
			 else
			 return "تعطیل کلی گروه فعال شد"
			 end
 else
local minutes = string.gsub(matches[3], 'm', '')
local num2 = tonumber(minutes) * 60
local num4 = tonumber(num2)
redis:setex(hash, num4, true)
if not lang then
 return "Closed all has been enabled for \n⏺ minutes : "..matches[3].."\n@TuringTeam"
 elseif lang then
 return "تعطیل کردن فعال شد در \n⏺ دقیقه : "..matches[3].."\n@TuringTeam"
 end
 end
 end
  if matches[1] == 'close' and matches[2] == 'seconds' and is_mod(msg) or matches[1] == 'Close' and matches[2] == 'seconds' and is_mod(msg) or matches[1] == 'تعطیل' and matches[2] == 'ثانیه' and is_mod(msg) then
       local hash = 'muteall:'..msg.to.id
       if not matches[3] then
              redis:set(hash, true)
			 if not lang then
             return "Closed all has been enabled"
			 else
			 return "تعطیل کلی گروه فعال شد"
			 end
 else
local second = string.gsub(matches[3], 's', '')
local num3 = tonumber(second) 
local num4 = tonumber(num3)
redis:setex(hash, num3, true)
if not lang then
 return "Closed all has been enabled for \n⏺ seconds : "..matches[3].."\n@TuringTeam"
 elseif lang then
 return "تعطیل کردن فعال شد در \n⏺ ثانیه : "..matches[3].."\n@TuringTeam"
 end
 end
 end
if matches[1] == 'closehelp' or  matches[1] == 'closehelp' or matches[1] == 'راهنمای تعطیل' then
if not lang then
text = [[
*راهنمای تعطیل گروه  :*

*🔶close group*
_🔸تعطیل کردن گروه بدون محدودیت زمانی_ 

*🔷close group* `(hour) (minute) (seconds)`
_🔹تعطیل کردن گروه با ساعت و دقیقه و ثانیه_ 

*🔶close hours* `(number)`
_🔸تعطیل کردن گروه در ساعت_ 

*🔷close minute* `(number)`
_🔹تعطیل کردن گروه در دقیقه_ 

*🔶close seconds* `(number)`
_🔸تعطیل کردن گروه در ثانیه_ 

*🔷open group*
_🔹آزاد سازی تعطیلی گروه در آن زمان_ 

]]
elseif lang then
text = [[
*راهنمای تعطیل گروه  :*

*🔶تعطیل گروه*
_🔸تعطیل کردن گروه بدون محدودیت زمانی_ 

*🔷تعطیل گروه* `(ساعت) (دقیقه) (ثانیه)`
_🔹تعطیل کردن گروه با ساعت و دقیقه و ثانیه_ 

*🔶تعطیل ساعت* `(عدد)`
_🔸تعطیل کردن گروه در ساعت_ 

*🔷تعطیل دقیقه* `(عدد)`
_🔹تعطیل کردن گروه در دقیقه_ 

*🔶تعطیل ثانیه* `(عدد)`
_🔸تعطیل کردن گروه در ثانیه_ 

*🔷بازکردن گروه*
_🔹آزاد سازی تعطیلی گروه در آن زمان_ 

]]
end
return text
end
if matches[1] == 'open' and matches[2] == 'group' or matches[1] == 'Open' and matches[2] == 'group' and is_mod(msg) or matches[1] == 'بازکردن' and matches[2] == 'گروه' then
               local hash = 'muteall:'..msg.to.id
        redis:del(hash)
		if not lang then
          return "closed all has been disabled"
		  else
		  return "گروه ازاد شد و افراد می توانند دوباره پست بگذارند"
  end
end
end
return {
   patterns = {
'([Cc]lose) (group)$',
'(تعطیل) (گروه)$',
'(open) (group)$',
'(Open) (group)$',
'(بازکردن) (گروه)$',
'([Cc]losehelp)$',
'(راهنمای تعطیل)$',
'([Cc]lose) (group) (.*) (.*) (.*)$',
'(تعطیل) (گروه) (.*) (.*) (.*)$',
'([Cc]lose) (hours) (.*)$',
'(تعطیل) (ساعت) (.*)$',
'([Cc]lose) (minutes) (.*)$',
'(تعطیل) (دقیقه) (.*)$',
'([Cc]lose) (seconds) (.*)$',
'(تعطیل) (ثانیه) (.*)$',
 },
run = run,
pre_process = pre_process
}
end
