--leak by matveicher
--vk group - https://vk.com/gmodffdev
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/V329W7Ce8g
--ds - matveicher

AddCSLuaFile()

SWEP.PrintName = "Поцеловать"
SWEP.Author    = "Juckey & Shad"
SWEP.Purpose   = "Allows you to kiss people... On the lips... Spread the love!"

SWEP.Category = "Личное оружие"

SWEP.Slot    = 2
SWEP.SlotPos = 99

SWEP.Spawnable = false

SWEP.DrawAmmo      = false
SWEP.DrawCrosshair = false

SWEP.ViewModel    = Model("models/weapons/c_kiss.mdl")
SWEP.WorldModel   = ""
SWEP.ViewModelFOV = 80
SWEP.UseHands     = false

SWEP.Primary.ClipSize    = -1
SWEP.Primary.DefaultClip = -1
SWEP.Primary.Automatic   = false
SWEP.Primary.Ammo        = "none"

SWEP.Secondary.ClipSize    = -1
SWEP.Secondary.DefaultClip = -1
SWEP.Secondary.Automatic   = true
SWEP.Secondary.Ammo        = "none"

sound.Add {
	name = "Weapon.Kiss",
	channel = CHAN_VOICE,
	volume = 0.5,
	sound = {
		"vo/kiss1.wav",
		"vo/kiss2.wav",
		"vo/kiss3.wav",
		"vo/kiss4.wav",
		"vo/kiss5.wav",
		"vo/kiss6.wav"
	},
	pitch = { 94, 106 }
}

sound.Add {
	name = "Weapon.KnuckleCrack",
	channel = CHAN_VOICE,
	volume = 0.5,
	sound = "physics/knuckle_crack.wav",
	pitch = { 94, 106 }
}

SWEP.ActInfo = {
	[ACT_VM_DRAW] = {
		sound  = Sound("Weapon.KnuckleCrack"),
		length = 0.8
	},
	[ACT_VM_PRIMARYATTACK] = {
		sound  = Sound("Weapon.Kiss"),
		length = 0.7
	}
}

SWEP.KissDistance = 48
SWEP.KissTime     = 0.25
SWEP.NextKissTime = 0.68
SWEP.KissDepth    = 0.2
SWEP.KissDamping  = 0.14

SWEP.KissViewDistance = 0
SWEP.KissFOVDecrease  = 0.3
SWEP.CameraViewMult   = 1

SWEP.AnimEaseIn  = 0.2
SWEP.AnimEaseOut = 0.8

SWEP.KissOrigin = Vector(0, -9, 5)
SWEP.KissAngles = Angle(-8, 0, 0)

local KISS_HULL = Vector(8, 8, 8)

local sv_kissdamage

if SERVER then
	sv_kissdamage = GetConVar("sv_kissdamage")

	if not sv_kissdamage then
		sv_kissdamage = CreateConVar("sv_kissdamage", "-10", FCVAR_ARCHIVE, "Damage dealt by the Kissing SWEP. Negative values heal.")
	end
end

function SWEP:Initialize()
	self:SetHoldType("normal")
end

function SWEP:EmitSoundX(...)
	if SERVER or ( CLIENT and IsFirstTimePredicted() ) then
		return self:EmitSound(...)
	end
end

function SWEP:PlayActivity(act)
	self:SendWeaponAnim(act)

	local info = self.ActInfo[act]
	if not info then
		return false
	end

	if info.length then
		local nextAct = CurTime() + info.length
		self:SetNextPrimaryFire(nextAct)
	end

	if info.sound then
		self._lastSound = info.sound
		self:EmitSoundX(info.sound)
	end

	self:UpdateNextIdle()
end

function SWEP:SetupDataTables()
	self:NetworkVar("Float", 0, "NextKiss")
	self:NetworkVar("Float", 1, "NextIdle")

	self:NetworkVar("Entity", 0, "KissVictim")
end

function SWEP:UpdateNextIdle()
	local vm = self.Owner:GetViewModel()
	self:SetNextIdle(CurTime() + (vm:SequenceDuration() / vm:GetPlaybackRate()))
end

local function IsLookingAt(ent, pos)
	if isentity(pos) then
		pos = pos:EyePos()
	end
	local diff = pos - ent:EyePos()
	return ent:EyeAngles():Forward():Dot(diff) / diff:Length() >= 0.25
end

local function GetKissDistance(kisser, victim)
	local EP = kisser:EyePos()
	EP:Sub(victim:EyePos())
	return EP:Length()
end

function SWEP:CanKiss(victim)
	if not IsValid(victim) then
		return false
	end

	local friendEnt = victim:IsNPC()
	if not (friendEnt or victim:IsPlayer()) then
		return false
	end

	if not IsLookingAt(victim, self.Owner) then
		return false
	elseif GetKissDistance(self.Owner, victim) > self.KissDistance then
		return false
	end

	return true
end

function SWEP:PrimaryAttack()
	local CT = CurTime()

	local pos = self.Owner:GetShootPos()
	local dir = self.Owner:GetAimVector()

	dir:Mul(self.KissDistance)

	local tr = util.TraceLine({
		start = pos,
		endpos = pos + dir,
		filter = self.Owner,
		mask = MASK_SHOT_HULL
	})

	if not IsValid(tr.Entity) then
		tr = util.TraceHull({
			start = pos,
			endpos = pos + dir,
			filter = self.Owner,
			mins = KISS_HULL * -1,
			maxs = KISS_HULL *  1,
			mask = MASK_SHOT_HULL
		})
	end

	if not self:CanKiss(tr.Entity) then
		return
	end

	self:SetKissVictim(tr.Entity)
	self:SetNextKiss(CT + self.KissTime)

	self:PlayActivity(ACT_VM_PRIMARYATTACK)
	self:SetHoldType("fist")
end

function SWEP:Kiss()
	local victim = self:GetKissVictim()
	if not IsValid(victim) then
		return
	end

	if SERVER then
		local dmginfo = DamageInfo()

		local dmg = 0
		if sv_kissdamage then
			dmg = sv_kissdamage:GetInt()
		end
		dmginfo:SetDamage(dmg)
		victim:TakeDamageInfo(dmginfo)
	end

	self:SetHoldType("normal")
end

function SWEP:AbortKiss()
	self:SetNextKiss(0)
	self:SetKissVictim(nil)

	if self._lastSound then
		self:StopSound(self._lastSound)
	end

	self:PlayActivity(ACT_VM_IDLE)
end

function SWEP:SecondaryAttack()

end

function SWEP:OnDrop()
	self:Remove()
end

function SWEP:Deploy()
	self:PlayActivity(ACT_VM_DRAW)

	if CLIENT then
		local vm = self.Owner:GetViewModel()
		vm:SetPoseParameter("idle_pose", 0)
	end

	return true
end

function SWEP:GetKissInfo()
	local kiss = self:GetNextPrimaryFire() > CurTime()
	if kiss then
		return true, self:GetKissVictim()
	end
	return false, nil
end

function SWEP:Holster()
	return not self:GetKissInfo()
end

function SWEP:Think()

	-- if SERVER then
	-- 	if not self.Owner:IsRoot() then
	-- 		self.Owner:Kill()
	-- 		rp.Notify(self.Owner, NOTIFY_ERROR, 'Этот свеп пока что нельзя использовать')
	-- 		rp.Notify(self.Owner, NOTIFY_ERROR, 'Этот свеп пока что нельзя использовать')
	-- 		rp.Notify(self.Owner, NOTIFY_ERROR, 'Этот свеп пока что нельзя использовать')
	-- 		rp.Notify(self.Owner, NOTIFY_ERROR, 'Этот свеп пока что нельзя использовать')
	-- 	end
	-- end

	local vm = self.Owner:GetViewModel()
	local CT = CurTime()
	local FT = FrameTime()

	local idleTime = self:GetNextIdle()

	if idleTime > 0 and CT > idleTime then
		vm:SendViewModelMatchingSequence(vm:LookupSequence("idle"))
		self:UpdateNextIdle()
	end

	local nextKissTime = self:GetNextKiss()
	if nextKissTime > 0 and CT > nextKissTime then
		self:Kiss()
		self:SetNextKiss(0)
	end

	local kissing = self:GetNextPrimaryFire() > CT
	local victim  = self:GetKissVictim()

	if IsValid(victim) and ( not kissing or not self:CanKiss(victim) ) then
		self:AbortKiss()
		kissing = false
	elseif not IsValid(victim) then
		kissing = false
	end

	if CLIENT then
		if self.KissDamping <= 0 then
			self._kissMult = kissing and 1 or 0
		else
			self._kissMult = Lerp(FT * (1 / self.KissDamping), self._kissMult, kissing and 1 or 0)
		end
		self.KissMult = math.EaseInOut(self._kissMult, self.AnimEaseIn, self.AnimEaseOut)
		if IsValid(victim) and self:ShouldAnimateKiss() then
			self.lastKissVictim = victim
		elseif not self:ShouldAnimateKiss() then
			self.lastKissVictim = nil
		end
	end
end

if CLIENT then
	local _vec = Vector(0, 0, 0)
	local _ang = Angle(0, 0, 0)

	SWEP._kissMult = 0
	SWEP.KissMult = 0
	SWEP.VMOrigin = Vector(0, 0, 0)

	-- since it's so hard to find those sweet lips to kiss...
	local npc_attachment_lookup = {
		{ attachment = "mouth",                origin = Vector(0, 0, 0),  angles = Angle(0, 0, 0) },
		{ attachment = "anim_attachment_head", origin = Vector(0, 8, 0),  angles = Angle(-90, 0, -90) },
		{ attachment = "eyes",                 origin = Vector(0, 0, -2), angles = Angle(0, 0, 0) }
	}

	local found_bones = {}

	local function FindHeadBone(ent)
		local name = ent:GetClass()
		if isnumber(found_bones[name]) then
			return found_bones[name]
		elseif found_bones[name] == false then
			return nil
		end
		for i = 0, ent:GetBoneCount() - 1 do
			local boneName = ent:GetBoneName(i)
			if boneName and boneName:lower():match("head") then
				found_bones[name] = i
				return i
			end
		end
		found_bones[name] = false
	end

	function SWEP:GetKissPos()
		local victim = self.lastKissVictim
		local EP, EA = self.Owner:EyePos(), self.Owner:EyeAngles()

		if IsValid(victim) and self:ShouldAnimateKiss() then
			local attID, pos, ang
			local pos, ang

			for i = 1, #npc_attachment_lookup do
				local tbl = npc_attachment_lookup[i]
				attID = victim:LookupAttachment(tbl.attachment)
				if attID and attID >= 0 then
					local att = victim:GetAttachment(attID)
					if att then
						pos, ang  = att.Pos, att.Ang

						ang:RotateAroundAxis( ang:Right(),   tbl.angles.p )
						ang:RotateAroundAxis( ang:Up(),      tbl.angles.y )
						ang:RotateAroundAxis( ang:Forward(), tbl.angles.r )

						pos = pos + ( tbl.origin.x ) * ang:Right()
						pos = pos + ( tbl.origin.y ) * ang:Forward()
						pos = pos + ( tbl.origin.z ) * ang:Up()
						break
					end
				end
			end

			if not pos or not ang then
				local boneID = FindHeadBone(victim)

				if boneID then
					pos = victim:GetBonePosition(boneID)
				else
					pos = victim:EyePos() - Vector(0, 0, 8)
				end

				ang = ( EP - pos ):Angle()
			end

			ang:RotateAroundAxis(ang:Up(), 180)

			pos = pos + ( self.KissOrigin.x ) * ang:Right()
			pos = pos + ( self.KissOrigin.y ) * ang:Forward()
			pos = pos + ( self.KissOrigin.z ) * ang:Up()

			ang:RotateAroundAxis( ang:Right(),   self.KissAngles.p )
			ang:RotateAroundAxis( ang:Up(),      self.KissAngles.y )
			ang:RotateAroundAxis( ang:Forward(), self.KissAngles.r )

			return pos, ang
		end

		return EP, EA
	end

	SWEP._walkPose = 0

	function SWEP:ShouldDrawViewModel()
		return true
	end
	
	local idle_pose = 0

	function SWEP:PreDrawViewModel(vm, wep, ply)
		local CT, FT = CurTime(), FrameTime()

		local attID = vm:LookupAttachment("camera")
		local act   = vm:GetSequenceActivity( vm:GetSequence() )

		-- when you suit zoom, the engine hides the viewmodel,
		-- and this means for some reason vm:GetAttachment() starts returning infinite values
		-- conveniently, the engine does not use the nodraw flag to hide the viewmodel, instead there's separate code handling it
		-- here's a list of other CONVENIENCES that made this little "hack" necessary:
		-- no way to check whether viewmodel is being drawn in current render context
		-- no way to check whether viewmodel is set to be drawn at all ( Player:ShowViewModel() still exists for some reason )
		-- no way to check whether you are actually zooming ( you can still check if you CAN zoom... )
		-- viewmodel hooks are still being called even though viewmodel is not being drawn (???)
		if attID and attID >= 0 and not ply:KeyDown(IN_ZOOM) then
			self.AttData = vm:GetAttachment(attID)

			local attpos = self.AttData.Pos
			local attang = self.AttData.Ang

			local vm_origin = vm:GetPos()
			local vm_angles = vm:GetAngles()

			attpos:Sub(vm_origin)
			-- attpos:Rotate(vm_angles)

			attang:RotateAroundAxis(attang:Up(), -90)
			attang:Sub(vm_angles)
			attang:Normalize()

			local mult = (self.ViewModelFOV / ply:GetFOV()) * self.CameraViewMult

			attpos:Mul(mult)
			attang:Mul(mult)
		elseif self.AttData then
			self.AttData = nil
		end

		local anim_idle = not self.ActInfo[act] and ply:GetMoveType() == MOVETYPE_WALK
		
		local vel = ply:GetVelocity()
		local speed = vel:Length()

		local pose_to = anim_idle and math.Clamp(speed / ply:GetRunSpeed(), 0, 1) or 0
		idle_pose = Lerp(FT * 4, idle_pose, pose_to)

		local pose = math.EaseInOut(idle_pose, self.AnimEaseIn, self.AnimEaseOut)
		vm:SetPoseParameter("idle_pose", pose)
		vm:InvalidateBoneCache()

		render.SetBlend(0)
	end

	function SWEP:PostDrawViewModel(vm, wep, ply)
		local vm_depth = ( self.ViewModelFOV / ply:GetFOV() ) -- * ( 1 - self.KissDepth * self.KissMult )

		render.SetBlend(1)
		render.DepthRange(0, vm_depth)

		local hands = ply:GetHands()
		hands:DrawModel()

		render.DepthRange(0, 1)
	end

	function SWEP:GetViewModelPosition(origin, angles)
		if self:ShouldAnimateKiss() then
			local pos, ang = self:GetKissPos()
			origin = LerpVector(self.KissMult, origin, pos)
			angles = LerpAngle(self.KissMult,  angles, ang)
		end
		return origin, angles
	end

	function SWEP:ShouldAnimateKiss()
		return math.Round(self.KissMult, 2) > 0
	end

	function SWEP:CalcView(ply, origin, angles, fov)
		if ply:GetViewEntity() ~= ply then
			return
		end

		if self:ShouldAnimateKiss() then
			local pos, ang = self:GetKissPos()

			origin = LerpVector(self.KissMult, origin, pos)
			angles = LerpAngle(self.KissMult,  angles, ang)

			fov = fov - ( self.KissMult * fov * self.KissFOVDecrease )
		end

		local att = self.AttData
		if att then
			origin:Add(att.Pos)
			angles:Add(att.Ang)
		end

		return origin, angles, fov
	end
end


--leak by matveicher
--vk group - https://vk.com/gmodffdev
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/V329W7Ce8g
--ds - matveicher
