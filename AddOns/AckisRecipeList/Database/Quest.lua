--[[
************************************************************************
Quest.lua
************************************************************************
File date: 2014-06-01T11:02:34Z
File hash: 6925a97
Project hash: 5b35dab
Project version: 3.0.5
************************************************************************
Please see http://www.wowace.com/addons/arl/ for more information.
************************************************************************
This source code is released under All Rights Reserved.
************************************************************************
]]--

-----------------------------------------------------------------------
-- Upvalued Lua API.
-----------------------------------------------------------------------
local _G = getfenv(0)

-----------------------------------------------------------------------
-- AddOn namespace.
-----------------------------------------------------------------------
local FOLDER_NAME, private	= ...

local LibStub = _G.LibStub
local addon	= LibStub("AceAddon-3.0"):GetAddon(private.addon_name)

-----------------------------------------------------------------------
-- Imports
-----------------------------------------------------------------------
local Z = private.ZONE_NAMES

-----------------------------------------------------------------------
-- Memoizing table for quest names.
-----------------------------------------------------------------------
private.quest_names = _G.setmetatable({}, {
	__index = function(t, id_num)
		_G.GameTooltip:SetOwner(_G.UIParent, _G.ANCHOR_NONE)
		_G.GameTooltip:SetHyperlink(("quest:%s"):format(_G.tostring(id_num)))

		local quest_name = _G["GameTooltipTextLeft1"]:GetText()
		_G.GameTooltip:Hide()

		if not quest_name then
			return _G.UNKNOWN
		end
		t[id_num] = quest_name
		return quest_name
	end,
})

function addon:InitQuest()
	local function AddQuest(quest_id, zone_name, coord_x, coord_y, faction)
		private.AcquireTypes.Quest:AddEntity(quest_id, nil, zone_name, coord_x, coord_y, faction)
	end

	AddQuest(8323,	Z.SILITHUS,			67.1,	69.7,	"Neutral") -- Blacksmithing, Tailoring

	self.InitQuest = nil
end
