--[[ Borlox 2010-10-14T11:41:07Z 029e918 ]]--
local CCopy = LibStub("AceAddon-3.0"):NewAddon("CCopy", "AceHook-3.0")

---------------------------------------------------------------------
---- Configuration

-- This string is displayed before saved chat lines
local MARKER = '*'

-- Show the time instead of the marker above
local SHOW_TIME = false

-- Format string for the time (see http://www.opengroup.org/onlinepubs/007908799/xsh/strftime.html)
local TIME_FMT = "[%H:%M:%S]"

-- Include the marke in the quoted line
local INCLUDE_MARKER = false

---- You should not touch anything beyond this line...
---------------------------------------------------------------------

local link_msg = "|HCCopy|h%s|h %s"
local link_regex = "|HCCopy|h(.-)|h "

local ChatFrame1EditBox = ChatFrame1EditBox

-- These rules are ordered, so the higher ones
-- may not interfer with the lower ones
-- e.g "raid target" and "any icon" rules
local ClearRules = {
	{
		["|H.-|h(.-)|h"] = "%1", -- remove links
		["|c%x%x%x%x%x%x%x%x(.-)|r"] = "%1", -- remove any colors
		["|TInterface\\TargetingFrame\\UI%-RaidTargetingIcon_(%d):0|t"] = "{rt%1}",	 -- raid target
	},
	{
		["|T.-|t"] = "<icon>", -- any icon
	},
	{
		["|"] = "||", -- any missing |
	},
}

function CCopy:OnEnable()
	self:RawHook("ChatFrame_OnHyperlinkShow", true)
	local _G = _G
	for i=1, NUM_CHAT_WINDOWS do
		self:RawHook(_G["ChatFrame"..i], "AddMessage", true)
	end
end

function CCopy:ClearMessage(msg)
	if not INCLUDE_MARKER then
		msg = msg:gsub(link_regex, "")
	end
	for i, ruleset in ipairs(ClearRules) do
		for rule, text in pairs(ruleset) do
			msg = msg:gsub(rule, text)
		end
	end
	
	return msg
end

function CCopy:ShowMessage(msg)
	msg = self:ClearMessage(msg)
	
	ChatFrame1EditBox:SetText(ChatFrame1EditBox:GetText() .. msg)
	if not ChatFrame1EditBox:IsShown() then
		ChatFrame1EditBox:Show()
		ChatFrame1EditBox:HighlightText()
		ChatFrame1EditBox:SetFocus()
	end
end

function CCopy:AddMessage(chatFrame, msg, ...)
	msg = link_msg:format(SHOW_TIME and date(TIME_FMT) or MARKER, msg or "")
	self.hooks[chatFrame].AddMessage(chatFrame, msg, ...)
end

function CCopy:ChatFrame_OnHyperlinkShow(chatframe, link, text, button)
	if link:sub(1, 5) == "CCopy" then
		local frame = GetMouseFocus()
		
		if not frame:IsObjectType("HyperLinkButton") then
			return
		end
		
		local fontString = select(2, frame:GetPoint(1))
		
		if not fontString:IsObjectType("FontString") then
			return
		end

		self:ShowMessage(fontString:GetText())
	else
		return self.hooks.ChatFrame_OnHyperlinkShow(chatframe, link, text, button)
	end
end


