local PromoCodes = {
    ["START"] = { donate = 300, max_uses = 0, expiration_date = nil },
    ["RANDE"] = { donate = 500, max_uses = 0, expiration_date = nil },
    ["9MAY"] = { donate = 500, max_uses = 0, expiration_date = "2026-05-20 23:59:59" },
    ["OBNOVA"] = { donate = 1000, max_uses = 0, expiration_date = "2026-06-01 23:59:59" },
    ["ARIZONA"] = { 
        rewards = {
            donate = 2000, 
            money = 500000 
        },
        max_uses = 0, 
        expiration_date = nil 
    },
    ["NEWHOSTING"] = { donate = 1000, max_uses = 0, expiration_date = nil }
}

if not file.IsDir("promocodes", "DATA") then file.CreateDir("promocodes") end
if not file.IsDir("promocodes_usage", "DATA") then file.CreateDir("promocodes_usage") end

local function isPromoExpired(promo)
    if not promo.expiration_date then return false end
    local y,mo,d,h,mi,s = string.match(promo.expiration_date, "(%d+)-(%d+)-(%d+) (%d+):(%d+):(%d+)")
    if not y then return false end
    return os.time() > os.time({year=tonumber(y),month=tonumber(mo),day=tonumber(d),hour=tonumber(h),min=tonumber(mi),sec=tonumber(s)})
end

local function getCount(cmd)
    local p = "promocodes_usage/" .. cmd .. "_count.txt"
    if file.Exists(p, "DATA") then return tonumber(file.Read(p, "DATA")) or 0 end
    return 0
end

local function incCount(cmd)
    file.Write("promocodes_usage/" .. cmd .. "_count.txt", tostring(getCount(cmd) + 1))
end

local function usedBy(ply, cmd)
    return file.Exists("promocodes/" .. ply:SteamID64() .. "_" .. cmd .. ".txt", "DATA")
end

local function giveDonate(ply, amount)
    if IGS and IGS.PLAYER and IGS.PLAYER.AddFunds then IGS.PLAYER.AddFunds(ply, amount) return true end
    if ply.AddIGSFunds then ply:AddIGSFunds(amount) return true end
    if ply.addDonate then ply:addDonate(amount) return true end
    if ply.addMoney then ply:addMoney(amount) return true end
    if ply.AddMoney then ply:AddMoney(amount) return true end
    return false
end

local function activate(ply, CMD)
    local promo = PromoCodes[CMD]
    if not promo then ply:ChatPrint("Промокод не найден") return end
    if isPromoExpired(promo) then ply:ChatPrint("Промокод истёк") return end
    if promo.max_uses > 0 and getCount(CMD) >= promo.max_uses then ply:ChatPrint("Промокод исчерпан") return end
    if usedBy(ply, CMD) then ply:ChatPrint("Вы уже использовали этот промокод") return end

    file.Write("promocodes/" .. ply:SteamID64() .. "_" .. CMD .. ".txt", os.date('%Y-%m-%d %H:%M:%S'))
    if promo.max_uses > 0 then incCount(CMD) end

    if promo.rewards then
        if promo.rewards.donate and promo.rewards.donate > 0 then giveDonate(ply, promo.rewards.donate) end
        if promo.rewards.money and promo.rewards.money > 0 then
            if ply.addMoney then ply:addMoney(promo.rewards.money)
            elseif ply.AddMoney then ply:AddMoney(promo.rewards.money) end
        end
        if promo.rewards.items then
            for _, item in ipairs(promo.rewards.items) do
                for i = 1, item.count do
                    if IGS and IGS.PLAYER and IGS.PLAYER.AddItem then IGS.PLAYER.AddItem(ply, item.name)
                    elseif ply.AddItem then ply:AddItem(item.name)
                    elseif ply.giveItem then ply:giveItem(item.name) end
                end
            end
        end
        ply:ChatPrint("Вы получили награду за промокод!")
    elseif promo.donate then
        if giveDonate(ply, promo.donate) then
            ply:ChatPrint("Вы получили " .. promo.donate .. " донат-рублей!")
        else
            ply:ChatPrint("Ошибка: система доната не найдена")
            file.Delete("promocodes/" .. ply:SteamID64() .. "_" .. CMD .. ".txt")
            return
        end
    end

    for _, v in ipairs(player.GetAll()) do
        v:ChatPrint(ply:Nick() .. " активировал промокод /" .. string.lower(CMD))
    end
end

for code, _ in pairs(PromoCodes) do
    local CMD = code
    ba.cmd.Create(string.lower(code), function(ply, args)
        activate(ply, CMD)
    end)
    :SetHelp("Активировать промокод " .. string.lower(code))
end

print("[ПРОМОКОДЫ] Готово, зарегистрировано " .. table.Count(PromoCodes) .. " промокодов")