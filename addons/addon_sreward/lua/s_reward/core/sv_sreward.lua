--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher

sReward = sReward or {}

sReward.data = sReward.data or {}
sReward.data["coupons"] = sReward.data["coupons"] or {}
sReward.data["shop"]  = sReward.data["shop"] or {}
sReward.data.leaderboard = sReward.data.leaderboard or {}
sReward.namesToKey = sReward.namesToKey or {}

sReward.synced = sReward.synced or {}

sReward.StaffNetworkedAll = sReward.StaffNetworkedAll or {}
sReward.NetworkingQueue = sReward.NetworkingQueue or {}

util.AddNetworkString("sR:NetworkingHandeler")
resource.AddWorkshop("2350861001")

local stringToInt = {
    ["rewards"] = {id = 1, instructions = {["jsontable"] = true, ["plydata"] = true}},
    ["total_referrals"] = {id = 2, instructions = {["player"] = true, ["int"] = true, ["plydata"] = true}},
    ["leaderboard"] = {id = 3, instructions = {["jsontable"] = true}},
    ["tokens"] = {id = 4, instructions = {["player"] = true, ["int"] = true, ["plydata"] = true}},
    ["coupons"] = {id = 5, instructions = {["jsontable"] = true}},
    ["shop"] = {id = 6, instructions = {["jsontable"] = true}},
    ["referral_top3"] = {id = 7, instructions = {["jsontable"] = true}}
}

sReward.NetworkData = function(ply, type, args)
    if ply then
        local net_data = stringToInt[type]
        if !net_data or !net_data.id and !args.id then return end
        local id = net_data.id or args.id
        local data = sReward.data

        if net_data.instructions and (net_data.instructions["plydata"] or net_data.instructions["player"]) then
            local args_ply = net_data.instructions["player"] and args and args.ply and args.ply:SteamID()
            local plysid = isentity(args_ply) and IsValid(args_ply) and args_ply:SteamID()
            local sid = (args and args.sid) or plysid or ply:SteamID()
            data = data[sid] or {}
        end

        data = data[type]

        if !data then return end
        local queueFuncs = {}
        if net_data.instructions then
            if net_data.instructions["key"] then
                local key = args and args.key
                if !key then return end

                table.insert(queueFuncs, function()
                    net.WriteUInt(key, 4)
                end)

                data = data[key] or {}
            end
    
            if net_data.instructions["player"] then
                local ply = args and args.ply
                if !ply then return end

                local entIndex = ply:EntIndex()

                table.insert(queueFuncs, function()
                    net.WriteUInt(entIndex, 16)
                end)
            end
    
            if net_data.instructions["jsontable"] then
                table.insert(queueFuncs, function()
                    if !data then return end
                    data = net.WriteString(util.TableToJSON(data))
                end)
            end
    
            if net_data.instructions["int"] then
                local int = args and args.int or 0

                table.insert(queueFuncs, function()
                    data = net.WriteUInt(int, 32)
                end)
            end
        end

        net.Start("sR:NetworkingHandeler")
        net.WriteUInt(1,2)
        net.WriteUInt(id, 4)
        for k,v in ipairs(queueFuncs) do
            v()
        end

        net.Send(ply)
    else
        for k,v in ipairs(player.GetAll()) do
            sReward.NetworkData(v, type, args)
        end
    end
end

local function networkFromQueue(ply)
    local psid = ply:SteamID()

    if !sReward.NetworkingQueue[psid] then return end

    for k,v in pairs(sReward.NetworkingQueue[psid]) do
        if k == "tokens" then
            for i, z in pairs(v) do
                if !IsValid(z) then continue end
                sReward.NetworkData(ply, "tokens", {ply = z, int = sReward.GetTokens(z)})
            end
        else
            sReward.NetworkData(ply, k)
        end

        sReward.NetworkingQueue[psid][k] = nil
    end
end

sReward.addToQueue = function(ply, type, var)
    if ply then
        if !IsValid(ply) then return end

        local psid = ply:SteamID()

        sReward.NetworkingQueue[psid] = sReward.NetworkingQueue[psid] or {}
        sReward.NetworkingQueue[psid][type] = sReward.NetworkingQueue[psid][type] or {}
        
        if var then
            table.insert(sReward.NetworkingQueue[psid][type], var)
        end

        networkFromQueue(ply)
    else
        for k,v in pairs(player.GetAll()) do
            sReward.addToQueue(v, type, var)
        end
    end
end

sReward.SetTokens = function(ply, tokens)
    local sid = ply:SteamID()
    sReward.data[sid] = sReward.data[sid] or {}
    sReward.data[sid]["tokens"] = math.Clamp(tokens, 0, tokens)
    sReward.updatePlayerData(ply)

    sReward.NetworkData(ply, "tokens", {ply = ply, int = sReward.GetTokens(ply)})

    hook.Run("sR:ChangedTokens", ply, tokens)
end

sReward.GetTokens = function(ply)
    local sid = ply:SteamID()
    return sReward.data[sid] and tonumber(sReward.data[sid]["tokens"]) or 0
end


sReward.GiveTokens = function(ply, amount, nototal)
    local sid = ply:SteamID()
    sReward.data[sid] = sReward.data[sid] or {}

    local has = sReward.GetTokens(ply)

    local recalculate = false

    if !nototal then
        local plysid64 = ply:SteamID64()

        sReward.data[sid]["total_tokens"] = sReward.data[sid]["total_tokens"] or 0
        sReward.data[sid]["total_tokens"] = sReward.data[sid]["total_tokens"] + amount

        local leader_count = sReward.leaderboard and table.Count(sReward.leaderboard) or 0

        if leader_count <= 0 or (sReward.leaderboard[leader_count].tokens <= sReward.data[sid]["total_tokens"]) then
            recalculate = true
        end
    end

    sReward.SetTokens(ply, has + amount, network)

    if recalculate then
        sReward.CalculateLeaderBoard()
    end

    return (has + amount)
end

sReward.TakeTokens = function(ply, amount, network)
    local has = sReward.GetTokens(ply)
    sReward.SetTokens(ply, has - amount, network)

    return (has - amount)
end

sReward.GiveReward = function(ply, key)
    local reward = sReward.config["rewards"][key]

    if reward then
        local sid = ply:SteamID()

        sReward.data[sid] = sReward.data[sid] or {}
        sReward.data[sid]["rewards"] = sReward.data[sid]["rewards"] or {}
        sReward.data[sid]["rewards"][key] = sReward.data[sid]["rewards"][key] or {}

        if reward.reward["coupon"] then
            local couponType = reward.reward["coupon"]
            local type = sReward.namesToKey["coupons"][couponType]
            if !key or !sReward.data["coupons"][type] or sReward.data["coupons"][type].name ~= type or !sReward.data["coupons"][type].data or table.Count(sReward.data["coupons"][type].data) <= 0 then
                slib.notify(sReward.config["prefix"]..slib.getLang("sreward", sReward.config["language"], "coupon_out_of_stock", couponType), ply)
            return end
        end

        local cooldownhit = false

        if reward.maxuse and reward.maxuse > 0 then
            sReward.data[sid]["rewards"][key].used = sReward.data[sid]["rewards"][key].used or 0

            if sReward.data[sid]["rewards"][key].used >= reward.maxuse then
                slib.notify(sReward.config["prefix"]..slib.getLang("sreward", sReward.config["language"], "max_use_reached"), ply)
            return end

            sReward.data[sid]["rewards"][key].used = sReward.data[sid]["rewards"][key].used + 1
        end
        
        if reward.cooldown and reward.cooldown > 0 then
            local lastUse = (sReward.data[sid]["rewards"][key].cd or 0)
            if lastUse > 0 and os.time() < (lastUse + reward.cooldown) then
                slib.notify(sReward.config["prefix"]..slib.getLang("sreward", sReward.config["language"], "on_cooldown", math.Round((lastUse + reward.cooldown) - os.time(), 1)), ply)
            return end

            sReward.data[sid]["rewards"][key].cd = os.time()
        end

        if reward.custom then
            reward.custom(ply)
        end

        for k,v in pairs(reward.reward) do
            sReward.Rewards[k](ply, v)
        end

        if reward.successMsg then
            slib.notify(sReward.config["prefix"]..reward.successMsg, ply)
        else
            slib.notify(sReward.config["prefix"]..slib.getLang("sreward", sReward.config["language"], "success_reward", reward.name), ply)
        end

        sReward.updatePlayerData(ply)
        sReward.NetworkData(ply, "rewards")

        return reward.name
    end
end

sReward.ClearReward = function(ply, key)
    local reward = sReward.config["rewards"][key]
    if !reward then return end

    local sid = ply:SteamID()

    sReward.data[sid]["rewards"][key] = nil
    sReward.updatePlayerData(ply)
    sReward.NetworkData(ply, "rewards")
end

sReward.GiveCoupon = function(ply, type)
    local key = sReward.namesToKey["coupons"][type]
    if !key or !sReward.data["coupons"][key] or sReward.data["coupons"][key].name ~= type or !sReward.data["coupons"][key].data then return end
    local title, coupon = table.Random(sReward.data["coupons"][key].data)

    sReward.data["coupons"][key].data[coupon] = nil

    sReward.updateCouponData(key)

    for k,v in ipairs(sReward.GetStaff()) do
        sReward.addToQueue(v, "coupons")
    end

    net.Start("sR:NetworkingHandeler")
    net.WriteUInt(2, 2)
    net.WriteString(util.TableToJSON({title = type, code = coupon}))
    net.Send(ply)
end

sReward.GetStaff = function()
    local staff = {}

    for k,v in ipairs(player.GetAll()) do
        if sReward.HasPermission(v, "sReward_AdminMenu") then
            table.insert(staff, v)
        end
    end

    return staff
end

local intToStorage = {
    [1] = "coupons",
    [2] = "shop"
}

local rewardCD = {}

net.Receive("sR:NetworkingHandeler", function(len, ply)
    local action = net.ReadUInt(3)
    local sid = ply:SteamID()

    if action < 1 then
        local open = net.ReadBool()

        networkFromQueue(ply)
    return end

    if !sReward.synced[sid] then return end

    if action == 1 then
        if !sReward.config["enabled_tabs"]["tasks"] then return end

        local key = net.ReadUInt(4)
        local reward = sReward.config["rewards"][key]

        if !reward or !reward.enabled then return end

        if reward.net_cd then
            if rewardCD[sid] and (rewardCD[sid][key] or 0) > CurTime() then
                slib.notify(sReward.config["prefix"]..slib.getLang("sreward", sReward.config["language"], "cooldown", math.Round(rewardCD[sid][key] - CurTime())), ply)
            return end
            
            rewardCD[sid] = rewardCD[sid] or {}
            rewardCD[sid][key] = CurTime() + reward.net_cd
        end

        if reward.customCheck and reward.customCheck(ply) == false then
            if reward.customCheckMsg then
                slib.notify(sReward.config["prefix"]..reward.customCheckMsg, ply)
            end
        return end

        if isfunction(sReward[reward.funcname]) then
            sReward[reward.funcname](ply, key)
        else
            sReward.GiveReward(ply, key)
        end
    elseif action == 2 then
        if !sReward.config["enabled_tabs"]["referral"] then return end
        if ply.doneReferring then slib.notify(sReward.config["prefix"]..slib.getLang("sreward", sReward.config["language"], "raferring_ratelimit"), ply) return end

        ply.doneReferring = true
        
        local sid64 = net.ReadString()

        if !sid64 or #sid64 ~= 17 or !isnumber(tonumber(sid64)) then slib.notify(sReward.config["prefix"]..slib.getLang("sreward", sReward.config["language"], "invalid_sid64"), ply) return end
        if sid64 == ply:SteamID64() then slib.notify(sReward.config["prefix"]..slib.getLang("sreward", sReward.config["language"], "cannot_referr_yourself"), ply) return end

        local ply_sid64 = ply:SteamID64()

        sReward.referrHandeler(ply_sid64, sid64, function(count, already_referred)
            if already_referred then
                slib.notify(sReward.config["prefix"]..slib.getLang("sreward", sReward.config["language"], "cannot_referr_again"), ply)
                ply.doneReferring = nil
            return end

            if count >= sReward.config["max_referrals"] then
                if IsValid(ply) then
                    slib.notify(sReward.config["prefix"]..slib.getLang("sreward", sReward.config["language"], "referral_limit"), ply)
                    ply.doneReferring = nil
                end
            return end

            sReward.giveReferralReward(ply_sid64, sid64)
        end)
    elseif action == 3 then
        if !sReward.config["enabled_tabs"]["shop"] then return end

        local id = net.ReadUInt(6)
        local special = net.ReadBool()
        local item = !special and sReward.config["shop"][id] or sReward.data["shop"][id]

        if !item or !item.enabled then return end
        local hasTokens = sReward.GetTokens(ply)

        local price = tonumber(item.price)

        if hasTokens < price then
            slib.notify(sReward.config["prefix"]..slib.getLang("sreward", sReward.config["language"], "cannot_afford"), ply)
        return end

        if item.reward["coupon"] then
            local couponType = item.reward["coupon"]
            local key = sReward.namesToKey["coupons"][couponType]

            if !key or !sReward.data["coupons"][key] or sReward.data["coupons"][key].name ~= couponType or !sReward.data["coupons"][key].data or table.Count(sReward.data["coupons"][key].data) <= 0 then
                slib.notify(sReward.config["prefix"]..slib.getLang("sreward", sReward.config["language"], "coupon_out_of_stock", couponType), ply)
            return end
        end

        for k,v in pairs(item.reward) do
            sReward.Rewards[k](ply, tonumber(v) or v)
        end

        sReward.TakeTokens(ply, price, true)

        slib.notify(sReward.config["prefix"]..slib.getLang("sreward", sReward.config["language"], "successfull_purchase", item.name), ply)
    elseif action == 4 and sReward.HasPermission(ply, "sReward_AdminMenu") then
        if !sReward.StaffNetworkedAll[ply] then
            sReward.StaffNetworkedAll[ply] = true
            sReward.NetworkData(ply, "coupons")
        end

        local doaction = tobool(net.ReadBit())
        if doaction then
            local target = net.ReadUInt(16)
            target = Entity(target)

            if !IsValid(target) then return end

            local subaction = net.ReadUInt(2)
            local val = net.ReadUInt(20)
            if subaction == 1 then
                local balance = string.Comma(sReward.GiveTokens(target, val, true))
                val = string.Comma(val)
                slib.notify(sReward.config["prefix"]..slib.getLang("sreward", sReward.config["language"], "given_tokens", val, balance), target)
                if target == ply then return end
                slib.notify(sReward.config["prefix"]..slib.getLang("sreward", sReward.config["language"], "performed_admin_action", slib.getLang("sreward", sReward.config["language"], "give_tokens"), val), target)
            elseif subaction == 2 then
                local balance = string.Comma(sReward.TakeTokens(target, val, true))
                val = string.Comma(val)
                slib.notify(sReward.config["prefix"]..slib.getLang("sreward", sReward.config["language"], "taken_tokens", val, balance), target)
                if target == ply then return end
                slib.notify(sReward.config["prefix"]..slib.getLang("sreward", sReward.config["language"], "performed_admin_action", slib.getLang("sreward", sReward.config["language"], "take_tokens"), val), target)
            elseif subaction == 3 then
                local name = sReward.GiveReward(target, val)
                slib.notify(sReward.config["prefix"]..slib.getLang("sreward", sReward.config["language"], "given_reward", name), target)
                if target == ply then return end
                slib.notify(sReward.config["prefix"]..slib.getLang("sreward", sReward.config["language"], "performed_admin_action", slib.getLang("sreward", sReward.config["language"], "give_reward"), name), target)
            end
        else
            local subaction = net.ReadUInt(2)
            local storagetype = intToStorage[subaction]

            if !storagetype then return end

            local data = net.ReadString()
            data = util.JSONToTable(data)

            sReward.data[storagetype] = sReward.data[storagetype] or {}
            sReward.namesToKey[storagetype] = sReward.namesToKey[storagetype] or {}
            local name = data.name
            local key = data.svid or sReward.namesToKey[storagetype][data.oldname] or sReward.namesToKey[storagetype][name]

            if key then
                sReward.data[storagetype][key] = data
            else
                key = table.insert(sReward.data[storagetype], data)
            end

            sReward.data[storagetype][key].oldname = nil

            sReward.data[storagetype][key].svid = key

            if sReward.data[storagetype][key] and sReward.data[storagetype][key].delete == "confirmed" then
                sReward.data[storagetype][key] = "delete"
            end

            sReward.namesToKey[storagetype] = {}

            for k,v in pairs(sReward.data[storagetype]) do
                if istable(v) and v.name then
                    sReward.namesToKey[storagetype][v.name] = k
                end
            end
            
            if storagetype == "coupons" then
                for k,v in ipairs(sReward.GetStaff()) do
                    sReward.addToQueue(v, "coupons")
                end

                sReward.updateCouponData(key)
            end

            if storagetype == "shop" then
                sReward.addToQueue(nil, "shop")
                sReward.updateShopData(key)
            end
        end
    end
end)

concommand.Add("sR_AddTokensToSID64", function(ply, _, args)
    if ply and !sReward.HasPermission(ply, "sReward_AddTokenCommand") then return end

    local sid64 = args[1]

    local amount = tonumber(args[2]) or 0
    
    if !sid64 or amount <= 0 then return end

    if #sid64 != 17 then
        sid64 = util.SteamIDTo64(sid64)

        if sid64 == "0" then return end
    end

    local target = slib.sid64ToPly[sid64]

    if IsValid(target) then
        local total = sReward.GiveTokens(target, amount, true)
        slib.notify(sReward.config["prefix"]..slib.getLang("sreward", sReward.config["language"], "you_got_tokens", string.Comma(amount), string.Comma(total)), target)
    else
        sReward.addPlayerTokens(sid64, amount)
    end
end)

hook.Add("sR:ChangedTokens", "sR:HandleAdminNetworkingQueue", function(ply)
    for k,v in ipairs(sReward.GetStaff()) do
        sReward.addToQueue(v, "tokens", ply)
    end
end)

hook.Add("slib.FullLoaded", "sR:SyncPlayerData", function(ply)
    sReward.syncPlayerData(ply)
    sReward.syncReferrals(ply)
    sReward.checkRewards(ply)

    sReward.addToQueue(ply, "referral_top3")
    sReward.addToQueue(ply, "shop")
    sReward.addToQueue(ply, "leaderboard")

    if sReward.config["open_on_join"] then
        ply:ConCommand("sreward_menu")
    end
end)

hook.Add("PlayerSay", "sR:OpenMenu", function( ply, text, public )
	if sReward.config["chat_commands"][string.lower(text)] then
		ply:ConCommand("sreward_menu")

		return ""
	end
end)

hook.Add("sR:SyncedData", "sR:HandleSyncing", function(ply, type)
    if type == "referrals" then
        sReward.addToQueue(ply, "referrals")
        ply.syncedReferrals = true
    return end

    sReward.addToQueue(ply, "tokens", ply)
    sReward.addToQueue(ply, "rewards")

    if sReward.HasPermission(ply, "sReward_AdminMenu") then
        sReward.addToQueue(ply, "coupons")

        for k,v in ipairs(player.GetHumans()) do
            sReward.addToQueue(ply, "tokens", v)
        end
    end

    for k,v in ipairs(player.GetHumans()) do
        if sReward.HasPermission(v, "sReward_AdminMenu") then
            sReward.addToQueue(v, "tokens", ply)
        end
    end

    sReward.synced[ply:SteamID()] = true
end)

hook.Add("PlayerDisconnected", "sR:RemoveDataOnLeave", function(ply)
    local sid = ply:SteamID()

    sReward.data[sid] = nil
    sReward.synced[sid] = nil
end)

hook.Add("sR:DBConnected", "sR:HandleDBConnected", function()
    sReward.syncCouponData()
    sReward.syncShopData()
    sReward.updateRewardStats()
end)

sReward.CalculateLeaderBoard()

--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher
