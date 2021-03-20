local addon_name, addon = ...
local macro_name = "Détournement"
local last_tank_name = ""

function addon.print(text)
    DEFAULT_CHAT_FRAME:AddMessage("|cff1C80E7" .. addon_name .. "|r: " .. text)
end

local function OnEvent(self, event)
    if not IsSpellKnown(34477) then
        return
    end
    
    local macro_id = GetMacroIndexByName(macro_name)

    if macro_id == 0 then
        macro_id = CreateMacro(macro_name, "ability_hunter_misdirection", "#showtooltip Détournement\n/cast Détournement", true)
    end

    local group_size = GetNumGroupMembers()

    if group_size > 1 then
        for i = 1, group_size do
            local role = UnitGroupRolesAssigned("party"..i)
            if role == "TANK" then
                local name = GetUnitName("party" .. i, true)
                local str="#showtooltip Détournement\n/cast [@" .. "party".. i .. "] Détournement"
                EditMacro(macro_id,nil,nil,str,1,1)
                if not last_tank_name == name then
                    last_tank_name = name
                    addon.print("Cible de Détournement définie sur " .. name .. ".") 
                end
                return
            end
        end
    end
end

local f = CreateFrame("Frame")

f:RegisterEvent("GROUP_ROSTER_UPDATE")
f:SetScript("OnEvent", OnEvent)