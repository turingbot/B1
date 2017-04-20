local function modadd(msg)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
    -- superuser and admins only (because sudo are always has privilege)
    if not is_admin(msg) then
   if not lang then
        return '_You are not bot admin_'
else
     return 'شما مدیر ربات نمیباشید'
    end
end
    local data = load_data(_config.moderation.data)
  if data[tostring(msg.to.id)] then
if not lang then
   return '_Group is already added_'
else
return 'گروه در لیست گروه های مدیریتی ربات هم اکنون موجود است'
  end
end
        -- create data array in moderation.json
      data[tostring(msg.to.id)] = {
              owners = {},
      mods ={},
      banned ={},
      is_silent_users ={},
      filterlist ={},
      settings = {
          set_name = msg.to.title,
          lock_link = 'yes',
          lock_tag = 'yes',
          lock_spam = 'yes',
          lock_webpage = 'no',
          lock_markdown = 'no',
          flood = 'yes',
          lock_bots = 'yes',
          lock_pin = 'no',
          lock_arabic = 'no',
          english = 'no',
          views = 'no',
          ads = 'no',
          fosh = 'no',
          welcome = 'no',
		  lock_fwd = 'no',
          lock_audio = 'no',
          lock_video = 'no',
          lock_contact = 'no',
          lock_text = 'no',
          lock_photos = 'no',
          lock_gif = 'no',
          lock_loc = 'no',
          lock_doc = 'no',
          lock_sticker = 'no',
          lock_voice = 'no',
          lock_all = 'no',
		  lock_keyboard = 'no'
          },
      }
  save_data(_config.moderation.data, data)
      local groups = 'groups'
      if not data[tostring(groups)] then
        data[tostring(groups)] = {}
        save_data(_config.moderation.data, data)
      end
      data[tostring(groups)][tostring(msg.to.id)] = msg.to.id
      save_data(_config.moderation.data, data)
    if not lang then
  return '*Group has been added*'
else
  return 'گروه با موفقیت به لیست گروه های مدیریتی ربات افزوده شد'
end
end

local function modrem(msg)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
    -- superuser and admins only (because sudo are always has privilege)
      if not is_admin(msg) then
     if not lang then
        return '_You are not bot admin_'
   else
        return 'شما مدیر ربات نمیباشید'
    end
   end
    local data = load_data(_config.moderation.data)
    local receiver = msg.to.id
  if not data[tostring(msg.to.id)] then
  if not lang then
    return '_Group is not added_'
else
    return 'گروه به لیست گروه های مدیریتی ربات اضافه نشده است'
   end
  end

  data[tostring(msg.to.id)] = nil
  save_data(_config.moderation.data, data)
     local groups = 'groups'
      if not data[tostring(groups)] then
        data[tostring(groups)] = nil
        save_data(_config.moderation.data, data)
      end data[tostring(groups)][tostring(msg.to.id)] = nil
      save_data(_config.moderation.data, data)
 if not lang then
  return '*Group has been removed*'
 else
  return 'گروه با موفیت از لیست گروه های مدیریتی ربات حذف شد'
end
end

local function filter_word(msg, word)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
local data = load_data(_config.moderation.data)
  if not data[tostring(msg.to.id)]['filterlist'] then
    data[tostring(msg.to.id)]['filterlist'] = {}
    save_data(_config.moderation.data, data)
    end
if data[tostring(msg.to.id)]['filterlist'][(word)] then
   if not lang then
         return "_Word_ *"..word.."* _is already filtered_"
            else
         return "_کلمه_ *"..word.."* _از قبل فیلتر بود_"
    end
end
   data[tostring(msg.to.id)]['filterlist'][(word)] = true
     save_data(_config.moderation.data, data)
   if not lang then
         return "_Word_ *"..word.."* _added to filtered words list_"
            else
         return "_کلمه_ *"..word.."* _به لیست کلمات فیلتر شده اضافه شد_"
    end
end

local function unfilter_word(msg, word)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
 local data = load_data(_config.moderation.data)
  if not data[tostring(msg.to.id)]['filterlist'] then
    data[tostring(msg.to.id)]['filterlist'] = {}
    save_data(_config.moderation.data, data)
    end
      if data[tostring(msg.to.id)]['filterlist'][word] then
      data[tostring(msg.to.id)]['filterlist'][(word)] = nil
       save_data(_config.moderation.data, data)
       if not lang then
         return "_Word_ *"..word.."* _removed from filtered words list_"
       elseif lang then
         return "_کلمه_ *"..word.."* _از لیست کلمات فیلتر شده حذف شد_"
     end
      else
       if not lang then
         return "_Word_ *"..word.."* _is not filtered_"
       elseif lang then
         return "_کلمه_ *"..word.."* _از قبل فیلتر نبود_"
      end
   end
end

local function modlist(msg)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
    local data = load_data(_config.moderation.data)
    local i = 1
  if not data[tostring(msg.chat_id_)] then
  if not lang then
    return "_Group is not added_"
 else
    return "گروه به لیست گروه های مدیریتی ربات اضافه نشده است"
  end
 end
  -- determine if table is empty
  if next(data[tostring(msg.to.id)]['mods']) == nil then --fix way
  if not lang then
    return "_No_ *moderator* _in this group_"
else
   return "در حال حاضر هیچ مدیری برای گروه انتخاب نشده است"
  end
end
if not lang then
   message = '*List of moderators :*\n'
else
   message = '*لیست مدیران گروه :*\n'
end
  for k,v in pairs(data[tostring(msg.to.id)]['mods'])
do
    message = message ..i.. '- '..v..' [' ..k.. '] \n'
   i = i + 1
end
  return message
end

local function ownerlist(msg)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
    local data = load_data(_config.moderation.data)
    local i = 1
  if not data[tostring(msg.to.id)] then
if not lang then
    return "_Group is not added_"
else
return "گروه به لیست گروه های مدیریتی ربات اضافه نشده است"
  end
end
  -- determine if table is empty
  if next(data[tostring(msg.to.id)]['owners']) == nil then --fix way
 if not lang then
    return "_No_ *owner* _in this group_"
else
    return "در حال حاضر هیچ مالکی برای گروه انتخاب نشده است"
  end
end
if not lang then
   message = '*List of moderators :*\n'
else
   message = '*لیست مالکین گروه :*\n'
end
  for k,v in pairs(data[tostring(msg.to.id)]['owners']) do
    message = message ..i.. '- '..v..' [' ..k.. '] \n'
   i = i + 1
end
  return message
end

local function action_by_reply(arg, data)
local hash = "gp_lang:"..data.chat_id_
local lang = redis:get(hash)
local cmd = arg.cmd
    local administration = load_data(_config.moderation.data)
if not tonumber(data.sender_user_id_) then return false end
    if data.sender_user_id_ then
  if not administration[tostring(data.chat_id_)] then
  if not lang then
    return tdcli.sendMessage(data.chat_id_, "", 0, "_Group is not added_", 0, "md")
else
    return tdcli.sendMessage(data.chat_id_, "", 0, "_گروه به لیست گروه های مدیریتی ربات اضافه نشده است_", 0, "md")
     end
  end
if cmd == "setowner" then
local function owner_cb(arg, data)
local hash = "gp_lang:"..arg.chat_id
local lang = redis:get(hash)
    local administration = load_data(_config.moderation.data)
if data.username_ then
user_name = '@'..check_markdown(data.username_)
else
user_name = check_markdown(data.first_name_)
end
if administration[tostring(arg.chat_id)]['owners'][tostring(data.id_)] then
    if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, "_User_ "..user_name.." *"..data.id_.."* _is already a_ *group owner*", 0, "md")
   else
    return tdcli.sendMessage(arg.chat_id, "", 0, "_کاربر_ "..user_name.." *"..data.id_.."* *از قبل صاحب گروه بود*", 0, "md")
      end
   end
administration[tostring(arg.chat_id)]['owners'][tostring(data.id_)] = user_name
    save_data(_config.moderation.data, administration)
   if not lang then
  return tdcli.sendMessage(arg.chat_id, "", 0, "_User_ "..user_name.." *"..data.id_.."* _is now the_ *group owner*", 0, "md")
   else
  return tdcli.sendMessage(arg.chat_id, "", 0, "_کاربر_ "..user_name.." *"..data.id_.."* *به مقام صاحب گروه منتصب شد*", 0, "md")
   end
end
tdcli_function ({
    ID = "GetUser",
    user_id_ = data.sender_user_id_
  }, owner_cb, {chat_id=data.chat_id_,user_id=data.sender_user_id_})
  end
    if cmd == "promote" then
local function promote_cb(arg, data)
local hash = "gp_lang:"..arg.chat_id
local lang = redis:get(hash)
    local administration = load_data(_config.moderation.data)
if data.username_ then
user_name = '@'..check_markdown(data.username_)
else
user_name = check_markdown(data.first_name_)
end
if administration[tostring(arg.chat_id)]['mods'][tostring(data.id_)] then
   if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, "_User_ "..user_name.." *"..data.id_.."* _is already a_ *moderator*", 0, "md")
else
    return tdcli.sendMessage(arg.chat_id, "", 0, "_کاربر_ "..user_name.." *"..data.id_.."* *از قبل مدیر گروه بود*", 0, "md")
      end
   end
administration[tostring(arg.chat_id)]['mods'][tostring(data.id_)] = user_name
    save_data(_config.moderation.data, administration)
   if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, "_User_ "..user_name.." *"..data.id_.."* _has been_ *promoted*", 0, "md")
   else
    return tdcli.sendMessage(arg.chat_id, "", 0, "_کاربر_ "..user_name.." *"..data.id_.."* *به مقام مدیر گروه منتصب شد*", 0, "md")
   end
end
tdcli_function ({
    ID = "GetUser",
    user_id_ = data.sender_user_id_
  }, promote_cb, {chat_id=data.chat_id_,user_id=data.sender_user_id_})
  end
     if cmd == "remowner" then
local function rem_owner_cb(arg, data)
local hash = "gp_lang:"..arg.chat_id
local lang = redis:get(hash)
    local administration = load_data(_config.moderation.data)
if data.username_ then
user_name = '@'..check_markdown(data.username_)
else
user_name = check_markdown(data.first_name_)
end
if not administration[tostring(arg.chat_id)]['owners'][tostring(data.id_)] then
   if not lang then
return tdcli.sendMessage(arg.chat_id, "", 0, "_User_ "..user_name.." *"..data.id_.."* _is not a_ *group owner*", 0, "md")
   else
return tdcli.sendMessage(arg.chat_id, "", 0, "_User_ "..user_name.." *"..data.id_.."* *از قبل صاحب گروه نبود*", 0, "md")
      end
   end
administration[tostring(arg.chat_id)]['owners'][tostring(data.id_)] = nil
    save_data(_config.moderation.data, administration)
   if not lang then
return tdcli.sendMessage(arg.chat_id, "", 0, "_User_ "..user_name.." *"..data.id_.."* _is no longer a_ *group owner*", 0, "md")
    else
return tdcli.sendMessage(arg.chat_id, "", 0, "_کاربر_ "..user_name.." *"..data.id_.."* *از مقام صاحب گروه برکنار شد*", 0, "md")
   end
end
tdcli_function ({
    ID = "GetUser",
    user_id_ = data.sender_user_id_
  }, rem_owner_cb, {chat_id=data.chat_id_,user_id=data.sender_user_id_})
  end
    if cmd == "demote" then
local function demote_cb(arg, data)
    local administration = load_data(_config.moderation.data)
if data.username_ then
user_name = '@'..check_markdown(data.username_)
else
user_name = check_markdown(data.first_name_)
end
if not administration[tostring(arg.chat_id)]['mods'][tostring(data.id_)] then
    if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, "_User_ "..user_name.." *"..data.id_.."* _is not a_ *moderator*", 0, "md")
    else
    return tdcli.sendMessage(arg.chat_id, "", 0, "_کاربر_ "..user_name.." *"..data.id_.."* *از قبل مدیر گروه نبود*", 0, "md")
   end
  end
administration[tostring(arg.chat_id)]['mods'][tostring(data.id_)] = nil
    save_data(_config.moderation.data, administration)
   if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, "_User_ "..user_name.." *"..data.id_.."* _has been_ *demoted*", 0, "md")
   else
    return tdcli.sendMessage(arg.chat_id, "", 0, "_کاربر_ "..user_name.." *"..data.id_.."* *از مقام مدیر گروه برکنار شد*", 0, "md")
   end
end
tdcli_function ({
    ID = "GetUser",
    user_id_ = data.sender_user_id_
  }, demote_cb, {chat_id=data.chat_id_,user_id=data.sender_user_id_})
  end
    if cmd == "id" then
local function id_cb(arg, data)
    return tdcli.sendMessage(arg.chat_id, "", 0, "*"..data.id_.."*", 0, "md")
end
tdcli_function ({
    ID = "GetUser",
    user_id_ = data.sender_user_id_
  }, id_cb, {chat_id=data.chat_id_,user_id=data.sender_user_id_})
  end
else
    if lang then
  return tdcli.sendMessage(data.chat_id_, "", 0, "_کاربر یافت نشد_", 0, "md")
   else
  return tdcli.sendMessage(data.chat_id_, "", 0, "*User Not Found*", 0, "md")
      end
   end
end

local function action_by_username(arg, data)
local hash = "gp_lang:"..arg.chat_id
local lang = redis:get(hash)
local cmd = arg.cmd
    local administration = load_data(_config.moderation.data)
  if not administration[tostring(arg.chat_id)] then
  if not lang then
    return tdcli.sendMessage(data.chat_id_, "", 0, "_Group is not added_", 0, "md")
else
    return tdcli.sendMessage(data.chat_id_, "", 0, "_گروه به لیست گروه های مدیریتی ربات اضافه نشده است_", 0, "md")
     end
  end
if not arg.username then return false end
   if data.id_ then
if data.type_.user_.username_ then
user_name = '@'..check_markdown(data.type_.user_.username_)
else
user_name = check_markdown(data.title_)
end
if cmd == "setowner" then
if administration[tostring(arg.chat_id)]['owners'][tostring(data.id_)] then
    if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, "_User_ "..user_name.." *"..data.id_.."* _is already a_ *group owner*", 0, "md")
   else
    return tdcli.sendMessage(arg.chat_id, "", 0, "_کاربر_ "..user_name.." *"..data.id_.."* *از قبل صاحب گروه بود*", 0, "md")
      end
   end
administration[tostring(arg.chat_id)]['owners'][tostring(data.id_)] = user_name
    save_data(_config.moderation.data, administration)
   if not lang then
  return tdcli.sendMessage(arg.chat_id, "", 0, "_User_ "..user_name.." *"..data.id_.."* _is now the_ *group owner*", 0, "md")
   else
  return tdcli.sendMessage(arg.chat_id, "", 0, "_کاربر_ "..user_name.." *"..data.id_.."* *به مقام صاحب گروه منتصب شد*", 0, "md")
   end
end
  if cmd == "promote" then
if administration[tostring(arg.chat_id)]['mods'][tostring(data.id_)] then
   if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, "_User_ "..user_name.." *"..data.id_.."* _is already a_ *moderator*", 0, "md")
else
    return tdcli.sendMessage(arg.chat_id, "", 0, "_کاربر_ "..user_name.." *"..data.id_.."* *از قبل مدیر گروه بود*", 0, "md")
      end
   end
administration[tostring(arg.chat_id)]['mods'][tostring(data.id_)] = user_name
    save_data(_config.moderation.data, administration)
   if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, "_User_ "..user_name.." *"..data.id_.."* _has been_ *promoted*", 0, "md")
   else
    return tdcli.sendMessage(arg.chat_id, "", 0, "_کاربر_ "..user_name.." *"..data.id_.."* *به مقام مدیر گروه منتصب شد*", 0, "md")
   end
end
   if cmd == "remowner" then
if not administration[tostring(arg.chat_id)]['owners'][tostring(data.id_)] then
   if not lang then
return tdcli.sendMessage(arg.chat_id, "", 0, "_User_ "..user_name.." *"..data.id_.."* _is not a_ *group owner*", 0, "md")
   else
return tdcli.sendMessage(arg.chat_id, "", 0, "_User_ "..user_name.." *"..data.id_.."* *از قبل صاحب گروه نبود*", 0, "md")
      end
   end
administration[tostring(arg.chat_id)]['owners'][tostring(data.id_)] = nil
    save_data(_config.moderation.data, administration)
   if not lang then
return tdcli.sendMessage(arg.chat_id, "", 0, "_User_ "..user_name.." *"..data.id_.."* _is no longer a_ *group owner*", 0, "md")
    else
return tdcli.sendMessage(arg.chat_id, "", 0, "_کاربر_ "..user_name.." *"..data.id_.."* *از مقام صاحب گروه برکنار شد*", 0, "md")
   end
end
   if cmd == "demote" then
if not administration[tostring(arg.chat_id)]['mods'][tostring(data.id_)] then
    if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, "_User_ "..user_name.." *"..data.id_.."* _is not a_ *moderator*", 0, "md")
    else
    return tdcli.sendMessage(arg.chat_id, "", 0, "_کاربر_ "..user_name.." *"..data.id_.."* *از قبل مدیر گروه نبود*", 0, "md")
   end
  end
administration[tostring(arg.chat_id)]['mods'][tostring(data.id_)] = nil
    save_data(_config.moderation.data, administration)
   if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, "_User_ "..user_name.." *"..data.id_.."* _has been_ *demoted*", 0, "md")
   else
    return tdcli.sendMessage(arg.chat_id, "", 0, "_کاربر_ "..user_name.." *"..data.id_.."* *از مقام مدیر گروه برکنار شد*", 0, "md")
   end
end
   if cmd == "id" then
    return tdcli.sendMessage(arg.chat_id, "", 0, "*"..data.id_.."*", 0, "md")
end
    if cmd == "res" then
    if not lang then
     text = "Result for [ "..check_markdown(data.type_.user_.username_).." ] :\n"
    .. ""..check_markdown(data.title_).."\n"
    .. " ["..data.id_.."]"
  else
     text = "اطلاعات برای [ "..check_markdown(data.type_.user_.username_).." ] :\n"
    .. "".. check_markdown(data.title_) .."\n"
    .. " [".. data.id_ .."]"
         end
       return tdcli.sendMessage(arg.chat_id, 0, 1, text, 1, 'md')
   end
else
    if lang then
  return tdcli.sendMessage(arg.chat_id, "", 0, "_کاربر یافت نشد_", 0, "md")
   else
  return tdcli.sendMessage(arg.chat_id, "", 0, "*User Not Found*", 0, "md")
      end
   end
end

local function action_by_id(arg, data)
local hash = "gp_lang:"..arg.chat_id
local lang = redis:get(hash)
local cmd = arg.cmd
    local administration = load_data(_config.moderation.data)
  if not administration[tostring(arg.chat_id)] then
  if not lang then
    return tdcli.sendMessage(data.chat_id_, "", 0, "_Group is not added_", 0, "md")
else
    return tdcli.sendMessage(data.chat_id_, "", 0, "_گروه به لیست گروه های مدیریتی ربات اضافه نشده است_", 0, "md")
     end
  end
if not tonumber(arg.user_id) then return false end
   if data.id_ then
if data.first_name_ then
if data.username_ then
user_name = '@'..check_markdown(data.username_)
else
user_name = check_markdown(data.first_name_)
end
  if cmd == "setowner" then
  if administration[tostring(arg.chat_id)]['owners'][tostring(data.id_)] then
    if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, "_User_ "..user_name.." *"..data.id_.."* _is already a_ *group owner*", 0, "md")
   else
    return tdcli.sendMessage(arg.chat_id, "", 0, "_کاربر_ "..user_name.." *"..data.id_.."* *از قبل صاحب گروه بود*", 0, "md")
      end
   end
administration[tostring(arg.chat_id)]['owners'][tostring(data.id_)] = user_name
    save_data(_config.moderation.data, administration)
   if not lang then
  return tdcli.sendMessage(arg.chat_id, "", 0, "_User_ "..user_name.." *"..data.id_.."* _is now the_ *group owner*", 0, "md")
   else
  return tdcli.sendMessage(arg.chat_id, "", 0, "_کاربر_ "..user_name.." *"..data.id_.."* *به مقام صاحب گروه منتصب شد*", 0, "md")
   end
end
  if cmd == "promote" then
if administration[tostring(arg.chat_id)]['mods'][tostring(data.id_)] then
   if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, "_User_ "..user_name.." *"..data.id_.."* _is already a_ *moderator*", 0, "md")
else
    return tdcli.sendMessage(arg.chat_id, "", 0, "_کاربر_ "..user_name.." *"..data.id_.."* *از قبل مدیر گروه بود*", 0, "md")
      end
   end
administration[tostring(arg.chat_id)]['mods'][tostring(data.id_)] = user_name
    save_data(_config.moderation.data, administration)
   if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, "_User_ "..user_name.." *"..data.id_.."* _has been_ *promoted*", 0, "md")
   else
    return tdcli.sendMessage(arg.chat_id, "", 0, "_کاربر_ "..user_name.." *"..data.id_.."* *به مقام مدیر گروه منتصب شد*", 0, "md")
   end
end
   if cmd == "remowner" then
if not administration[tostring(arg.chat_id)]['owners'][tostring(data.id_)] then
   if not lang then
return tdcli.sendMessage(arg.chat_id, "", 0, "_User_ "..user_name.." *"..data.id_.."* _is not a_ *group owner*", 0, "md")
   else
return tdcli.sendMessage(arg.chat_id, "", 0, "_User_ "..user_name.." *"..data.id_.."* *از قبل صاحب گروه نبود*", 0, "md")
      end
   end
administration[tostring(arg.chat_id)]['owners'][tostring(data.id_)] = nil
    save_data(_config.moderation.data, administration)
   if not lang then
return tdcli.sendMessage(arg.chat_id, "", 0, "_User_ "..user_name.." *"..data.id_.."* _is no longer a_ *group owner*", 0, "md")
    else
return tdcli.sendMessage(arg.chat_id, "", 0, "_کاربر_ "..user_name.." *"..data.id_.."* *از مقام صاحب گروه برکنار شد*", 0, "md")
   end
end
   if cmd == "demote" then
if not administration[tostring(arg.chat_id)]['mods'][tostring(data.id_)] then
    if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, "_User_ "..user_name.." *"..data.id_.."* _is not a_ *moderator*", 0, "md")
    else
    return tdcli.sendMessage(arg.chat_id, "", 0, "_کاربر_ "..user_name.." *"..data.id_.."* *از قبل مدیر گروه نبود*", 0, "md")
   end
  end
administration[tostring(arg.chat_id)]['mods'][tostring(data.id_)] = nil
    save_data(_config.moderation.data, administration)
   if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, "_User_ "..user_name.." *"..data.id_.."* _has been_ *demoted*", 0, "md")
   else
    return tdcli.sendMessage(arg.chat_id, "", 0, "_کاربر_ "..user_name.." *"..data.id_.."* *از مقام مدیر گروه برکنار شد*", 0, "md")
   end
end
    if cmd == "whois" then
if data.username_ then
username = '@'..check_markdown(data.username_)
else
if not lang then
username = 'not found'
 else
username = 'ندارد'
  end
end
     if not lang then
       return tdcli.sendMessage(arg.chat_id, 0, 1, 'Info for [ '..data.id_..' ] :\nUserName : '..username..'\nName : '..data.first_name_, 1)
   else
       return tdcli.sendMessage(arg.chat_id, 0, 1, 'اطلاعات برای [ '..data.id_..' ] :\nیوزرنیم : '..username..'\nنام : '..data.first_name_, 1)
      end
   end
 else
    if not lang then
  return tdcli.sendMessage(arg.chat_id, "", 0, "_User not founded_", 0, "md")
   else
  return tdcli.sendMessage(arg.chat_id, "", 0, "_کاربر یافت نشد_", 0, "md")
    end
  end
else
    if lang then
  return tdcli.sendMessage(arg.chat_id, "", 0, "_کاربر یافت نشد_", 0, "md")
   else
  return tdcli.sendMessage(arg.chat_id, "", 0, "*User Not Found*", 0, "md")
      end
   end
end


---------------Lock Link-------------------
local function lock_link(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
 return "_You're Not_ *Moderator*"
else
 return "شما مدیر گروه نمیباشید"
end
end

local lock_link = data[tostring(target)]["settings"]["lock_link"] 
if lock_link == "yes" then
if not lang then
 return "*Link* _Posting Is Already Locked_"
elseif lang then
 return "ارسال لینک در گروه هم اکنون ممنوع است"
end
else
data[tostring(target)]["settings"]["lock_link"] = "yes"
save_data(_config.moderation.data, data) 
if not lang then
 return "*Link* _Posting Has Been Locked_"
else
 return "ارسال لینک در گروه ممنوع شد"
end
end
end

local function unlock_link(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
 if not is_mod(msg) then
if not lang then
return "_You're Not_ *Moderator*"
else
return "شما مدیر گروه نمیباشید"
end
end 

local lock_link = data[tostring(target)]["settings"]["lock_link"]
 if lock_link == "no" then
if not lang then
return "*Link* _Posting Is Not Locked_" 
elseif lang then
return "ارسال لینک در گروه ممنوع نمیباشد"
end
else 
data[tostring(target)]["settings"]["lock_link"] = "no" save_data(_config.moderation.data, data) 
if not lang then
return "*Link* _Posting Has Been Unlocked_" 
else
return "ارسال لینک در گروه آزاد شد"
end
end
end


---------------Lock Vewis-------------------
local function lock_views(msg, data, target) 
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
 return "_You're Not_ *Moderator*"
else
 return "شما مدیر گروه نمیباشید"
end
end

local lock_views = data[tostring(target)]["settings"]["views"] 
if lock_views == "yes" then
if not lang then
 return "*Views* _Posting Is Already Locked_"
elseif lang then
 return "ارسال پست ویو دار در گروه هم اکنون ممنوع است"
end
else
 data[tostring(target)]["settings"]["views"] = "yes"
save_data(_config.moderation.data, data) 
if not lang then
 return "*Views* _Posting Has Been Locked_"
else
 return "ارسال پست ویو دار در گروه ممنوع شد"
end
end
end

local function unlock_views(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
 return "_You're Not_ *Moderator*"
else
 return "شما مدیر گروه نمیباشید"
end 
end

local lock_views = data[tostring(target)]["settings"]["views"]
if lock_views == "no" then
if not lang then
 return "*Views* _Posting Is Not Locked_" 
elseif lang then
 return "ارسال پست ویو دار در گروه ممنوع نمیباشد"
end
else 
data[tostring(target)]["settings"]["views"] = "no" save_data(_config.moderation.data, data) 
if not lang then
 return "*Views* _Posting Has Been Unlocked_" 
else
 return "ارسال پست ویو دار در گروه آزاد شد"
end
end
end


---------------Lock English-------------------
local function lock_english(msg, data, target) 
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
 return "_You're Not_ *Moderator*"
else
 return "شما مدیر گروه نمیباشید"
end
end

local lock_english = data[tostring(target)]["settings"]["english"] 
if lock_english == "yes" then
if not lang then
 return "*English* _Posting Is Already Locked_"
elseif lang then
 return "ارسال نوشته انگلیسی در گروه هم اکنون ممنوع است"
end
else
data[tostring(target)]["settings"]["english"] = "yes"
save_data(_config.moderation.data, data) 
if not lang then
 return "*English* _Posting Has Been Locked_"
else
 return "ارسال نوشته انگلیسی در گروه ممنوع شد"
end
end
end

local function unlock_english(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
 if not is_mod(msg) then
if not lang then
return "_You're Not_ *Moderator*"
else
 return "شما مدیر گروه نمیباشید"
end 
end

local lock_english = data[tostring(target)]["settings"]["english"]
if lock_english == "no" then
if not lang then
 return "*English* _Posting Is Not Locked_" 
elseif lang then
 return "ارسال نوشته انگلیسی در گروه ممنوع نمیباشد"
end
else 
data[tostring(target)]["settings"]["english"] = "no" save_data(_config.moderation.data, data) 
if not lang then
 return "*English* _Posting Has Been Unlocked_" 
else
 return "ارسال نوشته انگلیسی در گروه آزاد شد"
end
end
end

---------------Lock Ads-------------------
local function lock_ads(msg, data, target) 
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
 return "_You're Not_ *Moderator*"
else
 return "شما مدیر گروه نمیباشید"
end
end

local lock_ads = data[tostring(target)]["settings"]["ads"] 
if lock_ads == "yes" then
if not lang then
 return "*Ads* _Posting Is Already Locked_"
elseif lang then
 return "ارسال تبلیغات در گروه هم اکنون ممنوع است"
end
else
data[tostring(target)]["settings"]["ads"] = "yes"
save_data(_config.moderation.data, data) 
if not lang then
 return "*Ads* _Posting Has Been Locked_"
else
 return "ارسال تبلیغات در گروه ممنوع شد"
end
end
end

local function unlock_ads(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
 return "_You're Not_ *Moderator*"
else
 return "شما مدیر گروه نمیباشید"
end 
end

local lock_ads = data[tostring(target)]["settings"]["ads"]
if lock_ads == "no" then
if not lang then
 return "*Fosh* _Posting Is Not Locked_" 
elseif lang then
 return "ارسال تبلیغات در گروه ممنوع نمیباشد"
end
else 
data[tostring(target)]["settings"]["ads"] = "no" save_data(_config.moderation.data, data) 
if not lang then
 return "*Ads* _Posting Has Been Unlocked_" 
else
 return "ارسال تبلیغات در گروه آزاد شد"
end
end
end

---------------Lock Fosh-------------------
local function lock_fosh(msg, data, target) 
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
 return "_You're Not_ *Moderator*"
else
 return "شما مدیر گروه نمیباشید"
end
end

local lock_fosh = data[tostring(target)]["settings"]["fosh"] 
if lock_fosh == "yes" then
if not lang then
 return "*Fosh* _Posting Is Already Locked_"
elseif lang then
 return "ارسال کلمات رکیک در گروه هم اکنون ممنوع است"
end
else
data[tostring(target)]["settings"]["fosh"] = "yes"
save_data(_config.moderation.data, data) 
if not lang then
 return "*Fosh* _Posting Has Been Locked_"
else
 return "ارسال کلمات رکیک در گروه ممنوع شد"
end
end
end

local function unlock_fosh(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
 return "_You're Not_ *Moderator*"
else
 return "شما مدیر گروه نمیباشید"
end 
end

local lock_fosh = data[tostring(target)]["settings"]["english"]
if lock_fosh == "no" then
if not lang then
 return "*Fosh* _Posting Is Not Locked_" 
elseif lang then
 return "ارسال کلمات رکیک در گروه ممنوع نمیباشد"
end
else 
data[tostring(target)]["settings"]["fosh"] = "no" save_data(_config.moderation.data, data) 
if not lang then
 return "*Fosh* _Posting Has Been Unlocked_" 
else
 return "ارسال کلمات رکیک در گروه آزاد شد"
end
end
end

---------------Lock Tag-------------------
local function lock_tag(msg, data, target) 
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
 return "_You're Not_ *Moderator*"
else
 return "شما مدیر گروه نمیباشید"
end
end

local lock_tag = data[tostring(target)]["settings"]["lock_tag"] 
if lock_tag == "yes" then
if not lang then
 return "*Tag* _Posting Is Already Locked_"
elseif lang then
 return "ارسال تگ در گروه هم اکنون ممنوع است"
end
else
data[tostring(target)]["settings"]["lock_tag"] = "yes"
save_data(_config.moderation.data, data) 
if not lang then
 return "*Tag* _Posting Has Been Locked_"
else
 return "ارسال تگ در گروه ممنوع شد"
end
end
end

local function unlock_tag(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
 return "_You're Not_ *Moderator*"
else
 return "شما مدیر گروه نمیباشید"
end 
end

local lock_tag = data[tostring(target)]["settings"]["lock_tag"]
if lock_tag == "no" then
if not lang then
 return "*Tag* _Posting Is Not Locked_" 
elseif lang then
 return "ارسال تگ در گروه ممنوع نمیباشد"
end
else 
data[tostring(target)]["settings"]["lock_tag"] = "no" save_data(_config.moderation.data, data) 
if not lang then
 return "*Tag* _Posting Has Been Unlocked_" 
else
 return "ارسال تگ در گروه آزاد شد"
end
end
end

---------------Lock Mention-------------------
local function lock_mention(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
 return "_You're Not_ *Moderator*"
else
 return "شما مدیر گروه نمیباشید"
end
end

local lock_mention = data[tostring(target)]["settings"]["lock_mention"] 
if lock_mention == "yes" then
if not lang then
 return "*Mention* _Posting Is Already Locked_"
elseif lang then
 return "ارسال فراخوانی افراد هم اکنون ممنوع است"
end
else
data[tostring(target)]["settings"]["lock_mention"] = "yes"
save_data(_config.moderation.data, data)
if not lang then 
 return "*Mention* _Posting Has Been Locked_"
else 
 return "ارسال فراخوانی افراد در گروه ممنوع شد"
end
end
end

local function unlock_mention(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
 return "_You're Not_ *Moderator*"
else
 return "شما مدیر گروه نمیباشید"
end
end 

local lock_mention = data[tostring(target)]["settings"]["lock_mention"]
if lock_mention == "no" then
if not lang then
 return "*Mention* _Posting Is Not Locked_" 
elseif lang then
 return "ارسال فراخوانی افراد در گروه ممنوع نمیباشد"
end
else 
data[tostring(target)]["settings"]["lock_mention"] = "no" save_data(_config.moderation.data, data) 
if not lang then
 return "*Mention* _Posting Has Been Unlocked_" 
else
 return "ارسال فراخوانی افراد در گروه آزاد شد"
end
end
end

---------------Lock Arabic--------------
local function lock_arabic(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
 return "_You're Not_ *Moderator*"
else
 return "شما مدیر گروه نمیباشید"
end
end

local lock_arabic = data[tostring(target)]["settings"]["lock_arabic"] 
if lock_arabic == "yes" then
if not lang then
 return "*Arabic/Persian* _Posting Is Already Locked_"
elseif lang then
 return "ارسال کلمات عربی/فارسی در گروه هم اکنون ممنوع است"
end
else
data[tostring(target)]["settings"]["lock_arabic"] = "yes"
save_data(_config.moderation.data, data) 
if not lang then
 return "*Arabic/Persian* _Posting Has Been Locked_"
else
 return "ارسال کلمات عربی/فارسی در گروه ممنوع شد"
end
end
end

local function unlock_arabic(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
 return "_You're Not_ *Moderator*"
else
 return "شما مدیر گروه نمیباشید"
end
end 

local lock_arabic = data[tostring(target)]["settings"]["lock_arabic"]
if lock_arabic == "no" then
if not lang then
 return "*Arabic/Persian* _Posting Is Not Locked_" 
elseif lang then
 return "ارسال کلمات عربی/فارسی در گروه ممنوع نمیباشد"
end
else 
data[tostring(target)]["settings"]["lock_arabic"] = "no" save_data(_config.moderation.data, data) 
if not lang then
 return "*Arabic/Persian* _Posting Has Been Unlocked_" 
else
 return "ارسال کلمات عربی/فارسی در گروه آزاد شد"
end
end
end

---------------Lock Edit-------------------
local function lock_edit(msg, data, target) 
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
 return "_You're Not_ *Moderator*"
else
 return "شما مدیر گروه نمیباشید"
end
end

local lock_edit = data[tostring(target)]["settings"]["lock_edit"] 
if lock_edit == "yes" then
if not lang then
 return "*Editing* _Is Already Locked_"
elseif lang then
 return "ویرایش پیام هم اکنون ممنوع است"
end
else
data[tostring(target)]["settings"]["lock_edit"] = "yes"
save_data(_config.moderation.data, data) 
if not lang then
 return "*Editing* _Has Been Locked_"
else
 return "ویرایش پیام در گروه ممنوع شد"
end
end
end

local function unlock_edit(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
 return "_You're Not_ *Moderator*"
else
 return "شما مدیر گروه نمیباشید"
end
end 

local lock_edit = data[tostring(target)]["settings"]["lock_edit"]
if lock_edit == "no" then
if not lang then
 return "*Editing* _Is Not Locked_" 
elseif lang then
 return "ویرایش پیام در گروه ممنوع نمیباشد"
end
else 
data[tostring(target)]["settings"]["lock_edit"] = "no" save_data(_config.moderation.data, data) 
if not lang then
 return "*Editing* _Has Been Unlocked_" 
else
 return "ویرایش پیام در گروه آزاد شد"
end
end
end

---------------Lock spam-------------------
local function lock_spam(msg, data, target) 
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
 return "_You're Not_ *Moderator*"
else
 return "شما مدیر گروه نمیباشید"
end
end

local lock_spam = data[tostring(target)]["settings"]["lock_spam"] 
if lock_spam == "yes" then
if not lang then
 return "*Spam* _Is Already Locked_"
elseif lang then
 return "ارسال هرزنامه در گروه هم اکنون ممنوع است"
end
else
data[tostring(target)]["settings"]["lock_spam"] = "yes"
save_data(_config.moderation.data, data) 
if not lang then
 return "*Spam* _Has Been Locked_"
else
 return "ارسال هرزنامه در گروه ممنوع شد"
end
end
end

local function unlock_spam(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
 return "_You're Not_ *Moderator*"
else
 return "شما مدیر گروه نمیباشید"
end
end 

local lock_spam = data[tostring(target)]["settings"]["lock_spam"]
if lock_spam == "no" then
if not lang then
 return "*Spam* _Posting Is Not Locked_" 
elseif lang then
 return "ارسال هرزنامه در گروه ممنوع نمیباشد"
end
else 
data[tostring(target)]["settings"]["lock_spam"] = "no" 
save_data(_config.moderation.data, data)
if not lang then 
 return "*Spam* _Posting Has Been Unlocked_" 
else
 return "ارسال هرزنامه در گروه آزاد شد"
end
end
end

---------------Lock Flood-------------------
local function lock_flood(msg, data, target) 
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
 return "_You're Not_ *Moderator*"
else
 return "شما مدیر گروه نمیباشید"
end
end

local lock_flood = data[tostring(target)]["settings"]["flood"] 
if lock_flood == "yes" then
if not lang then
 return "*Flooding* _Is Already Locked_"
elseif lang then
 return "ارسال پیام مکرر در گروه هم اکنون ممنوع است"
end
else
data[tostring(target)]["settings"]["flood"] = "yes"
save_data(_config.moderation.data, data) 
if not lang then
 return "*Flooding* _Has Been Locked_"
else
 return "ارسال پیام مکرر در گروه ممنوع شد"
end
end
end

local function unlock_flood(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
 return "_You're Not_ *Moderator*"
else
 return "شما مدیر گروه نمیباشید"
end
end 

local lock_flood = data[tostring(target)]["settings"]["flood"]
if lock_flood == "no" then
if not lang then
 return "*Flooding* _Is Not Locked_" 
elseif lang then
 return "ارسال پیام مکرر در گروه ممنوع نمیباشد"
end
else 
data[tostring(target)]["settings"]["flood"] = "no" save_data(_config.moderation.data, data) 
if not lang then
 return "*Flooding* _Has Been Unlocked_" 
else
 return "ارسال پیام مکرر در گروه آزاد شد"
end
end
end

---------------Lock Bots-------------------
local function lock_bots(msg, data, target) 
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
 return "_You're Not_ *Moderator*"
else
 return "شما مدیر گروه نمیباشید"
end
end

local lock_bots = data[tostring(target)]["settings"]["lock_bots"] 
if lock_bots == "yes" then
if not lang then
 return "*Bots* _Protection Is Already Enabled_"
elseif lang then
 return "محافظت از گروه در برابر ربات ها هم اکنون فعال است"
end
else
data[tostring(target)]["settings"]["lock_bots"] = "yes"
save_data(_config.moderation.data, data) 
if not lang then
 return "*Bots* _Protection Has Been Enabled_"
else
 return "محافظت از گروه در برابر ربات ها فعال شد"
end
end
end

local function unlock_bots(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
 return "_You're Not_ *Moderator*"
else
 return "شما مدیر گروه نمیباشید"
end 
end

local lock_bots = data[tostring(target)]["settings"]["lock_bots"]
if lock_bots == "no" then
if not lang then
 return "*Bots* _Protection Is Not Enabled_" 
elseif lang then
 return "محافظت از گروه در برابر ربات ها غیر فعال است"
end
else 
data[tostring(target)]["settings"]["lock_bots"] = "no" save_data(_config.moderation.data, data) 
if not lang then
 return "*Bots* _Protection Has Been Disabled_" 
else
 return "محافظت از گروه در برابر ربات ها غیر فعال شد"
end
end
end

---------------Lock Markdown-------------------
local function lock_markdown(msg, data, target) 
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
 return "_You're Not_ *Moderator*"
else
 return "شما مدیر گروه نمیباشید"
end
end

local lock_markdown = data[tostring(target)]["settings"]["lock_markdown"] 
if lock_markdown == "yes" then
if not lang then 
 return "*Markdown* _Posting Is Already Locked_"
elseif lang then
 return "ارسال پیام های دارای فونت در گروه هم اکنون ممنوع است"
end
else
data[tostring(target)]["settings"]["lock_markdown"] = "yes"
save_data(_config.moderation.data, data) 
if not lang then
 return "*Markdown* _Posting Has Been Locked_"
else
 return "ارسال پیام های دارای فونت در گروه ممنوع شد"
end
end
end

local function unlock_markdown(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
 return "_You're Not_ *Moderator*"
else
 return "شما مدیر گروه نمیباشید"
end 
end

local lock_markdown = data[tostring(target)]["settings"]["lock_markdown"]
if lock_markdown == "no" then
if not lang then
 return "*Markdown* _Posting Is Not Locked_"
elseif lang then
 return "ارسال پیام های دارای فونت در گروه ممنوع نمیباشد"
end
else 
data[tostring(target)]["settings"]["lock_markdown"] = "no" save_data(_config.moderation.data, data) 
if not lang then
 return "*Markdown* _Posting Has Been Unlocked_"
else
 return "ارسال پیام های دارای فونت در گروه آزاد شد"
end
end
end

---------------Lock Webpage-------------------
local function lock_webpage(msg, data, target) 
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
 return "_You're Not_ *Moderator*"
else
 return "شما مدیر گروه نمیباشید"
end
end

local lock_webpage = data[tostring(target)]["settings"]["lock_webpage"] 
if lock_webpage == "yes" then
if not lang then
 return "*Webpage* _Is Already Locked_"
elseif lang then
 return "ارسال صفحات وب در گروه هم اکنون ممنوع است"
end
else
data[tostring(target)]["settings"]["lock_webpage"] = "yes"
save_data(_config.moderation.data, data) 
if not lang then
 return "*Webpage* _Has Been Locked_"
else
 return "ارسال صفحات وب در گروه ممنوع شد"
end
end
end

local function unlock_webpage(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
 return "_You're Not_ *Moderator*"
else
 return "شما مدیر گروه نمیباشید"
end 
end

local lock_webpage = data[tostring(target)]["settings"]["lock_webpage"]
if lock_webpage == "no" then
if not lang then
 return "*Webpage* _Is Not Locked_" 
elseif lang then
 return "ارسال صفحات وب در گروه ممنوع نمیباشد"
end
else 
data[tostring(target)]["settings"]["lock_webpage"] = "no"
save_data(_config.moderation.data, data) 
if not lang then
 return "*Webpage* _Has Been Unlocked_" 
else
 return "ارسال صفحات وب در گروه آزاد شد"
end
end
end

---------------Lock Pin-------------------
local function lock_pin(msg, data, target) 
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
 return "_You're Not_ *Moderator*"
else
 return "شما مدیر گروه نمیباشید"
end
end

local lock_pin = data[tostring(target)]["settings"]["lock_pin"] 
if lock_pin == "yes" then
if not lang then
 return "*Pinned Message* _Is Already Locked_"
elseif lang then
 return "سنجاق کردن پیام در گروه هم اکنون ممنوع است"
end
else
data[tostring(target)]["settings"]["lock_pin"] = "yes"
save_data(_config.moderation.data, data) 
if not lang then
 return "*Pinned Message* _Has Been Locked_"
else
 return "سنجاق کردن پیام در گروه ممنوع شد"
end
end
end

local function unlock_pin(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
 return "_You're Not_ *Moderator*"
else
 return "شما مدیر گروه نمیباشید"
end 
end

local lock_pin = data[tostring(target)]["settings"]["lock_pin"]
if lock_pin == "no" then
if not lang then
 return "*Pinned Message* _Is Not Locked_" 
elseif lang then
 return "سنجاق کردن پیام در گروه ممنوع نمیباشد"
end
else 
data[tostring(target)]["settings"]["lock_pin"] = "no"
save_data(_config.moderation.data, data) 
if not lang then
 return "*Pinned Message* _Has Been Unlocked_" 
else
 return "سنجاق کردن پیام در گروه آزاد شد"
end
end
end

local function lock_all(msg, data, target) 
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
if not is_mod(msg) then 
if not lang then
return "_You're Not_ *Moderator*" 
else
return "شما مدیر گروه نمیباشید"
end
end

local lock_all = data[tostring(target)]["settings"]["lock_all"] 
if lock_all == "yes" then 
if not lang then
return "*Lock All* _Is Already Enabled_" 
elseif lang then
return "قفل کردن چت فعال است"
end
else 
data[tostring(target)]["settings"]["lock_all"] = "yes"
 save_data(_config.moderation.data, data) 
if not lang then
return "*Lock All* _Has Been Enabled_" 
else
return "قفل کردن چت فعال شد"
end
end
end

local function unlock_all(msg, data, target) 
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
if not is_mod(msg) then 
if not lang then
return "_You're Not_ *Moderator*" 
else
return "شما مدیر گروه نمیباشید"
end
end

local lock_all = data[tostring(target)]["settings"]["lock_all"] 
if lock_all == "no" then 
if not lang then
return "*Lock All* _Is Already Disabled_" 
elseif lang then
return "قفل کردن چت غیر فعال است"
end
else 
data[tostring(target)]["settings"]["lock_all"] = "no"
 save_data(_config.moderation.data, data) 
if not lang then
return "*Lock All* _Has Been Disabled_" 
else
return "قفل کردن چت غیر فعال شد"
end 
end
end

---------------Lock Gif-------------------
local function lock_gif(msg, data, target) 
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
 return "_You're Not_ *Moderator*"
else
 return "شما مدیر گروه نمیباشید"
end
end

local lock_gif = data[tostring(target)]["settings"]["lock_gif"] 
if lock_gif == "yes" then
if not lang then
 return "*Lock Gif* _Is Already Enabled_"
elseif lang then
 return "قفل کردن تصاویر متحرک فعال است"
end
else
 data[tostring(target)]["settings"]["lock_gif"] = "yes" 
save_data(_config.moderation.data, data) 
if not lang then 
 return "*Lock Gif* _Has Been Enabled_"
else
 return "قفل کردن تصاویر متحرک فعال شد"
end
end
end

local function unlock_gif(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
 if not is_mod(msg) then
if not lang then
return "_You're Not_ *Moderator*"
else
return "شما مدیر گروه نمیباشید"
end
end 

local lock_gif = data[tostring(target)]["settings"]["lock_gif"]
 if lock_gif == "no" then
if not lang then
return "*Lock Gif* _Is Already Disabled_" 
elseif lang then
return "قفل کردن تصاویر متحرک غیر فعال بود"
end
else 
data[tostring(target)]["settings"]["lock_gif"] = "no"
 save_data(_config.moderation.data, data) 
if not lang then
return "*Lock Gif* _Has Been Disabled_" 
else
return "قفل کردن تصاویر متحرک غیر فعال شد"
end
end
end
---------------Lock Game-------------------
local function lock_game(msg, data, target) 
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
 return "_You're Not_ *Moderator*"
else
 return "شما مدیر گروه نمیباشید"
end
end

local lock_game = data[tostring(target)]["settings"]["lock_game"] 
if lock_game == "yes" then
if not lang then
 return "*Lock Game* _Is Already Enabled_"
elseif lang then
 return "قفل کردن بازی های تحت وب فعال است"
end
else
 data[tostring(target)]["settings"]["lock_game"] = "yes" 
save_data(_config.moderation.data, data) 
if not lang then
 return "*Lock Game* _Has Been Enabled_"
else
 return "قفل کردن بازی های تحت وب فعال شد"
end
end
end

local function unlock_game(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
 if not is_mod(msg) then
if not lang then
return "_You're Not_ *Moderator*"
else
return "شما مدیر گروه نمیباشید"
end 
end

local lock_game = data[tostring(target)]["settings"]["lock_game"]
 if lock_game == "no" then
if not lang then
return "*Lock Game* _Is Already Disabled_" 
elseif lang then
return "قفل کردن بازی های تحت وب غیر فعال است"
end
else 
data[tostring(target)]["settings"]["lock_game"] = "no"
 save_data(_config.moderation.data, data)
if not lang then 
return "*Lock Game* _Has Been Disabled_" 
else
return "قفل کردن بازی های تحت وب غیر فعال شد"
end
end
end
---------------Lock Inline-------------------
local function lock_inline(msg, data, target) 
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
 return "_You're Not_ *Moderator*"
else
 return "شما مدیر گروه نمیباشید"
end
end

local lock_inline = data[tostring(target)]["settings"]["lock_inline"] 
if lock_inline == "yes" then
if not lang then
 return "*Lock Inline* _Is Already Enabled_"
elseif lang then
 return "قفل کردن کیبورد شیشه ای فعال است"
end
else
 data[tostring(target)]["settings"]["lock_inline"] = "yes" 
save_data(_config.moderation.data, data) 
if not lang then
 return "*Lock Inline* _Has Been Enabled_"
else
 return "قفل کردن کیبورد شیشه ای فعال شد"
end
end
end

local function unlock_inline(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
 if not is_mod(msg) then
if not lang then
return "_You're Not_ *Moderator*"
else
return "شما مدیر گروه نمیباشید"
end
end 

local lock_inline = data[tostring(target)]["settings"]["lock_inline"]
 if lock_inline == "no" then
if not lang then
return "*Lock Inline* _Is Already Disabled_" 
elseif lang then
return "قفل کردن کیبورد شیشه ای غیر فعال است"
end
else 
data[tostring(target)]["settings"]["lock_inline"] = "no"
 save_data(_config.moderation.data, data) 
if not lang then
return "*Lock Inline* _Has Been Disabled_" 
else
return "قفل کردن کیبورد شیشه ای غیر فعال شد"
end
end
end
---------------Lock Text-------------------
local function lock_text(msg, data, target) 
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
 return "_You're Not_ *Moderator*"
else
 return "شما مدیر گروه نمیباشید"
end
end

local lock_text = data[tostring(target)]["settings"]["lock_text"] 
if lock_text == "yes" then
if not lang then
 return "*Lock Text* _Is Already Enabled_"
elseif lang then
 return "قفل کردن متن فعال است"
end
else
 data[tostring(target)]["settings"]["lock_text"] = "yes" 
save_data(_config.moderation.data, data) 
if not lang then
 return "*Lock Text* _Has Been Enabled_"
else
 return "قفل کردن متن فعال شد"
end
end
end

local function unlock_text(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
 if not is_mod(msg) then
if not lang then
return "_You're Not_ *Moderator*"
else
return "شما مدیر گروه نمیباشید"
end 
end

local lock_text = data[tostring(target)]["settings"]["lock_text"]
 if lock_text == "no" then
if not lang then
return "*Lock Text* _Is Already Disabled_"
elseif lang then
return "قفل کردن متن غیر فعال است" 
end
else 
data[tostring(target)]["settings"]["lock_text"] = "no"
 save_data(_config.moderation.data, data) 
if not lang then
return "*Lock Text* _Has Been Disabled_" 
else
return "قفل کردن متن غیر فعال شد"
end
end
end
---------------Lock photo-------------------
local function lock_photo(msg, data, target) 
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
 return "_You're Not_ *Moderator*"
else
 return "شما مدیر گروه نمیباشید"
end
end

local lock_photo = data[tostring(target)]["settings"]["lock_photo"] 
if lock_photo == "yes" then
if not lang then
 return "*Lock Photo* _Is Already Enabled_"
elseif lang then
 return "قفل کردن عکس فعال است"
end
else
 data[tostring(target)]["settings"]["lock_photo"] = "yes" 
save_data(_config.moderation.data, data) 
if not lang then
 return "*Lock Photo* _Has Been Enabled_"
else
 return "قفل کردن عکس فعال شد"
end
end
end

local function unlock_photo(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
 if not is_mod(msg) then
if not lang then
return "_You're Not_ *Moderator*"
else
return "شما مدیر گروه نمیباشید"
end
end
 
local lock_photo = data[tostring(target)]["settings"]["lock_photo"]
 if lock_photo == "no" then
if not lang then
return "*Lock Photo* _Is Already Disabled_" 
elseif lang then
return "قفل کردن عکس غیر فعال است"
end
else 
data[tostring(target)]["settings"]["lock_photo"] = "no"
 save_data(_config.moderation.data, data) 
if not lang then
return "*Lock Photo* _Has Been Disabled_" 
else
return "قفل کردن عکس غیر فعال شد"
end
end
end
---------------Lock Video-------------------
local function lock_video(msg, data, target) 
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
 return "_You're Not_ *Moderator*"
else
 return "شما مدیر گروه نمیباشید"
end
end

local lock_video = data[tostring(target)]["settings"]["lock_video"] 
if lock_video == "yes" then
if not lang then
 return "*Lock Video* _Is Already Enabled_"
elseif lang then
 return "قفل کردن فیلم فعال است"
end
else
 data[tostring(target)]["settings"]["lock_video"] = "yes" 
save_data(_config.moderation.data, data)
if not lang then 
 return "*Lock Video* _Has Been Enabled_"
else
 return "قفل کردن فیلم فعال شد"
end
end
end

local function unlock_video(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
 if not is_mod(msg) then
if not lang then
return "_You're Not_ *Moderator*"
else
return "شما مدیر گروه نمیباشید"
end
end 

local lock_video = data[tostring(target)]["settings"]["lock_video"]
 if lock_video == "no" then
if not lang then
return "*Lock Video* _Is Already Disabled_" 
elseif lang then
return "قفل کردن فیلم غیر فعال است"
end
else 
data[tostring(target)]["settings"]["lock_video"] = "no"
 save_data(_config.moderation.data, data) 
if not lang then
return "*Lock Video* _Has Been Disabled_" 
else
return "قفل کردن فیلم غیر فعال شد"
end
end
end
---------------Lock Audio-------------------
local function lock_audio(msg, data, target) 
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
 return "_You're Not_ *Moderator*"
else
 return "شما مدیر گروه نمیباشید"
end
end

local lock_audio = data[tostring(target)]["settings"]["lock_audio"] 
if lock_audio == "yes" then
if not lang then
 return "*Lock Audio* _Is Already Enabled_"
elseif lang then
 return "قفل کردن آهنگ فعال است"
end
else
 data[tostring(target)]["settings"]["lock_audio"] = "yes" 
save_data(_config.moderation.data, data) 
if not lang then
 return "*Lock Audio* _Has Been Enabled_"
else 
return "قفل کردن آهنگ فعال شد"
end
end
end

local function unlock_audio(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
 if not is_mod(msg) then
if not lang then
return "_You're Not_ *Moderator*"
else
return "شما مدیر گروه نمیباشید"
end
end 

local lock_audio = data[tostring(target)]["settings"]["lock_audio"]
 if lock_audio == "no" then
if not lang then
return "*Lock Audio* _Is Already Disabled_" 
elseif lang then
return "قفل کردن آهنک غیر فعال است"
end
else 
data[tostring(target)]["settings"]["lock_audio"] = "no"
 save_data(_config.moderation.data, data)
if not lang then 
return "*Lock Audio* _Has Been Disabled_"
else
return "قفل کردن آهنگ غیر فعال شد" 
end
end
end
---------------Lock Voice-------------------
local function lock_voice(msg, data, target) 
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
 return "_You're Not_ *Moderator*"
else
 return "شما مدیر گروه نمیباشید"
end
end

local lock_voice = data[tostring(target)]["settings"]["lock_voice"] 
if lock_voice == "yes" then
if not lang then
 return "*Lock Voice* _Is Already Enabled_"
elseif lang then
 return "قفل کردن صدا فعال است"
end
else
 data[tostring(target)]["settings"]["lock_voice"] = "yes" 
save_data(_config.moderation.data, data) 
if not lang then
 return "*Lock Voice* _Has Been Enabled_"
else
 return "قفل کردن صدا فعال شد"
end
end
end

local function unlock_voice(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
 if not is_mod(msg) then
if not lang then
return "_You're Not_ *Moderator*"
else
return "شما مدیر گروه نمیباشید"
end
end 

local lock_voice = data[tostring(target)]["settings"]["lock_voice"]
 if lock_voice == "no" then
if not lang then
return "*Lock Voice* _Is Already Disabled_" 
elseif lang then
return "قفل کردن صدا غیر فعال است"
end
else 
data[tostring(target)]["settings"]["lock_voice"] = "no"
 save_data(_config.moderation.data, data)
if not lang then 
return "*Lock Voice* _Has Been Disabled_" 
else
return "قفل کردن صدا غیر فعال شد"
end
end
end
---------------Lock Sticker-------------------
local function lock_sticker(msg, data, target) 
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
 return "_You're Not_ *Moderator*"
else
 return "شما مدیر گروه نمیباشید"
end
end

local lock_sticker = data[tostring(target)]["settings"]["lock_sticker"] 
if lock_sticker == "yes" then
if not lang then
 return "*Lock Sticker* _Is Already Enabled_"
elseif lang then
 return "قفل کردن برچسب فعال است"
end
else
 data[tostring(target)]["settings"]["lock_sticker"] = "yes" 
save_data(_config.moderation.data, data) 
if not lang then
 return "*Lock Sticker* _Has Been Enabled_"
else
 return "قفل کردن برچسب فعال شد"
end
end
end

local function unlock_sticker(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
 if not is_mod(msg) then
if not lang then
return "_You're Not_ *Moderator*"
else
return "شما مدیر گروه نمیباشید"
end 
end

local lock_sticker = data[tostring(target)]["settings"]["lock_sticker"]
 if lock_sticker == "no" then
if not lang then
return "*Lock Sticker* _Is Already Disabled_" 
elseif lang then
return "قفل کردن برچسب غیر فعال است"
end
else 
data[tostring(target)]["settings"]["lock_sticker"] = "no"
 save_data(_config.moderation.data, data)
if not lang then 
return "*Lock Sticker* _Has Been Disabled_"
else
return "قفل کردن برچسب غیر فعال شد"
end 
end
end
---------------Lock Contact-------------------
local function lock_contact(msg, data, target) 
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
 return "_You're Not_ *Moderator*"
else
 return "شما مدیر گروه نمیباشید"
end
end

local lock_contact = data[tostring(target)]["settings"]["lock_contact"] 
if lock_contact == "yes" then
if not lang then
 return "*Lock Contact* _Is Already Enabled_"
elseif lang then
 return "قفل کردن مخاطب فعال است"
end
else
 data[tostring(target)]["settings"]["lock_contact"] = "yes" 
save_data(_config.moderation.data, data) 
if not lang then
 return "*Lock Contact* _Has Been Enabled_"
else
 return "قفل کردن مخاطب فعال شد"
end
end
end

local function unlock_contact(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
 if not is_mod(msg) then
if not lang then
return "_You're Not_ *Moderator*"
else
return "شما مدیر گروه نمیباشید"
end
end 

local lock_contact = data[tostring(target)]["settings"]["lock_contact"]
 if lock_contact == "no" then
if not lang then
return "*Lock Contact* _Is Already Disabled_" 
elseif lang then
return "قفل کردن مخاطب غیر فعال است"
end
else 
data[tostring(target)]["settings"]["lock_contact"] = "no"
 save_data(_config.moderation.data, data) 
if not lang then
return "*Lock Contact* _Has Been Disabled_" 
else
return "قفل کردن مخاطب غیر فعال شد"
end
end
end
---------------Lock Forward-------------------
local function lock_forward(msg, data, target) 
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
 return "_You're Not_ *Moderator*"
else
 return "شما مدیر گروه نمیباشید"
end
end

local lock_forward = data[tostring(target)]["settings"]["lock_forward"] 
if lock_forward == "yes" then
if not lang then
 return "*Lock Forward* _Is Already Enabled_"
elseif lang then
 return "قفل کردن نقل قول فعال است"
end
else
 data[tostring(target)]["settings"]["lock_forward"] = "yes" 
save_data(_config.moderation.data, data) 
if not lang then
 return "*Lock Forward* _Has Been Enabled_"
else
 return "قفل کردن نقل قول فعال شد"
end
end
end

local function unlock_forward(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
 if not is_mod(msg) then
if not lang then
return "_You're Not_ *Moderator*"
else
return "شما مدیر گروه نمیباشید"
end
end 

local lock_forward = data[tostring(target)]["settings"]["lock_forward"]
 if lock_forward == "no" then
if not lang then
return "*Lock Forward* _Is Already Disabled_"
elseif lang then
return "قفل کردن نقل قول غیر فعال است"
end 
else 
data[tostring(target)]["settings"]["lock_forward"] = "no"
 save_data(_config.moderation.data, data)
if not lang then 
return "*Lock Forward* _Has Been Disabled_" 
else
return "قفل کردن نقل قول غیر فعال شد"
end
end
end
---------------Lock Location-------------------
local function lock_location(msg, data, target) 
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
 return "_You're Not_ *Moderator*"
else
 return "شما مدیر گروه نمیباشید"
end
end

local lock_location = data[tostring(target)]["settings"]["lock_location"] 
if lock_location == "yes" then
if not lang then
 return "*Lock Location* _Is Already Enabled_"
elseif lang then
 return "قفل کردن موقعیت فعال است"
end
else
 data[tostring(target)]["settings"]["lock_location"] = "yes" 
save_data(_config.moderation.data, data)
if not lang then
 return "*Lock Location* _Has Been Enabled_"
else
 return "قفل کردن موقعیت فعال شد"
end
end
end

local function unlock_location(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
 if not is_mod(msg) then
if not lang then
return "_You're Not_ *Moderator*"
else
return "شما مدیر گروه نمیباشید"
end
end 

local lock_location = data[tostring(target)]["settings"]["lock_location"]
 if lock_location == "no" then
if not lang then
return "*Lock Location* _Is Already Disabled_" 
elseif lang then
return "قفل کردن موقعیت غیر فعال است"
end
else 
data[tostring(target)]["settings"]["lock_location"] = "no"
 save_data(_config.moderation.data, data) 
if not lang then
return "*Lock Location* _Has Been Disabled_" 
else
return "قفل کردن موقعیت غیر فعال شد"
end
end
end
---------------Lock Document-------------------
local function lock_document(msg, data, target) 
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
 return "_You're Not_ *Moderator*"
else
return "شما مدیر گروه نمیباشید"
end
end

local lock_document = data[tostring(target)]["settings"]["lock_document"] 
if lock_document == "yes" then
if not lang then
 return "*Lock Document* _Is Already Enabled_"
elseif lang then
 return "قفل کردن اسناد فعال لست"
end
else
 data[tostring(target)]["settings"]["lock_document"] = "yes" 
save_data(_config.moderation.data, data) 
if not lang then
 return "*Lock Document* _Has Been Enabled_"
else
 return "قفل کردن اسناد فعال شد"
end
end
end

local function unlock_document(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
 if not is_mod(msg) then
if not lang then
return "_You're Not_ *Moderator*"
else
return "شما مدیر گروه نمیباشید"
end
end 

local lock_document = data[tostring(target)]["settings"]["lock_document"]
 if lock_document == "no" then
if not lang then
return "*Lock Document* _Is Already Disabled_" 
elseif lang then
return "قفل کردن اسناد غیر فعال است"
end
else 
data[tostring(target)]["settings"]["lock_document"] = "no"
 save_data(_config.moderation.data, data) 
if not lang then
return "*Lock Document* _Has Been Disabled_" 
else
return "قفل کردن اسناد غیر فعال شد"
end
end
end
---------------Lock TgService-------------------
local function lock_tgservice(msg, data, target) 
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
 return "_You're Not_ *Moderator*"
else
 return "شما مدیر گروه نمیباشید"
end
end

local lock_tgservice = data[tostring(target)]["settings"]["lock_tgservice"] 
if lock_tgservice == "yes" then
if not lang then
 return "*Lock TgService* _Is Already Enabled_"
elseif lang then
 return "قفل کردن خدمات تلگرام فعال است"
end
else
 data[tostring(target)]["settings"]["lock_tgservice"] = "yes" 
save_data(_config.moderation.data, data) 
if not lang then
 return "*Lock TgService* _Has Been Enabled_"
else
return "قفل کردن خدمات تلگرام فعال شد"
end
end
end

local function unlock_tgservice(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
 if not is_mod(msg) then
if not lang then
return "_You're Not_ *Moderator*"
else
return "شما مدیر گروه نیستید"
end 
end

local lock_tgservice = data[tostring(target)]["settings"]["lock_tgservice"]
 if lock_tgservice == "no" then
if not lang then
return "*Lock TgService* _Is Already Disabled_"
elseif lang then
return "قفل کردن خدمات تلگرام غیر فعال است"
end 
else 
data[tostring(target)]["settings"]["lock_tgservice"] = "no"
 save_data(_config.moderation.data, data) 
if not lang then
return "*Lock TgService* _Has Been Disabled_"
else
return "قفل کردن خدمات تلگرام غیر فعال شد"
end 
end
end

---------------Lock Keyboard-------------------
local function lock_keyboard(msg, data, target) 
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
 return "_You're Not_ *Moderator*"
else
 return "شما مدیر گروه نمیباشید"
end
end

local lock_keyboard = data[tostring(target)]["settings"]["lock_keyboard"] 
if lock_keyboard == "yes" then
if not lang then
 return "*Lock Keyboard* _Is Already Enabled_"
elseif lang then
 return "قفل کردن صفحه کلید فعال است"
end
else
 data[tostring(target)]["settings"]["lock_keyboard"] = "yes" 
save_data(_config.moderation.data, data) 
if not lang then
 return "*Lock Keyboard* _Has Been Enabled_"
else
return "قفل کردن صفحه کلید فعال شد"
end
end
end

local function unlock_keyboard(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
 if not is_mod(msg) then
if not lang then
return "_You're Not_ *Moderator*"
else
return "شما مدیر گروه نیستید"
end 
end

local lock_keyboard = data[tostring(target)]["settings"]["lock_keyboard"]
 if lock_keyboard == "no" then
if not lang then
return "*Lock Keyboard* _Is Already Disabled_"
elseif lang then
return "قفل کردن صفحه کلید غیرفعال است"
end 
else 
data[tostring(target)]["settings"]["lock_keyboard"] = "no"
 save_data(_config.moderation.data, data) 
if not lang then
return "*Lock TgService* _Has Been Disabled_"
else
return "قفل کردن صفحه کلید غیرفعال شد"
end 
end
end

function group_settings(msg, target) 	
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
 return "_You're Not_ *Moderator*"
else
 return "شما مدیر گروه نمیباشید"
end
end
local data = load_data(_config.moderation.data)
local target = msg.to.id 
if data[tostring(target)] then 	
if data[tostring(target)]["settings"]["num_msg_max"] then 	
NUM_MSG_MAX = tonumber(data[tostring(target)]['settings']['num_msg_max'])
	print('custom'..NUM_MSG_MAX) 	
else 	
NUM_MSG_MAX = 5
end
end

if data[tostring(target)]["settings"] then		
if not data[tostring(target)]["settings"]["lock_link"] then			
data[tostring(target)]["settings"]["lock_link"] = "yes"		
end
end

if data[tostring(target)]["settings"] then		
if not data[tostring(target)]["settings"]["lock_tag"] then			
data[tostring(target)]["settings"]["lock_tag"] = "yes"		
end
end

if data[tostring(target)]["settings"] then		
if not data[tostring(target)]["settings"]["lock_mention"] then			
data[tostring(target)]["settings"]["lock_mention"] = "no"		
end
end

if data[tostring(target)]["settings"] then		
if not data[tostring(target)]["settings"]["lock_arabic"] then			
data[tostring(target)]["settings"]["lock_arabic"] = "no"		
end
end

if data[tostring(target)]["settings"] then		
if not data[tostring(target)]["settings"]["lock_edit"] then			
data[tostring(target)]["settings"]["lock_edit"] = "no"		
end
end

if data[tostring(target)]["settings"] then		
if not data[tostring(target)]["settings"]["lock_spam"] then			
data[tostring(target)]["settings"]["lock_spam"] = "yes"		
end
end

if data[tostring(target)]["settings"] then		
if not data[tostring(target)]["settings"]["lock_flood"] then			
data[tostring(target)]["settings"]["lock_flood"] = "yes"		
end
end

if data[tostring(target)]["settings"] then		
if not data[tostring(target)]["settings"]["lock_bots"] then			
data[tostring(target)]["settings"]["lock_bots"] = "yes"		
end
end

if data[tostring(target)]["settings"] then		
if not data[tostring(target)]["settings"]["lock_markdown"] then			
data[tostring(target)]["settings"]["lock_markdown"] = "no"		
end
end

if data[tostring(target)]["settings"] then		
if not data[tostring(target)]["settings"]["lock_webpage"] then			
data[tostring(target)]["settings"]["lock_webpage"] = "no"		
end
end

if data[tostring(target)]["settings"] then		
if not data[tostring(target)]["settings"]["english"] then			
data[tostring(target)]["settings"]["english"] = "yes"		
end
end

if data[tostring(target)]["settings"] then		
if not data[tostring(target)]["settings"]["views"] then			
data[tostring(target)]["settings"]["views"] = "yes"		
end
end

if data[tostring(target)]["settings"] then		
if not data[tostring(target)]["settings"]["ads"] then			
data[tostring(target)]["settings"]["ads"] = "no"		
end
end

if data[tostring(target)]["settings"] then		
if not data[tostring(target)]["settings"]["fosh"] then			
data[tostring(target)]["settings"]["fosh"] = "no"		
end
end

if data[tostring(target)]["settings"] then		
if not data[tostring(target)]["settings"]["welcome"] then			
data[tostring(target)]["settings"]["welcome"] = "no"		
end
end

 if data[tostring(target)]["settings"] then		
 if not data[tostring(target)]["settings"]["lock_pin"] then			
 data[tostring(target)]["settings"]["lock_pin"] = "no"		
 end
 end
 
 if data[tostring(target)]["settings"] then		
if not data[tostring(target)]["settings"]["lock_all"] then			
data[tostring(target)]["settings"]["lock_all"] = "no"		
end
end
if data[tostring(target)]["settings"] then		
if not data[tostring(target)]["settings"]["lock_gif"] then			
data[tostring(target)]["settings"]["lock_gif"] = "no"		
end
end
if data[tostring(target)]["settings"] then		
if not data[tostring(target)]["settings"]["lock_text"] then			
data[tostring(target)]["settings"]["lock_text"] = "no"		
end
end
if data[tostring(target)]["settings"] then		
if not data[tostring(target)]["settings"]["lock_photo"] then			
data[tostring(target)]["settings"]["lock_photo"] = "no"		
end
end
if data[tostring(target)]["settings"] then		
if not data[tostring(target)]["settings"]["lock_video"] then			
data[tostring(target)]["settings"]["lock_video"] = "no"		
end
end
if data[tostring(target)]["settings"] then		
if not data[tostring(target)]["settings"]["lock_audio"] then			
data[tostring(target)]["settings"]["lock_audio"] = "no"		
end
end
if data[tostring(target)]["settings"] then		
if not data[tostring(target)]["settings"]["lock_voice"] then			
data[tostring(target)]["settings"]["lock_voice"] = "no"		
end
end
if data[tostring(target)]["settings"] then		
if not data[tostring(target)]["settings"]["lock_sticker"] then			
data[tostring(target)]["settings"]["lock_sticker"] = "no"		
end
end
if data[tostring(target)]["settings"] then		
if not data[tostring(target)]["settings"]["lock_contact"] then			
data[tostring(target)]["settings"]["lock_contact"] = "no"		
end
end
if data[tostring(target)]["settings"] then		
if not data[tostring(target)]["settings"]["lock_forward"] then			
data[tostring(target)]["settings"]["lock_forward"] = "no"		
end
end
if data[tostring(target)]["settings"] then		
if not data[tostring(target)]["settings"]["lock_location"] then			
data[tostring(target)]["settings"]["lock_location"] = "no"		
end
end
if data[tostring(target)]["settings"] then		
if not data[tostring(target)]["settings"]["lock_document"] then			
data[tostring(target)]["settings"]["lock_document"] = "no"		
end
end
if data[tostring(target)]["settings"] then		
if not data[tostring(target)]["settings"]["lock_tgservice"] then			
data[tostring(target)]["settings"]["lock_tgservice"] = "no"		
end
end
if data[tostring(target)]["settings"] then		
if not data[tostring(target)]["settings"]["lock_inline"] then			
data[tostring(target)]["settings"]["lock_inline"] = "no"		
end
end
if data[tostring(target)]["settings"] then		
if not data[tostring(target)]["settings"]["lock_game"] then			
data[tostring(target)]["settings"]["lock_game"] = "no"		
end
end
if data[tostring(target)]["settings"] then		
if not data[tostring(target)]["settings"]["lock_keyboard"] then			
data[tostring(target)]["settings"]["lock_keyboard"] = "no"		
end
end
 
 local expire_date = ''
local expi = redis:ttl('ExpireDate:'..msg.to.id)
if expi == -1 then
if lang then
	expire_date = 'نامحدود!'
else
	expire_date = 'Unlimited!'
end
else
	local day = math.floor(expi / 86400) + 1
if lang then
	expire_date = day..' روز'
else
	expire_date = day..' Days'
end
end

if not lang then
local settings = data[tostring(target)]["settings"] 
local settings = data[tostring(target)]["settings"] 
 text = "🔰*Group Settings*🔰\n\n💠_Lock gif :_ *"..settings.lock_gif.."*\n💠_Lock file :_ *"..settings.lock_document.."*\n💠_Lock pin :_ *"..settings.lock_pin.."*\n💠_Lock ads :_ *"..settings.ads.."*\n💠_Lock edit :_ *"..settings.lock_edit.."*\n💠_Lock text :_ *"..settings.lock_text.."*\n💠_Lock font :_ *"..settings.lock_markdown.."*\n💠_Lock tags :_ *"..settings.lock_tag.."*\n💠_Lock bots :_ *"..settings.lock_bots.."*\n💠_Lock fosh :_ *"..settings.fosh.."*\n💠_Lock farsi :_ *"..settings.lock_arabic.."*\n💠_Lock links :_ *"..settings.lock_link.."*\n💠_Lock chat : _ *"..settings.lock_all.."*\n💠_Lock flood :_ *"..settings.flood.."*\n💠_Lock voice :_ *"..settings.lock_voice.."*\n💠_Lock inline :_ *"..settings.lock_inline.."*\n💠_Lock video :_ *"..settings.lock_video.."*\n💠_Lock audio :_ *"..settings.lock_audio.."*\n💠_Lock game :_ *"..settings.lock_game.."*\n💠_Lock views :_ *"..settings.views.."*\n💠_Lock spam :_ *"..settings.lock_spam.."*\n💠_Lock photo :_ *"..settings.lock_photo.."*\n💠_Lock sticker :_ *"..settings.lock_sticker.."*\n💠_Lock english :_ *"..settings.english.."*\n💠_Lock contact :_ *"..settings.lock_contact.."*\n💠_Lock forward :_ *"..settings.lock_forward.."*\n💠_Lock location :_ *"..settings.lock_location.."*\n💠_Lock mention :_ *"..settings.lock_mention.."*\n💠_Lock webpage :_ *"..settings.lock_webpage.."*\n💠_Lock Keyboard :_ *"..settings.lock_keyboard.."*\n💠_Lock TgService :_ *"..settings.lock_tgservice.."*\n💠_Flood sensitivity :_ *"..NUM_MSG_MAX.."*\n✋_Group welcome :_ *"..settings.welcome.."*\n*_________________________*\n⏱Expire Date : *"..expire_date.."*\n*Bot channel*: @TuringTeam\n*Group Language* : *EN*"
else
local settings = data[tostring(target)]["settings"] 
local settings = data[tostring(target)]["settings"] 
 text = "🔰*تنظیمات گروه*🔰\n\n💠_قفل تگ :_ *"..settings.lock_tag.."*\n💠_قفل ویو :_ *"..settings.views.."*\n💠_قفل متن :_ *"..settings.lock_text.."*\n💠_قفل چت :_ *"..settings.lock_all.."*\n💠_قفل بازی :_ *"..settings.lock_game.."*\n💠_قفل فایل :_ *"..settings.lock_document.."*\n💠_قفل ربات :_ *"..settings.lock_bots.."*\n💠_قفل لینک :_ *"..settings.lock_link.."*\n💠_قفل اسپم :_ *"..settings.lock_spam.."*\n💠_قفل مکان :_ *"..settings.lock_location.."*\n**\n💠_قفل اهنگ :_ *"..settings.lock_audio.."*\n💠_قفل ویس :_ *"..settings.lock_voice.."*\n💠_قفل کلیپ :_ *"..settings.lock_video.."*\n💠_قفل گیف  :_ *"..settings.lock_gif.."*\n💠_قفل عکس :_ *"..settings.lock_photo.."*\n💠_قفل فونت :_ *"..settings.lock_markdown.."*\n💠_قفل سایت :_ *"..settings.lock_webpage.."*\n💠_قفل فحش :_ *"..settings.fosh.."*\n💠_قفل فروارد :_ *"..settings.lock_forward.."*\n💠_قفل کیبورد :_ *"..settings.lock_keyboard.."*\n**\n💠_قفل فارسی :_ *"..settings.lock_arabic.."*\n💠_قفل استیکر :_ *"..settings.lock_sticker.."*\n💠_قفل سنجاق :_ *"..settings.lock_pin.."*\n💠_قفل تبلیغات :_ *"..settings.ads.."*\n💠_قفل ویرایش :_ *"..settings.lock_edit.."*\n💠_قفل مخاطب :_ *"..settings.lock_contact.."*\n💠_قفل انگلیسی :_ *"..settings.english.."*\n💠_قفل فراخوانی :_ *"..settings.lock_mention.."*\n💠_قفل حساسیت : _ *"..settings.flood.."*\n💠_قفل دکمه شیشه ای :_ *"..settings.lock_inline.."*\n💠_قفل سرویس تلگرام :_ *"..settings.lock_tgservice.."*\n💠_حساسیت اسپم :_ *"..NUM_MSG_MAX.."*\n✋️_پیام خوشامدگویی :_ *"..settings.welcome.."*\n*_________________________*\n⏱_تاریخ انقضا :_ *"..expire_date.."*\n*کانال ما*: @TuringTeam\n*زبان ربات* : *فارسی*\n"
end
if not lang then
text = string.gsub(text, "yes", "✅")
 text =  string.gsub(text, "no", "☑️")
 else
 text = string.gsub(text, "yes", "✅")
 text =  string.gsub(text, "no", "☑️")
 end
return text
end

local function run(msg, matches)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
local data = load_data(_config.moderation.data)
local chat = msg.to.id
local user = msg.from.id
if msg.to.type ~= 'pv' then
if matches[1] == "id" or matches[1] == "ایدی" then
if not matches[2] and not msg.reply_id then
local function getpro(arg, data)
   if data.photos_[0] then
       if not lang then
            tdcli.sendPhoto(msg.chat_id_, msg.id_, 0, 1, nil, data.photos_[0].sizes_[1].photo_.persistent_id_,'Chat ID : '..msg.to.id..'\nUser ID : '..msg.from.id,dl_cb,nil)
       elseif lang then
          tdcli.sendPhoto(msg.chat_id_, msg.id_, 0, 1, nil, data.photos_[0].sizes_[1].photo_.persistent_id_,'شناسه گروه : '..msg.to.id..'\nشناسه شما : '..msg.from.id,dl_cb,nil)
     end
   else
       if not lang then
      tdcli.sendMessage(msg.to.id, msg.id_, 1, "`You Have Not Profile Photo...!`\n\n> *Chat ID :* `"..msg.to.id.."`\n*User ID :* `"..msg.from.id.."`", 1, 'md')
       elseif lang then
      tdcli.sendMessage(msg.to.id, msg.id_, 1, "_شما هیچ عکسی ندارید...!_\n\n> _شناسه گروه :_ `"..msg.to.id.."`\n_شناسه شما :_ `"..msg.from.id.."`", 1, 'md')
            end
        end
   end
   tdcli_function ({
    ID = "GetUserProfilePhotos",
    user_id_ = msg.from.id,
    offset_ = 0,
    limit_ = 1
  }, getpro, nil)
end
if msg.reply_id and not matches[2] then
    tdcli_function ({
      ID = "GetMessage",
      chat_id_ = msg.to.id,
      message_id_ = msg.reply_id
    }, action_by_reply, {chat_id=msg.to.id,cmd="id"})
  end
if matches[2] then
   tdcli_function ({
      ID = "SearchPublicChat",
      username_ = matches[2]
    }, action_by_username, {chat_id=msg.to.id,username=matches[2],cmd="id"})
      end
   end
if matches[1] == "pin" and is_mod(msg) and msg.reply_id  or matches[1] == "سنجاق" and is_mod(msg) and msg.reply_id then
local lock_pin = data[tostring(msg.to.id)]["settings"]["lock_pin"] 
 if lock_pin == 'yes' then
if is_owner(msg) then
    data[tostring(chat)]['pin'] = msg.reply_id
	  save_data(_config.moderation.data, data)
tdcli.pinChannelMessage(msg.to.id, msg.reply_id, 1)
if not lang then
return "*Message Has Been Pinned*"
elseif lang then
return "پیام سجاق شد"
end
elseif not is_owner(msg) then
   return
 end
 elseif lock_pin == 'no' then
    data[tostring(chat)]['pin'] = msg.reply_id
	  save_data(_config.moderation.data, data)
tdcli.pinChannelMessage(msg.to.id, msg.reply_id, 1)
if not lang then
return "*Message Has Been Pinned*"
elseif lang then
return "پیام سجاق شد"
end
end
end
if matches[1] == 'unpin' and is_mod(msg) or matches[1] == 'حذف سنجاق' and is_mod(msg) then
local lock_pin = data[tostring(msg.to.id)]["settings"]["lock_pin"] 
 if lock_pin == 'yes' then
if is_owner(msg) then
tdcli.unpinChannelMessage(msg.to.id)
if not lang then
return "*Pin message has been unpinned*"
elseif lang then
return "پیام سنجاق شده پاک شد"
end
elseif not is_owner(msg) then
   return 
 end
 elseif lock_pin == 'no' then
tdcli.unpinChannelMessage(msg.to.id)
if not lang then
return "*Pin message has been unpinned*"
elseif lang then
return "پیام سنجاق شده پاک شد"
end
end
end
if matches[1] == "add" or  matches[1] == "نصب" then
return modadd(msg)
end
if matches[1] == "rem" or matches[1] == "لغو نصب" then
return modrem(msg)
end
if matches[1] == "setowner" and is_admin(msg) or  matches[1] == "تنظیم مالک" and is_admin(msg) then
if not matches[2] and msg.reply_id then
    tdcli_function ({
      ID = "GetMessage",
      chat_id_ = msg.to.id,
      message_id_ = msg.reply_id
    }, action_by_reply, {chat_id=msg.to.id,cmd="setowner"})
  end
  if matches[2] and string.match(matches[2], '^%d+$') then
tdcli_function ({
    ID = "GetUser",
    user_id_ = matches[2],
  }, action_by_id, {chat_id=msg.to.id,user_id=matches[2],cmd="setowner"})
    end
  if matches[2] and not string.match(matches[2], '^%d+$') then
   tdcli_function ({
      ID = "SearchPublicChat",
      username_ = matches[2]
    }, action_by_username, {chat_id=msg.to.id,username=matches[2],cmd="setowner"})
      end
   end
if matches[1] == "remowner" and is_admin(msg) or matches[1] == "حذف مالک" and is_admin(msg) then
if not matches[2] and msg.reply_id then
    tdcli_function ({
      ID = "GetMessage",
      chat_id_ = msg.to.id,
      message_id_ = msg.reply_id
    }, action_by_reply, {chat_id=msg.to.id,cmd="remowner"})
  end
  if matches[2] and string.match(matches[2], '^%d+$') then
tdcli_function ({
    ID = "GetUser",
    user_id_ = matches[2],
  }, action_by_id, {chat_id=msg.to.id,user_id=matches[2],cmd="remowner"})
    end
  if matches[2] and not string.match(matches[2], '^%d+$') then
   tdcli_function ({
      ID = "SearchPublicChat",
      username_ = matches[2]
    }, action_by_username, {chat_id=msg.to.id,username=matches[2],cmd="remowner"})
      end
   end
if matches[1] == "promote" and is_owner(msg) or matches[1] == "ترفیع مقام" and is_owner(msg) then
if not matches[2] and msg.reply_id then
    tdcli_function ({
      ID = "GetMessage",
      chat_id_ = msg.to.id,
      message_id_ = msg.reply_id
    }, action_by_reply, {chat_id=msg.to.id,cmd="promote"})
  end
  if matches[2] and string.match(matches[2], '^%d+$') then
tdcli_function ({
    ID = "GetUser",
    user_id_ = matches[2],
  }, action_by_id, {chat_id=msg.to.id,user_id=matches[2],cmd="promote"})
    end
  if matches[2] and not string.match(matches[2], '^%d+$') then
   tdcli_function ({
      ID = "SearchPublicChat",
      username_ = matches[2]
    }, action_by_username, {chat_id=msg.to.id,username=matches[2],cmd="promote"})
      end
   end
if matches[1] == "demote" and is_owner(msg) or  matches[1] == "تنزل مقام" and is_owner(msg) then
if not matches[2] and msg.reply_id then
 tdcli_function ({
      ID = "GetMessage",
      chat_id_ = msg.to.id,
      message_id_ = msg.reply_id
    }, action_by_reply, {chat_id=msg.to.id,cmd="demote"})
  end
  if matches[2] and string.match(matches[2], '^%d+$') then
tdcli_function ({
    ID = "GetUser",
    user_id_ = matches[2],
  }, action_by_id, {chat_id=msg.to.id,user_id=matches[2],cmd="demote"})
    end
  if matches[2] and not string.match(matches[2], '^%d+$') then
    tdcli_function ({
      ID = "SearchPublicChat",
      username_ = matches[2]
    }, action_by_username, {chat_id=msg.to.id,username=matches[2],cmd="demote"})
      end
   end

if matches[1] == "lock" and is_mod(msg) or  matches[1] == "قفل" and is_mod(msg) then
local target = msg.to.id
if matches[2] == "link" or matches[2]=="لینک" then
return lock_link(msg, data, target)
end
if matches[2] == "tag" or matches[2]=="تگ" then
return lock_tag(msg, data, target)
end
if matches[2] == "mention" or matches[2]=="فراخوانی" then
return lock_mention(msg, data, target)
end
if matches[2] == "farsi" or matches[2]=="فارسی" then
return lock_arabic(msg, data, target)
end
if matches[2] == "edit" or matches[2]=="ویرایش" then
return lock_edit(msg, data, target)
end
if matches[2] == "spam" or matches[2]=="اسپم" then
return lock_spam(msg, data, target)
end
if matches[2] == "flood" or matches[2]=="حساسیت" then
return lock_flood(msg, data, target)
end
if matches[2] == "bots" or matches[2]=="ربات" then
return lock_bots(msg, data, target)
end
if matches[2] == "font" or matches[2]=="فونت" then
return lock_markdown(msg, data, target)
end
if matches[2] == "webpage" or matches[2]=="سایت" then
return lock_webpage(msg, data, target)
end
if matches[2] == "pin" and is_owner(msg) or matches[2]=="سنجاق" and is_owner(msg) then
return lock_pin(msg, data, target)
end
if matches[2] == "english" or matches[2]=="انگلیسی"  then
return lock_english(msg, data, target)
end
if matches[2] == "views" or matches[2]=="ویو" then
return lock_views(msg, data, target)
end
if matches[2] == "fosh" or matches[2]=="فحش" then
return lock_fosh(msg, data, target)
end
if matches[2] == "ads" or matches[2]=="تبلیغات" then
return lock_ads(msg, data, target)
end
end

if matches[1] == "unlock" and is_mod(msg) or matches[1]=="بازکردن" and is_mod(msg) then
local target = msg.to.id
if matches[2] == "link" or matches[2]=="لینک" then
return unlock_link(msg, data, target)
end
if matches[2] == "tag" or matches[2]=="تگ" then
return unlock_tag(msg, data, target)
end
if matches[2] == "mention" or matches[2]=="فراخوانی" then
return unlock_mention(msg, data, target)
end
if matches[2] == "farsi" or matches[2]=="فارسی" then
return unlock_arabic(msg, data, target)
end
if matches[2] == "edit" or matches[2]=="ویرایش" then
return unlock_edit(msg, data, target)
end
if matches[2] == "spam" or matches[2]=="اسپم" then
return unlock_spam(msg, data, target)
end
if matches[2] == "flood" or matches[2]=="حساسیت" then
return unlock_flood(msg, data, target)
end
if matches[2] == "bots" or matches[2]=="ربات" then
return unlock_bots(msg, data, target)
end
if matches[2] == "font" or matches[2]=="فونت" then
return unlock_markdown(msg, data, target)
end
if matches[2] == "webpage" or matches[2]=="سایت" then
return unlock_webpage(msg, data, target)
end
if matches[2] == "pin" and is_owner(msg) or matches[2]=="سنجاق" and is_owner(msg) then
return unlock_pin(msg, data, target)
end
if matches[2] == "english" or matches[2]=="انگلیسی" then
return unlock_english(msg, data, target)
end
if matches[2] == "views" or matches[2]=="ویو" then
return unlock_views(msg, data, target)
end
if matches[2] == "fosh" or matches[2]=="فحش" then
return unlock_fosh(msg, data, target)
end
if matches[2] == "ads" or matches[2]=="تبلیغات" then
return unlock_ads(msg, data, target)
end
end

if matches[1] == "lock" and is_mod(msg) or matches[1]== "قفل" and is_mod(msg) then
local target = msg.to.id
if matches[2] == "chat" or matches[2]=="چت" then
return lock_all(msg, data, target)
end
if matches[2] == "gif" or matches[2]=="گیف" then
return lock_gif(msg, data, target)
end
if matches[2] == "text" or matches[2]=="متن" then
return lock_text(msg ,data, target)
end
if matches[2] == "photo" or matches[2]=="عکس" then
return lock_photo(msg ,data, target)
end
if matches[2] == "video" or matches[2]=="کلیپ" then
return lock_video(msg ,data, target)
end
if matches[2] == "audio" or matches[2]=="اهنگ" then
return lock_audio(msg ,data, target)
end
if matches[2] == "voice" or matches[2]=="ویس" then
return lock_voice(msg ,data, target)
end
if matches[2] == "sticker" or matches[2]=="استیکر" then
return lock_sticker(msg ,data, target)
end
if matches[2] == "contact" or matches[2]=="مخاطب" then
return lock_contact(msg ,data, target)
end
if matches[2] == "forward" or matches[2]=="فروارد" then
return lock_forward(msg ,data, target)
end
if matches[2] == "location" or matches[2]=="مکان" then
return lock_location(msg ,data, target)
end
if matches[2] == "file" or matches[2]=="فایل" then
return lock_document(msg ,data, target)
end
if matches[2] == "tgservice" or matches[2]=="سرویس تلگرام" then
return lock_tgservice(msg ,data, target)
end
if matches[2] == "inline" or matches[2]=="دکمه شیشه ای" then
return lock_inline(msg ,data, target)
end
if matches[2] == "game" or matches[2]=="بازی" then
return lock_game(msg ,data, target)
end
if matches[2] == "keyboard" or matches[2]=="کیبورد" then
return lock_keyboard(msg ,data, target)
end
end

if matches[1] == "unlock" and is_mod(msg) or matches[1]=="بازکردن" and is_mod(msg) then
local target = msg.to.id
if matches[2] == "chat" or matches[2]=="چت" then
return unlock_all(msg, data, target)
end
if matches[2] == "gif" or matches[2]=="گیف" then
return unlock_gif(msg, data, target)
end
if matches[2] == "text" or matches[2]=="متن" then
return unlock_text(msg, data, target)
end
if matches[2] == "photo" or matches[2]=="عکس" then
return unlock_photo(msg ,data, target)
end
if matches[2] == "video" or matches[2]=="کلیپ" then
return unlock_video(msg ,data, target)
end
if matches[2] == "audio" or matches[2]=="اهنگ" then
return unlock_audio(msg ,data, target)
end
if matches[2] == "voice" or matches[2]=="ویس" then
return unlock_voice(msg ,data, target)
end
if matches[2] == "sticker" or matches[2]=="استیکر" then
return unlock_sticker(msg ,data, target)
end
if matches[2] == "contact" or matches[2]=="مخاطب" then
return unlock_contact(msg ,data, target)
end
if matches[2] == "forward" or matches[2]=="فروارد" then
return unlock_forward(msg ,data, target)
end
if matches[2] == "location" or matches[2]=="مکان" then
return unlock_location(msg ,data, target)
end
if matches[2] == "file" or matches[2]=="فایل" then
return unlock_document(msg ,data, target)
end
if matches[2] == "tgservice" or matches[2]=="سرویس تلگرام" then
return unlock_tgservice(msg ,data, target)
end
if matches[2] == "inline" or matches[2]=="دکمه شیشه ای" then
return unlock_inline(msg ,data, target)
end
if matches[2] == "game" or matches[2]=="بازی" then
return unlock_game(msg ,data, target)
end
if matches[2] == "keyboard" or matches[2]=="کیبورد" then
return unlock_keyboard(msg ,data, target)
end
end
if matches[1] == "gpinfo" and is_mod(msg) and msg.to.type == "channel" or matches[1] == "اطلاعات گروه" and is_mod(msg) and msg.to.type == "channel" then
local function group_info(arg, data)
local hash = "gp_lang:"..arg.chat_id
local lang = redis:get(hash)
if not lang then
ginfo = "*Group Info :*\n_Admin Count :_ *"..data.administrator_count_.."*\n_Member Count :_ *"..data.member_count_.."*\n_Kicked Count :_ *"..data.kicked_count_.."*\n_Group ID :_ *"..data.channel_.id_.."*"
print(serpent.block(data))
elseif lang then
ginfo = "*اطلاعات گروه :*\n_تعداد مدیران :_ *"..data.administrator_count_.."*\n_تعداد اعضا :_ *"..data.member_count_.."*\n_تعداد اعضای حذف شده :_ *"..data.kicked_count_.."*\n_شناسه گروه :_ *"..data.channel_.id_.."*"
print(serpent.block(data))
end
        tdcli.sendMessage(arg.chat_id, arg.msg_id, 1, ginfo, 1, 'md')
end
 tdcli.getChannelFull(msg.to.id, group_info, {chat_id=msg.to.id,msg_id=msg.id})
end
if matches[1] == 'newlink' and is_mod(msg) or  matches[1] == 'لینک جدید' and is_mod(msg) then
			local function callback_link (arg, data)
   local hash = "gp_lang:"..msg.to.id
   local lang = redis:get(hash)
    local administration = load_data(_config.moderation.data) 
				if not data.invite_link_ then
					administration[tostring(msg.to.id)]['settings']['linkgp'] = nil
					save_data(_config.moderation.data, administration)
       if not lang then
       return tdcli.sendMessage(msg.to.id, msg.id, 1, "_Bot is not group creator_\n_set a link for group with using_ /setlink", 1, 'md')
       elseif lang then
       return tdcli.sendMessage(msg.to.id, msg.id, 1, "_ربات سازنده گروه نیست_\n_با دستور_ setlink/ _لینک جدیدی برای گروه ثبت کنید_", 1, 'md')
    end
				else
					administration[tostring(msg.to.id)]['settings']['linkgp'] = data.invite_link_
					save_data(_config.moderation.data, administration)
        if not lang then
       return tdcli.sendMessage(msg.to.id, msg.id, 1, "*Newlink Created*", 1, 'md')
        elseif lang then
       return tdcli.sendMessage(msg.to.id, msg.id, 1, "_لینک جدید ساخته شد_", 1, 'md')
            end
				end
			end
 tdcli.exportChatInviteLink(msg.to.id, callback_link, nil)
		end
		if matches[1] == 'setlink' and is_owner(msg) or matches[1] == 'تنظیم لینک' and is_owner(msg) then
			data[tostring(chat)]['settings']['linkgp'] = 'waiting'
			save_data(_config.moderation.data, data)
      if not lang then
			return '_Please send the new group_ *link* _now_'
    else 
         return 'لطفا لینک گروه خود را ارسال کنید'
       end
		end

		if msg.text then
   local is_link = msg.text:match("^([https?://w]*.?telegram.me/joinchat/%S+)$") or msg.text:match("^([https?://w]*.?t.me/joinchat/%S+)$")
			if is_link and data[tostring(chat)]['settings']['linkgp'] == 'waiting' and is_owner(msg) then
				data[tostring(chat)]['settings']['linkgp'] = msg.text
				save_data(_config.moderation.data, data)
            if not lang then
				return "*Newlink* _has been set_"
           else
           return "لینک جدید ذخیره شد"
		 	end
       end
		end
    if matches[1] == 'link' and is_mod(msg) or  matches[1] == 'لینک' and is_mod(msg) then
      local linkgp = data[tostring(chat)]['settings']['linkgp']
      if not linkgp then
      if not lang then
        return "_First create a link for group with using_ /newlink\n_If bot not group creator set a link with using_ /setlink"
     else
        return "ابتدا با دستور newlink/ لینک جدیدی برای گروه بسازید\nو اگر ربات سازنده گروه نیس با دستور setlink/ لینک جدیدی برای گروه ثبت کنید"
      end
      end
     if not lang then
       text = "<b>Group Link :</b>\n"..linkgp
     else
      text = "<b>لینک گروه :</b>\n"..linkgp
         end
        return tdcli.sendMessage(chat, msg.id, 1, text, 1, 'html')
     end
    if matches[1] == 'linkpv' and is_mod(msg) or matches[1] == 'لینک پیوی' and is_mod(msg) then
      local linkgp = data[tostring(chat)]['settings']['linkgp']
      if not linkgp then
      if not lang then
        return "_First create a link for group with using_ /newlink\n_If bot not group creator set a link with using_ /setlink"
     else
        return "ابتدا با دستور newlink/ لینک جدیدی برای گروه بسازید\nو اگر ربات سازنده گروه نیس با دستور setlink/ لینک جدیدی برای گروه ثبت کنید"
      end
      end
     if not lang then
     tdcli.sendMessage(user, "", 1, "<b>Group Link "..msg.to.title.." :</b>\n"..linkgp, 1, 'html')
     else
      tdcli.sendMessage(user, "", 1, "<b>لینک گروه "..msg.to.title.." :</b>\n"..linkgp, 1, 'html')
         end
      if not lang then
        return "*Group Link Was Send In Your Private Message*"
       else
        return "_لینک گروه به چت خصوصی شما ارسال شد_"
        end
     end
  if matches[1] == "setrules" and matches[2] and is_mod(msg) or matches[1] == "تنظیم قانون" and matches[2] and is_mod(msg) then
    data[tostring(chat)]['rules'] = matches[2]
	  save_data(_config.moderation.data, data)
     if not lang then
    return "*Group rules* _has been set_"
   else 
  return "قوانین گروه ثبت شد"
   end
  end
  if matches[1] == "rules" or matches[1] == "قانون" then
 if not data[tostring(chat)]['rules'] then
   if not lang then
     rules = "ℹ️ The Default Rules :\n1⃣ No Flood.\n2⃣ No Spam.\n3⃣ No Advertising.\n4⃣ Try to stay on topic.\n5⃣ Forbidden any racist, sexual, homophobic or gore content.\n➡️ Repeated failure to comply with these rules will cause ban.\n@TuringTeam"
    elseif lang then
       rules = "ℹ️ قوانین پپیشفرض:\n1⃣ ارسال پیام مکرر ممنوع.\n2⃣ اسپم ممنوع.\n3⃣ تبلیغ ممنوع.\n4⃣ سعی کنید از موضوع خارج نشید.\n5⃣ هرنوع نژاد پرستی, شاخ بازی و پورنوگرافی ممنوع .\n➡️ از قوانین پیروی کنید, در صورت عدم رعایت قوانین اول اخطار و در صورت تکرار مسدود.\n@TuringTeam"
 end
        else
     rules = "*Group Rules :*\n"..data[tostring(chat)]['rules']
      end
    return rules
  end
if matches[1] == "res" and matches[2] and is_mod(msg) or matches[1] == "رس" and matches[2] and is_mod(msg) then
    tdcli_function ({
      ID = "SearchPublicChat",
      username_ = matches[2]
    }, action_by_username, {chat_id=msg.to.id,username=matches[2],cmd="res"})
  end
if matches[1] == "whois" and matches[2] and is_mod(msg) or matches[1] == "هویس" and matches[2] and is_mod(msg) then
tdcli_function ({
    ID = "GetUser",
    user_id_ = matches[2],
  }, action_by_id, {chat_id=msg.to.id,user_id=matches[2],cmd="whois"})
  end
  if matches[1] == 'setflood' and is_mod(msg) or matches[1] == 'حساسیت اسپم' and is_mod(msg) then
			if tonumber(matches[2]) < 1 or tonumber(matches[2]) > 200 then
				if not lang then
				return "_Wrong number, range is_ *[1-200]*"
				else
				return "عدد اشتباه است محدوده مجاز *[1-200]*"
      end
	  end
			local flood_max = matches[2]
			data[tostring(chat)]['settings']['num_msg_max'] = flood_max
			save_data(_config.moderation.data, data)
			if not lang then
    return "_Group_ *flood* _sensitivity has been set to :_ *[ "..matches[2].." ]*"
	else
	return "حساسیت نسبت به پیام های مکرر تنظیم شد به : *[ "..matches[2].." ]*"
       end
	   end
		if matches[1]:lower() == 'clean' and is_owner(msg) or matches[1]:lower() == 'پاکسازی' and is_owner(msg) then
			if matches[2] == 'mods' or  matches[2] == 'مدیران' then
				if next(data[tostring(chat)]['mods']) == nil then
            if not lang then
					return "_No_ *moderators* _in this group_"
             else
                return "هیچ مدیری برای گروه انتخاب نشده است"
				end
            end
				for k,v in pairs(data[tostring(chat)]['mods']) do
					data[tostring(chat)]['mods'][tostring(k)] = nil
					save_data(_config.moderation.data, data)
				end
            if not lang then
				return "_All_ *moderators* _has been demoted_"
          else
            return "تمام مدیران گروه تنزیل مقام شدند"
			end
         end
			if matches[2] == 'filterlist' or matches[2] == 'لیست فیلتر' then
				if next(data[tostring(chat)]['filterlist']) == nil then
     if not lang then
					return "*Filtered words list* _is empty_"
         else
					return "_لیست کلمات فیلتر شده خالی است_"
             end
				end
				for k,v in pairs(data[tostring(chat)]['filterlist']) do
					data[tostring(chat)]['filterlist'][tostring(k)] = nil
					save_data(_config.moderation.data, data)
				end
       if not lang then
				return "*Filtered words list* _has been cleaned_"
           else
				return "_لیست کلمات فیلتر شده پاک شد_"
           end
			end
			if matches[2] == 'rules' or matches[2] == 'قانون' then
				if not data[tostring(chat)]['rules'] then
            if not lang then
					return "_No_ *rules* _available_"
             else
               return "قوانین برای گروه ثبت نشده است"
             end
				end
					data[tostring(chat)]['rules'] = nil
					save_data(_config.moderation.data, data)
             if not lang then
				return "*Group rules* _has been cleaned_"
          else
            return "قوانین گروه پاک شد"
			end
       end
			if matches[2] == 'welcome' or matches[2] == 'خوشامدگویی' then
				if not data[tostring(chat)]['setwelcome'] then
            if not lang then
					return "*Welcome Message not set*"
             else
               return "پیام خوشآمد گویی ثبت نشده است"
             end
				end
					data[tostring(chat)]['setwelcome'] = nil
					save_data(_config.moderation.data, data)
             if not lang then
				return "*Welcome message* _has been cleaned_"
          else
            return "پیام خوشآمد گویی پاک شد"
			end
       end
			if matches[2] == 'about'  or matches[2] == 'درباره گروه' then
        if msg.to.type == "chat" then
				if not data[tostring(chat)]['about'] then
            if not lang then
					return "_No_ *description* _available_"
            else
              return "پیامی مبنی بر درباره گروه ثبت نشده است"
          end
				end
					data[tostring(chat)]['about'] = nil
					save_data(_config.moderation.data, data)
        elseif msg.to.type == "channel" then
   tdcli.changeChannelAbout(chat, "", dl_cb, nil)
             end
             if not lang then
				return "*Group description* _has been cleaned_"
           else
              return "پیام مبنی بر درباره گروه پاک شد"
             end
		   	end
        end
		if matches[1]:lower() == 'clean' and is_admin(msg) or matches[1]:lower() == 'پاکسازی' and is_admin(msg) then
			if matches[2] == 'owners' or matches[2] == 'مالکان' then
				if next(data[tostring(chat)]['owners']) == nil then
             if not lang then
					return "_No_ *owners* _in this group_"
            else
                return "مالکی برای گروه انتخاب نشده است"
            end
				end
				for k,v in pairs(data[tostring(chat)]['owners']) do
					data[tostring(chat)]['owners'][tostring(k)] = nil
					save_data(_config.moderation.data, data)
				end
            if not lang then
				return "_All_ *owners* _has been demoted_"
           else
            return "تمامی مالکان گروه تنزیل مقام شدند"
          end
			end
     end
if matches[1] == "setname" and matches[2] and is_mod(msg) or matches[1] == "تنظیم نام" and matches[2] and is_mod(msg) then
local gp_name = matches[2]
tdcli.changeChatTitle(chat, gp_name, dl_cb, nil)
end
  if matches[1] == "setabout" and matches[2] and is_mod(msg) or  matches[1] == "تنظیم درباره گروه" and matches[2] and is_mod(msg) then
     if msg.to.type == "channel" then
   tdcli.changeChannelAbout(chat, matches[2], dl_cb, nil)
    elseif msg.to.type == "chat" then
    data[tostring(chat)]['about'] = matches[2]
	  save_data(_config.moderation.data, data)
     end
     if not lang then
    return "*Group description* _has been set_"
    else
     return "پیام مبنی بر درباره گروه ثبت شد"
      end
  end
  if matches[1] == "about" and msg.to.type == "chat" or matches[1] == "درباره گروه" and msg.to.type == "chat" then
 if not data[tostring(chat)]['about'] then
     if not lang then
     about = "_No_ *description* _available_"
      elseif lang then
      about = "پیامی مبنی بر درباره گروه ثبت نشده است"
       end
        else
     about = "*Group Description :*\n"..data[tostring(chat)]['about']
      end
    return about
  end
  if matches[1] == 'filter' and is_mod(msg) or matches[1] == 'فیلتر' and is_mod(msg) then
    return filter_word(msg, matches[2])
  end
  if matches[1] == 'unfilter' and is_mod(msg) or matches[1] == 'حذف فیلتر' and is_mod(msg) then
    return unfilter_word(msg, matches[2])
  end
  if matches[1] == 'filterlist' and is_mod(msg) or  matches[1] == 'لیست فیلتر' and is_mod(msg) then
    return filter_list(msg)
  end
if matches[1] == "settings" or matches[1] == "تنظیمات" then
return group_settings(msg, target)
end
if matches[1] == "modlist" or matches[1] == "لیست مدیران" then
return modlist(msg)
end
if matches[1] == "ownerlist" and is_owner(msg) or  matches[1] == "لیست مالکان" and is_owner(msg)  then
return ownerlist(msg)
end

if matches[1] == "setlang" and is_owner(msg) or matches[1] == "تنظیم زبان" and is_owner(msg) then
   if matches[2] == "en" or matches[2] == "انگلیسی" then
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
 redis:del(hash)
return "_Group Language Set To:_ EN"
  elseif matches[2] == "fa" or matches[2] == "فارسی" then
redis:set(hash, true)
return "*زبان گروه تنظیم شد به : فارسی*"
end
end

if matches[1] == "help" and is_mod(msg) then
if not lang then
text = [[
*!add*
🔹نصب ربات در گروه

*!rem*
🔹حذف گروه از دیتابیس ربات

*!setowner* `[username|id|reply]` 
انتخاب مالک گروه(قابل انتخاب چند مالک)

*!remowner* `[username|id|reply]` 
🔹حذف کردن فرد از فهرست مالکان گروه

*!promote* `[username|id|reply]` 
🔹ارتقا مقام کاربر به مدیر گروه

*!demote* `[username|id|reply]` 
🔹تنزیل مقام مدیر به کاربر

*!setflood* `[2-200]`
🔹تنظیم حداکثر تعداد پیام مکرر

*!silent* `[username|id|reply]` 
🔹عدم توانایی چت کردن کاربر در گروه

*!unsilent* `[username|id|reply]` 
🔹به دست آوردن توانایی چت کردن شخص در گروه

*!kick* `[username|id|reply]` 
🔹حذف کاربر از گروه

*!ban* `[username|id|reply]` 
🔹مسدود کردن کاربر از گروه

*!unban* `[username|id|reply]` 
🔹در آوردن از حالت مسدودیت کاربر از گروه

*!banall* `[username|id|reply]`
🔹مسدود کردن کاربر از گروه و تمام گروه های ربات

*!unbanall* `[username|id|reply]`
🔹ازاد کردن کاربر از گروه و تمام گروه های ربات

*!lock* `[link | tag | edit | arabic | webpage | view | ads | english | fosh | bots | spam | flood | font | mention | pin | gif | photo | file | sticker | keyboard | tgservice | inline | game | video | text | forward | location | audio | voice | contact | chat]`
🔹در صورت قفل بودن فعالیت ها, ربات آنهارا حذف خواهد کرد

*!unlock* `[link | tag | edit | arabic | webpage | view | ads | english | fosh | bots | spam | flood | font | mention | pin | gif | photo | file | sticker | keyboard | tgservice | inline | game | video | text | forward | location | audio | voice | contact | chat]`
🔹در صورت قفل نبودن فعالیت ها, ربات آنهارا حذف نخواهد کرد

*!set*`[rules | name | link | about | welcome]`
🔹ربات آنهارا ثبت خواهد کرد

*!clean* `[bans | gbans | mods | owners | rules | about | silentlist | filterlist | welcome]`   
🔹ربات آنهارا پاک خواهد کرد

*!filter* `[word]`
🔹فیلتر‌کلمه مورد نظر

*!unfilter* `[word]`
🔹ازاد کردن کلمه مورد نظر

*!pin* `[reply]`
🔹ربات پیام شمارا در گروه سنجاق خواهد کرد

*!unpin* 
🔹ربات پیام سنجاق شده در گروه را حذف خواهد کرد

*!welcome enable/disable*
🔹فعال یا غیرفعال کردن خوشآمد گویی

*!settings*
🔹نمایش تنظیمات گروه


*!silentlist*
🔹نمایش فهرست افرادی که در حالت عدم توانایی چت قرار دارند

*!filterlist*
🔹نمایش لیست کلمات فیلتر شده

*!banlist*
🔹نمایش افراد مسدود شده از گروه

*!gbanlist*
🔹نمایش افراد مسدود شده از گروه و گروه های ربات

*!ownerlist*
🔹نمایش فهرست مالکان گروه 

*!modlist* 
🔹نمایش فهرست مدیران گروه

*!rules*
🔹نمایش قوانین گروه

*!about*
🔹نمایش درباره گروه

*!id*
🔹نمایش شناسه شما و گروه

*!res* `[username]`
🔹نمایش شناسه کاربر

*!id* `[reply]`
🔹نمایش شناسه کاربر

*!whois* `[id]`
🔹نمایش نام کاربر, نام کاربری و اطلاعات حساب

*!gpinfo*
🔹نمایش اطلاعات گروه

*!newlink*
🔹ساخت لینک جدید

*!link*
🔹نمایش لینک گروه

*!linkpv*
🔹ارسال لینک گروه به چت خصوصی شما

*!setwelcome [text]*
🔹ثبت پیام خوشامدگویی

*!del* `[1-1000]`
🔹پاک کردن تعداد پیام اخیر سورپر گروه

*!setlang* `[fa | en]`
🔹تنظیم زبان ربات

*closehelp*
🔹نمایش دستورات مربوط به تعطیل کردن گروه

*ربات / رباط*
🔹نمایش آنلاین بودن ربات

🔹*شما میتوانید از [!/#] در اول دستورات برای اجرای آنها بهره بگیرید*

🔹*این راهنما فقط برای مدیران/مالکان گروه میباشد!*

🔹*این به این معناست که فقط مدیران/مالکان گروه میتوانند از دستورات بالا استفاده کنند!*

*موفق باشید .*]]

elseif lang then

text = [[
*نصب*
🔹نصب ربات در گروه

*لغو نصب*
🔹حذف گروه از دیتابیس ربات

*تنظیم مالک [یوزرنیم - ایدی - ریپلای]*
🔹انتخاب مدیر گروه(قابل انتخاب چند مالک)

*حذف مالک [یوزرنیم - ایدی - ریپلای]*
🔹حذف کردن فرد از فهرست مدیران گروه

*ترفيع مقام [يوزرنيم - ايدي - ريپلاي]*
🔹ارتقا مقام کاربر به معاون گروه

*تنزل مقام [يوزرنيم - ايدي - ريپلاي]*
🔹تنزیل مقام مدیر به کاربر

*حساسیت اسپم [2-200]*
🔹تنظیم حداکثر تعداد پیام مکرر

*سکوت [يوزرنيم - ايدي - ريپلاي]*
🔹عدم توانایی چت کردن کاربر در گروه

*لغو سکوت [يوزرنيم - ايدي - ريپلاي]*
🔹به دست آوردن توانایی چت کردن شخص در گروه

*اخراج [یوزرنیم - ایدی - ریپلای]*
🔹حذف کاربر از گروه

*مسدود [یوزرنیم - ایدی - ریپلای]*
🔹مسدود کردن کاربر از گروه

*ازاد [یوزرنیم - ایدی - ریپلای]*
🔹در آوردن از حالت مسدودیت کاربر از گروه

*مسدود کلی [یوزرنیم - ایدی - ریپلای]*
🔹مسدود کردن کاربر از گروه و تمام گروه های ربات

*ازاد کلی [یوزرنیم - ایدی - ریپلای]*
🔹ازاد کردن کاربر از گروه و تمام گروه های ربات

*قفل [لینک - تگ - ویرایش - فارسی - انگلیسی - ویو - فحش - تلبیغات - سایت - فونت - ربات - اسپم - حساسیت - فراخوانی - سنجاق - گیف - عکس - فایل - استیکر - بازی - کیبورد - دکمه شیشه ای - کلیپ - متن - سرویس تلگرام - فروارد - مکان - اهنگ - ویس - مخاطب - چت]*
🔹در صورت قفل بودن فعالیت ها, ربات آنهارا حذف خواهد کرد

*بازکردن [لینک - تگ - ویرایش - فارسی - انگلیسی - ویو - فحش - تلبیغات - سایت - فونت - ربات - اسپم - حساسیت - فراخوانی - سنجاق - گیف - عکس - فایل - استیکر - بازی - کیبورد - دکمه شیشه ای - کلیپ - متن - سرویس تلگرام - فروارد - مکان - اهنگ - ویس - مخاطب - چت]*
🔹در صورت قفل نبودن فعالیت ها, ربات آنهارا حذف نخواهد کرد

*تنظیم [قانون - لینک - درباره گروه - نام - خوشامدگویی]*
🔹ربات آنهارا ثبت خواهد کرد

*پاکسازی [مسدودها - مسدود کلی  - مالکان - مدیران - قانون - درباره گروه - لیست سکوت - لیست فیلتر - خوشامدگویی]*
🔹ربات آنهارا پاک خواهد کرد

*فیلتر [کلمه]*
🔹فیلتر‌کلمه مورد نظر

*حذف فیلتر [کلمه]*
🔹ازاد کردن کلمه مورد نظر

*سنجاق [ریپلای]*
🔹ربات پیام شمارا در گروه سنجاق خواهد کرد

*حذف سنجاق*
🔹ربات پیام سنجاق شده در گروه را حذف خواهد کرد

*خوشامدگویی [روشن - خاموش]*
🔹فعال یا غیرفعال کردن خوشآمد گویی

*تنظیمات*
🔹نمایش تنظیمات گروه

*لیست سکوت*
🔹نمایش فهرست افرادی که در حالت عدم توانایی چت قرار دارند

*لیست فیلتر*
🔹نمایش لیست کلمات فیلتر شده

*لیست مسدودها*
🔹نمایش افراد مسدود شده از گروه

*لیست مسدود کلی*
🔹نمایش افراد مسدود شده از گروه و گروه های ربات

*لیست مالکان*
🔹نمایش فهرست مالکان گروه

*لیست مدیران*
🔹نمایش فهرست مدیران گروه

*قانون*
🔹نمایش قوانین گروه

*درباره گروه*
🔹نمایش درباره گروه

*ایدی*
نمایش شناسه شما و گروه

*ایدی [ریپلای]*
🔹نمایش شناسه کاربر

*رس [یوزرنیم]*
🔹نمایش شناسه کاربر

*هویس [ایدی]*
🔹نمایش نام کاربر, نام کاربری و اطلاعات حساب

*اطلاعات گروه*
🔹نمایش اطلاعات گروه

*لینک جدید*
🔹ساخت لینک جدید

*لینک*
🔹نمایش لینک گروه

*لینک پیوی*
ارسال لینک گروه به چت خصوصی شما

*تنظیم خوشامدگویی [متن]*
🔹ثبت پیام خوش آمد گویی

*پاک کردن  [1-1000]*
🔹پاک کردن تعداد پیام اخیر سورپر گروه

*پاک کردن [ریپلای]*
🔹پاک کردن تمام پیام های فرد در گروه

*تنظیم زبان [فارسی - انگلیسی]*
🔹تنظیم زبان ربات

*راهنمای تعطیل*
🔹نمایش دستورات مربوط به تعطیل کردن گروه

*ربات / رباط*
🔹نمایش آنلاین بودن ربات

🔹*این راهنما فقط برای مدیران/مالکان گروه میباشد!*

🔹*این به این معناست که فقط مدیران/مالکان گروه میتوانند از دستورات بالا استفاده کنند!*
]]
end
return text
end
if matches[1] == "راهنما" and is_mod(msg) then
text = [[
*نصب*
🔹نصب ربات در گروه

*لغو نصب*
🔹حذف گروه از دیتابیس ربات

*تنظیم مالک [یوزرنیم - ایدی - ریپلای]*
🔹انتخاب مدیر گروه(قابل انتخاب چند مالک)

*حذف مالک [یوزرنیم - ایدی - ریپلای]*
🔹حذف کردن فرد از فهرست مدیران گروه

*ترفيع مقام [يوزرنيم - ايدي - ريپلاي]*
🔹ارتقا مقام کاربر به معاون گروه

*تنزل مقام [يوزرنيم - ايدي - ريپلاي]*
🔹تنزیل مقام مدیر به کاربر

*حساسیت اسپم [2-200]*
🔹تنظیم حداکثر تعداد پیام مکرر

*سکوت [يوزرنيم - ايدي - ريپلاي]*
🔹عدم توانایی چت کردن کاربر در گروه

*لغو سکوت [يوزرنيم - ايدي - ريپلاي]*
🔹به دست آوردن توانایی چت کردن شخص در گروه

*اخراج [یوزرنیم - ایدی - ریپلای]*
🔹حذف کاربر از گروه

*مسدود [یوزرنیم - ایدی - ریپلای]*
🔹مسدود کردن کاربر از گروه

*ازاد [یوزرنیم - ایدی - ریپلای]*
🔹در آوردن از حالت مسدودیت کاربر از گروه

*مسدود کلی [یوزرنیم - ایدی - ریپلای]*
🔹مسدود کردن کاربر از گروه و تمام گروه های ربات

*ازاد کلی [یوزرنیم - ایدی - ریپلای]*
🔹ازاد کردن کاربر از گروه و تمام گروه های ربات

*قفل [لینک - تگ - ویرایش - فارسی - انگلیسی - ویو - فحش - تلبیغات - سایت - فونت - ربات - اسپم - حساسیت - فراخوانی - سنجاق - گیف - عکس - فایل - استیکر - بازی - کیبورد - دکمه شیشه ای - کلیپ - متن - سرویس تلگرام - فروارد - مکان - اهنگ - ویس - مخاطب - چت]*
🔹در صورت قفل بودن فعالیت ها, ربات آنهارا حذف خواهد کرد

*بازکردن [لینک - تگ - ویرایش - فارسی - انگلیسی - ویو - فحش - تلبیغات - سایت - فونت - ربات - اسپم - حساسیت - فراخوانی - سنجاق - گیف - عکس - فایل - استیکر - بازی - کیبورد - دکمه شیشه ای - کلیپ - متن - سرویس تلگرام - فروارد - مکان - اهنگ - ویس - مخاطب - چت]*
🔹در صورت قفل نبودن فعالیت ها, ربات آنهارا حذف نخواهد کرد

*تنظیم [قانون - لینک - درباره گروه - نام - خوشامدگویی]*
🔹ربات آنهارا ثبت خواهد کرد

*پاکسازی [مسدودها - مسدود کلی  - مالکان - مدیران - قانون - درباره گروه - لیست سکوت - لیست فیلتر - خوشامدگویی]*
🔹ربات آنهارا پاک خواهد کرد

*فیلتر [کلمه]*
🔹فیلتر‌کلمه مورد نظر

*حذف فیلتر [کلمه]*
🔹ازاد کردن کلمه مورد نظر

*سنجاق [ریپلای]*
🔹ربات پیام شمارا در گروه سنجاق خواهد کرد

*حذف سنجاق*
🔹ربات پیام سنجاق شده در گروه را حذف خواهد کرد

*خوشامدگویی [روشن - خاموش]*
🔹فعال یا غیرفعال کردن خوشآمد گویی

*تنظیمات*
🔹نمایش تنظیمات گروه

*لیست سکوت*
🔹نمایش فهرست افرادی که در حالت عدم توانایی چت قرار دارند

*لیست فیلتر*
🔹نمایش لیست کلمات فیلتر شده

*لیست مسدودها*
🔹نمایش افراد مسدود شده از گروه

*لیست مسدود کلی*
🔹نمایش افراد مسدود شده از گروه و گروه های ربات

*لیست مالکان*
🔹نمایش فهرست مالکان گروه

*لیست مدیران*
🔹نمایش فهرست مدیران گروه

*قانون*
🔹نمایش قوانین گروه

*درباره گروه*
🔹نمایش درباره گروه

*ایدی*
نمایش شناسه شما و گروه

*ایدی [ریپلای]*
🔹نمایش شناسه کاربر

*رس [یوزرنیم]*
🔹نمایش شناسه کاربر

*هویس [ایدی]*
🔹نمایش نام کاربر, نام کاربری و اطلاعات حساب

*اطلاعات گروه*
🔹نمایش اطلاعات گروه

*لینک جدید*
🔹ساخت لینک جدید

*لینک*
🔹نمایش لینک گروه

*لینک پیوی*
ارسال لینک گروه به چت خصوصی شما

*تنظیم خوشامدگویی [متن]*
🔹ثبت پیام خوش آمد گویی

*پاک کردن  [1-1000]*
🔹پاک کردن تعداد پیام اخیر سورپر گروه

*پاک کردن [ریپلای]*
🔹پاک کردن تمام پیام های فرد در گروه

*تنظیم زبان [فارسی - انگلیسی]*
🔹تنظیم زبان ربات

*راهنمای تعطیل*
🔹نمایش دستورات مربوط به تعطیل کردن گروه

*ربات / رباط*
🔹نمایش آنلاین بودن ربات

🔹*این راهنما فقط برای مدیران/مالکان گروه میباشد!*

🔹*این به این معناست که فقط مدیران/مالکان گروه میتوانند از دستورات بالا استفاده کنند!*
]]
return text
end

--------------------- Welcome -----------------------
	if matches[1] == "welcome" and is_mod(msg) or matches[1] == "خوشامدگویی" and is_mod(msg) then
		if matches[2] == "enable" or matches[2] == "روشن" then
			welcome = data[tostring(chat)]['settings']['welcome']
			if welcome == "yes" then
       if not lang then
				return "_Group_ *welcome* _is already enabled_"
       elseif lang then
				return "_خوشآمد گویی از قبل فعال بود_"
           end
			else
		data[tostring(chat)]['settings']['welcome'] = "yes"
	    save_data(_config.moderation.data, data)
       if not lang then
				return "_Group_ *welcome* _has been enabled_"
       elseif lang then
				return "_خوشآمد گویی فعال شد_"
          end
			end
		end
		
		if matches[2] == "disable" or matches[2] == "خاموش" then
			welcome = data[tostring(chat)]['settings']['welcome']
			if welcome == "no" then
      if not lang then
				return "_Group_ *Welcome* _is already disabled_"
      elseif lang then
				return "_خوشآمد گویی از قبل فعال نبود_"
         end
			else
		data[tostring(chat)]['settings']['welcome'] = "no"
	    save_data(_config.moderation.data, data)
      if not lang then
				return "_Group_ *welcome* _has been disabled_"
      elseif lang then
				return "_خوشآمد گویی غیرفعال شد_"
          end
			end
		end
	end
	if matches[1] == "setwelcome" and matches[2] and is_mod(msg) or matches[1] == "تنظیم خوشامدگویی" and matches[2] and is_mod(msg) then
		data[tostring(chat)]['setwelcome'] = matches[2]
	    save_data(_config.moderation.data, data)
       if not lang then
		return "_Welcome Message Has Been Set To :_\n*"..matches[2].."*\n\n*You can use :*\n_{gpname} Group Name_\n_{rules} ➣ Show Group Rules_\n_{name} ➣ New Member First Name_\n_{username} ➣ New Member Username_"
       else
		return "_پیام خوشآمد گویی تنظیم شد به :_\n*"..matches[2].."*\n\n*شما میتوانید از*\n_{gpname} نام گروه_\n_{rules} ➣ نمایش قوانین گروه_\n_{name} ➣ نام کاربر جدید_\n_{username} ➣ نام کاربری کاربر جدید_\n_استفاده کنید_"
        end
     end
	end
end
-----------------------------------------
local function pre_process(msg)
   local chat = msg.to.id
   local user = msg.from.id
 local data = load_data(_config.moderation.data)
	local function welcome_cb(arg, data)
local hash = "gp_lang:"..arg.chat_id
local lang = redis:get(hash)
		administration = load_data(_config.moderation.data)
    if administration[arg.chat_id]['setwelcome'] then
     welcome = administration[arg.chat_id]['setwelcome']
      else
     if not lang then
     welcome = "*Welcome Dude*"
    elseif lang then
     welcome = "_خوش آمدید_"
        end
     end
 if administration[tostring(arg.chat_id)]['rules'] then
rules = administration[arg.chat_id]['rules']
else
   if not lang then
     rules = "ℹ️ The Default Rules :\n1⃣ No Flood.\n2⃣ No Spam.\n3⃣ No Advertising.\n4⃣ Try to stay on topic.\n5⃣ Forbidden any racist, sexual, homophobic or gore content.\n➡️ Repeated failure to comply with these rules will cause ban.\n@TuringTeam"
    elseif lang then
       rules = "ℹ️ قوانین پپیشفرض:\n1⃣ ارسال پیام مکرر ممنوع.\n2⃣ اسپم ممنوع.\n3⃣ تبلیغ ممنوع.\n4⃣ سعی کنید از موضوع خارج نشید.\n5⃣ هرنوع نژاد پرستی, شاخ بازی و پورنوگرافی ممنوع .\n➡️ از قوانین پیروی کنید, در صورت عدم رعایت قوانین اول اخطار و در صورت تکرار مسدود.\n@TuringTeam"
 end
end
if data.username_ then
user_name = "@"..check_markdown(data.username_)
else
user_name = ""
end
		local welcome = welcome:gsub("{rules}", rules)
		local welcome = welcome:gsub("{name}", check_markdown(data.first_name_))
		local welcome = welcome:gsub("{username}", user_name)
		local welcome = welcome:gsub("{gpname}", arg.gp_name)
		tdcli.sendMessage(arg.chat_id, arg.msg_id, 0, welcome, 0, "md")
	end
	if data[tostring(chat)] and data[tostring(chat)]['settings'] then
	if msg.adduser then
		welcome = data[tostring(msg.to.id)]['settings']['welcome']
		if welcome == "yes" then
			tdcli_function ({
	      ID = "GetUser",
      	user_id_ = msg.adduser
    	}, welcome_cb, {chat_id=chat,msg_id=msg.id,gp_name=msg.to.title})
		else
			return false
		end
	end
	if msg.joinuser then
		welcome = data[tostring(msg.to.id)]['settings']['welcome']
		if welcome == "yes" then
			tdcli_function ({
	      ID = "GetUser",
      	user_id_ = msg.joinuser
    	}, welcome_cb, {chat_id=chat,msg_id=msg.id,gp_name=msg.to.title})
		else
			return false
        end
		end
	end
	-- return msg
 end
return {
patterns ={
"^[!/#](id)$",
"^(ایدی)$",
"^[!/#](id) (.*)$",
"^(ایدی) (.*)$",
"^[!/#](pin)$",
"^(سنجاق)$",
"^[!/#](unpin)$",
"^(حذف سنجاق)$",
"^[!/#](gpinfo)$",
"^(اطلاعات گروه)$",
"^[!/#](test)$",
"^[!/#](add)$",
"^(نصب)$",
"^[!/#](rem)$",
"^(لغو نصب)$",
"^[!/#](setowner)$",
"^(تنظیم مالک)$",
"^[!/#](setowner) (.*)$",
"^(تنظیم مالک) (.*)$",
"^[!/#](remowner)$",
"^(حذف مالک)$",
"^[!/#](remowner) (.*)$",
"^(حذف مالک) (.*)$",
"^[!/#](promote)$",
"^(ترفیع مقام)$",
"^[!/#](promote) (.*)$",
"^(ترفیع مقام) (.*)$",
"^[!/#](demote)$",
"^(تنزل مقام)$",
"^[!/#](demote) (.*)$",
"^(تنزل مقام) (.*)$",
"^[!/#](modlist)$",
"^(لیست مدیران)$",
"^[!/#](ownerlist)$",
"^(لیست مالکان)$",
"^[!/#](lock) (.*)$",
"^(قفل) (.*)$",
"^[!/#](unlock) (.*)$",
"^(بازکردن) (.*)$",
"^[!/#](settings)$",
"^(تنظیمات)$",
"^[!/#](lock) (.*)$",
"^(قفل) (.*)$",
"^[!/#](unlock) (.*)$",
"^[!/#](link)$",
"^(لینک)$",
"^[!/#](linkpv)$",
"^(لینک پیوی)$",
"^[!/#](setlink)$",
"^(تنظیم لینک)$",
"^[!/#](newlink)$",
"^(لینک جدید)$",
"^[!/#](rules)$",
"^(قانون)$",
"^[!/#](setrules) (.*)$",
"^(تنظیم قانون) (.*)$",
"^[!/#](about)$",
"^(درباره گروه)$",
"^[!/#](setabout) (.*)$",
"^(تنظیم درباره گروه) (.*)$",
"^[!/#](setname) (.*)$",
"^(تنظیم نام) (.*)$",
"^[!/#](clean) (.*)$",
"^(پاکسازی) (.*)$",
"^[!/#](setflood) (%d+)$",
"^(حساسیت اسپم) (%d+)$",
"^[!/#](res) (.*)$",
"^(رس) (.*)$",
"^[!/#](whois) (%d+)$",
"^(هویس) (%d+)$",
"^[!/#](help)$",
"^(راهنما)$",
"^[!/#](setlang) (.*)$",
"^(تنظیم زبان) (.*)$",
"^[#!/](filter) (.*)$",
"^(فیلتر) (.*)$",
"^[#!/](unfilter) (.*)$",
"^(حذف فیلتر) (.*)$",
"^[#!/](filterlist)$",
"^(لیست فیلتر)$",
"^([https?://w]*.?t.me/joinchat/%S+)$",
"^([https?://w]*.?telegram.me/joinchat/%S+)$",
"^[!/#](setwelcome) (.*)",
"^(تنظیم خوشامدگویی) (.*)",
"^[!/#](welcome) (.*)$",
"^(خوشامدگویی) (.*)$"

},
run=run,
pre_process = pre_process
}
