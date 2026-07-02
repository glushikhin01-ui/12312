if not A_AM or not A_AM.ActMod or not A_AM.ActMod.SetChfg then return end
A_AM.ActMod.SpSysGesture = true

A_AM.ActMod.GestureSystem = A_AM.ActMod.GestureSystem or {}


A_AM.ActMod.GESTURE_SLOTS = {
    GESTURE_SLOT_GRENADE,
    GESTURE_SLOT_SWIM,
    GESTURE_SLOT_FLINCH,
    GESTURE_SLOT_VCD,
    GESTURE_SLOT_CUSTOM
}

local FADE_TIME = 0.3
A_AM.ActMod.GestureSystem.NUM_SLOTS = #A_AM.ActMod.GESTURE_SLOTS
local ALLOW_FORCE_OVERRIDE = true

local function IsPlayer(ent)
    return IsValid(ent) and ent:IsPlayer()
end

local function InitPlayerGestureData(ply)
    if not ply.ActMod_GestureData then
        ply.ActMod_GestureData = {
            slots = {},
            currentSlotIndex = 1,
            lastUsedSlot = 0,
            isPlayer = IsPlayer(ply)
        }
        
        for i = 1, A_AM.ActMod.GestureSystem.NUM_SLOTS do
            ply.ActMod_GestureData.slots[i] = {
                slotType = A_AM.ActMod.GESTURE_SLOTS[i],
                layerIndex = i - 1,
                active = false,
                sequence = -1,
                sequenceName = "",
                weight = 0,
                targetWeight = 1,
                cycle = 0,
                playbackRate = 1,
                startTime = 0,
                duration = 0,
                autoStop = true,
                loop = false,
                fadeInTime = 0.15,
                fadeOutTime = FADE_TIME,
                isFadingOut = false,
                fadeOutStartTime = 0
            }
        end
    end
end


local function IsSlotInUseByOther(ply, slotType, slotIndex ,tnn)
    if not IsValid(ply) then return false end
    if tnn ~= 5 and slotType == 5 and IsPlayer(ply) and ply:IsTyping() then return true end
    local ourSlot = ply.ActMod_GestureData and ply.ActMod_GestureData.slots[slotIndex]
    local gqet,cycle,Weight,Rate = ply.GetLayerSequence and ply:GetLayerSequence(IsPlayer(ply) and slotType or slotIndex - 1) or 0,1,1,1
    if IsPlayer(ply) then
        cycle = ply:GetLayerCycle(slotType)
		Weight = ply:GetLayerWeight(slotType)
		Rate = ply:GetLayerPlaybackRate(slotType)
    else
        local layerIndex = slotIndex - 1
        if ply.GetLayerCycle then cycle = ply:GetLayerCycle(layerIndex) or 1 end
        if ply.GetLayerWeight then cycle = ply:GetLayerWeight(layerIndex) or 1 end
        if ply.GetLayerPlaybackRate then cycle = ply:GetLayerPlaybackRate(layerIndex) or 1 end
    end
    if (ourSlot and ourSlot.active) or (gqet ~= 0 and gqet ~= ourSlot.sequence) and (cycle ~= 0 or Weight ~= 0 or Rate ~= 1) then return true end
    return false
end

local function FindAvailableSlot(ply, allowForce ,tnn)
    if not IsValid(ply) then return false end
    InitPlayerGestureData(ply)
    local NUM_SLOTS = A_AM.ActMod.GestureSystem.NUM_SLOTS
    local data = ply.ActMod_GestureData
    if isnumber(tnn) then
		for i = 1, NUM_SLOTS do
			local slotIndex = ((data.currentSlotIndex - 1 + i - 1) % NUM_SLOTS) + 1
			local slotType = A_AM.ActMod.GESTURE_SLOTS[slotIndex]
			if slotType == tnn then
				if not IsSlotInUseByOther(ent, slotType, slotIndex ,tnn) then
					data.currentSlotIndex = (slotIndex % NUM_SLOTS) + 1
					return slotIndex, slotType
				end
			end
		end
		return nil, nil
	end
    for i = 1, NUM_SLOTS do
        local slotIndex = ((data.currentSlotIndex - 1 + i - 1) % NUM_SLOTS) + 1
        local slotType = A_AM.ActMod.GESTURE_SLOTS[slotIndex]
        if slotType ~= GESTURE_SLOT_VCD then
			if not IsSlotInUseByOther(ply, slotType, slotIndex) then
				data.currentSlotIndex = (slotIndex % NUM_SLOTS) + 1
				return slotIndex, slotType
			end
        end
    end
    if allowForce then
        local slotIndex = data.currentSlotIndex
        local slotType = A_AM.ActMod.GESTURE_SLOTS[slotIndex]
        if slotType == GESTURE_SLOT_VCD then
            for i = 1, NUM_SLOTS do
                local testIndex = ((slotIndex - 1 + i - 1) % NUM_SLOTS) + 1
                if A_AM.ActMod.GESTURE_SLOTS[testIndex] ~= GESTURE_SLOT_VCD then
                    slotIndex = testIndex
                    slotType = A_AM.ActMod.GESTURE_SLOTS[testIndex]
                    break
                end
            end
        end
        data.currentSlotIndex = (slotIndex % NUM_SLOTS) + 1
        return slotIndex, slotType
    end
    return nil, nil
end

local function GetNextSlotIndex(ply)
    InitPlayerGestureData(ply)
    local data = ply.ActMod_GestureData
    local nextIndex = data.currentSlotIndex
    data.currentSlotIndex = (data.currentSlotIndex % A_AM.ActMod.GestureSystem.NUM_SLOTS) + 1
    return nextIndex
end

local function FadeOutOtherSlots(ply, exceptIndex)
    InitPlayerGestureData(ply)
    local curTime = CurTime()
    for i = 1, A_AM.ActMod.GestureSystem.NUM_SLOTS do
        if i ~= exceptIndex then
            local slot = ply.ActMod_GestureData.slots[i]
            if slot.active and not slot.isFadingOut then
                slot.isFadingOut = true
                slot.fadeOutStartTime = curTime
            end
        end
    end
end

local function str_iError(plA,str)
	if IsPlayer(plA) and not plA:IsBot() then
		if SERVER then
			net.Start( "A_AM.ActMod.SvToCl_Tab" ) net.WriteTable( {"iError_cl",str} ) net.Send(plA)
		else
			A_AM.ActMod:SP_iError(plA,str)
		end
	end
end

function A_AM.ActMod.GestureSystem:PlayGesture(ply, options ,dntS)
    if not IsValid(ply) then return false end
    
    InitPlayerGestureData(ply)
    
    options = options or {}
    local animName = options.animation or options.anim or ""
    local speed = options.speed or options.playbackRate or 1
    local cycle = options.cycle or 0
    local autoStop = options.autoStop ~= false
    local loop = options.loop or false
    local duration = options.duration or 0
    local Weight = options.weight or 1
    local fadeIn = options.fadeIn or 0.15
    local fadeOut = options.fadeOut or FADE_TIME
    local Mat = options.mat or ""
    
    if animName == "" then
		str_iError(ply,"!M_.Animation name is required!")
        return false
    end
    
    local sequence = ply:LookupSequence(animName)
    if sequence == -1 then
		str_iError(ply,"!M_.Animation '" .. animName .. "' not found!")
        return false
    end
    
    local animDuration = ply:SequenceDuration(sequence) / speed
    if duration > 0 then animDuration = duration end
    
    local slotIndex, slotType = FindAvailableSlot(ply, forceOverride)
    
    if not slotIndex then
		slotIndex, slotType = FindAvailableSlot(ply, forceOverride ,GESTURE_SLOT_VCD)
    
		if not slotIndex then
			if not forceOverride then
				str_iError(ply,"!M_.No available slot and forceOverride is disabled!")
			end
			return false
		end
    end
    
    local slot = ply.ActMod_GestureData.slots[slotIndex]
    
    if not dntS then FadeOutOtherSlots(ply, slotIndex) end
    
    slot.active = true
    slot.mat = Mat
    slot.sequence = sequence
    slot.sequenceName = animName
    slot.weight = 0
    slot.targetWeight = Weight
    slot.cycle = cycle
    slot.playbackRate = speed
    slot.startTime = CurTime()
    slot.duration = animDuration
    slot.autoStop = autoStop and not loop
    slot.loop = loop
    slot.fadeInTime = fadeIn
    slot.fadeOutTime = fadeOut
    slot.isFadingOut = false
    slot.fadeOutStartTime = 0
    
    if IsPlayer(ply) then
		ply:SetLayerPlaybackRate(slot.slotType, 0)
		ply:SetLayerCycle(slot.slotType, 0)
		ply:AnimSetGestureWeight(slot.slotType, 0)
		ply:SetLayerWeight(slot.slotType, 0)
        ply:AddVCDSequenceToGestureSlot(slot.slotType, sequence, cycle, true)
        ply:AnimSetGestureSequence(slot.slotType, sequence)
		ply:SetLayerPlaybackRate(slot.slotType, 0)
		ply:AnimSetGestureWeight(slot.slotType, 0)
		ply:SetLayerCycle(slot.slotType, cycle)
		ply:SetLayerWeight(slot.slotType, 0)
    else
        if ply.SetLayerSequence then
            ply:SetLayerSequence(slot.layerIndex, sequence)
            ply:SetLayerCycle(slot.layerIndex, cycle)
            ply:SetLayerWeight(slot.layerIndex, 0)
        end
    end
    
    return slotIndex
end

function A_AM.ActMod.GestureSystem:StopGesture(ply,fadeTime,slotIndex)
    if not IsValid(ply) then return end
    InitPlayerGestureData(ply)
    fadeTime = fadeTime or FADE_TIME
    if not slotIndex then
        for i = 1, A_AM.ActMod.GestureSystem.NUM_SLOTS do self:StopGesture(ply,fadeTime,i) end
        return
    end
    local slot = ply.ActMod_GestureData.slots[slotIndex]
    if not (slot.active and fadeTime > 0) and (not slot or not slot.active or slot.isFadingOut) then return end
    if fadeTime <= 0 then
		ply:AddVCDSequenceToGestureSlot(slot.slotType, 0, 1, true)
		ply:SetLayerPlaybackRate(slot.slotType, 1)
		ply:AnimSetGestureWeight(slot.slotType, 0)
		slot.active = false
		slot.cycle = 0
		slot.weight = 0
		slot.sequence = -1
		return
	end
    slot.isFadingOut = true
    slot.fadeOutStartTime = CurTime()
    slot.fadeOutTime = fadeTime
end

function A_AM.ActMod.GestureSystem:StopAllGestures(ply, fadeTime)
    self:StopGesture(ply,fadeTime)
	
    local NUM_SLOTS = A_AM.ActMod.GestureSystem.NUM_SLOTS
    local data = ply.ActMod_GestureData
	if fadeTime == 0 then
		for i = 1, NUM_SLOTS do
			local slotIndex = ((data.currentSlotIndex - 1 + i - 1) % NUM_SLOTS) + 1
			local slotType = A_AM.ActMod.GESTURE_SLOTS[slotIndex]
			local slot = ply.ActMod_GestureData.slots[slotIndex]
			if slot and slot.active and slotType then
				if IsPlayer(ply) then
					ply:AddVCDSequenceToGestureSlot(slotType, 0, 1, true)
					ply:SetLayerCycle(slotType, 1)
					ply:SetLayerPlaybackRate(slotType, 1)
					ply:AnimSetGestureWeight(slotType, 0)
					ply:AnimResetGestureSlot(slotType)
				else
					if ply.SetLayerCycle then
						ply:SetLayerPlaybackRate(i-1, 1)
						ply:SetLayerCycle(i-1, 1)
						ply:SetLayerWeight(i-1, 0)
					end
				end
			end
		end
    end
end

function A_AM.ActMod.GestureSystem:SetForceOverride(enabled)
    ALLOW_FORCE_OVERRIDE = enabled
end

function A_AM.ActMod.GestureSystem:IsSlotUsedByOther(ply, slotIndex)
    if not IsValid(ply) or not slotIndex then return false end
    local slotType = A_AM.ActMod.GESTURE_SLOTS[slotIndex]
    if not slotType then return false end
    return IsSlotInUseByOther(ply, slotType, slotIndex)
end

function A_AM.ActMod.GestureSystem:SetPlaybackRate(ply, slotIndex, rate)
    if not IsValid(ply) or not ply.ActMod_GestureData then return end
    if not slotIndex then return end
    local slot = ply.ActMod_GestureData.slots[slotIndex]
    if slot and slot.active then
        slot.playbackRate = rate
    end
end

function A_AM.ActMod.GestureSystem:UpdateGestures(ply)
    if not IsValid(ply) or not ply.ActMod_GestureData then return end
    local curTime = CurTime()
    local frameTime = FrameTime()
    local isPlayer = IsPlayer(ply)
    
    for i = 1, A_AM.ActMod.GestureSystem.NUM_SLOTS do
        local slot = ply.ActMod_GestureData.slots[i]
        if slot.active then
            local timeSinceStart = curTime - slot.startTime
			local fadeInProgress = math.min(timeSinceStart / slot.fadeInTime, 1)
			if slot.sequence == -1 then slot.active = false slot.cycle = 0 slot.weight = 0 continue end
			slot.weight = Lerp(fadeInProgress, 0, (slot.targetWeight or 1))
            if slot.isFadingOut then
                local fadeOutProgress = math.min((curTime - slot.fadeOutStartTime) / slot.fadeOutTime, 1)
                slot.weight = Lerp(fadeOutProgress, slot.weight, 0)
                if fadeOutProgress >= 1 then
                    slot.active = false
                    slot.weight = 0
					slot.cycle = 0
                    slot.sequence = -1
                    slot.sequenceName = ""
                    if isPlayer then
						ply:AddVCDSequenceToGestureSlot(slot.slotType, 0, 1, true)
						ply:SetLayerCycle(slot.slotType, 1)
						ply:SetLayerPlaybackRate(slot.slotType, 1)
						ply:AnimSetGestureWeight(slot.slotType, 0)
						ply:AnimResetGestureSlot(slot.slotType)
                    else
                        if ply.SetLayerCycle then
                            ply:SetLayerCycle(slot.layerIndex, 1)
                            ply:SetLayerWeight(slot.layerIndex, 0)
                        end
                    end
                end
            end
            if slot.active then
				if not slot.isFadingOut then
					local sequenceDuration = ply:SequenceDuration(slot.sequence)
					if sequenceDuration > 0 then
						slot.cycle = slot.cycle + (frameTime * slot.playbackRate / sequenceDuration)
						if slot.loop then
							while slot.cycle >= 1 do
								slot.cycle = 0
								if isPlayer then
									ply:AnimSetGestureSequence(slot.slotType, slot.sequence)
								else
									if ply.SetLayerSequence then
										ply:SetLayerSequence(slot.layerIndex, slot.sequence)
									end
								end
							end
						else
							slot.cycle = math.min(slot.cycle, 1)
						end
						if slot.autoStop and not slot.loop and timeSinceStart >= slot.duration then
							slot.isFadingOut = true
							slot.fadeOutStartTime = curTime
						end
						if isPlayer then
							ply:SetLayerCycle(slot.slotType, slot.cycle)
						else
							if ply.SetLayerCycle then ply:SetLayerCycle(slot.layerIndex, slot.cycle) end
						end
					end
				end
                if isPlayer then
					ply:AnimSetGestureWeight(slot.slotType, slot.weight)
                else
                    if ply.SetLayerWeight then ply:SetLayerWeight(slot.layerIndex, slot.weight) end
                end
            end
        end
    end
end


function A_AM.ActMod.GestureSystem:GetSlotInfo(ply, slotIndex)
    if not IsValid(ply) or not ply.ActMod_GestureData then return nil end
    return ply.ActMod_GestureData.slots[slotIndex]
end

function A_AM.ActMod.GestureSystem:IsSlotActive(ply, slotIndex)
    local info = self:GetSlotInfo(ply, slotIndex)
    return info and info.active or false
end

function A_AM.ActMod.GestureSystem:GetActiveSlotCount(ply)
    if not IsValid(ply) or not ply.ActMod_GestureData then return 0 end
    local count = 0
    for i = 1, A_AM.ActMod.GestureSystem.NUM_SLOTS do
        if ply.ActMod_GestureData.slots[i].active then
            count = count + 1
        end
    end
    return count
end

function A_AM.ActMod.GestureSystem:GetDebugInfo(ply)
    if not IsValid(ply) or not ply.ActMod_GestureData then return "No data" end
    local data = ply.ActMod_GestureData
    local info = "\nActMod Gesture System Debug:\n"
    for i = 1, A_AM.ActMod.GestureSystem.NUM_SLOTS do
        local slot = data.slots[i]
        local slotName = "Slot " .. i .. " (GESTURE_SLOT_" .. (i == 1 and "GRENADE" or i == 2 and "VCD" or "CUSTOM") .. ")"
        if slot.active then
			local GLCycle = tostring(ply:GetLayerCycle(slot.slotType))
			local GLWeight = tostring(ply:GetLayerWeight(slot.slotType))
			local usedByOther = IsSlotInUseByOther(ply, A_AM.ActMod.GESTURE_SLOTS[i], i)
            info = info .. string.format(
                "  %s: Active | Anim: %s | Cycle: %.2f(%.2f) | Weight: %.2f(%.2f) | Fading: %s%s\n",
                slotName,
                slot.sequenceName or "none",
                slot.cycle,GLCycle,
                slot.weight,GLWeight,
                tostring(slot.isFadingOut)
				,usedByOther and " | [USED BY OTHER]" or ""
            )
        elseif usedByOther then
            info = info .. string.format("  %s: Used by other addon (Cycle: %.2f)\n", slotName, ply:GetLayerCycle(A_AM.ActMod.GESTURE_SLOTS[i]))
        else
            info = info .. string.format("  %s: Inactive\n", slotName)
        end
    end
    info = info .. string.format( "Active Slots: %d/%d | Force Override: %s",self:GetActiveSlotCount(ply),A_AM.ActMod.GestureSystem.NUM_SLOTS,tostring(ALLOW_FORCE_OVERRIDE) )
    return info
end



if SERVER then return end

ActMod = ActMod or {}
ActMod.GestureHUD = ActMod.GestureHUD or {}

local HUD = ActMod.GestureHUD

HUD.IconSize = 64
HUD.Spacing = 10
HUD.MaxSlots = 3

local LMaterials = {}
local function GetMaterial(path)
	if not LMaterials[path] then
		local matl
		local gmat = A_AM.ActMod:RIPng(path)
		if isstring(gmat) and gmat ~= "" and gmat ~= "nil" then
			matl = Material(gmat, "smooth")
			if matl:IsError() then matl = Material(path, "smooth") end
		else matl = Material(path, "smooth")
		end
		LMaterials[path] = matl
	end
	return LMaterials[path]
end

local function DrawCircle(x, y, radius, segments, color)
	local circle = {}
	segments = segments or 36
	for i = 0, segments do
		local angle = math.rad((i / segments) * 360)
		table.insert(circle, {
			x = x + math.cos(angle) * radius,
			y = y + math.sin(angle) * radius
		})
	end
	surface.SetDrawColor(color)
	draw.NoTexture()
	surface.DrawPoly(circle)
end

local function DrawArc(x, y, radius, thickness, startAngle, endAngle, color, segments)
	segments = segments or 36
	local step = (endAngle - startAngle) / segments
	for i = 0, segments - 1 do
		local angle1 = math.rad(startAngle + (i * step))
		local angle2 = math.rad(startAngle + ((i + 1) * step))
		local x1_outer = x + math.cos(angle1) * radius
		local y1_outer = y + math.sin(angle1) * radius
		local x2_outer = x + math.cos(angle2) * radius
		local y2_outer = y + math.sin(angle2) * radius
		local x1_inner = x + math.cos(angle1) * (radius - thickness)
		local y1_inner = y + math.sin(angle1) * (radius - thickness)
		local x2_inner = x + math.cos(angle2) * (radius - thickness)
		local y2_inner = y + math.sin(angle2) * (radius - thickness)
		surface.SetDrawColor(color)
		draw.NoTexture()
		surface.DrawPoly({
			{x = x1_outer, y = y1_outer},
			{x = x2_outer, y = y2_outer},
			{x = x2_inner, y = y2_inner},
			{x = x1_inner, y = y1_inner}
		})
	end
end


local function DrawProgressCircle(x, y, size, progress ,aapl ,apa)
	local centerX = x + size / 2
	local centerY = y + size / 2
	local radius = size / 2 - 4
	DrawCircle(centerX, centerY, radius, 36, Color(0, 0, 0, 140*aapl))
	local angle = -90 + (360 * progress)
	if apa then
		DrawArc(centerX, centerY, radius, 6, -90, angle, Color(100+150*aapl , 200+55*aapl, 255, 255*aapl), 36)
	else
		DrawArc(centerX, centerY, radius, 6, -90, angle, Color(100, 200, 255*(apa and 1-aapl or 1), 255*aapl), 36)
	end
end

local function DrawProgressFillCircle(x, y, size, progress, aaa)
	local centerX = x + size / 2
	local centerY = y + size / 2
	local radius = (size / 2 - 4) * progress
	if not aaa then
		DrawCircle(centerX, centerY, size / 2 - 4, 36, Color(0, 0, 50, 150))
		if progress > 0 then DrawCircle(centerX, centerY, radius, 36, Color(100, 200, 255, 255)) end
	else
		if progress > 0 then DrawCircle(centerX, centerY, radius, 36, Color(150, 100, 255, 70)) end
	end
end

local function DrawProgressFillVertical(x, y, size, progress)
	surface.SetDrawColor(0, 0, 0, 100)
	surface.DrawRect(x, y, size, size)
	local fillHeight = size * progress
	surface.SetDrawColor(Color(100, 200, 255, 200))
	surface.DrawRect(x, y + size - fillHeight, size, fillHeight)
end

local function DrawProgressFillHorizontal(x, y, size, progress)
	surface.SetDrawColor(0, 0, 0, 100)
	surface.DrawRect(x, y, size, size)
	local fillWidth = size * progress
	surface.SetDrawColor(Color(100, 200, 255, 200))
	surface.DrawRect(x, y, fillWidth, size)
end

local function DrawProgressSpiral(x, y, size, progress)
	local centerX = x + size / 2
	local centerY = y + size / 2
	local maxRadius = size / 2 - 4
	local segments = 60
	local prevX, prevY
	for i = 0, segments * progress do
		local t = i / segments
		local angle = math.rad(t * 720)
		local radius = maxRadius * t
		local px = centerX + math.cos(angle) * radius
		local py = centerY + math.sin(angle) * radius
		if prevX then
			surface.SetDrawColor(Color(100, 200, 255, 255))
			surface.DrawLine(prevX, prevY, px, py)
		end
		prevX, prevY = px, py
	end
end

local function DrawProgressRadial(x, y, size, progress)
	local centerX = x + size / 2
	local centerY = y + size / 2
	local maxRadius = size / 2 - 4
	local aaa = 0.5+0.5*math.abs(math.sin(CurTime()*8))
	local rays = 20
	for i = 1, rays do
		local angle = math.rad((i / rays) * 360)
		local rayProgress = math.max(0, (progress - (i - 1) / rays) * rays)
		rayProgress = math.min(rayProgress, 1)
		local endX = centerX + math.cos(angle) * maxRadius * rayProgress
		local endY = centerY + math.sin(angle) * maxRadius * rayProgress
		if rayProgress < 1 then
			surface.SetDrawColor(100, 200, 255, 255)
		else
			surface.SetDrawColor(255*aaa, 255*aaa, 255, 255)
		end
		surface.DrawLine(centerX, centerY, endX, endY)
	end
end

local function DrawGestureIcon(x, y, slot, Tab,GISize)
	local size = GISize or HUD.IconSize
	local aapl = 1
	if slot.isFadingOut then aapl = slot.weight end
	local progress = slot.duration < 0 and 0 or math.Clamp((CurTime() - slot.startTime)/slot.duration,0,1)
	surface.SetDrawColor(30, 30, 35, 100*aapl)
	surface.DrawRect(x, y, size, size)
	local gcvNTy = GetConVarNumber("actmod_cl_g_hud_typ")
	if not slot.isFadingOut then
		if gcvNTy == 1 then
			DrawProgressFillVertical(x, y, size, progress)
		elseif gcvNTy == 2 then
			DrawProgressFillHorizontal(x, y, size, progress)
		elseif gcvNTy == 3 then
			DrawProgressFillCircle(x, y, size, progress)
		elseif gcvNTy == 4 then
			DrawProgressCircle(x, y, size, progress ,aapl)
		elseif gcvNTy == 6 then
			DrawProgressSpiral(x, y, size, progress)
		end
	end
	local iconPadding = 5
	local mat = GetMaterial(Tab[2] or "icon64/tool.png")
	surface.SetDrawColor(Color(255, 255, 255, 255*aapl))
	surface.SetMaterial(mat)
	surface.DrawTexturedRect(x + iconPadding, y + iconPadding, size - iconPadding * 2, size - iconPadding * 2)
	if slot.isFadingOut then
		if gcvNTy == 4 then
			DrawProgressCircle(x, y, size, progress ,aapl ,true)
		end
		surface.SetDrawColor(200, 255, 255, 180*math.max(1-(1-aapl)*2.5,0))
		surface.DrawRect(x, y, size, size)
	else
		if gcvNTy == 3 then
			DrawProgressFillCircle(x, y, size, progress ,true)
		elseif gcvNTy == 5 then
			DrawProgressRadial(x, y, size, progress)
		end
	end
	surface.SetDrawColor(60, 60, 70, 255*aapl)
	surface.DrawOutlinedRect(x, y, size, size)
	surface.DrawOutlinedRect(x + 1, y + 1, size - 2, size - 2)
	if slot.isFadingOut then
		surface.SetDrawColor(255, 100, 100, 150 * slot.weight)
		surface.DrawRect(x, y, size, 3)
	end
end

local function DrawGestureHUD()
	if GetConVarNumber("actmod_cl_g_hud_typ") == 0 then return end
	local ent = LocalPlayer()
	if not IsValid(ent) or not ent.ActMod_GestureData then return end
	local data,activeSlots = ent.ActMod_GestureData,{}
	for i = 1, A_AM.ActMod.GestureSystem.NUM_SLOTS do
		if data.slots[i].active then
			table.insert(activeSlots, {index = i, slot = data.slots[i]})
		end
	end
	if #activeSlots == 0 then return end
	table.sort(activeSlots, function(a, b) return (not a.slot.isFadingOut and a.index > b.index ) end)
	local aawh = math.min(math.max(ScrW(),ScrH()),1280)
	local GISize = HUD.IconSize*(aawh*0.0009)
	local totalWidth = (#activeSlots * GISize) + ((#activeSlots - 1) * HUD.Spacing)
	local startX = ScrW()*0.18
	local startY = ScrH()*0.85 - GISize
	for i, slotData in pairs(activeSlots) do
		local slot = slotData.slot
		local x = startX + ((i - 1) * (GISize + HUD.Spacing))
		local y = startY
		local alpha = slot.weight
		local mat = slot.mat ~= "" and slot.mat or false
		if alpha < 1 then
			y = y + (1 - alpha) * 20
		end
		DrawGestureIcon(x, y, slot ,{alpha,mat},GISize)
	end
end
hook.Add("HUDPaint", "ActMd_GestureSystem_UserHUD", function() DrawGestureHUD() end)

function HUD:SetIconSize(size) self.IconSize = math.max(size,20) end
concommand.Add("actmod_cl_gesture_hud_size", function(ply, cmd, args)
	if args[1] then
		local size = tonumber(args[1]) or 64
		HUD:SetIconSize(size)
		print(string.format("[ActMod] Gesture HUD icon size: %d", size))
	else
		print("[ActMod] Usage: actmod_hud_size <size>")
	end
end)


