local LL, _, T = {}, ...
--[[
 Ogri'La - Localization data
  Translate this (+ Notes: section in .toc), and submit using:
   
]]

-- English
LL["enUS"] = {
	colors={"|cff22ff22Green|r","|cffeeee22Yellow|r","|cff2288ffBlue|r","|cffff2200Red|r"},
	colorDefaultKeys={"G", "Y", "B", "R"},
	colorClick="Add %s Relic",
	colorHotkey="Alternatively, press %s.",
	caption="Ogri'La  Relic Remember",
	remove="Left click to remove this.\nRight click to remove up to here.",
	unbinderror="You are in combat - keybindings will update when you're finished.",
	nosuchkeyset="Valid keysets: %s, or %s for default.",
	cfgShowTooltip="Show help tooltips",
	cfgUnbindInCombat="Disable  hotkeys while in combat",
	cfgEnableHotkeys="Enable hotkeys while Ogrila Stone is shown",
	cfgLanguageSelector="Language: %s",
	cfgKeybindings="Key bindings",
};

-- German [contributed by Endeavour@Arthas-EU]
LL["deDE"] = {
	colors={"|cff22ff22Gr\195\188n|r","|cffeeee22Gelb|r","|cff2288ffBlau|r","|cffff2200Rot|r"},
	colorDefaultKeys = {"G", "E", "B", "R"},
	colorClick="%s - Relikt hinzuf\195\188gen.",
	colorHotkey="Alternativ %s dr\195\188cken.",
	caption="Ogri'La  Relic Remember",
};

-- Russian (contributed by Хоргул-Гордунни)
LL["ruRU"] = {
	colors={"|cff22ff22Зеленый|r","|cffeeee22Желтый|r","|cff2288ffСиний|r","|cffff2200Красный|r"},
	colorDefaultKeys={"З", "Ж", "С", "К"},
	colorClick="Добавить %s реликвию",
	colorHotkey="Или нажмите %s.",
	caption="Запомнить реликвию Огри'ла",
	remove="ЛКМ, чтобы удалить это.\nПКМ, чтобы удалить здесь.",
	unbinderror="Вы в бою - комбинации клавиш обновятся, когда вы закончите.",
	nosuchkeyset="Допустимые наборы клавиш: %s или %s по умолчанию.",
	cfgShowTooltip="Показать всплывающие подсказки",
	cfgUnbindInCombat="Отключить горячие клавиши в бою",
	cfgEnableHotkeys="Включите горячие клавиши, пока отображаются камни Огри'ла",
	cfgLanguageSelector="Язык: %s",
	cfgKeybindings="Привязки клавиш",
};

-- French [contributed by oXid_Fox]
LL["frFR"] = {
	colors={"|cff22ff22verte|r","|cffeeee22jaune|r","|cff2288ffbleue|r","|cffff2200rouge|r"},
	colorDefaultKeys={"V","J","B","R"},
	colorClick="Ajouter une relique %s",
	colorHotkey="Raccourci : %s",
	caption="Ogri'La Relic Remember",
	remove="Clic gauche pour supprimer cette couleur. Clic droit pour tout supprimer \195\160 partir d'ici.",
	unbinderror="Vous \195\170tes en combat - les associations de touches seront mises \195\160 jour en sortie de combat.",
	nosuchkeyset="Raccourcis valides: %s, ou %s par d\195\169faut.",
	cfgShowTooltip="Afficher les infobulles",
	cfgUnbindInCombat="Restaure les associations de touches  en combat",
	cfgEnableHotkeys="Activer les raccourcis quand Ogri'La Stone est affich\195\169",
	cfgLanguageSelector="Langue: %s",
	cfgKeybindings="Associations de touches"
};

local L, LD = LL[GetLocale()], LL.enUS
T.L = setmetatable({}, {__index=function(self, key)
	local s = L and L[key] or LD[key] or ("#NOLOC#" .. tostring(key) .. "#")
	self[key] = s
	return s
end, __call=function(self, key)
	return self[key]
end})
