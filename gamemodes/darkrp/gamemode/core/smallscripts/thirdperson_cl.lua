--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher

cvar.Register'enable_thirdperson':SetDefault(false):AddMetadata('State', 'RPMenu'):AddMetadata('Menu', 'Включить вид от 3 лица')

local function scopeAiming()
	local wep = LocalPlayer():GetActiveWeapon()

	return IsValid(wep) and wep.SWBWeapon and wep.dt and (wep.dt.State == SWB_AIMING)
end

local camOffset = {
	UD = 0, -- Up / Down. Use a positive number for up, negative for right. Default = 0
	RL = 0, -- Right / Left. Use a positive number for right, negative for left. Default = 0
	FB = -88 -- Forward / Backward. Use a positive number for forward ( Not sure why you would do it ), negative for backward. Default = -88
}

hook('ShouldDrawLocalPlayer', 'ThirdPersonDrawPlayer', function()
	if cvar.GetValue('enable_thirdperson') then return ((not LocalPlayer():InVehicle()) and (not scopeAiming())) end
end)

hook('CalcView', 'ThirdPersonCalcView', function(pl, origin, ang, fov)
	if cvar.GetValue('enable_thirdperson') and (not pl:InVehicle()) and (not scopeAiming()) then
		return {
			origin = util.TraceLine({
				start = origin,
				endpos = origin + (ang:Up() * camOffset.UD) + (ang:Right() * camOffset.RL) + (ang:Forward() * camOffset.FB),
				filter = pl
			}).HitPos + (ang:Forward() * 16),
			angles = ang,
			fov = fov
		}
	end
end)

--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher
