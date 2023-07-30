local nf_VERSION = "1.0.0.0" --don't use letters or numbers > 10
local me = UnitName('player')

nf = CreateFrame("Frame", nil, UIParent)
nf.Initialized = false;

nf.DPx_Ready = false;
nf.DPx_Countdown = 0;
nf.AmDPx = false;
nf.AmMTx = false;

nf.MTxState = false;

local asscount = 0;

function nf.Print(a)
    if a == nil then
        DEFAULT_CHAT_FRAME:AddMessage('|cff69ccf0[NF]|cff0070de:' .. time() .. '|cffffffff attempt to print a nil value.')
        return false
    end
    DEFAULT_CHAT_FRAME:AddMessage("|cff69ccf0[NF] |cffffffff" .. a)
end

function nf.Error(a)
    DEFAULT_CHAT_FRAME:AddMessage('|cff69ccf0[NF]|cff0070de:' .. time() .. '|cffffffff[' .. a .. ']')
end

function nf.Debug(a)
    --    if not TWLC_DEBUG then return end
    if me == 'Kzktst' or me == 'Xerrtwo' then
        nf.Print('|cff0070de[TWADEBUG:' .. time() .. ']|cffffffff[' .. a .. ']')
    end
end

function nf.Initialize()

    --VRotaConfig_Text_Version:SetText("NoFear v" .. nf_VERSION)

    local class = UnitClass('player');
    local race = UnitRace('player');
    if class == "Priest" and race == "Dwarf" then
        nf.Print('you are a dorf preest')
        nf.AmDPx = true;
        DPxFrame:Show()
        MTxFrame:Hide()
    else
        nf.Print('you are NOT a dorf preest')
        nf.AmDPx = false;
        DPxFrame:Hide()
        MTxFrame:Show()
        nf.CreateMTxButton()
    end

    nf.Initialized = true;
end

--[ OnLoad ]--
function nf.OnLoad()
    nf.RegisterEvents()
    nf.UnpauseEvents()
end

--[ OnUpdate ]--
function nf.OnUpdate(arg1)

end

--[ OnEvent ]--
function nf.OnEvent(event, arg1, arg2)

    if false then
        --
    elseif event == "PARTY_MEMBERS_CHANGED" then
        --vr.api.GroupSync();

    --elseif event == "CHAT_MSG_ADDON" then
    --    nf.Print(event .. ":" .. arg1 .. ":" .. arg2)
    --
    elseif event == "CHAT_MSG_ADDON" and arg1 == "NF_MTx" then
        nf.handleMTxSync(arg1, arg2, arg3, arg4)

    elseif event == "CHAT_MSG_ADDON" and arg1 == "NF_DPx" then
        nf.Print('i see some fucking thing')
        nf.handleDPxSync(arg1, arg2, arg3, arg4)

    elseif event == "PLAYER_AURAS_CHANGED" then
        ---- Check to see if mounted
        --if UnitIsMounted("player") then
        --    VRotaMount = true
        --else
        --    VRotaMount = false
        --end

    elseif event == "CHAT_MSG_SPELL_PERIODIC_SELF_BUFFS" then
        --if arg1 == CHAT_GAINED_FLURRY_FURY then
        --    FuryFlurryStart = GetTime()
        --end

    elseif event == "PLAYER_REGEN_DISABLED" then
        nf.Combat = true

    elseif (event == "VARIABLES_LOADED") then
        if not nf.Initialized then
            nf.Initialize(false);
        end
    end

end

function nf.ToggleUI()
    if nf.AmDPx then
        if DPxFrame:IsShown() then
            DPxFrame:Hide();
        else
            DPxFrame:Show();
        end
    else
        if MTxButton:IsShown() then
            MTxButton:Hide();
        else
            MTxButton:Show();
        end
    end
end


---[ nf_DPxPing ]-----------------------------------------------------------
function nf.DPxPing()
    nf.DPx_Countdown = nf.DPx_Countdown + 1
    ChatThrottleLib:SendAddonMessage("ALERT", "NF_DPx", nf.DPx_Countdown, "RAID") -- transmit roster
end

function nf.handleDPxSync(arg1, arg2, arg3, arg4)

    nf.Print(arg1 .. ":" .. arg2)
end


---[ nf_MTxPing ]-----------------------------------------------------------
function nf.MTxPing()

end

function nf.CreateMTxButton()
    MTxButton = CreateFrame("Button", nil, ass)
    MTxButton:SetPoint("CENTER", ass, "CENTER", 0, 0)
    MTxButton:SetWidth(75)
    MTxButton:SetHeight(75)

    MTxButton:SetMovable(true)
    MTxButton:EnableMouse(true)
    MTxButton:SetScript("OnMouseDown",function() MTxButton:StartMoving() end)
    MTxButton:SetScript("OnMouseUp",function() MTxButton:StopMovingOrSizing() end)

    --MTxButton:SetNormalFontObject("GameFontNormal")

    local ntex = MTxButton:CreateTexture()
    --ntex:SetTexture("Interface/Buttons/UI-Panel-Button-Up")
    --Interface\Icons\Spell_Holy_Excorcism
    ntex:SetTexture("Interface/Icons/Spell_Holy_Excorcism")
    --ntex:SetTexCoord(0, 0.625, 0, 0.6875)
    ntex:SetAllPoints()
    MTxButton:SetNormalTexture(ntex)

    MTxButton:SetText("test")

    local fo = button:CreateFontString()
    fo:SetFont("Fonts/ARIALN.TTF",48)
    fo:SetPoint("CENTER", MTxButton, "CENTER", 0, 0)
    fo:SetText("test")
    MTxButton:SetFontString(fo)



    --local htex = MTxButton:CreateTexture()
    ----htex:SetTexture("Interface/Buttons/UI-Panel-Button-Highlight")
    --htex:SetTexture("Interface/Icons/Spell_Holy_Excorcism")
    --htex:SetTexCoord(0, 0.625, 0, 0.6875)
    --htex:SetAllPoints()
    --MTxButton:SetHighlightTexture(htex)
    --
    --local ptex = MTxButton:CreateTexture()
    ----ptex:SetTexture("Interface/Buttons/UI-Panel-Button-Down")
    --ptex:SetTexture("Interface/Buttons/UI-Panel-Button-Down")
    --ptex:SetTexCoord(0, 0.625, 0, 0.6875)
    --ptex:SetAllPoints()
    --MTxButton:SetPushedTexture(ptex)

end

function nf.SetMTxButtonText()
    local fo = button:CreateFontString()
    fo:SetFont("Fonts/ARIALN.TTF",24)
    fo:SetPoint("CENTER", MTxButton, "CENTER", 0, 0)
    fo:SetText("test")
    MTxButton:SetFontString(fo)
end

function nf.SetMTxButtonNormal()
    local ntex = MTxButton:CreateTexture()
    ntex:SetTexture("Interface/Icons/Spell_Holy_Excorcism")
    ntex:SetAllPoints()
    MTxButton:SetNormalTexture(ntex)
    MTxButton:SetText('A')
end

function nf.SetMTxButtonRed()
    local ntex = MTxButton:CreateTexture()
    ntex:SetTexture("Interface/Icons/Spell_Holy_Excorcism")
    ntex:SetAllPoints()
    MTxButton:SetNormalTexture(ntex)
    MTxButton:SetText('B')
end

function nf.ToggleMTxButton()
    if nf.MTxState then
        nf.SetMTxButtonNormal()
        nf.MTxState = not nf.MTxState
    else
        nf.SetMTxButtonRed()
        nf.MTxState = not nf.MTxState
    end

end