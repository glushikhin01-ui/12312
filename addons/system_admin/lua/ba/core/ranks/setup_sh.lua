--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher

------------------------------------------
-- НАБОРНЫЕ
--[[
Флаги:
u - user
v - vip
m - moderator
a - administrator
l - ls-sostav
s - vs-sostav
d - dep-manager
e - manager
c - curator
]]--
ba.ranks.Create('*', 20)
	:SetImmunity(20000)
	:SetRoot(true)

ba.ranks.Create('uprav', 19)
	:SetImmunity(20000)
	:SetRoot(true)

ba.ranks.Create('team', 18)
	:SetImmunity(12)
	:SetFlags('uvmalsdec*')
	:SetMaxBan( 500 * 86400, "500d" )
	:SetMaxHPAR( "100" )
	:SetAdmin(true)
	:SetSuperAdmin(true)

ba.ranks.Create('supervisior', 17)
	:SetImmunity(11)
	:SetFlags('uvmalsde')
	:SetMaxBan( 500 * 86400, "500d" )
	:SetMaxHPAR( "100" )
	:SetAdmin(true)
	:SetSuperAdmin(true)

ba.ranks.Create('zam-supervisior', 16)
	:SetImmunity(10)
	:SetFlags('uvmalsde')
	:SetMaxBan( 500 * 86400, "500d" )
	:SetMaxHPAR( "100" )
	:SetAdmin(true)
	:SetSuperAdmin(true)
    
ba.ranks.Create('overwatch', 15)
	:SetImmunity(10)
	:SetFlags('uvmalsde')
	:SetMaxBan( 500 * 86400, "500d" )
	:SetMaxHPAR( "100" )
	:SetAdmin(true)

ba.ranks.Create('root', 14)
	:SetImmunity(10)
	:SetFlags('uvmalsde')
	:SetMaxBan( 500 * 86400, "500d" )
	:SetMaxHPAR( "100" )
	:SetAdmin(true)

ba.ranks.Create('d-creator', 13)
	:SetImmunity(9)
	:SetFlags('uvmalsd')
	:SetMaxBan( 999 * 86400, "999d" )
	:SetMaxHPAR( "100" )
	:SetAdmin(true)

ba.ranks.Create('d-arizona', 12)
	:SetImmunity(9)
	:SetFlags('uvmal')
	:SetMaxBan( 999 * 86400, "999d" )
	:SetMaxHPAR( "100" )
	:SetAdmin(true)

ba.ranks.Create('support', 11)
	:SetImmunity(8)
	:SetFlags('uvmal')
	:SetMaxBan( 999 * 86400, "999d" )
	:SetMaxHPAR( "100" )
	:SetAdmin(true)

ba.ranks.Create('admin', 10)
	:SetImmunity(7)
	:SetFlags('uvma')
	:SetMaxBan( 999 * 86400, "999d" )
	:SetMaxHPAR( "100" )
	:SetAdmin(true)

ba.ranks.Create('sponsor', 9)
	:SetImmunity(7)
	:SetFlags('uvma')
	:SetMaxBan( 30 * 86400, "30d" )
	:SetMaxHPAR( "100" )
	:SetAdmin(true)

ba.ranks.Create('moder', 8)
	:SetImmunity(7)
	:SetFlags('uvma')
	:SetMaxBan( 7 * 86400, "7d" )
	:SetMaxHPAR( "100" )
	:SetAdmin(true)

ba.ranks.Create('mlmoder', 7)
	:SetImmunity(6)
	:SetFlags('uvm')
	:SetMaxBan( 3 * 86400, "3d" )
	:SetMaxHPAR( "100" )
	:SetAdmin(true)

ba.ranks.Create('assistant', 6)
	:SetImmunity(6)
	:SetFlags('uvm')
	:SetMaxBan( 1 * 86400, "1d" )
	:SetMaxHPAR( "100" )
	:SetAdmin(true)

ba.ranks.Create('d-admin', 5)
	:SetImmunity(5)
	:SetFlags('uv')
	:SetMaxJail( 45 * 60, "45mi" )
	:SetAdmin(true)
--[[ Старые
ba.ranks.Create('gl-admin', 19)
	:SetImmunity(3000)
	:SetFlags('uvmaszowpdntcg')
	:SetMaxBan( 500 * 86400, "500d" )
	:SetMaxJail( 60 * 60, "60mi" )
	:SetMaxHPAR( "100" )
	:SetAdmin(true)

ba.ranks.Create('curator', 18)
	:SetImmunity(2000)
	:SetFlags('uvmaszowpntc')
	:SetMaxBan( 500 * 86400, "500d" )
	:SetMaxJail( 60 * 60, "60mi" )
	:SetMaxHPAR( "100" )
	:SetAdmin(true)

ba.ranks.Create('zam-curator', 17)
	:SetImmunity(1000)
	:SetFlags('uvmaszowpnt')
	:SetMaxBan( 500 * 86400, "500d" )
	:SetMaxJail( 60 * 60, "60mi" )
	:SetMaxHPAR( "100" )
	:SetAdmin(true)

ba.ranks.Create('st-admin', 16)
	:SetImmunity(900)
	:SetFlags('uvmaszowpnt')
	:SetMaxBan( 500 * 86400, "500d" )
	:SetMaxJail( 60 * 60, "60mi" )
	:SetMaxHPAR( "100" )
	:SetAdmin(true)

ba.ranks.Create('admin', 15)
	:SetImmunity(650)
	:SetFlags('uvmaszpn')
	:SetMaxBan( 500 * 86400, "500d" )
	:SetMaxJail( 60 * 60, "60mi" )
	:SetMaxHPAR( "100" )
	:SetAdmin(true)

ba.ranks.Create('moderator', 14)
	:SetImmunity(550)
	:SetFlags('uvmas')
	:SetMaxBan( 30 * 86400, "30d" )
	:SetMaxJail( 60 * 60, "60mi" )
	:SetMaxHPAR( "100" )
	:SetAdmin(true)
	
ba.ranks.Create('helper', 13)
	:SetImmunity(450)
	:SetFlags('uvmas')
	:SetMaxBan( 7 * 86400, "7d" )
	:SetMaxJail( 60 * 60, "60mi" )
	:SetMaxHPAR( "100" )
	:SetAdmin(true)	

--]]
------------------------------------------
-- ИВЕНТОЛОГ
------------------------------------------

------------------------------------------
-- ДОНАТ
------------------------------------------

ba.ranks.Create('d-moderator', 4)
	:SetImmunity(100)
	:SetFlags('uvm')
	:SetMaxJail( 45 * 60, "45mi" )
	:SetAdmin(true)

ba.ranks.Create('Premium', 3)
	:SetImmunity(1)
	:SetFlags('uv')
	:SetVIP(true)

ba.ranks.Create('VIP', 2)
	:SetImmunity(1)
	:SetFlags('uv')
	:SetVIP(true)

ba.ranks.Create('User', 1)
	:SetImmunity(0)
	:SetFlags('u')

--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher
