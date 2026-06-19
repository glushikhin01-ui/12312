local PromoCodes = {}

function VibeRP.SyncPromos()
    if not VibeRP or not VibeRP.Config then return end
    local url = VibeRP.Config.PanelURL .. "/api/promos_sync?action=list&password=" .. VibeRP.Config.Secret
    HTTP({
        url = url, method = "GET",
        headers = { ["Accept"] = "application/json" },
        success = function(code, body)
            if code < 200 or code >= 300 then return end
            local ok, data = pcall(util.JSONToTable, body)
            if not ok or not data or not data.ok then return end

            local newPromos = {}
            for _, row in ipairs(data.items or {}) do
                if row.is_active == 1 or row.is_active == true then
                    local code = string.upper(tostring(row.code or ""))
                    if code ~= "" then
                        newPromos[code] = {
                            id          = tonumber(row.id) or 0,
                            code        = code,
                            donate      = tonumber(row.donate) or 0,
                            money       = tonumber(row.money) or 0,
                            max_uses    = tonumber(row.max_uses) or 0,
                            exp_date    = row.expiration_date,
                            is_active   = true,
                        }
                    end
                end
            end

            PromoCodes = newPromos
            print("[ПРОМОКОДЫ] Синхронизировано " .. table.Count(PromoCodes) .. " промокодов с сайта")

            for code, promo in pairs(PromoCodes) do
                local CMD = code
                local cmdName = string.lower(code)
                if not concommand.GetTable()[cmdName] and not ba.cmd.Exists(cmdName) then
                    ba.cmd.Create(cmdName, function(ply, args)
                        VibeRP.ActivatePromo(ply, CMD)
                    end):SetHelp("Активировать промокод " .. cmdName)
                end
            end
        end,
        failed = function(reason)
            print("[ПРОМОКОДЫ] Ошибка синхронизации: " .. tostring(reason))
        end
    })
end

local function hasUsedPromo(promoId, steamid64, callback)
    local url = VibeRP.Config.PanelURL .. "/api/promos_sync?action=has_used&promo_id=" .. promoId .. "&steamid64=" .. steamid64 .. "&password=" .. VibeRP.Config.Secret
    HTTP({
        url = url, method = "GET",
        headers = { ["Accept"] = "application/json" },
        success = function(code, body)
            if code >= 200 and code < 300 then
                local ok, data = pcall(util.JSONToTable, body)
                if ok and data then callback(data.used == true) return end
            end
            callback(false)
        end,
        failed = function() callback(false) end
    })
end

local function recordPromoUse(promoId, steamid64, steamid32, nickname)
    local url = VibeRP.Config.PanelURL .. "/api/promos_sync"
    HTTP({
        url = url, method = "POST",
        body = util.TableToJSON({
            action     = "record_use",
            password   = VibeRP.Config.Secret,
            promo_id   = promoId,
            steamid64  = steamid64,
            steamid32  = steamid32,
            nickname   = nickname,
        }),
        type = "application/json",
        headers = { ["Content-Type"] = "application/json" },
        success = function() end,
        failed = function(reason) print("[ПРОМОКОДЫ] Ошибка записи использования: " .. tostring(reason)) end
    })
end

local function giveDonate(ply, amount)
    if IGS and IGS.PLAYER and IGS.PLAYER.AddFunds then IGS.PLAYER.AddFunds(ply, amount) return true end
    if ply.AddIGSFunds then ply:AddIGSFunds(amount, "Промокод") return true end
    if ply.addDonate then ply:addDonate(amount) return true end
    return false
end

local function giveMoney(ply, amount)
    if ply.addMoney then ply:addMoney(amount) return true end
    if ply.AddMoney then ply:AddMoney(amount) return true end
    return false
end

function VibeRP.ActivatePromo(ply, CMD)
    local promo = PromoCodes[CMD]
    if not promo then
        ply:ChatPrint("Промокод не найден")
        return
    end

    if promo.exp_date then
        local y, mo, d, h, mi, s = string.match(promo.exp_date, "(%d+)-(%d+)-(%d+) (%d+):(%d+):(%d+)")
        if y and os.time() > os.time({year=tonumber(y), month=tonumber(mo), day=tonumber(d), hour=tonumber(h), min=tonumber(mi), sec=tonumber(s)}) then
            ply:ChatPrint("Промокод истёк")
            return
        end
    end

    if promo.max_uses > 0 and promo.id > 0 then
        local url = VibeRP.Config.PanelURL .. "/api/promos_sync?action=get_usage_count&promo_id=" .. promo.id .. "&password=" .. VibeRP.Config.Secret
        HTTP({
            url = url, method = "GET",
            headers = { ["Accept"] = "application/json" },
            success = function(code, body)
                if code >= 200 and code < 300 then
                    local ok, data = pcall(util.JSONToTable, body)
                    if ok and data and (data.count or 0) >= promo.max_uses then
                        ply:ChatPrint("Промокод исчерпан")
                        return
                    end
                end
                hasUsedPromo(promo.id, ply:SteamID64(), function(used)
                    if used then
                        ply:ChatPrint("Вы уже использовали этот промокод")
                        return
                    end
                    VibeRP.ApplyPromoReward(ply, CMD, promo)
                end)
            end,
            failed = function()
                ply:ChatPrint("Ошибка проверки промокода, попробуйте позже")
            end
        })
    else
        hasUsedPromo(promo.id, ply:SteamID64(), function(used)
            if used then
                ply:ChatPrint("Вы уже использовали этот промокод")
                return
            end
            VibeRP.ApplyPromoReward(ply, CMD, promo)
        end)
    end
end

function VibeRP.ApplyPromoReward(ply, CMD, promo)
    recordPromoUse(promo.id, ply:SteamID64(), ply:SteamID(), ply:Nick())

    local rewardText = {}

    if promo.donate > 0 then
        if giveDonate(ply, promo.donate) then
            table.insert(rewardText, promo.donate .. " донат-рублей")
        else
            ply:ChatPrint("Ошибка: система доната не найдена")
            return
        end
    end

    if promo.money > 0 then
        if giveMoney(ply, promo.money) then
            table.insert(rewardText, string.format("%s$", string.Comma(promo.money)))
        end
    end

    if #rewardText > 0 then
        ply:ChatPrint("Вы получили: " .. table.concat(rewardText, " + ") .. " за промокод!")
    end

    for _, v in ipairs(player.GetAll()) do
        if IsValid(v) then
            v:ChatPrint(ply:Nick() .. " активировал промокод /" .. string.lower(CMD))
        end
    end
end

hook.Add("Initialize", "VibeRP_PromoInit", function()
    timer.Simple(8, function()
        VibeRP.SyncPromos()
    end)
    timer.Create("VibeRP_PromoSync", 120, 0, function()
        VibeRP.SyncPromos()
    end)
end)

print("[ПРОМОКОДЫ] Модуль загружен, ожидание синхронизации с сайтом...")