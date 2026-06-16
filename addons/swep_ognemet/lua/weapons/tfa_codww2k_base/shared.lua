DEFINE_BASECLASS("tfa_bash_base")

-- For some reason adding this fixes vmanip. Adding SWEP.ViewModelElements doesn't work! 
SWEP.VElements = {
	
}

--[ADS fire notif]-- Copy paste of jamming msg
function SWEP:NotifyAdsFire()
	local ply = self:GetOwner()

	if IsValid(ply) and ply:IsPlayer() and IsFirstTimePredicted() and (not ply._TFA_LastJamMessage or ply._TFA_LastJamMessage < RealTime()) then
		ply:PrintMessage(HUD_PRINTCENTER, "#tfa.msg.adsfire")
		ply._TFA_LastJamMessage = RealTime() + 1
	end
end

--[ADS Sway]-- Credit to yurie from crysis 2 sweps
function SWEP:Sway(pos, ang, ftv, ...)
	local spos, sang = BaseClass.Sway(self, pos * 1, ang * 1, ftv, ...)

	if self.IronSightsProgress > .01 then
		spos = Lerp(self.IronSightsProgress * .82, spos, pos)
		sang = Lerp(self.IronSightsProgress * .82, sang, ang)
	end

	return spos, sang
end

--[Sound Layers]--
function SWEP:PostPrimaryAttack()
	if not self.Primary then return end
	if self:GetSilenced() then return end
	local ply = self:GetOwner()
	local ifp = IsFirstTimePredicted()
	if not IsValid(ply) then return end
	
	local lyr1 = self:GetStat("Primary.SoundLyr1")
	if lyr1 and ifp then
		self:EmitGunfireSound(lyr1)
	end
	
	local lyr2 = self:GetStat("Primary.SoundLyr2")
	if lyr2 and ifp then
		self:EmitGunfireSound(lyr2)
	end
	
	local lyr3 = self:GetStat("Primary.SoundLyr3")
	if lyr3 and ifp then
		self:EmitGunfireSound(lyr3)
	end
	
	local lyr4 = self:GetStat("Primary.SoundLyr4")
	if lyr4 and ifp then
		self:EmitGunfireSound(lyr4)
	end
	
	local lyr5 = self:GetStat("Primary.SoundLyr5")
	if lyr5 and ifp then
		self:EmitGunfireSound(lyr5)
	end
	
	local lyr6 = self:GetStat("Primary.SoundLyr6")
	if lyr6 and ifp then
		self:EmitGunfireSound(lyr6)
	end
	
	local lyr7 = self:GetStat("Primary.SoundLyr7")
	if lyr7 and ifp then
		self:EmitGunfireSound(lyr7)
	end
	
	local lyr8 = self:GetStat("Primary.SoundLyr8")
	if lyr8 and ifp then
		self:EmitGunfireSound(lyr8)
	end
	
	local lyr9 = self:GetStat("Primary.SoundLyr9")
	if lyr9 and ifp then
		self:EmitGunfireSound(lyr9)
	end
end

--[Ammo Pickup Sounds]-- Credit to yurie from crysis 2 sweps
if SERVER then
	function SWEP:OwnerChanged(...)
		if self.Primary.PickupSoundOnDraw then
			if IsValid(self:GetOwner()) and self:GetOwner():IsPlayer() then
				local pickupsnd = self:GetStat("Primary.PickupSound")

				if pickupsnd and pickupsnd ~= "" then
					self:EmitSound(pickupsnd)
				end
			end
		end
		return BaseClass.OwnerChanged(self, ...)
	end
	
	function SWEP:EquipAmmo(ply, ...)
		local pickupsnd = self:GetStat("Primary.PickupSound")

		if pickupsnd and pickupsnd ~= "" then
			self:EmitSound(pickupsnd)
		end

		return BaseClass.EquipAmmo(self, ply, ...)
	end
end
