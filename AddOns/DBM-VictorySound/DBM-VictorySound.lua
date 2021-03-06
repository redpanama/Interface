local L = DBM_VictorySound_Translations

local default_settings = {
    enabled = true,
	wipeSound = true,
    victorySound = true,
    startSound = true,
    wipePath = 'defeat.mp3',
    victoryPath = 'victory.mp3',
    startPath = 'start.mp3',
    musicDisable = true,
    masterSound = true,
}


local wipeSoundList = {
    'defeat.mp3',
    'PIRdefeat.mp3',
    'SMB3defeat.mp3',
    'SMWdefeat.mp3',
    'KCdefeat.mp3',
}

local victorySoundList = {
    'victory.mp3',
    'SMB3victory.mp3',
    'SMBvictory.mp3',
    'SMRPGvictory.mp3',
    'FFvictory.mp3',
    'FFvictoryclassic.mp3',
    'FFvictorylong.mp3',
}

local startSoundList = {
    'start.mp3',
    'SMB3start.mp3',
    'SMWstart.mp3',
    'SMRPGstart.mp3',
    'WCstart.mp3',
    'SMRidleyStart.mp3',
    'FFstart.mp3',
    'FFXstart.mp3',
}


DBM_VictorySound_Settings = {}
local settings = default_settings

local vs_startMusicPlaying = false;

--local settings = DBM_VictorySound_Options
local mainframe = CreateFrame("Frame", L.VictorySound_Options, UIParent)

local addDefaultOptions

local function playVS(method, test)
    if settings.enabled or test then
        if method == "start" then
            if vsMusicSetting == nil then
                vsMusicSetting = GetCVar("Sound_EnableMusic")
            end
            if settings.startSound then
                if settings.musicDisable == true then
                    SetCVar("Sound_EnableMusic",1)
                end
                PlayMusic("Interface\\AddOns\\DBM-VictorySound\\sounds\\" .. settings.startPath);
            end
        elseif method == "wipe" then
            StopMusic()
            if settings.musicDisable == true then
                SetCVar("Sound_EnableMusic",vsMusicSetting)
            end 
            vsMusicSetting = nil
            if settings.wipeSound == true then
                if settings.masterSound == true then
                    PlaySoundFile("Interface\\AddOns\\DBM-VictorySound\\sounds\\" .. settings.wipePath, "Master");
                else
                    PlaySoundFile("Interface\\AddOns\\DBM-VictorySound\\sounds\\" .. settings.wipePath);
                end
            end
        elseif method == "victory" then
            StopMusic()
            if settings.musicDisable == true then
                SetCVar("Sound_EnableMusic",vsMusicSettings)
            end
            vsMusicSetting = nil
            if settings.victorySound == true then
                if settings.masterSound == true then
                    PlaySoundFile("Interface\\AddOns\\DBM-VictorySound\\sounds\\" .. settings.victoryPath, "Master");
                else
                    PlaySoundFile("Interface\\AddOns\\DBM-VictorySound\\sounds\\" .. settings.victoryPath);
                end
            end
        elseif method == "stop" then
            StopMusic()
            if settings.musicDisable == true then
                SetCVar("Sound_EnableMusic",vsMusicSettings)
            end
            vsMusicSetting = nil
        end
    end
end
    

-- Ripped from DBM-Core.
-- checks if a given value is in an array
-- returns true if it finds the value, false otherwise
local function checkEntry(t, val)
	for i, v in ipairs(t) do
		if v == val then
			return true
		end
	end
	return false
end

local function toboolean(var) 
    if var then return true else return false end
end

local function createpanel()
    panel = DBM_GUI:CreateNewPanel(L.VictorySoundTab, "option")
        do
			local area = panel:CreateArea(L.AreaEnable, nil, 50, true)
			local enabled = area:CreateCheckButton(L.Activate, true)
            
            local area2 = panel:CreateArea(L.AreaGeneral, nil, 310, true)
            local wipeSound = area2:CreateCheckButton(L.VictorySound_Wipe, true)
            local victorySound = area2:CreateCheckButton(L.VictorySound_Victory, true)
            local masterSound = area2:CreateCheckButton(L.MasterSound, true)
            local startSound = area2:CreateCheckButton(L.VictorySound_Start, true)
            local musicDisable = area2:CreateCheckButton(L.VictorySound_DisableMusic, true)
            local startWarning = area2:CreateText(L.StartWarning, 350, true, nil, "left")
            startWarning:SetPoint("TOPLEFT", area2.frame, "TOPLEFT", 20, -140)
            
			enabled:SetScript("OnClick", 		    function(self) settings.enabled = toboolean(self:GetChecked()) end)
			enabled:SetScript("OnShow", 		    function(self) self:SetChecked(settings.enabled) end)
           
            wipeSound:SetScript("OnClick", 		    function(self) settings.wipeSound = toboolean(self:GetChecked()) end)
			wipeSound:SetScript("OnShow", 		    function(self) self:SetChecked(settings.wipeSound) end)
            victorySound:SetScript("OnClick", 		function(self) settings.victorySound = toboolean(self:GetChecked()) end)
			victorySound:SetScript("OnShow", 		function(self) self:SetChecked(settings.victorySound) end)
            masterSound:SetScript("OnClick", 		function(self) settings.masterSound = toboolean(self:GetChecked()) end)
			masterSound:SetScript("OnShow", 		function(self) self:SetChecked(settings.masterSound) end)
            startSound:SetScript("OnClick", 		function(self) settings.startSound = toboolean(self:GetChecked()) end)
			startSound:SetScript("OnShow", 		function(self) self:SetChecked(settings.startSound) end)
            musicDisable:SetScript("OnClick", 		function(self) settings.musicDisable = toboolean(self:GetChecked()) end)
			musicDisable:SetScript("OnShow", 		function(self) self:SetChecked(settings.musicDisable) end)
            
            local resettool = area:CreateButton(L.Button_ResetSettings, 100, 16)
			resettool:SetPoint('BOTTOMRIGHT', area.frame, "TOPRIGHT", 0, 0)
			resettool:SetNormalFontObject(GameFontNormalSmall)
			resettool:SetHighlightFontObject(GameFontNormalSmall)
			resettool:SetScript("OnClick", function(self) 
				table.wipe(DBM_VictorySound_Settings)
				addDefaultOptions(settings, default_settings)

				DBM_GUI_OptionsFrame:Hide()
				DBM_GUI_OptionsFrame:Show()				
			end)
		end
        
    fileOptionsPanel = panel:CreateNewPanel(L.FileOptionsSubtab, "option")
        do
            local wipePathBox = -30
            local victoryPathBox = -140
            local startPathBox = -250
            
            local area3 = fileOptionsPanel:CreateArea(L.AreaPaths, nil, nil, true)
            local wipePath = area3:CreateEditBox(L.WipePath, settings.wipePath, 200)
            wipePath:SetPoint("TOPLEFT", area3.frame, "TOPLEFT", 27, wipePathBox)
            local victoryPath = area3:CreateEditBox(L.VictoryPath, settings.victoryPath, 200)
            victoryPath:SetPoint('TOPLEFT', area3.frame, "TOPLEFT", 27, victoryPathBox)
            local startPath = area3:CreateEditBox(L.StartPath, settings.startPath, 200)
            startPath:SetPoint('TOPLEFT', area3.frame, "TOPLEFT", 27, startPathBox)
            local wipePlay = area3:CreateButton(L.Button_Play, 100, 20)
			wipePlay:SetPoint('TOPLEFT', area3.frame, "TOPLEFT", 250, wipePathBox)
            local victoryPlay = area3:CreateButton(L.Button_Play, 100, 20)
			victoryPlay:SetPoint('TOPLEFT', area3.frame, "TOPLEFT", 250, victoryPathBox)
            local startPlay = area3:CreateButton(L.Button_Play, 100, 20)
            local startPlayStop = area3:CreateButton(L.Button_Stop, 100, 20)
			startPlay:SetPoint('TOPLEFT', area3.frame, "TOPLEFT", 250, startPathBox)
			startPlayStop:SetPoint('TOPLEFT', area3.frame, "TOPLEFT", 250, startPathBox-30)

            
            wipeSoundListDropdown = { }
            for i=1, getn(wipeSoundList), 1 do
				table.insert(wipeSoundListDropdown, { text=wipeSoundList[i],value=i })
			end
            local wipeList = area3:CreateDropdown(L.WipeSoundList, wipeSoundListDropdown, settings.wipePath, function(value) settings.wipePath = wipeSoundList[value] wipePath:SetText(wipeSoundList[value])  end, 200)
			wipeList:SetScript("OnShow", function(self) 
                table.wipe(wipeSoundListDropdown)
                for i=1, getn(wipeSoundList), 1 do
                    table.insert(wipeSoundListDropdown, { text=wipeSoundList[i],value=i })
                end
			end)
			wipeList:SetPoint("TOPLEFT", area3.frame, "TOPLEFT", 0, wipePathBox-40)
            
            victorySoundListDropdown = { }
            for i=1, getn(victorySoundList), 1 do
				table.insert(victorySoundListDropdown, { text=victorySoundList[i],value=i })
			end
            local victoryList = area3:CreateDropdown(L.VictorySoundList, victorySoundListDropdown, settings.victoryPath, function(value) settings.victoryPath = victorySoundList[value] victoryPath:SetText(victorySoundList[value])  end, 200)
			victoryList:SetScript("OnShow", function(self) 
                table.wipe(victorySoundListDropdown)
                for i=1, getn(victorySoundList), 1 do
                    table.insert(victorySoundListDropdown, { text=victorySoundList[i],value=i })
                end
			end)
			victoryList:SetPoint("TOPLEFT", area3.frame, "TOPLEFT", 0, victoryPathBox-40)
            
            startSoundListDropdown = { }
            for i=1, getn(startSoundList), 1 do
				table.insert(startSoundListDropdown, { text=startSoundList[i],value=i })
			end
            local startList = area3:CreateDropdown(L.StartSoundList, startSoundListDropdown, settings.startPath, function(value) settings.startPath = startSoundList[value] startPath:SetText(startSoundList[value])  end, 200)
			startList:SetScript("OnShow", function(self) 
                table.wipe(startSoundListDropdown)
                for i=1, getn(startSoundList), 1 do
                    table.insert(startSoundListDropdown, { text=startSoundList[i],value=i })
                end
			end)
			startList:SetPoint("TOPLEFT", area3.frame, "TOPLEFT", 0, startPathBox-40)
	
           
            wipePath:SetScript("OnTextChanged", 	function(self) settings.wipePath = self:GetText() end)
			wipePath:SetScript("OnShow", 		    function(self) self:SetText(settings.wipePath) end)
            victoryPath:SetScript("OnTextChanged", 	function(self) settings.victoryPath = self:GetText() end)
			victoryPath:SetScript("OnShow", 		function(self) self:SetText(settings.victoryPath) end)
 
            startPath:SetScript("OnTextChanged", 	function(self) settings.startPath = self:GetText() end)
			startPath:SetScript("OnShow", 		function(self) self:SetText(settings.startPath) end)
            
            wipePlay:SetScript("OnClick",           function(self) playVS("wipe", true) end)
            victoryPlay:SetScript("OnClick",        function(self) playVS("victory", true) end)
            startPlay:SetScript("OnClick",        function(self) playVS("start", true) end)
            startPlayStop:SetScript("OnClick",        function(self) playVS("stop", true); end)
      
            local resettool = area3:CreateButton(L.Button_ResetSettings, 100, 16)
			resettool:SetPoint('BOTTOMRIGHT', area3.frame, "TOPRIGHT", 0, 0)
			resettool:SetNormalFontObject(GameFontNormalSmall)
			resettool:SetHighlightFontObject(GameFontNormalSmall)
			resettool:SetScript("OnClick", function(self) 
				table.wipe(DBM_VictorySound_Settings)
				addDefaultOptions(settings, default_settings)

				DBM_GUI_OptionsFrame:Hide()
				DBM_GUI_OptionsFrame:Show()				
			end)

       end
end

DBM:RegisterOnGuiLoadCallback(createpanel, 25)

local function addDefaultOptions(t1, t2)
	for i, v in pairs(t2) do
		if t1[i] == nil then
			t1[i] = v
		elseif type(v) == "table" then
			addDefaultOptions(v, t2[i])
		end
	end
end

do
    mainframe:SetScript("OnEvent", function(self, event, ...)
        if event == "ADDON_LOADED" and select(1, ...) == "DBM-VictorySound" then
            -- Update settings of this Addon
            settings = DBM_VictorySound_Settings
            addDefaultOptions(settings, default_settings)
        end
    end)
        
    -- lets register the Events
    mainframe:RegisterEvent("ADDON_LOADED")
end

function DBM:VS_StartCombat(mod, delay, synced)
    -- Plays on start
    if vs_startMusicPlaying == false then
        playVS("start", false)
        vs_startMusicPlaying = true;
    end
    DBM:SavedStartCombat(mod, delay, synced);
end

DBM.SavedStartCombat = DBM.StartCombat;
DBM.StartCombat = DBM.VS_StartCombat;

function DBM:VS_EndCombat(mod, wipe)
    StopMusic()
    vs_startMusicPlaying = false;
    if wipe then
        -- Plays on wipe
        playVS("wipe", false)
    elseif not wipe then
        -- Plays on boss kill
        playVS("victory", false)
    end
    DBM:SavedEndCombat(mod, wipe);
end

DBM.SavedEndCombat = DBM.EndCombat;
DBM.EndCombat = DBM.VS_EndCombat;