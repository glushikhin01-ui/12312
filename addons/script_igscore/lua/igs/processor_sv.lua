--leak by matveicher
--vk group - https://vk.com/gmodffdev
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/V329W7Ce8g
--ds - matveicher

local function IGS_DBReady()
	return rp and rp._Stats and isfunction(rp._Stats.Query)
end

local function IGS_SQLStr(v)
	return sql.SQLStr(tostring(v or ""))
end

local function IGS_MirrorEnsureTables()
	if not IGS_DBReady() then return end

	rp._Stats:Query([[CREATE TABLE IF NOT EXISTS GMDonate_Players (
		SteamID64 VARCHAR(32) NOT NULL PRIMARY KEY,
		Nick VARCHAR(128) DEFAULT '',
		Balance BIGINT NOT NULL DEFAULT 0,
		Score BIGINT NOT NULL DEFAULT 0,
		TotalTransactions BIGINT NOT NULL DEFAULT 0,
		Level INT NOT NULL DEFAULT 0,
		UpdatedAt INT NOT NULL DEFAULT 0,
		KEY idx_gmd_balance (Balance),
		KEY idx_gmd_updated (UpdatedAt)
	) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci]])

	rp._Stats:Query([[CREATE TABLE IF NOT EXISTS GMDonate_Transactions (
		TxHash VARCHAR(64) NOT NULL PRIMARY KEY,
		SteamID64 VARCHAR(32) NOT NULL,
		Sum BIGINT NOT NULL DEFAULT 0,
		Note TEXT,
		TxTime INT NOT NULL DEFAULT 0,
		RawJSON MEDIUMTEXT,
		UpdatedAt INT NOT NULL DEFAULT 0,
		KEY idx_gmd_tx_sid (SteamID64),
		KEY idx_gmd_tx_time (TxTime)
	) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci]])
end

timer.Simple(3, IGS_MirrorEnsureTables)

local function IGS_MirrorPlayer(pl, balance, score, totalTransactions, lvl)
	if not IGS_DBReady() or not IsValid(pl) then return end
	IGS_MirrorEnsureTables()
	local sid64 = pl:SteamID64()
	local nick = pl:Nick() or pl:Name() or ""
	balance = math.floor(tonumber(balance) or tonumber(pl:IGSFunds()) or 0)
	score = math.floor(tonumber(score) or tonumber(pl.igs_score) or 0)
	totalTransactions = math.floor(tonumber(totalTransactions) or tonumber(pl:GetIGSVar("igs_total_transactions")) or 0)
	lvl = math.floor(tonumber(lvl) or tonumber(pl:GetIGSVar("igs_lvl")) or 0)

	rp._Stats:Query(string.format(
		[[INSERT INTO GMDonate_Players (SteamID64, Nick, Balance, Score, TotalTransactions, Level, UpdatedAt)
		  VALUES (%s, %s, %d, %d, %d, %d, %d)
		  ON DUPLICATE KEY UPDATE Nick = VALUES(Nick), Balance = VALUES(Balance), Score = VALUES(Score),
		  TotalTransactions = VALUES(TotalTransactions), Level = VALUES(Level), UpdatedAt = VALUES(UpdatedAt)]],
		IGS_SQLStr(sid64), IGS_SQLStr(nick), balance, score, totalTransactions, lvl, os.time()
	))
end

local function IGS_MirrorTransactions(pl, dat)
	if not IGS_DBReady() or not IsValid(pl) or not istable(dat) then return end
	IGS_MirrorEnsureTables()
	local sid64 = pl:SteamID64()
	for _, tr in ipairs(dat) do
		local sum = math.floor(tonumber(tr.Sum or tr.sum or 0) or 0)
		local note = tostring(tr.Note or tr.note or "")
		local txTime = math.floor(tonumber(tr.Time or tr.time or tr.Date or tr.date or 0) or 0)
		local raw = util.TableToJSON(tr, false) or "{}"
		local idPart = tostring(tr.ID or tr.Id or tr.id or "")
		local hash = util.CRC(sid64 .. "|" .. idPart .. "|" .. tostring(sum) .. "|" .. tostring(txTime) .. "|" .. note)
		rp._Stats:Query(string.format(
			[[INSERT INTO GMDonate_Transactions (TxHash, SteamID64, Sum, Note, TxTime, RawJSON, UpdatedAt)
			  VALUES (%s, %s, %d, %s, %d, %s, %d)
			  ON DUPLICATE KEY UPDATE Sum = VALUES(Sum), Note = VALUES(Note), TxTime = VALUES(TxTime), RawJSON = VALUES(RawJSON), UpdatedAt = VALUES(UpdatedAt)]],
			IGS_SQLStr(hash), IGS_SQLStr(sid64), sum, IGS_SQLStr(note), txTime, IGS_SQLStr(raw), os.time()
		))
	end
end


local function giveLvlBonuses(pl, from_lvl, to_lvl)
	for i = from_lvl,to_lvl do
		local lvl = IGS.LVL.Get(i)

		if lvl.bonus then
			lvl.bonus(pl)
		end

		IGS.NotifyAll(pl:Name() .. " получил новый (" .. i .. ") бизнес уровень - " .. lvl:Name())
	end
end

local function recalcTransactionsAndBonuses(pl, bGiveBonuses)
	-- Сумма операций
	IGS.GetPlayerTransactionsBypassingLimit(function(dat)
		local tt = 0
		for _,v in ipairs(dat) do
			tt = v.Sum > 0 and tt + v.Sum or tt
		end

		local prev_lvl = IGS.PlayerLVL(pl) or 0 -- не двигать под igs_lvl!
		local newLvl = IGS.LVL.GetByCost( IGS.RealPrice(tt) ):LVL()
		pl:SetIGSVar("igs_lvl", newLvl)
		pl:SetIGSVar("igs_total_transactions", tt)
		IGS_MirrorTransactions(pl, dat)
		IGS_MirrorPlayer(pl, pl:IGSFunds(), pl.igs_score, tt, newLvl)

		if bGiveBonuses and IGS.PlayerLVL(pl) > prev_lvl then
			giveLvlBonuses(pl, prev_lvl + 1, IGS.PlayerLVL(pl))
		end
	end, pl:SteamID64())
end


local function updateBalance(pl, fOnFinish, bGiveBonuses)
	IGS.GetPlayer(pl:SteamID64(),function(pld_)
		if not IsValid(pl) then return end
		local now_igs_ = pld_ and pld_.Balance
		local now_score_ = pld_ and pld_.Score

		local was_igs = pl:IGSFunds()
		local diff = (now_igs_ or 0) - was_igs

		if diff ~= 0 then -- баланс ~= nil и не 0 (? https://t.me/c/1353676159/45001)
			pl:SetIGSVar("igs_balance", now_igs_) -- НЕ ДОЛЖНО ВЫПОЛНЯТЬСЯ НА НЕ_КЛИЕНТОВ
		end

		if now_score_ ~= nil then
			pl.igs_score = now_score_ -- #todo make netvar
		end

		if now_igs_ ~= nil then
			IGS_MirrorPlayer(pl, now_igs_, now_score_)
		end

		if now_igs_ then 
			recalcTransactionsAndBonuses(pl, bGiveBonuses)
		end

		if fOnFinish then
			fOnFinish(now_igs_, diff)
		end
	end)
end


hook.Add("PlayerInitialSpawn", "IGS.LoadPlayer", function(pl)
	if pl:IsBot() then return end

	updateBalance(pl, function(now_igs_)
		if (not IsValid(pl)) then return end

		IGS.LoadPlayerPurchases(pl)
		IGS.LoadInventory(pl)

		if now_igs_ and now_igs_ > 0 then
			IGS.UpdatePlayerName(pl:SteamID64(), pl:Name())
		end
	end)
end)

local function repairBrokenPurchases(pl,purchases)
	for uid in pairs(purchases) do -- , count
		local ITEM = IGS.GetItemByUID(uid)

		if ITEM:IsValid(pl) == false then
			ITEM:Setup(pl) 
		end
	end
end

hook.Add("IGS.PlayerPurchasesLoaded", "RestorePex", function(pl,purchases)
	if purchases then
		repairBrokenPurchases(pl, purchases)
	end
end)


-- https://gist.github.com/1b41e1f869752d4750440619339e4085
hook.Add("IGS.PaymentStatusUpdated","NoRejoiningCharge",function(pl,dat)
	if dat.method ~= "pay" then return end

	--timer.Simple(1,function() -- даем успеть в БД обновить данные

		updateBalance(pl,function(new_bal, diff)
			hook.Run("IGS.PlayerDonate", pl, diff, new_bal)
		end, true) -- updateBalance with bGiveBonuses

	--end) -- timer 1
end)


--leak by matveicher
--vk group - https://vk.com/gmodffdev
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/V329W7Ce8g
--ds - matveicher