--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher

sReward = sReward or {}
sReward.data = sReward.data or {}
sReward.data.leaderboard = sReward.data.leaderboard or {}
sReward.data.referral_top3 = sReward.data.referral_top3 or {}
sReward.namesToKey = sReward.namesToKey or {}
sReward.namesToKey["coupons"] = sReward.namesToKey["coupons"] or {}

local query, db
local escape_str = function(str) return SQLStr(str, true) end

local create_queries = {
    [1] = [[CREATE TABLE IF NOT EXISTS sreward_player(
        id INTEGER PRIMARY KEY %s,
        sid64 CHAR(17),
        tokens INTEGER DEFAULT 0,
        total_tokens INTEGER DEFAULT 0,
        rewards TEXT
    )]],
    [2] = [[CREATE TABLE IF NOT EXISTS sreward_referral(
        id INTEGER PRIMARY KEY %s,
        sid64 CHAR(17),
        sid64_referred CHAR(17)
    )]],
    [3] = [[CREATE TABLE IF NOT EXISTS sreward_reward_give(
        id INTEGER PRIMARY KEY %s,
        sid64 CHAR(17),
        json TEXT
    )]],
    [4] = [[CREATE TABLE IF NOT EXISTS sreward_shop(
        id INTEGER PRIMARY KEY %s,
        name TEXT,
        price INTEGER DEFAULT 0,
        imgur_id VARCHAR(10),
        rewards TEXT
    )]],
    [5] = [[CREATE TABLE IF NOT EXISTS sreward_coupons(
        id INTEGER PRIMARY KEY %s,
        name TEXT,
        data TEXT
    )]]
}

local function makeTables()
    for i = 1, #create_queries do
        query(string.format(create_queries[i], sReward.config["storage_type"] == "sql_local" and "AUTOINCREMENT" or "AUTO_INCREMENT"))
    end
end

if sReward.config["storage_type"] == "mysql" then
    require( "mysqloo" )

    query = function() end

    local dbinfo = sReward.config["mysql_info"]

    db = mysqloo.connect(dbinfo.host, dbinfo.username, dbinfo.password, dbinfo.database, dbinfo.port)

    function db:onConnected()
        print(sReward.config["prefix"]..slib.getLang("sreward", sReward.config["language"], "mysql_successfull"))

        query = function(str, func)
            local q = db:query(str)
            q.onSuccess = function(_, data)
                if func then
                    func(data)
                end
            end

            q.onError = function(_, err) end

            q:start()
        end

        escape_str = function(str) return db:escape(tostring(str)) end

        makeTables()

        hook.Run("sR:DBConnected")
    end

    function db:onConnectionFailed(err)
        print(sReward.config["prefix"]..slib.getLang("sreward", sReward.config["language"], "mysql_failed"))
        print( "Error:", err )
    end

    db:connect()
else
    local oldFunc = sql.Query
    query = function(str, func)
        local result = oldFunc(str)

        if func then
            func(result)
        end
    end

    makeTables()

    timer.Simple(.1, function() hook.Run("sR:DBConnected") end)
end

sReward.syncPlayerData = function(ply)
    local sid64 = ply:SteamID64()
    local sid = ply:SteamID()

    sReward.data[sid] = sReward.data[sid] or {}

    local data = sReward.data[sid]

    data.tokens = data.tokens or 0
    data.total_tokens = data.total_tokens or 0
    data.rewards = data.rewards or {}
    data.referrals = data.referrals or {}

    query("SELECT * FROM sreward_player WHERE sid64 = '"..sid64.."'", function(result)
        if result and result[1] then
            sReward.data[sid] = result[1]
            sReward.data[sid].rewards = sReward.data[sid].rewards and isstring(sReward.data[sid].rewards) and util.JSONToTable(sReward.data[sid].rewards) or sReward.data[sid].rewards
            sReward.data[sid].rewards = istable(sReward.data[sid].rewards) and sReward.data[sid].rewards or {}
        else
            query([[INSERT INTO sreward_player(sid64, tokens, total_tokens, rewards) VALUES(']]..sid64..[[',']]..escape_str(data.tokens)..[[', ']]..escape_str(data.total_tokens)..[[',']]..""..[[')]])
        end

        hook.Run("sR:SyncedData", ply)
    end)
end

local sqlTerms = {
    ["mysql"] = "ON DUPLICATE KEY UPDATE",
    ["sql_local"] = "ON CONFLICT(id) DO UPDATE SET"
}

sReward.updatePlayerData = function(ply)
    local sid64 = ply:SteamID64()
    local sid = ply:SteamID()

    sReward.data[sid] = sReward.data[sid] or {}

    local data = sReward.data[sid]

    data.tokens = data.tokens or 0
    data.total_tokens = data.total_tokens or 0
    data.rewards = data.rewards or {}
    data.referrals = data.referrals or {}

    local rewards_json = util.TableToJSON(data.rewards)
    local referral_json = util.TableToJSON(data.referrals)

    query([[UPDATE sreward_player SET tokens = ']]..escape_str(data.tokens)..[[', total_tokens = ']]..escape_str(data.total_tokens)..[[', rewards = ']]..escape_str(rewards_json)..[[' WHERE sid64 = ]]..sid64)
end

sReward.addPlayerTokens = function(sid64, amount)
    query("SELECT * FROM sreward_player WHERE sid64 = '"..escape_str(sid64).."'", function(result)
        if result and result[1] then
            query([[UPDATE sreward_player SET tokens = ']]..(result[1].tokens + amount)..[[' WHERE sid64 = ]]..escape_str(sid64))
        end
    end)
end

sReward.updateRewardStats = function()
    query("SELECT * FROM sreward_referral", function(result)
        if result then
            local niceTbl, sid64ToKey = {}, {}

            for k,v in ipairs(result) do
                if !sid64ToKey[v.sid64] then
                    local key = #niceTbl + 1
                    sid64ToKey[v.sid64] = key

                    niceTbl[key] = {amount = 0, sid64 = v.sid64}
                end

                niceTbl[sid64ToKey[v.sid64]].amount = niceTbl[sid64ToKey[v.sid64]].amount + 1
            end

            table.sort(niceTbl, function(a, b) return a.amount > b.amount end)

            local final = {}

            for i=1,3 do
                final[i] = niceTbl[i]
            end

            sReward.data["referral_top3"] = final

            sReward.addToQueue(nil, "referral_top3")
        end
    end)
end


sReward.queueReward = function(sid64, tbl)
    if !isnumber(tonumber(sid64)) then return end

    query([[INSERT INTO sreward_reward_give(sid64, json) VALUES(']]..sid64..[[',']]..util.TableToJSON(tbl)..[[')]])
end

sReward.checkRewards = function(ply)
    local sid64 = ply:SteamID64()

    query("SELECT * FROM sreward_reward_give WHERE sid64 = '"..sid64.."'", function(result)
        if result and result[1] then
            for k,v in ipairs(result) do
                local tbl = util.JSONToTable(v.json)

                for k,v in pairs(tbl) do
                    sReward.Rewards[k](ply, v)
                end

                slib.notify(sReward.config["prefix"]..slib.getLang("sreward", sReward.config["language"], "referring_person"), ply)
            end

            query([[DELETE FROM sreward_reward_give WHERE sid64 = ']]..sid64..[[']])
        end
    end)
end

sReward.syncReferrals = function(ply)
    local sid64, sid = ply:SteamID64(), ply:SteamID()

    query("SELECT * FROM sreward_referral WHERE sid64 = '"..sid64.."'", function(result)
        if result then
            sReward.data[sid] = sReward.data[sid] or {}
            sReward.data[sid]["total_referrals"] = #result

            sReward.NetworkData(ply, "total_referrals", {ply = ply, int = sReward.data[sid]["total_referrals"]})
        end
    end)
end

sReward.giveReferralReward = function(ply_sid64, sid64)
    if !isnumber(tonumber(ply_sid64)) or !isnumber(tonumber(sid64)) then return end
    
    local ply, referrer = slib.sid64ToPly[ply_sid64], slib.sid64ToPly[sid64]

    if IsValid(ply) then
        for k,v in pairs(sReward.config["give_referral_reward"]) do
            sReward.Rewards[k](ply, v)
        end

        slib.notify(sReward.config["prefix"]..slib.getLang("sreward", sReward.config["language"], "referred_person", IsValid(referrer) and referrer:Nick() or sid64), ply)
    else
        sReward.queueReward(ply_sid64, sReward.config["give_referral_reward"])
    end

    if IsValid(referrer) then
        for k,v in pairs(sReward.config["receive_referral_reward"]) do
            sReward.Rewards[k](referrer, v)
        end

        slib.notify(sReward.config["prefix"]..slib.getLang("sreward", sReward.config["language"], "referred_by", IsValid(ply) and ply:Nick() or ply_sid64), referrer)
    else
        sReward.queueReward(sid64, sReward.config["receive_referral_reward"])
    end

    query([[INSERT INTO sreward_referral(sid64, sid64_referred) VALUES(']]..sid64..[[',']]..ply_sid64..[[')]], function() if IsValid(ply) then sReward.syncReferrals(ply) ply.doneReferring = nil end end)

    sReward.updateRewardStats()
end

sReward.referrHandeler = function(ply_sid64, sid64, callback)
    ply_sid64 = escape_str(ply_sid64)

    query("SELECT * FROM sreward_referral WHERE sid64_referred = '"..ply_sid64.."'", function(result)
        local count, already_referred = 0, false

        if result then
            count = #result

            for k,v in ipairs(result) do
                if v.sid64 == sid64 then
                    already_referred = true
                break end
            end
        end

        callback(count, already_referred)
    end)
end

sReward.syncCouponData = function()
    local data = sReward.data[sid]

    local result = query("SELECT * FROM sreward_coupons", function(result)
        if result then
            for k,v in ipairs(result) do
                v.id = tonumber(v.id)
                sReward.data["coupons"][v.id] = {
                    name = v.name,
                    data = util.JSONToTable(v.data)
                }
    
                sReward.namesToKey["coupons"][v.name] = v.id
            end
        end
    end)
end

sReward.updateCouponData = function(id)
    local data = sReward.data["coupons"][id]

    if data == "delete" then
        query([[DELETE FROM sreward_coupons WHERE id = ']]..escape_str(id)..[[']])

        sReward.data["coupons"][id] = nil
    return end

    local codes_json = util.TableToJSON(data.data)

    query([[INSERT INTO sreward_coupons(id, name, data) VALUES(']]..escape_str(id)..[[',']]..escape_str(data.name)..[[', ']]..codes_json..[[') ]]..sqlTerms[sReward.config["storage_type"]]..[[ name = ']]..escape_str(data.name)..[[', data = ']]..codes_json..[[']])
end

sReward.syncShopData = function()
    local data = sReward.data[sid]

    local result = query("SELECT * FROM sreward_shop", function(result)
        if result then
            for k,v in ipairs(result) do
                v.id = tonumber(v.id)
                sReward.data["shop"][v.id] = {
                    name = v.name,
                    imgurid = v.imgur_id,
                    price = tonumber(v.price),
                    enabled = true,
                    svid = v.id,
                    reward = util.JSONToTable(v.rewards)
                }
            end
        end
    end)
end

sReward.updateShopData = function(id)
    local data = sReward.data["shop"][id]

    if data == "delete" then
        query([[DELETE FROM sreward_shop WHERE id = ']]..escape_str(id)..[[']])

        sReward.data["shop"][id] = nil
    return end

    local rewards_json = util.TableToJSON(data.reward)

    query([[INSERT INTO sreward_shop(id, name, price, imgur_id, rewards) VALUES(']]..escape_str(id)..[[',']]..escape_str(data.name)..[[', ']]..escape_str(data.price)..[[', ']]..escape_str(data.imgurid)..[[', ']]..rewards_json..[[') ]]..sqlTerms[sReward.config["storage_type"]]..[[ name = ']]..escape_str(data.name)..[[', price = ']]..escape_str(data.price)..[[', imgur_id = ']]..escape_str(data.imgurid)..[[', rewards = ']]..rewards_json..[[']])
end

sReward.CalculateLeaderBoard = function()
    query([[SELECT sid64, total_tokens FROM sreward_player ORDER BY total_tokens DESC LIMIT 10;]], function(result)
        if !result or !result[1] or tonumber(result[1].total_tokens) <= 0 then return end
        sReward.data.leaderboard = result
        for k,v in ipairs(result) do
            sReward.data.leaderboard[k] = {
                sid64 = v.sid64,
                tokens = v.total_tokens
            }
        end

        sReward.addToQueue(nil, "leaderboard")
    end)
end

--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher
