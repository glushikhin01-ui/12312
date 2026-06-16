eui.bonus = eui.bonus or {}
eui.bonus.time = 18000

function eui.bonus.AddWin(pl)
	KylDonate.AddDonateCoins(pl:SteamID(), 2500)
	pl:ChatPrint('Вы получили награду за отыгрыш 5 часов!')
end

nw.Register('eui.bonus:Time')
	:Write(net.WriteUInt, 32)
	:Read(net.ReadUInt, 32)
	:SetLocalPlayer()

nw.Register('eui.bonus:Win')
	:Write(net.WriteBool)
	:Read(net.ReadBool)
	:SetLocalPlayer()

nw.Register('eui.bonus:Claimed')
	:Write(net.WriteBool)
	:Read(net.ReadBool)
	:SetLocalPlayer()
