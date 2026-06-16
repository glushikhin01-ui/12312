--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher

util.AddNetworkString('mayor_system:OpenMenu')
util.AddNetworkString('mayor_system:ChangeStatus')
util.AddNetworkString('mayor_system:Choose')

-- nw.SetGlobal('party', mayor_system.defaultParty)

local function resetDeputats()
    local tbl = {}
    for k, v in next, mayor_system.parties do
        tbl[k] = {}
    end

    nw.SetGlobal('deputats', tbl)
end

resetDeputats()

do
    local numPlayers = team.NumPlayers

    function mayor_system.ChoosePolitical(pl, new)
        pl.cooldownChangePolitical = pl.cooldownChangePolitical or 0
        if pl.cooldownChangePolitical > CurTime() then return 'Вы не можете сделать это сейчас!' end
        if mayor_system.GetParty(new) then return 'Сейчас и так этот политический строй!' end

        return mayor_system.SetChoose(pl, new)
    end
end

function mayor_system.SetChoose(pl, new)
    local tbl = nw.GetGlobal('deputats')

    tbl[new] = tbl[new] or {}

    local newParty = tbl[new]
    if newParty[pl] then
        return 'Вы и так проголосовали за эту партию!'
    end

    for k, v in next, tbl do
        for ply, _ in next, v do
            if pl ~= ply then continue end
            
            tbl[k][pl] = nil
        end
    end

    newParty[pl] = true 
    nw.SetGlobal('deputats', tbl)

    pl.cooldownChangePolitical = CurTime() + 170
    return 'Вы успешно проголосовали за эту партию!'
end

function mayor_system.ChangeStatus(pl, new)
    local tbl = nw.GetGlobal('deputats')
    tbl[new] = tbl[new] or {}

    local newParty = tbl[new]
    if #newParty < 3 then
        return 'За партию проголосовало недостаточно количество депутатов!'
    end

    resetDeputats()

    mayor_system.SetParty(new)

    return 'Вы успешно изменили политический режим!'
end

net.Receive('mayor_system:ChangeStatus', function(_, pl)
    if not pl:IsMayor() then return end

    local status = net.ReadString()

    if not mayor_system.parties[status] then
        return
    end

    local notify = mayor_system.ChangeStatus(pl, status)
    rp.Notify(pl, 5, notify)
end)

net.Receive('mayor_system:Choose', function(_, pl)
    if pl:GetJob() ~= TEAM_DEP then return end

    local status = net.ReadString()

    if not mayor_system.parties[status] then
        return
    end

    local notify = mayor_system.ChoosePolitical(pl, status)
    rp.Notify(pl, 5, notify)
    eui.battlepass.AddProgress(pl, 11)
end)

local function openMenu(pl)
    if pl:GetJob() ~= TEAM_DEP then return end
    
    net.Start('mayor_system:OpenMenu')
    net.Send(pl)
end

local function removeVote(pl)
    local tbl = nw.GetGlobal('deputats')

    for k, v in next, tbl do
        if not tbl[k][pl] then continue end

        tbl[k][pl] = nil
    end
end

hook.Add('OnPlayerChangedTeam', 'mayor_system:OnPlayerChangedTeam', function(pl, old, new)
    if new == TEAM_DEP then
        openMenu(pl)
    end

    if old == TEAM_DEP then
        removeVote(pl)
    end
end)

hook.Add('PlayerDisconnected', 'mayor_system:PlayerDisconnected', removeVote)

--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher
