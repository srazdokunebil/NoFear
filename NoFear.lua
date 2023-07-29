local nf_VERSION = "1.0.0.0" --don't use letters or numbers > 10
local me = UnitName('player')

local NF = CreateFrame("Frame")
local nf_Initialized = false;

local DPx_Ready = false;
local DPx_Countdown = 0;

function nf_Print(a)
    if a == nil then
        DEFAULT_CHAT_FRAME:AddMessage('|cff69ccf0[NF]|cff0070de:' .. time() .. '|cffffffff attempt to print a nil value.')
        return false
    end
    DEFAULT_CHAT_FRAME:AddMessage("|cff69ccf0[NF] |cffffffff" .. a)
end

function nf_Error(a)
    DEFAULT_CHAT_FRAME:AddMessage('|cff69ccf0[NF]|cff0070de:' .. time() .. '|cffffffff[' .. a .. ']')
end

function nf_Debug(a)
    --    if not TWLC_DEBUG then return end
    if me == 'Kzktst' or me == 'Xerrtwo' then
        nf_Print('|cff0070de[TWADEBUG:' .. time() .. ']|cffffffff[' .. a .. ']')
    end
end

function nf_Initialize()

    --VRotaConfig_Text_Version:SetText("NoFear v" .. nf_VERSION)

    local class = UnitClass('player');
    local race = UnitRace('player');
    if class == "Priest" and race == "Dwarf" then
        nf_Print('you are a dorf preest')
        DPxFrame:Show()
        MTxFrame:Hide()
    else
        nf_Print('you are NOT a dorf preest')
        DPxFrame:Hide()
        MTxFrame:Show()
    end

    nf_Initialized = true;
end

--[ OnLoad ]--
function nf_OnLoad()
    nf_RegisterEvents()
    nf_UnpauseEvents()
end

--[ OnUpdate ]--
function nf_OnUpdate(arg1)

end

--[ OnEvent ]--
function nf_OnEvent(event, arg1)

    if false then
        --
    elseif event == "PARTY_MEMBERS_CHANGED" then
        --vr.api.GroupSync();

    elseif event == "CHAT_MSG_ADDON" and arg1 == "MTx" then
        NF.handleMTxSync(arg1, arg2, arg3, arg4)

    elseif event == "CHAT_MSG_ADDON" and arg1 == "DPx" then
        NF.handleDPxSync(arg1, arg2, arg3, arg4)

    elseif event == "PLAYER_AURAS_CHANGED" then
        -- Check to see if mounted
        if UnitIsMounted("player") then
            VRotaMount = true
        else
            VRotaMount = false
        end

    elseif event == "CHAT_MSG_SPELL_PERIODIC_SELF_BUFFS" then
        if arg1 == CHAT_GAINED_FLURRY_FURY then
            FuryFlurryStart = GetTime()
        end

    elseif event == "PLAYER_REGEN_DISABLED" then
        nf_Combat = true

    elseif (event == "VARIABLES_LOADED") then
        if not nf_Initialized then
            nf_Initialize(false);
        end
    end

end




---[ DPx functions ]-----------------------------------------------------------
function nf_DPxPing()
    DPx_Countdown = DPx_Countdown + 1
    ChatThrottleLib:SendAddonMessage("ALERT", "NF", DPx_Countdown, "RAID") -- transmit roster
end




---[ MTx functions ]-----------------------------------------------------------
function nf_MTxPing()

end