--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher

util.AddNetworkString("enc.inv.sync")
util.AddNetworkString("enc.inv.syncent")
util.AddNetworkString("enc.inv.move")
util.AddNetworkString("enc.inv.open_crate")
util.AddNetworkString("enc.inv.refresh")
util.AddNetworkString("enc.inv.use")
util.AddNetworkString("enc.inv.drop")

sql.Query([[CREATE TABLE IF NOT EXISTS "inventory" (
	"SteamID"	INTEGER UNIQUE,
	"Inventory"	TEXT,
	PRIMARY KEY("SteamID")
);]])

concommand.Add('inventory_wipedata', function(ply)
	if IsValid(ply) then print(ply, ' tried to ran command wipe-data in inventory.') ply:ChatPrint('Эта команда доступна только в коносли.') return end

	sql.Query("DROP TABLE inventory;")
	print("Inventory was successfully dropped.")

	sql.Query([[CREATE TABLE "inventory" (
		"SteamID"	INTEGER UNIQUE,
		"Inventory"	TEXT,
		PRIMARY KEY("SteamID")
	);]])
end)

concommand.Add('inventory_wipedata_accs', function(ply)
	if IsValid(ply) then print(ply, ' tried to ran command wipe-data in inventory accs.') ply:ChatPrint('Эта команда доступна только в коносли.') return end
	sql.Query("DROP TABLE aas_inventory;")
	print("aas_inventory was successfully dropped.")

	sql.Query("CREATE TABLE IF NOT EXISTS aas_inventory (steam_id VARCHAR(64), uniqueId INT, price VARCHAR(100))")
end)

local PLAYER = FindMetaTable"Player"

function PLAYER:GetInvFreeSlot()
	local slot = false

	for i=1,5*10 do
		if !self.inventory[i] then slot = i break end
	end

	return slot
end

function PLAYER:HasItem( class )
	local has = false

	for i=1,5*10 do
		if self.inventory[i].Class == class then has = true break end
	end

	return has
end

function PLAYER:SaveDB()
	sql.Query( ('UPDATE "inventory" SET Inventory=%s WHERE SteamID=%s;'):format( SQLStr(util.TableToJSON(self.inventory or {})), SQLStr(self:SteamID64()) ) )
end

function PLAYER:AddItem( class, data )
	local slot = self:GetInvFreeSlot()
	if !slot then return print("inventory full") end
	print('Add Item To inventory', class)

	self.inventory[slot] = {Class = class, Data = data}
	self:SyncInventoryData()
	self:SaveDB()
end

function PLAYER:AddSlotItem( class, slot, data )
	if self.inventory[class] then return print("inventory full") end

	self.inventory[slot] = {Class = class, Data = data}
	self:SyncInventoryData()
	self:SaveDB()
end

function PLAYER:HasInvAccessory( uID )
	local has = false

	for i=-4,5*10 do
		local class = self.inventory[i] or {}
		class = class.Class or ''
		if class[1] == '_' and string.TrimLeft( class, "_acc_" ) == tostring(uID) then has = true break end
	end
	return has
end

function PLAYER:SyncInventoryData()
	net.Start("enc.inv.sync")
	net.WriteTable(self.inventory or {})
	net.Send(self)
end

function PLAYER:RefreshInventory()
	net.Start('enc.inv.refresh')
	net.Send(self)
end

net.Receive("enc.inv.sync", function(_,ply)
	ply:SyncInventoryData()
end)

net.Receive("enc.inv.syncent", function(_,ply)
	local ent = net.ReadEntity()

	if !IsValid(ent) then return end
	if ent:GetClass() != "inv_dumpster" then return end
	if(ent:GetPos():Distance(ply:GetPos()) > 100) then return end

	net.Start("enc.inv.syncent")
	net.WriteEntity(ent)
	net.WriteTable(ent.inventory or {})
	net.Send(ply)
end)

local accesories = {
	[-1] = {"Головной убор"},
	[-2] = {"Маски"},
	[-3] = {"Шея"},
	[-4] = {"Спина"},
}

hook.Add("PlayerInitialSpawn", "enc.inv.load", function(ply)
	nw.WaitForPlayer(ply, function()
		local data = sql.Query( ('SELECT * FROM `inventory` WHERE SteamID=%s'):format( SQLStr(ply:SteamID64()) ) ) or {}

		if #data <= 0 then
			ply.inventory = {}
			ply:SyncInventoryData()
			sql.Query( ('INSERT INTO "inventory" ("SteamID", "Inventory") VALUES (%s, %s);'):format( SQLStr(ply:SteamID64()), SQLStr('[]') ) )
			return
		end

		ply.inventory = util.JSONToTable(data[1].Inventory)
		ply:SyncInventoryData()
		for i=-4,-1 do
			local class = ply.inventory[i] or {}
			class = class.Class
			local item = enc_inv.stored[class] or {}

			if item.uID then
				ply:AASEquipAccessory(item.uID)
			end
		end
	end)
end)


function PLAYER:OpenCrate( ent )
	net.Start("enc.inv.open_crate")
	net.WriteEntity(ent)
	net.Send(self)
end

local ENTITY = FindMetaTable"Entity"

function ENTITY:SyncItems()
	for k,v in pairs(ents.FindInSphere(self:GetPos(), 150)) do
		if !v:IsPlayer() then continue end
		net.Start("enc.inv.syncent")
		net.WriteEntity(self)
		net.WriteTable(self.inventory or {})
		net.Send(v)
	end
end

net.Receive("enc.inv.move", function(_,ply)
	local from = net.ReadInt(12)
	local to = net.ReadInt(12)
	local ent = net.ReadEntity()
	local incrate = net.ReadBool()
	local fromcrate = net.ReadBool()

	if (to < 1 and !accesories[to]) || (from < 1 and !accesories[from]) then return end
	if to > 112 || from > 112 then return end

	local item = ply.inventory[from]
	local itemto = ply.inventory[to]

	if IsValid(ent) and ent:GetClass() == 'inv_dumpster' and ent:GetPos():Distance(ply:GetPos()) < 100 then
		if(incrate and fromcrate) then
			local _item = ent.inventory[from]
			local _itemto = ent.inventory[to]
			
			if !_item then return end
			if _itemto then return end

			ent.inventory[to] = _item
			ent.inventory[from] = nil
		elseif(incrate and !fromcrate) then
			local _item = ply.inventory[from]
			local _itemto = ent.inventory[to]
			
			if !_item then return end
			if _itemto then return end

			ent.inventory[to] = _item
			ply.inventory[from] = nil
			ply:SyncInventoryData()
		elseif(fromcrate and !incrate) then
			local _item = ent.inventory[from]
			local _itemto = ply.inventory[to]
			
			if !_item then return end
			if _itemto then return end

			ply.inventory[to] = _item
			ent.inventory[from] = nil
		end

		ply:SyncInventoryData()
		ent:SyncItems()

		return
	end

	if !item then return end
	if itemto then return end

	item = item.Class
	itemto = item.Class
	if accesories[to] then
		if item[1] == "_" then 
			local id = string.TrimLeft( item, "_acc_" )
			local tb = AAS.FormatTable(id)
			local f
			for k,v in pairs(accesories[to]) do
				if tb.category == v then
					ply:AASEquipAccessory(id)
					f = true
				end
			end
			if not f then return end
		else
			return
		end
	elseif accesories[from] then
		local id = string.TrimLeft( item, "_acc_" )
		ply:AASUnEquipAccessoryById( tonumber(id) )
	end

	ply.inventory[to] = ply.inventory[from]
	ply.inventory[from] = nil
	ply:SyncInventoryData()
	ply:RefreshInventory()
	sql.Query( ('UPDATE "inventory" SET Inventory=%s WHERE SteamID=%s;'):format( SQLStr(util.TableToJSON(ply.inventory or {})), SQLStr(ply:SteamID64()) ) )
end)

--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher
