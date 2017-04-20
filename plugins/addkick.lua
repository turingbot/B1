local function run(msg, matches)
    if matches[1] == 'addban' and is_mod(msg) or matches[1] == 'ÏÚæÊ ÇÎÑÇÌí åÇ' and is_mod(msg) then
        if gp_type(msg.to.id) == "channel" then
            tdcli.getChannelMembers(msg.to.id, 0, "Kicked", 200, function (i, naji)
                for k,v in pairs(naji.members_) do
                    tdcli.addChatMember(i.chat_id, v.user_id_, 50, dl_cb, nil)
                end
            end, {chat_id=msg.to.id})
            return "`ÇÚÖÇí ãÍÑæã ÇÒ Ñæå Èå Ñæå ÏÚæÊ ÔÏäÏ?`"
        end
        return "_?? İŞØ ÏÑ _`ÓæÑ Ñæå`_ ãã˜ä ÇÓÊ_"
    end
end

return { 
patterns = { 
"^[!/#](addkick)$", 
"^(ÏÚæÊ ÇÎÑÇÌí åÇ)$"
}, 
run = run 
}