local _, T = ...
local L = T.L

local cfgFrame = CreateFrame("Frame", "RelicConfigFrame", UIParent)
cfgFrame:SetSize(500, 550)
cfgFrame:SetPoint("CENTER")

local cfgBg = cfgFrame:CreateTexture(nil, "BACKGROUND")
cfgBg:SetAllPoints()
cfgBg:SetTexture("Interface\\FrameGeneral\\UI-Background-Marble")
cfgBg:SetVertexColor(0.2, 0.2, 0.2, 1)

local cfgFrameHeader = cfgFrame:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
	cfgFrameHeader:SetPoint("TOPLEFT", 15, -15)

local cfgShowHelpTooltip = CreateFrame("CheckButton", nil, cfgFrame, "InterfaceOptionsCheckButtonTemplate")
	cfgShowHelpTooltip:SetPoint("TOPLEFT", 20, -45)

local cfgUnbindInCombat = CreateFrame("CheckButton", nil, cfgFrame, "InterfaceOptionsCheckButtonTemplate")
	cfgUnbindInCombat:SetPoint("TOPLEFT", 20, -70)

local cfgEnableHotkeys = CreateFrame("CheckButton", nil, cfgFrame, "InterfaceOptionsCheckButtonTemplate")
	cfgEnableHotkeys:SetPoint("TOPLEFT", 20, -95)

-- Section Annonces
local cfgAnnounceHeader = cfgFrame:CreateFontString(nil, "OVERLAY", "GameFontNormalMed3")
	cfgAnnounceHeader:SetPoint("TOPLEFT", 15, -135)
	cfgAnnounceHeader:SetText("Annonces")

local cfgAnnounceEnabled = CreateFrame("CheckButton", nil, cfgFrame, "InterfaceOptionsCheckButtonTemplate")
	cfgAnnounceEnabled:SetPoint("TOPLEFT", 20, -160)

local cfgAnnounceGroupOnly = CreateFrame("CheckButton", nil, cfgFrame, "InterfaceOptionsCheckButtonTemplate")
	cfgAnnounceGroupOnly:SetPoint("TOPLEFT", 20, -185)

local cfgAnnounceDelayLabel = cfgFrame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
	cfgAnnounceDelayLabel:SetPoint("TOPLEFT", 40, -215)
	cfgAnnounceDelayLabel:SetText("Délai :")

local cfgAnnounceDelayValue = cfgFrame:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
	cfgAnnounceDelayValue:SetPoint("TOPLEFT", 80, -238)
	cfgAnnounceDelayValue:SetText("1s")

local cfgAnnounceDelayMinus = CreateFrame("Button", nil, cfgFrame, "UIPanelButtonTemplate")
	cfgAnnounceDelayMinus:SetSize(35, 22)
	cfgAnnounceDelayMinus:SetPoint("TOPLEFT", 40, -235)
	cfgAnnounceDelayMinus:SetText("-")
	cfgAnnounceDelayMinus:SetScript("OnClick", function()
		Relic_AnnounceDelay = math.max(0.5, (Relic_AnnounceDelay or 1) - 0.5)
		cfgAnnounceDelayValue:SetText(string.format("%.1fs", Relic_AnnounceDelay))
	end)

local cfgAnnounceDelayPlus = CreateFrame("Button", nil, cfgFrame, "UIPanelButtonTemplate")
	cfgAnnounceDelayPlus:SetSize(35, 22)
	cfgAnnounceDelayPlus:SetPoint("TOPLEFT", 115, -235)
	cfgAnnounceDelayPlus:SetText("+")
	cfgAnnounceDelayPlus:SetScript("OnClick", function()
		Relic_AnnounceDelay = math.min(10, (Relic_AnnounceDelay or 1) + 0.5)
		cfgAnnounceDelayValue:SetText(string.format("%.1fs", Relic_AnnounceDelay))
	end)

local Relic_SpawnKeyset do
	local function Relic_KeysetDisarm(btn)
		GameTooltip:Hide()
		btn:UnlockHighlight()
		btn:SetScript("OnKeyDown", nil)
		btn:EnableKeyboard(false)
		btn:GetParent().keysetActive = nil
	end
	local function Relic_KeysetListen(self, arg1)
	  if not (arg1:match("^[LR]?ALT$") or arg1:match("^[LR]?CTRL$") or arg1:match("^[LR]?SHIFT$")) then
		  local prefix = (IsAltKeyDown() and "ALT-" or "") ..  (IsControlKeyDown() and "CTRL-" or "") .. (IsShiftKeyDown() and "SHIFT-" or "")
			self:SetText(prefix .. arg1)
			Relic_KeysetDisarm(self)
		end
	end
	local function Relic_KeysetClick(self)
		local oldKeySet = self:GetParent().keysetActive
		if oldKeySet then
			Relic_KeysetDisarm(oldKeySet)
			if oldKeySet == self then
				return
			end
		end
		--print("bind record")
		GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
		GameTooltip:AddLine("["..L.colors[tonumber(self:GetName())].."] : Press any key to define the Bind key")
		GameTooltip:Show()
	
		self:LockHighlight()
		self:GetParent().keysetActive = self
		self:SetScript("OnKeyDown", Relic_KeysetListen)
		self:EnableKeyboard(true)
	end
	function Relic_SpawnKeyset(bt_name,ofsy)
		local btn = CreateFrame("Button", bt_name, cfgFrame, "UIPanelButtonTemplate")
		btn.lbl = btn:CreateFontString(nil, "OVERLAY", "GameFontHighlightLeft")
		btn:SetSize(125, 22)
		btn:SetPoint("TOPLEFT", 285, ofsy)
		btn.lbl:SetPoint("LEFT", -65, 0)
		btn:SetScript("OnClick", Relic_KeysetClick)
		btn:RegisterForClicks("AnyUp")
		return btn
	end
end
local cfgKeybindingsHeader = cfgFrame:CreateFontString(nil, "OVERLAY", "GameFontNormalMed3")
cfgKeybindingsHeader:SetPoint("TOPLEFT", 215, -119-24-50)
local cfgGreenButton, cfgYellowButton, cfgBlueButton, cfgRedButton = Relic_SpawnKeyset(1,-139-24-50), Relic_SpawnKeyset(2,-163-24-50), Relic_SpawnKeyset(3,-187-24-50), Relic_SpawnKeyset(4,-211-24-50)

local skipNextUpdate = false
local function Relic_cfgSetBindingsDisplay(t)
	cfgGreenButton:SetText(t[1] or "")
	cfgYellowButton:SetText(t[2] or "")
	cfgBlueButton:SetText(t[3] or "")
	cfgRedButton:SetText(t[4] or "")
end
local function Relic_cfgInitView()
	if skipNextUpdate then
		skipNextUpdate = false
		return
	end
	cfgFrameHeader:SetText(L"caption")
	cfgShowHelpTooltip.Text:SetText(L"cfgShowTooltip")
	cfgShowHelpTooltip:SetChecked(Relic_ShowTooltip ~= false)
	cfgUnbindInCombat.Text:SetText(L"cfgUnbindInCombat")
	cfgUnbindInCombat:SetChecked(Relic_UnbindCombat ~= false)
	cfgEnableHotkeys.Text:SetText(L"cfgEnableHotkeys")
	cfgEnableHotkeys:SetChecked(Relic_EnableHotkeys ~= false)
	cfgAnnounceEnabled.Text:SetText("Activer les annonces")
	cfgAnnounceEnabled:SetChecked(Relic_AnnounceEnabled ~= false)
	cfgAnnounceGroupOnly.Text:SetText("Seulement en groupe")
	cfgAnnounceGroupOnly:SetChecked(Relic_AnnounceGroupOnly ~= false)
	cfgAnnounceDelayValue:SetText(string.format("%.1fs", Relic_AnnounceDelay or 1))
	cfgKeybindingsHeader:SetText(L"cfgKeybindings")
	cfgGreenButton.lbl:SetText(L.colors[1])
	cfgYellowButton.lbl:SetText(L.colors[2])
	cfgBlueButton.lbl:SetText(L.colors[3])
	cfgRedButton.lbl:SetText(L.colors[4])
	Relic_cfgSetBindingsDisplay(T.GetKeyBindings())
end

local function Relic_cfgSaveView()
	Relic_ShowTooltip = not not cfgShowHelpTooltip:GetChecked()
	Relic_UnbindCombat = not not cfgUnbindInCombat:GetChecked()
	Relic_EnableHotkeys = not not cfgEnableHotkeys:GetChecked()
	Relic_AnnounceEnabled = not not cfgAnnounceEnabled:GetChecked()
	Relic_AnnounceGroupOnly = not not cfgAnnounceGroupOnly:GetChecked()
	T.SetKeyBindings({cfgGreenButton:GetText(), cfgYellowButton:GetText(), cfgBlueButton:GetText(), cfgRedButton:GetText()})
	Relic_cfgInitView()
end
local function Relic_cfgSetDefaults()
	cfgShowHelpTooltip:SetChecked(true)
	cfgUnbindInCombat:SetChecked(true)
	cfgEnableHotkeys:SetChecked(true)
	Relic_cfgSetBindingsDisplay(L"colorDefaultKeys")
	skipNextUpdate = true
end

local cfgCloseButton = CreateFrame("Button", nil, cfgFrame, "UIPanelCloseButton")
cfgCloseButton:SetPoint("TOPRIGHT", -5, -5)

cfgFrame:Hide()
cfgFrame:SetScript("OnShow", Relic_cfgInitView)
cfgFrame.name, cfgFrame.okay, cfgFrame.default = "Ogrila Stone", Relic_cfgSaveView, Relic_cfgSetDefaults
if InterfaceOptions_AddCategory then
	InterfaceOptions_AddCategory(cfgFrame)
end
