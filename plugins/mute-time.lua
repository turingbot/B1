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
 if matches[1] == 'closed' and matches[2] == 'all' and is_mod(msg) or matches[1] == 'Closed' and matches[2] == 'all' and is_mod(msg) or matches[1] == 'تعطیل' and matches[2] == 'کلی' and is_mod(msg) then
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
local minutes = string.gsub(matches[4], 'm', '')
local num2 = tonumber(minutes) * 60
local second = string.gsub(matches[5], 's', '')
local num3 = tonumber(second) 
local num4 = tonumber(num1 + num2 + num3)
redis:setex(hash, num4, true)
if not lang then
 return "Closed all has been enabled for \n⏺ hours : "..matches[3].."\n⏺ minutes : "..matches[4].."\n⏺ seconds : "..matches[5].."\n@TuringTeam"
 elseif lang then
 return "بی صدا کردن فعال شد در \n⏺ ساعت : "..matches[3].."\n⏺ دقیقه : "..matches[4].."\n⏺ ثانیه : "..matches[5].."\n@TuringTeam"
 end
 end
 end
 if matches[1] == 'closed' and matches[2] == 'hours' and is_mod(msg) or matches[1] == 'Closed' and matches[2] == 'hours' and is_mod(msg) or matches[1] == 'تعطیل' and matches[2] == 'ساعت' and is_mod(msg) then
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
 return "بی صدا کردن فعال شد در \n⏺ ساعت : "..matches[3].."\n@TuringTeam"
 end
 end
 end
  if matches[1] == 'closed' and matches[2] == 'minutes' and is_mod(msg) or matches[1] == 'Closed' and matches[2] == 'minutes' and is_mod(msg) or matches[1] == 'تعطیل' and matches[2] == 'دقیقه' and is_mod(msg) then
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
 return "بی صدا کردن فعال شد در \n⏺ دقیقه : "..matches[3].."\n@TuringTeam"
 end
 end
 end
  if matches[1] == 'closed' and matches[2] == 'seconds' and is_mod(msg) or matches[1] == 'Closed' and matches[2] == 'seconds' and is_mod(msg) or matches[1] == 'تعطیل' and matches[2] == 'ثانیه' and is_mod(msg) then
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
 return "بی صدا کردن فعال شد در \n⏺ ثانیه : "..matches[3].."\n@TuringTeam"
 end
 end
 end
if matches[1] == 'helpsclosed' or  matches[1] == 'Helpsclosed' or matches[1] == 'راهنمای تعطیل' then
if not lang then
text = [[
*راهنمای تعطیل گروه  :*

*!closed all* `(hour) (minute) (seconds)`
_تعطیل کردن گروه با ساعت و دقیقه و ثانیه_ 

*!closed hours* `(number)`
_تعطیل کردن گروه در ساعت_ 

*!closed minute* `(number)`
_تعطیل کردن گروه در دقیقه_ 

*!closed seconds* `(number)`
_تعطیل کردن گروه در ثانیه_ 

*!unclosed all*
_آزاد سازی تعطیلی گروه در آن زمان_ 

]]
elseif lang then
text = [[
*راهنمای تعطیل گروه  :*

*!تعطیل کلی* `(ساعت) (دقیقه) (ثانیه)`
_تعطیل کردن گروه با ساعت و دقیقه و ثانیه_ 

*!تعطیل ساعت* `(عدد)`
_تعطیل کردن گروه در ساعت_ 

*!تعطیل دقیقه* `(عدد)`
_تعطیل کردن گروه در دقیقه_ 

*!تعطیل ثانیه* `(عدد)`
_تعطیل کردن گروه در ثانیه_ 

*!بازکردن کلی*
_آزاد سازی تعطیلی گروه در آن زمان_ 

]]
end
return text
end
if matches[1] == 'unclosed' and matches[2] == 'all' or matches[1] == 'Unclosed' and matches[2] == 'all' and is_mod(msg) or matches[1] == 'بازکردن' and matches[2] == 'کلی' then
               local hash = 'muteall:'..msg.to.id
        redis:del(hash)
		if not lang then
          return "closed all has been disabled"
		  elseif lang then
		  return "گروه ازاد شد و افراد می توانند دوباره پست بگذارند"
  end
end
end
return {
   patterns = {
'([Cc]losed) (all)$',
'(تعطیل) (کلی)$',
'([Uu]nclosed) (all)$',
'(بازکردن) (کلی)$',
'([Hh]elpsclosed)$',
'(راهنمای تعطیل)$',
'([Cc]losed) (all) (.*) (.*) (.*)$',
'(تعطیل) (کلی) (.*) (.*) (.*)$',
'([Cc]losed) (hours) (.*)$',
'(تعطیل) (ساعت) (.*)$',
'([Cc]losed) (minutes) (.*)$',
'(تعطیل) (دقیقه) (.*)$',
'([Cc]losed) (seconds) (.*)$',
'(تعطیل) (ثانیه) (.*)$',
 },
run = run,
pre_process = pre_process
}
end
