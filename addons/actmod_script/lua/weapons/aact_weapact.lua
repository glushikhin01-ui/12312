if CLIENT then
	SWEP.PrintName = ""
	SWEP.Category = "> A <"
	SWEP.DrawCrosshair = false
	SWEP.ViewModelFOV = 60
	SWEP.Slot = 20
	SWEP.SlotPos = 20
	SWEP.UseHands = false
	function SWEP:ViewModelDrawn() end
	function SWEP:WorldModelDrawn() end
	function SWEP:DrawViewModel() end
	function SWEP:DrawWorldModel() end
end

SWEP.ASTWTWO = true  -- Draconic Base
SWEP.NZPreventBox = true -- Prevents from being in the box by default  ( nZombies )
if (engine.ActiveGamemode() == "terrortown") then SWEP.Kind = 0 end


local ActIndex = {
	[ "pistol" ] 		= ACT_HL2MP_IDLE_PISTOL,
	[ "smg" ] 			= ACT_HL2MP_IDLE_SMG1,
	[ "grenade" ] 		= ACT_HL2MP_IDLE_GRENADE,
	[ "ar2" ] 			= ACT_HL2MP_IDLE_AR2,
	[ "shotgun" ] 		= ACT_HL2MP_IDLE_SHOTGUN,
	[ "rpg" ]	 		= ACT_HL2MP_IDLE_RPG,
	[ "physgun" ] 		= ACT_HL2MP_IDLE_PHYSGUN,
	[ "crossbow" ] 		= ACT_HL2MP_IDLE_CROSSBOW,
	[ "melee" ] 		= ACT_HL2MP_IDLE_MELEE,
	[ "slam" ] 			= ACT_HL2MP_IDLE_SLAM,
	[ "normal" ]		= ACT_HL2MP_IDLE,
	[ "fist" ]			= ACT_HL2MP_IDLE_FIST,
	[ "melee2" ]		= ACT_HL2MP_IDLE_MELEE2,
	[ "passive" ]		= ACT_HL2MP_IDLE_PASSIVE,
	[ "knife" ]			= ACT_HL2MP_IDLE_KNIFE,
	[ "duel" ]			= ACT_HL2MP_IDLE_DUEL,
	[ "camera" ]		= ACT_HL2MP_IDLE_CAMERA,
	[ "magic" ]			= ACT_HL2MP_IDLE_MAGIC,
	[ "revolver" ]		= ACT_HL2MP_IDLE_REVOLVER
}
function SWEP:SetWeaponHoldType( t )
	t = string.lower( t )
	local index = ActIndex[ t ]
	if ( index == nil ) then
		t = "normal"
		index = ActIndex[ t ]
	end
	self.ActivityTranslate = {}
	self.ActivityTranslate [ ACT_MP_STAND_IDLE ] 				= index
	self.ActivityTranslate [ ACT_MP_WALK ] 						= index+1
	self.ActivityTranslate [ ACT_MP_RUN ] 						= index+2
	self.ActivityTranslate [ ACT_MP_CROUCH_IDLE ] 				= index+3
	self.ActivityTranslate [ ACT_MP_CROUCHWALK ] 				= index+4
	self.ActivityTranslate [ ACT_MP_ATTACK_STAND_PRIMARYFIRE ] 	= index+5
	self.ActivityTranslate [ ACT_MP_ATTACK_CROUCH_PRIMARYFIRE ] = index+5
	self.ActivityTranslate [ ACT_MP_RELOAD_STAND ]		 		= index+6
	self.ActivityTranslate [ ACT_MP_RELOAD_CROUCH ]		 		= index+6
	self.ActivityTranslate [ ACT_MP_JUMP ] 						= index+7
	self.ActivityTranslate [ ACT_RANGE_ATTACK1 ] 				= index+8
	self.ActivityTranslate [ ACT_MP_SWIM ] 						= index+9
	if t == "normal" then
		self.ActivityTranslate [ ACT_MP_JUMP ] = ACT_HL2MP_JUMP_SLAM
	end
end
function SWEP:TranslateActivity( act )
	if ( self.ActivityTranslate[ act ] != nil ) then
		return self.ActivityTranslate[ act ]
	end
	return -1
end

		
SWEP.ViewModel			= "models/weapons/c_arms_animations.mdl"
SWEP.WorldModel			= ""

SWEP.HoldType			= "normal"

SWEP.Spawnable = false
SWEP.AdminSpawnable = false
SWEP.DrawAmmo = false


SWEP.Primary.ClipSize = -1
SWEP.Primary.DefaultClip = -1
SWEP.Primary.Automatic = false
SWEP.Primary.Ammo = "none"
SWEP.Primary.Delay = 0

SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = -1
SWEP.Secondary.Automatic = false
SWEP.Secondary.Ammo = "none"
SWEP.Secondary.Delay = 0

SWEP.tt = 0


function SWEP:SetupDataTables()
	self:NetworkVar("Int", 0, "State")
	self:NetworkVar("Bool", 0, "IsOwnerValidForAnimation")
end

function SWEP:RuSelectWeapon(ply)
	if ply and IsValid(ply) and ply:IsPlayer() and ply.A_oldWeap then ply:SelectWeapon(ply.A_oldWeap) end
end

function SWEP:VOwnerCompatibility()
	local owner = self:GetOwner()
	if not IsValid(owner) then
		self:SetIsOwnerValidForAnimation(false)
		return false
	end
	
	self.OwnerLastPlayermodel = owner:GetModel()
	
	local seqId, seqDur = owner:LookupSequence("walk_suitcase")
	local seqId2, seqDur2 = owner:LookupSequence("taunt_dance")
	if (seqId == -1 or seqId2 == -1) then
		self:SetIsOwnerValidForAnimation(false)
		return false
	end
	
	self:SetIsOwnerValidForAnimation(true)
	return true
end

function SWEP:ResetState()
	self:SetNextPrimaryFire(CurTime())
	self:GetOwner().aSatSavModel = {}
	for i = 0, self:GetBoneCount() do
		self:ManipulateBonePosition(i, Vector(0, 0, 0))
		self:ManipulateBoneAngles(i, Angle(0, 0, 0))
	end
end

if SERVER then
	SWEP.GiveTo = SWEP.Owner
	function SWEP:Onweap(ply,TiHoBase) self.Weapon.Onweaps = true  self.Weapon.ply = ply or nil  self.Weapon.tt = TiHoBase  end
	function SWEP:STaweap()
		if self.Weapon.Onweaps == false or (self.Weapon.ply and IsValid(self.Weapon.ply) and (self.Weapon.ply:GetActiveWeapon() and self.Weapon.ply:GetActiveWeapon():IsValid() and self.Weapon.ply:GetActiveWeapon():GetClass() != "aact_weapact" and self.Weapon.ply.actent_On != true)) then
			if self.Weapon.ply and IsValid(self.Weapon.ply) and A_AM and A_AM.ActMod then A_AM.ActMod:A_ActMod_OffActing( self.Weapon.ply ) end
			self.Weapon:Fire("Kill","","0")
		end
	end
end


function SWEP:Initialize()
	-- self:ResetState()
	if not self:GetOwner().ActMod_Cum then self:ResetState() end
	self:DrawShadow(false)
	self:SetWeaponHoldType(self.HoldType) timer.Create("AWeapAct_sh"..self.Weapon:EntIndex(),0.1,5,function() if IsValid(self.Weapon) then self:SetWeaponHoldType(self.HoldType) end end)
	if CLIENT then self:SetWeaponHoldType(self.HoldType) timer.Create("AWeapAct_cl",0.1,5,function() if IsValid(self.Weapon) then self:SetWeaponHoldType(self.HoldType) end end) end
	if SERVER then self:SetWeaponHoldType(self.HoldType) timer.Create("AWeapAct_vs"..self.Weapon:EntIndex(),0.1,5,function() if IsValid(self.Weapon) then self:SetWeaponHoldType(self.HoldType) end end)
		self.GiveTo = self.Owner
		self.Weapon.GiveTo = self.Owner
		self.Weapon.Onweaps = false
		self.Weapon.offweap = false
		self.Weapon.offweapD = false
		timer.Simple( 0, function() if IsValid(self.Weapon) then self.Weapon.tt = self.Weapon.tt or 0
		timer.Simple( 0.25+self.Weapon.tt, function() if IsValid(self.Weapon) then self:STaweap() end end)
		end end)
	end
end

function SWEP:Equip(owner)
	self:SetHoldType(self.HoldType)
	self:ResetState()
end

function SWEP:Deploy()
	if not self:GetOwner().ActMod_Cum then self:ResetState() end
	self:SetWeaponHoldType(self.HoldType)
	timer.Create("AWeapAct_sh"..self.Weapon:EntIndex(),0.1,5,function() if IsValid(self.Weapon) then self:SetWeaponHoldType(self.HoldType) end end)
	if CLIENT then self:SetWeaponHoldType(self.HoldType) timer.Create("AWeapAct_cl",0.1,5,function() if IsValid(self.Weapon) then self:SetWeaponHoldType(self.HoldType) end end) end
	if SERVER then self:SetWeaponHoldType(self.HoldType) timer.Create("AWeapAct_vs"..self.Weapon:EntIndex(),0.1,5,function() if IsValid(self.Weapon) then self:SetWeaponHoldType(self.HoldType) end end)
	if self.Weapon.offweapD == true then
		self:RuSelectWeapon(self.Owner)
		self.Weapon:Remove()
	end
	self.Weapon.offweapD = true
	end
	return true
end

function SWEP:DrawHUD() end
function SWEP:PrimaryAttack() end
function SWEP:CanPrimaryAttack() return false end
function SWEP:SecondaryAttack() end
function SWEP:CanSecondaryAttack() return false end
function SWEP:Reload() end

function SWEP:Think()
	if SERVER then
		local owner = self:GetOwner()
		if IsValid(owner) then
			if (self.OwnerLastPlayermodel == nil or self.OwnerLastPlayermodel ~= owner:GetModel()) then
				self:VOwnerCompatibility()
				if self:GetIsOwnerValidForAnimation() == false then
					if IsValid(self.Weapon) then
						self:RuSelectWeapon(self.Owner)
						self.Weapon:Remove()
					end
				end
			end
		else
			if IsValid(self.Weapon) then
				self:RuSelectWeapon(self.Owner)
				self.Weapon:Remove()
			end
		end
	end
end

function SWEP:Holster()
	if self.Weapon.offweap and self.Weapon.offweap == true then
		return true
	else
		return false
	end
end
function SWEP:OnDrop()
	if IsValid(self) then
		self:RuSelectWeapon(self.Owner)
		self:Fire("kill",0,0)
	end
end
function SWEP:Precache()
	if IsValid(self) then
		self:RuSelectWeapon(self.Owner)
		self:Fire("kill",0,0)
	end
end

function SWEP:OnRemove()
	if self.Weapon.ply and IsValid(self.Weapon.ply) and A_AM and A_AM.ActMod then
		A_AM.ActMod:A_ActMod_OffActing( self.Weapon.ply )
	end
end

function SWEP:GetPlayerHeadPosAng()
	local owner = self:GetOwner()
	if (IsValid(owner)) then
		local headBoneIndex = owner:LookupBone("ValveBiped.Bip01_Head1")
		if (headBoneIndex ~= -1) then
			local headBoneMat = owner:GetBoneMatrix(headBoneIndex)
			local pos = headBoneMat:GetTranslation()
			local ang = headBoneMat:GetAngles()
			return pos, ang
		end
	end
end
