--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher

// Copyright © 2012-2018 VCMod (freemmaann). All Rights Reserved. if you have any complaints or ideas contact me: steam - steamcommunity.com/id/freemmaann/ or email - freemmaann@gmail.com.

file.CreateDir("vcmod/handling") file.CreateDir("vcmod/handling/changelogs") file.CreateDir("vcmod/handling/temp")

VC.Hdl_PanelData = {}

function VC.Add_El_SliderP_Hdl(Pnl, Txt, Min, Max, Dec, Tip) local slider = VC.Add_El_SliderP(Pnl, Txt, VC.Hdl_Insane and (-1733216255) or Min, VC.Hdl_Insane and (1733216255) or Max, Dec, Tip) slider.VC_Defaults = {Pnl, Txt, Min, Max, Dec, Tip} table.insert(VC.Hdl_PanelData, slider) return slider end

local function BuildMenu(Pnl, Height)
	local ply = LocalPlayer()

	local Pnl_Left, Pnl_Right = nil, nil
	if Height then
	local tem_cat = vgui.Create("DCollapsibleCategory", Pnl) tem_cat:SetExpanded(false) tem_cat:SetLabel("Main options") tem_cat:SetExpanded(true) Pnl_Left = vgui.Create("DPanelList") Pnl_Left:SetAutoSize(true) tem_cat:SetContents(Pnl_Left) Pnl:AddItem(tem_cat) Pnl_Right = Pnl
	else
	local MPnl = VC.Add_El_Panel(Pnl, {0.35,0.65}, (Height or Pnl:GetTall()), Height and true or nil) Pnl_Left = MPnl[1] Pnl_Right = MPnl[2]
	end

	local GrTbl, SndGrTbl, SndStTbl, SndCrTbl, GrSlc, SndGrSlc, SndCrSlc, SndStSlc, GrDSlc, SndGrDSlcS, SndGrDSlcF, SndStDSlcS, SndCrDSlcS, SndCrDSlcF, SndCrDSlcG, SSlc, RsDel = {}, {}, {}, {}, 1, 1, 1, nil, false, false, false, false, false, false, false, nil, 0
	local HSL = file.Find("Data/vcmod/handling/temp/*.txt", "GAME") for _, St in pairs(HSL) do file.Delete("vcmod/handling/temp/"..St, "GAME") end
	local SLst = vgui.Create("DListView") SLst:SetSize(0, 200) SLst:SetMultiSelect(false) SLst:SetSortable(true) SLst:AddColumn(VC.Lng("TheName")) SLst:AddColumn(VC.Lng("Date")):SetFixedWidth(50) SLst:SetToolTip("Scripts are stored at: 'Data/vcmod/handling/'./nVehicle script is selected for a car if it matches its name.") Pnl_Left:AddItem(SLst)
	local function RefreshList(Init) if !Init then SLst:Clear() end local HSL = file.Find("Data/vcmod/handling/*.txt", "GAME") for i = 1, table.Count(HSL) do local Str = string.Explode("\n", file.Read("Data/vcmod/handling/"..HSL[i], "GAME"))[1] SLst:AddLine(string.gsub(HSL[i],".txt",""), string.find(Str, " in ") and string.Explode(" ", string.Explode(" in ", Str)[2])[1] or "") end if !Init then SLst:SelectFirstItem() end end
	RefreshList(true)
	local STN = vgui.Create("DTextEntry") STN:SetTall(20) STN:SetToolTip("Only the file name, without the filepath or extention.") Pnl_Left:AddItem(STN)
	local ARB = vgui.Create("VC_Button") ARB:SetTall(20) ARB:SetText(VC.Lng("Save")) ARB:SetToolTip("Save the handling script.") Pnl_Left:AddItem(ARB) ARB:SetColor(VC.Color.Btn_Add)
	local SNLbl = vgui.Create("DLabel") SNLbl:SetText("") SNLbl:SetTall(3) Pnl_Left:AddItem(SNLbl)

		local MPnl = VC.Add_El_Panel(Height and Pnl_Right or Pnl_Left, {0.4,0.6}, 20, true)
		local El_Load = vgui.Create("VC_Button", Pnl_Left) El_Load:SetText(VC.Lng("Load")) El_Load:SetTall(20) El_Load:SetToolTip("The vehicle you are in now or the one you are looking at.") El_Load:SetColor(VC.Color.Neutral) MPnl[1]:AddItem(El_Load)
		local AplHnd = vgui.Create("VC_Button", Pnl_Left) AplHnd:SetText(VC.Lng("Apply")) AplHnd:SetTall(20) AplHnd:SetToolTip("Respawn the currently driven vehicle with custom handling options.") MPnl[2]:AddItem(AplHnd) AplHnd:SetColor(VC.Color.Btn_Spw)

	local Insane = vgui.Create("VC_Button") Insane:SetTall(20) Insane:SetText(VC.Hdl_Insane and VC.Lng("Enabled safe slider limits") or VC.Lng("Disable safe slider limits (use with caution)")) Insane:SetToolTip("Be careful with this, might cause crashing.") Pnl_Left:AddItem(Insane) Insane:SetColor(VC.Hdl_Insane and Color(0,155,0) or Color(155,0,0))

	local Sheet = vgui.Create("DPropertySheet") Sheet:SetTall(Height or Pnl:GetTall())
	local BdLst = VC.Add_El_List(0, 6, 450, Sheet:GetTall()) VC.DoTabClr(Sheet, Sheet:AddSheet(VC.Lng("Body"), BdLst, "icon16/car.png", false, false, "Controls of the vehicles body."))
	local EngLst = VC.Add_El_List(0, 6, 450, Sheet:GetTall()) VC.DoTabClr(Sheet, Sheet:AddSheet(VC.Lng("Engine"), EngLst, "icon16/cog.png", false, false, "These values attempt to match the actual mechanical workings of an engine.\nKeep in mind that acceleration is proportional to Torque, and while you can't set it directly you can change a lot of things that do.\nBe warned though, if the total torque gets too high your car will start behaving unpredictably.\n\nEngine Torque = horsepower * 5252 / Engine RPM\nFinal Gear Ratio = Axle Ratio * Current Gear\nWheel RPM = MPH * Final Gear Ratio * 360 / Tire Diameter\nWheel Torque = Engine Torque * Final Gear Ratio."))
	local StrLst = VC.Add_El_List(0, 6, 450, Sheet:GetTall()) VC.DoTabClr(Sheet, Sheet:AddSheet(VC.Lng("Steering"), StrLst, "icon16/arrow_rotate_clockwise.png", false, false, "Controls of the vehicles steering."))
	local FrntAxlLst = VC.Add_El_List(0, 6, 450, Sheet:GetTall()) VC.DoTabClr(Sheet, Sheet:AddSheet(VC.Lng("FrontAxle"), FrntAxlLst, "icon16/arrow_up.png", false, false, "These are used for both of the wheels on the axle.\nPhysics wheels are only used by the vehicle simulation.\nIt only affects behavior, not appearance. These physics wheels are also spherical, so their center should be slightly inside the wheel.\n\nDamped spring system: F = k*x- v*b."))
	local RearAxlLst = VC.Add_El_List(0, 6, 450, Sheet:GetTall()) VC.DoTabClr(Sheet, Sheet:AddSheet(VC.Lng("RearAxle"), RearAxlLst, "icon16/arrow_down.png", false, false, "These are used for both of the wheels on the axle.\nPhysics wheels are only used by the vehicle simulation.\nIt only affects behavior, not appearance. These physics wheels are also spherical, so their center should be slightly inside the wheel.\n\nDamped spring system: F = k*x- v*b"))
	local SndLst = VC.Add_El_List(0, 6, 450, Sheet:GetTall()) VC.DoTabClr(Sheet, Sheet:AddSheet(VC.Lng("Sound"), SndLst, "icon16/sound.png", false, false, "Controls of the vehicles sound."))
	Pnl_Right:AddItem(Sheet)

	Sheet.Paint = function(obj, Sx, Sy) draw.RoundedBox(0, 0, 0, Sx, Sy-4, Height and Color(0,0,0,255) or Color(0,0,0,100)) end
	if Height then Pnl.Paint = function(obj, Sx, Sy) draw.RoundedBox(0, 0, 0, Sx, Sy-4, Color(0,0,0,255)) end end

		-- local WhlsAxl = VC.Add_El_SliderP_Hdl(BdLst, "Wheels Per-Axle", 1, 2, 0, "The only 'global' script variable, defines the number of wheels on each axle. Setting it to anything but 2 will crash the game when the vehicle physics object is created.")
		local CTrgFctr = VC.Add_El_SliderP_Hdl(BdLst, "Counter Torque Factor", -2, 2, 3, "Effects the amount of torque the wheels exert on the vehicle when accelerating. Positive values causing wheelies and negative values pushing the hood into the ground.")
		local MssCntrOvrd = vgui.Create("VC_Vector", Pnl_Right) MssCntrOvrd:Setup("Mass Center Override", nil, nil, "Values are in the format 'x y z'. Lower (-y) values will make the vehicle very resistant to tipping.") BdLst:AddItem(MssCntrOvrd)
		local MssOvrd = VC.Add_El_SliderP_Hdl(BdLst, "Mass Override", 0, 10000, 0, "Sets the mass of the vehicle in kilograms. Typical values range between 500 and 1000 depending on the vehicle.")
		local Gravity = VC.Add_El_SliderP_Hdl(BdLst, "Add Gravity", 0, 3, 2, "Effect is dependent on the mass of the vehicle. This is typically set to around 4/3 gravity. Too much gravity will have to be counteracted by a more powerful engine.")
		local MxAngVl = VC.Add_El_SliderP_Hdl(BdLst, "Max Angular Velocity", 1, 1000, 0, "Maximum angular velocity the vehicle is able to reach.")

		local AutoTr = VC.Add_El_CheckboxP(EngLst, "Auto Transmission", "This does not appear to have any effect on the game, since there is no key bind for shift up/down.")
		local HrsPwr = VC.Add_El_SliderP_Hdl(EngLst, "Horse Power", 0, 5000, 0, "Negative values cause unpredictable behavior and make you drive backwards, zero - makes the vehicle unable to move.")
		local MxRPM = VC.Add_El_SliderP_Hdl(EngLst, "Max RPM", 0, 5000, 0, "Negative and Zero values make you unable to move, and a value of 1 will give you nearly instantaneous acceleration.")
		local MxSpd = VC.Add_El_SliderP_Hdl(EngLst, "Max Speed", 0, 150, 0, "In miles per hour. Negative values make you unable to move, while a value of 0 makes the game crash. If the engine is not powerful enough, this speed may actually never be reached. If it is reached, the engine simply cuts out until the current speed drops below the threshold value.")
		local MxRvSpd = VC.Add_El_SliderP_Hdl(EngLst, "Max Reverse Speed", 0, 100, 0, "The same effect and range as above, but only affects the reverse speed.")
		local ABrkSpdGn = VC.Add_El_SliderP_Hdl(EngLst, "Autobrake Speed Gain", 0, 5, 2, "10% speed gain while coasting, put on the brakes after that.")
		local ABrkSpdFc = VC.Add_El_SliderP_Hdl(EngLst, "Autobrake Speed Factor", 0, 10, 2, "Brake is this times the speed gain.")
		local AxlRto = VC.Add_El_SliderP_Hdl(EngLst, "Axle Ratio", 0, 10, 2, "Negative values make the car buck a bit instead of moving, 0 makes you completely immobile. Higher values mean that the engine must be moving faster at a given wheel speed.")
		VC.Add_El_Line(EngLst)
		local GearRto = VC.Add_El_SliderP_Hdl(nil, "Gear", 0, 10, 2, "Negative values will produce similar results as a negative 'Axle Ratio', however it is interesting to note that if both values are negative, they will cancel out and produce normal results. Only the first listed gear seem to has any effect on the car's behavior")
		local GrLst = vgui.Create("DComboBox", Pnl_Right) GrTbl[1] = 0 GrLst.VC_Text = "Gear" GrLst:AddChoice("Gear 1") GrLst:ChooseOptionID(1) GrLst.OnSelect = function(idx, val) GrDSlc = 2 GearRto:SetValue(GrTbl[val]) GrSlc = val end
		local GrBtns = vgui.Create("VC_MultiButton", Pnl_Right) GrBtns:SetTall(20) GrBtns.VC_BTbl = {{name = "Add Gear", tooltip = "Add another gear", clk = function() local GrNm = #GrTbl+1 GrLst:AddChoice("Gear "..GrNm) GrTbl[GrNm] = GearRto:GetValue() GrLst:ChooseOptionID(GrNm) end}, {name = "Remove Gear", tooltip = "Remove current gear", clk = function() if GrSlc > 1 then table.remove(GrTbl, GrSlc) GrLst:Clear() for i=1, #GrTbl do GrLst:AddChoice("Gear "..i) end GrLst:ChooseOptionID(GrTbl[GrSlc] and GrSlc or #GrTbl) end end}}
		GearRto.OnValueChanged = function(idx, val) if !GrDSlc or GrDSlc <= 0 then GrTbl[GrSlc] = tonumber(val) else GrDSlc = GrDSlc-1 end end
		EngLst:AddItem(GrLst) EngLst:AddItem(GrBtns) EngLst:AddItem(GearRto)
		VC.Add_El_Line(EngLst)
		local SftUpRPM = VC.Add_El_SliderP_Hdl(EngLst, "Shift Up RPM", 0, 5000, 0, "Theoretically the RPM when the car would shift up gears, however it has no noticeable effect.")
		local SftDwRPM = VC.Add_El_SliderP_Hdl(EngLst, "Shift Down RPM", 0, 5000, 0, "Same as above, but for down shift.")
		VC.Add_El_Line(EngLst)
		local Boost = VC.Add_El_CheckboxP(EngLst, "Boost", "Vehicle uses boost")
			local BstFrc = VC.Add_El_SliderP_Hdl(EngLst, "Force", 0, 1, 0, "Negative and Positive values do the same thing while zero's effect changes depending on 'Torque Boost'.")
			local BstDur = VC.Add_El_SliderP_Hdl(EngLst, "Duration", 0, 10, 0, "Duration of the boost in seconds. Negative or Zero values will render the booster useless.")
			local BstDel = VC.Add_El_SliderP_Hdl(EngLst, "Delay", 0, 15, 0, "Specifies the number of seconds between booster uses. Negative and Zero values mean that you can use the booster without delay.")
			local BstMxSpd = VC.Add_El_SliderP_Hdl(EngLst, "Max Speed", 0, 150, 0, "Mximum speed while the turbo is engaged. Negative values will cause the boost to work like a break, while zero will do nothing. If lower than the car's current speed, it will have no effect.")
			local BstTBst = VC.Add_El_CheckboxP(EngLst, "Torgue Boost", "If checked the boost will apply torque to the car to simulate huge increase in horsepower. If unchecked, however, the boost applies no additional torque and merely pushes the car straight ahead. When using 'torqueboost', 'force' multiplies the power from the engine and, if it is 0, can actually be used to kill the engine temporarily.")

		local DgrsSlow = VC.Add_El_SliderP_Hdl(StrLst, "Degrees Slow", 0, 100, 0, "Steering cone at zero to slow speed.")
		local DgrsFast = VC.Add_El_SliderP_Hdl(StrLst, "Degrees Fast", 0, 100, 0, "Steering cone at fast speed to max speed.")
		local DgrsBst = VC.Add_El_SliderP_Hdl(StrLst, "Degrees Boost", 0, 100, 0, "Steering cone at max boost speed (blend toward this after max speed).")
		VC.Add_El_Line(StrLst)
		local StrFstDmp = VC.Add_El_SliderP_Hdl(StrLst, "Fast Dampen", -100, 100, 0, "Determines how 'wobbly' the steering is - dampens the rotation about the z(front-back) axis.  Negative values add wobble while zero offers no correction and higher values make the vehicle feel very stable.")
		local StrExpnt = VC.Add_El_SliderP_Hdl(StrLst, "Steering Exponent", 0, 2, 2, "Steering Exponent.")
		local SlwCarSpd = VC.Add_El_SliderP_Hdl(StrLst, "Slow Car Speed", 0, 100, 0, "Degrees the car’s wheels will turn at a slow speed.")
		local FstCarSpd = VC.Add_El_SliderP_Hdl(StrLst, "Fast Car Speed", 0, 100, 0, "Degrees the car’s wheels will turn at a fast speed.")
		VC.Add_El_Line(StrLst)
		local SlwStrngRt = VC.Add_El_SliderP_Hdl(StrLst, "Slow Steering Rate", 0, 10, 2, "The speed the vehicle turns at while its traveling slow.")
		local FstStrngRt = VC.Add_El_SliderP_Hdl(StrLst, "Fast Steering Rate", 0, 10, 2, "The speed the vehicle turns at while its traveling fast.")
		VC.Add_El_Line(StrLst)
		local StrRstRtSlw = VC.Add_El_SliderP_Hdl(StrLst, "Steering Rest Rate Slow", 0, 5, 2, "Determines the rate at which steering returns to a netural position at slower speeds, 1 is normal turning speed.")
		local StrRstRtFst = VC.Add_El_SliderP_Hdl(StrLst, "Steering Rest Rate Fast", 0, 5, 2, "Determines the rate at which steering returns to a netural position at faster speeds, 1 is normal turning speed.")
		VC.Add_El_Line(StrLst)
		local TrnThrRdcSlw = VC.Add_El_SliderP_Hdl(StrLst, "Turn Throttle Reduce Slow", 0, 1, 2, "Reduces turning speed as throttle is applied at slower speeds.")
		local TrnThrRdcFst = VC.Add_El_SliderP_Hdl(StrLst, "Turn Throttle Reduce Fast", 0, 1, 2, "Reduces turning speed as throttle is applied at higher speeds.")
		VC.Add_El_Line(StrLst)
		local BrkStrRtFctr = VC.Add_El_SliderP_Hdl(StrLst, "Brake Steering Rate Factor", 0, 5, 2, "The rate of steering as the brake is being applied.")
		local ThrStrRstRtFctr = VC.Add_El_SliderP_Hdl(StrLst, "Throttle Steering Rest Rate Factor", 0, 5, 2, "The rate at which the steering returns to neutral position while throttle is being applied.")
		local BstStrRstRtFctr = VC.Add_El_SliderP_Hdl(StrLst, "Boost Steering Rest Rate Factor", 0, 5, 2, "The rate at which the steering returns to neutral position while boost is active.")
		local BstStrRtFctr = VC.Add_El_SliderP_Hdl(StrLst, "Boost Steering Rate Factor", 0, 5, 2, "The overall rate of steering while boost is active.")
		VC.Add_El_Line(StrLst)
		local PwrtSldAccl = VC.Add_El_SliderP_Hdl(StrLst, "Power Slide Accel", 0, 1000, 0, "Amount velocity applied to the vehicle while its sliding.")
		local SkidAlwd = VC.Add_El_CheckboxP(StrLst, "Skid Allowed", "This doesn't completely eliminate skidding, but does reduce it signifigantly.")
		local DstCld = VC.Add_El_CheckboxP(StrLst, "Dust Cloud", "Determines if the vehicle should kick up dust behind it.")

		local FXTrgFctr = VC.Add_El_SliderP_Hdl(FrntAxlLst, "Torque Factor", 0, 2, 2, "Behaves like another part of the gear system. Fractional values deliver high speeds at reduced torque, and higher values produce more torque but less speed.")
		local FXBrkFctr = VC.Add_El_SliderP_Hdl(FrntAxlLst, "Brake Factor", 0, 1, 2, "This controls the engine braking - how quickly the car will slow down when not pressing the gas. Negative values will cause the car to always move, while 0 makes your car basically frictionless.")
		VC.Add_El_Line(FrntAxlLst) local SNLbl = vgui.Create("DLabel", Pnl_Right) SNLbl:SetText("Wheels:") FrntAxlLst:AddItem(SNLbl) VC.Add_El_Line(FrntAxlLst)
		local FXRadius = VC.Add_El_SliderP_Hdl(FrntAxlLst, "Radius", 0, 100, 3, "The radius of the physics wheel. Negative and zero values mean your car has no wheels.")
		local FXMass = VC.Add_El_SliderP_Hdl(FrntAxlLst, "Mass", 0, 1000, 0, "The mass of each tire. This is used as a divisor in most calculations, so zero and negative values cause invalid results and make the tires to spin wildly out of control.\nConversely, if the values are too large it will severely impair the steering of the vehicle.")
		local FXInert = VC.Add_El_SliderP_Hdl(FrntAxlLst, "Inertia", 0, 2, 2, "Steadies the car and helps prevent tipping.\nVery large negative values will reduce tipping, while large positive values can exaggerate it.\nA value of zero makes things behave without correction.\nVery small positive values (>0.1) can eliminate the brake-flipping issue.")
		local FXDamp = VC.Add_El_SliderP_Hdl(FrntAxlLst, "Damping", 0, 1, 2, "Resistance of the tires to rolling forward. Negative values will cause the car to always move forward, while zero will offer no resistance and positive values will slow the car slightly.")
		local FXRtDamp = VC.Add_El_SliderP_Hdl(FrntAxlLst, "Rot Damping", 0, 1, 2, "Similar to 'damping', the largest difference is that negative values will crash the game.")
		VC.Add_El_Line(FrntAxlLst)
		local FXMat = vgui.Create("VC_TextEntry", FrntAxlLst) FXMat.VC_TEntry = true FXMat:SetTall(20) FXMat.VC_Text = "Material" FXMat:SetToolTip("This is the name of the material the tires are made of.") FrntAxlLst:AddItem(FXMat)
		local FXSkdMat = vgui.Create("VC_TextEntry", FrntAxlLst) FXSkdMat.VC_TEntry = true FXSkdMat:SetTall(20) FXSkdMat.VC_Text = "Skid Material" FXSkdMat:SetToolTip("This is the material for skidding.") FrntAxlLst:AddItem(FXSkdMat)
		local FXBrkMat = vgui.Create("VC_TextEntry", FrntAxlLst) FXBrkMat.VC_TEntry = true FXBrkMat:SetTall(20) FXBrkMat.VC_Text = "Brake Material" FXBrkMat:SetToolTip("This is the material for braking.") FrntAxlLst:AddItem(FXBrkMat)
		VC.Add_El_Line(FrntAxlLst) local SNLbl = vgui.Create("DLabel", Pnl_Right) SNLbl:SetText("Suspension:") FrntAxlLst:AddItem(SNLbl)
		local FXSprngCn = VC.Add_El_SliderP_Hdl(FrntAxlLst, "Spring Constant", 0, 500, 0, "This is 'k' in the tabs equation. Controls the 'tightness' of the suspension. If it is too high, your vehicle is likely to skid around a lot. If it is too low, it may become too weak to support the car at a standstill.")
		local FXSprngDmp = VC.Add_El_SliderP_Hdl(FrntAxlLst, "Spring Damping", 0, 1, 2, "This is 'b' in the tabs equation, except that it is in radians. The closer it is to 3.14, the faster your vehicles suspension will be damped.")
		local FXStblCn = VC.Add_El_SliderP_Hdl(FrntAxlLst, "Stabilizer Constant", -1, 100, 0, "Has no noticeable effect.")
		local FXSprngDmpCmpr = VC.Add_El_SliderP_Hdl(FrntAxlLst, "Spring Damping Compression", 0, 10, 2, "Similar to 'springDamping'.")
		local FXMxBdFrc = VC.Add_El_SliderP_Hdl(FrntAxlLst, "Max Body Force", 0, 100, 0, "Represents the maximum force the suspension can absorb at any given moment.")

		local RXTrgFctr = VC.Add_El_SliderP_Hdl(RearAxlLst, "Torque Factor", 0, 2, 2, "Behaves like another part of the gear system. Fractional values deliver high speeds at reduced torque, and higher values produce more torque but less speed.")
		local RXBrkFctr = VC.Add_El_SliderP_Hdl(RearAxlLst, "Brake Factor", 0, 1, 2, "This controls the engine braking - how quickly the car will slow down when not pressing the gas. Negative values will cause the car to always move, while 0 makes your car basically frictionless.")
		VC.Add_El_Line(RearAxlLst) local SNLbl = vgui.Create("DLabel", Pnl_Right) SNLbl:SetText("Wheels:") RearAxlLst:AddItem(SNLbl) VC.Add_El_Line(RearAxlLst)
		local RXRadius = VC.Add_El_SliderP_Hdl(RearAxlLst, "Radius", 0, 100, 3, "The radius of the physics wheel. Negative and zero values mean your car has no wheels.")
		local RXMass = VC.Add_El_SliderP_Hdl(RearAxlLst, "Mass", 0, 1000, 0, "The mass of each tire. This is used as a divisor in most calculations, so zero and negative values cause invalid results and make the tires to spin wildly out of control.\nConversely, if the values are too large it will severely impair the steering of the vehicle.")
		local RXInert = VC.Add_El_SliderP_Hdl(RearAxlLst, "Inertia", 0, 2, 2, "Steadies the car and helps prevent tipping.\nVery large negative values will reduce tipping, while large positive values can exaggerate it.\nA value of zero makes things behave without correction.\nVery small positive values (>0.1) can eliminate the brake-flipping issue.")
		local RXDamp = VC.Add_El_SliderP_Hdl(RearAxlLst, "Damping", 0, 1, 2, "Resistance of the tires to rolling forward. Negative values will cause the car to always move forward, while zero will offer no resistance and positive values will slow the car slightly.")
		local RXRtDamp = VC.Add_El_SliderP_Hdl(RearAxlLst, "Rot Damping", 0, 1, 2, "Similar to 'damping', the largest difference is that negative values will crash the game.")
		VC.Add_El_Line(RearAxlLst)
		local RXMat = vgui.Create("VC_TextEntry", RearAxlLst) RXMat.VC_TEntry = true RXMat:SetTall(20) RXMat.VC_Text = "Material" RXMat:SetToolTip("This is the name of the material the tires are made of.") RearAxlLst:AddItem(RXMat)
		local RXSkdMat = vgui.Create("VC_TextEntry", RearAxlLst) RXSkdMat.VC_TEntry = true RXSkdMat:SetTall(20) RXSkdMat.VC_Text = "Skid Material" RXSkdMat:SetToolTip("This is the material for skidding.") RearAxlLst:AddItem(RXSkdMat)
		local RXBrkMat = vgui.Create("VC_TextEntry", RearAxlLst) RXBrkMat.VC_TEntry = true RXBrkMat:SetTall(20) RXBrkMat.VC_Text = "Brake Material" RXBrkMat:SetToolTip("This is the material for braking.") RearAxlLst:AddItem(RXBrkMat)
		VC.Add_El_Line(RearAxlLst) local SNLbl = vgui.Create("DLabel", Pnl_Right) SNLbl:SetText("Suspension:") RearAxlLst:AddItem(SNLbl)
		local RXSprngCn = VC.Add_El_SliderP_Hdl(RearAxlLst, "Spring Constant", 0, 500, 0, "This is 'k' in the tabs equation. Controls the 'tightness' of the suspension. If it is too high, your vehicle is likely to skid around a lot. If it is too low, it may become too weak to support the car at a standstill.")
		local RXSprngDmp = VC.Add_El_SliderP_Hdl(RearAxlLst, "Spring Damping", 0, 1, 2, "This is 'b' in the tabs equation, except that it is in radians. The closer it is to 3.14, the faster your vehicles suspension will be damped.")
		local RXStblCn = VC.Add_El_SliderP_Hdl(RearAxlLst, "Stabilizer Constant", -1, 100, 0, "Has no noticeable effect.")
		local RXSprngDmpCmpr = VC.Add_El_SliderP_Hdl(RearAxlLst, "Spring Damping Compression", 0, 10, 2, "Similar to 'springDamping'.")
		local RXMxBdFrc = VC.Add_El_SliderP_Hdl(RearAxlLst, "Max Body Force", 0, 100, 0, "Represents the maximum force the suspension can absorb at any given moment.")

		local SNLbl = vgui.Create("DLabel", Pnl_Right) SNLbl:SetText("Gears:") SndLst:AddItem(SNLbl)
		local SndMaxSpd = VC.Add_El_SliderP_Hdl(nil, "Max Speed", 0, 5, 2, "The maximum speed that the vehicle will reach in this gear, 1 would be the normal maximum speed.")
		local SndAprcFctr = VC.Add_El_SliderP_Hdl(nil, "Speed Approach Factor", 0, 1, 3, "Acceleration amount applied for that gear.")
		local SndGrLst = vgui.Create("DComboBox", Pnl_Right) SndGrLst.VC_Text = "Gear" SndGrLst.OnSelect = function(idx, val) SndGrDSlcS = 2 SndGrDSlcF = 2 SndMaxSpd:SetValue(SndGrTbl[val].MaxSpeed) SndAprcFctr:SetValue(SndGrTbl[val].AprcFctr) SndGrSlc = val end
		local SndGrBtns = vgui.Create("VC_MultiButton", Pnl_Right) SndGrBtns:SetTall(20) SndGrBtns.VC_BTbl = {{name = "Add Gear", tooltip = "Add another sound gear", clk = function() local GrNm = #SndGrTbl+1 SndGrLst:AddChoice("Gear "..GrNm) SndGrTbl[GrNm] = {} SndGrTbl[GrNm].MaxSpeed = SndMaxSpd:GetValue() SndGrTbl[GrNm].AprcFctr = SndAprcFctr:GetValue() SndGrLst:ChooseOptionID(GrNm) end}, {name = "Remove Gear", tooltip = "Remove current sound gear", clk = function() table.remove(SndGrTbl, SndGrSlc) SndGrLst:Clear() for i=1, #SndGrTbl do SndGrLst:AddChoice("Gear "..i) end if #SndGrTbl > 0 then SndGrLst:ChooseOptionID(SndGrTbl[SndGrSlc] and SndGrSlc or #SndGrTbl) end end}}
		SndMaxSpd.OnValueChanged = function(idx, val) if (!SndGrDSlcS or SndGrDSlcS <= 0) and #SndGrTbl > 0 then SndGrTbl[SndGrSlc].MaxSpeed = tonumber(val) else SndGrDSlcS = SndGrDSlcS-1 end end
		SndAprcFctr.OnValueChanged = function(idx, val) if (!SndGrDSlcF or SndGrDSlcF <= 0) and #SndGrTbl > 0 then SndGrTbl[SndGrSlc].AprcFctr = tonumber(val) else SndGrDSlcF = SndGrDSlcF-1 end end
		SndLst:AddItem(SndGrLst) SndLst:AddItem(SndGrBtns) SndLst:AddItem(SndMaxSpd) SndLst:AddItem(SndAprcFctr)
		VC.Add_El_Line(SndLst) local SNLbl = vgui.Create("DLabel", Pnl_Right) SNLbl:SetText("States:") SndLst:AddItem(SNLbl)
		local SndStMinSpd = VC.Add_El_SliderP_Hdl(nil, "Min Time", 0, 10, 2, "Minimum amount of time has to pass for this sound to be disabled.")
		local SndStSnd = vgui.Create("VC_TextEntry", SndLst) SndStSnd.VC_TEntry = true SndStSnd:SetTall(20) SndStSnd.VC_Text = "Sound" SndStSnd.VC_TxtNtrPrc = 0.85 SndStSnd.VC_TextChngd = function() if SndStSlc then SndStTbl[SndStSlc].Sound = SndStSnd.VC_TxtNtr:GetValue() end end SndStSnd:SetToolTip("Sound name for the chosen state.")
		local SndStLst = vgui.Create("DComboBox", Pnl_Right) SndStLst.VC_Text = "State" SndStLst.OnSelect = function(idx, val) SndStDSlcS = 2 local TVal = string.lower(SndStLst:GetOptionText(val)) SndStMinSpd:SetValue(SndStTbl[TVal].MinTime or 0) if !SndStTbl[TVal].MinTime then SndStTbl[TVal].MinTime = SndStMinSpd:GetValue() end SndStSnd.VC_TxtNtr:SetValue(SndStTbl[TVal].Sound or "") if !SndStTbl[TVal].Sound then SndStTbl[TVal].Sound = SndStSnd.VC_TxtNtr:GetValue() end SndStSlc = TVal end
		for Stk, Stv in pairs({"SS_START_IDLE", "SS_GEAR_0", "SS_GEAR_1_RESUME", "SS_GEAR_3_RESUME", "SS_GEAR_3", "SS_START_WATER", "SS_GEAR_1", "SS_SHUTDOWN", "SS_IDLE", "SS_REVERSE", "SS_GEAR_2_RESUME", "SS_TURBO", "SS_SLOWDOWN", "SS_GEAR_4_RESUME", "SS_SHUTDOWN_WATER", "SS_GEAR_2", "SS_GEAR_0_RESUME", "SS_GEAR_4", "SS_SLOWDOWN_HIGHSPEED"}) do SndStLst:AddChoice(Stv) SndStTbl[string.lower(Stv)] = {} end SndStLst:ChooseOptionID(1)
		SndStMinSpd.OnValueChanged = function(idx, val) if (!SndStDSlcS or SndStDSlcS <= 0) and SndStSlc then SndStTbl[SndStSlc].MinTime = tonumber(val) else SndStDSlcS = SndStDSlcS-1 end end
		SndLst:AddItem(SndStLst) SndLst:AddItem(SndStSnd) SndLst:AddItem(SndStMinSpd)
		VC.Add_El_Line(SndLst) local SNLbl = vgui.Create("DLabel", Pnl_Right) SNLbl:SetText("Crash Sounds:") SndLst:AddItem(SNLbl)
		local SndCrMnSpd = VC.Add_El_SliderP_Hdl(nil, "Min Speed", 0, 1000, 0, "Minimum speed for the sound to play.")
		local SndCrMnSpdCn = VC.Add_El_SliderP_Hdl(nil, "Min Speed Change", 0, 1000, 0, "Minimum speed change for the sound to play.")
		local SndCrGrlmt = VC.Add_El_SliderP_Hdl(nil, "Gear Limit", 0, 4, 0, "Limit the sound to gear.")
		local SndCrSnd = vgui.Create("VC_TextEntry", SndLst) SndCrSnd.VC_TEntry = true SndCrSnd:SetTall(20) SndCrSnd.VC_Text = "Sound" SndCrSnd.VC_TxtNtrPrc = 0.85 SndCrSnd.VC_TextChngd = function() if #SndCrTbl > 0 then SndCrTbl[SndCrSlc].Sound = SndCrSnd.VC_TxtNtr:GetValue() end end SndCrSnd:SetToolTip("Name for the chosen crash sound, must be precached in a sound script.")
		local SndCrLst = vgui.Create("DComboBox", Pnl_Right) SndCrLst.VC_Text = "Crash Sound" SndCrLst.OnSelect = function(idx, val) SndCrDSlcS = 2 SndCrMnSpd:SetValue(SndCrTbl[val].MinSpeed) SndCrDSlcF = 2 SndCrMnSpdCn:SetValue(SndCrTbl[val].MinSpeedChng) SndCrDSlcG = 2 SndCrGrlmt:SetValue(SndCrTbl[val].GearLimit) if SndCrTbl[val].Sound then SndCrSnd.VC_TxtNtr:SetValue(SndCrTbl[val].Sound) else SndCrSnd.VC_TxtNtr:SetValue(SndCrSnd.VC_TxtNtr:GetValue()) SndCrTbl[SndCrSlc].Sound = SndCrSnd.VC_TxtNtr:GetValue() end SndCrSlc = val end
		local SndCrBtns = vgui.Create("VC_MultiButton", Pnl_Right) SndCrBtns:SetTall(20) SndCrBtns.VC_BTbl = {{name = "Add Crash Sound", tooltip = "Add another crash sound gear", clk = function() local CrNm = #SndCrTbl+1 SndCrLst:AddChoice("Crash Sound "..CrNm) SndCrTbl[CrNm] = {} SndCrTbl[CrNm].MinSpeed = SndCrMnSpd:GetValue() SndCrTbl[CrNm].MinSpeedChng = SndCrMnSpdCn:GetValue() SndCrTbl[CrNm].GearLimit = SndCrGrlmt:GetValue() SndCrLst:ChooseOptionID(CrNm) end}, {name = "Remove Crash Sound", tooltip = "Remove current crash sound gear", clk = function() table.remove(SndCrTbl, SndCrSlc) SndCrLst:Clear() for i=1, #SndCrTbl do SndCrLst:AddChoice("Crash Sound "..i) end if #SndCrTbl > 0 then SndCrLst:ChooseOptionID(SndCrTbl[SndCrSlc] and SndCrSlc or #SndCrTbl) end end}}
		SndCrMnSpd.OnValueChanged = function(idx, val) if (!SndCrDSlcS or SndCrDSlcS <= 0) and #SndCrTbl > 0 then SndCrTbl[SndCrSlc].MinSpeed = tonumber(val) else SndCrDSlcS = SndCrDSlcS-1 end end
		SndCrMnSpdCn.OnValueChanged = function(idx, val) if (!SndCrDSlcF or SndCrDSlcF <= 0) and #SndCrTbl > 0 then SndCrTbl[SndCrSlc].MinSpeedChng = tonumber(val) else SndCrDSlcF = SndCrDSlcF-1 end end
		SndCrGrlmt.OnValueChanged = function(idx, val) if (!SndCrDSlcG or SndCrDSlcG <= 0) and #SndCrTbl > 0 then SndCrTbl[SndCrSlc].GearLimit = tonumber(val) else SndCrDSlcG = SndCrDSlcG-1 end end
		SndLst:AddItem(SndCrLst) SndLst:AddItem(SndCrBtns) SndLst:AddItem(SndCrSnd) SndLst:AddItem(SndCrMnSpd) SndLst:AddItem(SndCrMnSpdCn) SndLst:AddItem(SndCrGrlmt)
		VC.Add_El_Line(SndLst) local SNLbl = vgui.Create("DLabel", Pnl_Right) SNLbl:SetText("Skid Sounds:") SndLst:AddItem(SNLbl)
		local SndSkdLwFrc = vgui.Create("VC_TextEntry", SndLst) SndSkdLwFrc.VC_TEntry = true SndSkdLwFrc:SetTall(20) SndSkdLwFrc.VC_Text = "Skid Low Friction" SndSkdLwFrc.VC_TxtNtrPrc = 0.6 SndSkdLwFrc:SetToolTip("Vehicle skid sound when the vehicle has a low friction.") SndLst:AddItem(SndSkdLwFrc)
		local SndSkdNmFrc = vgui.Create("VC_TextEntry", SndLst) SndSkdNmFrc.VC_TEntry = true SndSkdNmFrc:SetTall(20) SndSkdNmFrc.VC_Text = "Skid Normal Friction" SndSkdNmFrc.VC_TxtNtrPrc = 0.6 SndSkdNmFrc:SetToolTip("Vehicle skid sound when the vehicle has a normal friction.") SndLst:AddItem(SndSkdNmFrc)
		local SndSkdHgFrc = vgui.Create("VC_TextEntry", SndLst) SndSkdHgFrc.VC_TEntry = true SndSkdHgFrc:SetTall(20) SndSkdHgFrc.VC_Text = "Skid High Friction" SndSkdHgFrc.VC_TxtNtrPrc = 0.6 SndSkdHgFrc:SetToolTip("Vehicle skid sound when the vehicle has a high friction.") SndLst:AddItem(SndSkdHgFrc)
		local function ManageAddButton() local SSHE = nil for _, Ln in pairs(SLst:GetLines()) do if string.lower(STN:GetValue()) == string.lower(Ln:GetValue(1)) then SSHE = true break end end if SSHE then ARB:SetText(VC.Lng("Update")) else ARB:SetText(VC.Lng("Save")) end end
		local function Import_TableRound(Val, POb) local VDc = 10^ POb.VC_Decimals return {math.Round(Val*VDc)/VDc, POb} end
		local function Import_Specific(OTbl) for _, Op in pairs(OTbl) do if !Op[3] then Op[2]:SetValue(Op[1]) end end end
		local function GetInfo_Body(Script, RdOnl)
			local InfoT, ITI = {}, 1
			local Bd = Script.body
			-- InfoT[ITI] = Import_TableRound(Script.wheelsperaxle or 0, WhlsAxl) ITI = ITI+1
			InfoT[ITI] = Import_TableRound(Bd and Bd.countertorquefactor or 0, CTrgFctr) ITI = ITI+1
			InfoT[ITI] = {Bd and Bd.masscenteroverride or "0 0 0", MssCntrOvrd, "Vector", function() return tostring(string.Implode(" ",MssCntrOvrd.VC_Change or {MssCntrOvrd.VC_VecX:GetValue(), MssCntrOvrd.VC_VecY:GetValue(), MssCntrOvrd.VC_VecZ:GetValue()})) end} if !RdOnl then MssCntrOvrd.VC_Change = string.Explode(" ", Bd and Bd.masscenteroverride or "0 0 0") end ITI = ITI+1
			InfoT[ITI] = Import_TableRound(Bd and Bd.massoverride or 0, MssOvrd) ITI = ITI+1
			InfoT[ITI] = Import_TableRound(Bd and Bd.addgravity or 0, Gravity) ITI = ITI+1
			InfoT[ITI] = Import_TableRound(Bd and Bd.maxangularvelocity or 0, MxAngVl)
			if RdOnl then return InfoT else Import_Specific(InfoT) end
		end
		local function GetInfo_Engine(Script, RdOnl, EGr)
			local InfoT, ITI = {}, 1
			local En = Script.engine
			InfoT[ITI] = {En and En.autotransmission or 0, AutoTr} ITI = ITI+1
			InfoT[ITI] = Import_TableRound(En and En.horsepower or 0, HrsPwr) ITI = ITI+1
			InfoT[ITI] = Import_TableRound(En and En.maxrpm or 0, MxRPM) ITI = ITI+1
			InfoT[ITI] = Import_TableRound(En and En.maxspeed or 0, MxSpd) ITI = ITI+1
			InfoT[ITI] = Import_TableRound(En and En.maxreversespeed or 0, MxRvSpd) ITI = ITI+1
			InfoT[ITI] = Import_TableRound(En and En.autobrakespeedgain or 0, ABrkSpdGn) ITI = ITI+1
			InfoT[ITI] = Import_TableRound(En and En.autobrakespeedfactor or 0, ABrkSpdFc) ITI = ITI+1
			InfoT[ITI] = Import_TableRound(En and En.axleratio or 0, AxlRto) ITI = ITI+1
			local OTbl, Opt = {}, nil for i=1, EGr > 0 and EGr or 1 do local COpt = Script["gear_"..i] local Val = En and En["gear_"..i] or 0 Val = math.Round(Val*100)/100 OTbl[i] = Val Opt = i end InfoT[ITI] = {OTbl, GrLst, "Table", GrTbl}
			if !RdOnl then GrLst:Clear() GrTbl = {} for Ok, Ov in pairs(OTbl) do GrLst:AddChoice("Gear "..Ok) GrTbl[Ok] = Ov end GrLst:ChooseOptionID(Opt) end ITI = ITI+1
			InfoT[ITI] = Import_TableRound(En and En.shiftuprpm or 0, SftUpRPM) ITI = ITI+1
			InfoT[ITI] = Import_TableRound(En and En.shiftdownrpm or 0, SftDwRPM) ITI = ITI+1
				local Bst = En and En.boost
				InfoT[ITI] = {Bst and Bst.force and Bst.force > 0 and 1 or 0, Boost} ITI = ITI+1
				InfoT[ITI] = Import_TableRound(Bst and Bst.force or 0, BstFrc) ITI = ITI+1
				InfoT[ITI] = Import_TableRound(Bst and Bst.duration or 0, BstDur) ITI = ITI+1
				InfoT[ITI] = Import_TableRound(Bst and Bst.delay or 0, BstDel) ITI = ITI+1
				InfoT[ITI] = {Bst and Bst.torqueboost or 0, BstTBst} ITI = ITI+1
				InfoT[ITI] = Import_TableRound(Bst and Bst.maxspeed or 0, BstMxSpd)
			if RdOnl then return InfoT else Import_Specific(InfoT) end
		end
		local function GetInfo_Steering(Script, RdOnl)
			local InfoT, ITI = {}, 1
			local Str = Script.steering
			InfoT[ITI] = Import_TableRound(Str and Str.degreesslow or 0, DgrsSlow) ITI = ITI+1
			InfoT[ITI] = Import_TableRound(Str and Str.degreesfast or 0, DgrsFast) ITI = ITI+1
			InfoT[ITI] = Import_TableRound(Str and Str.degreesboost or 0, DgrsBst) ITI = ITI+1
			InfoT[ITI] = Import_TableRound(Str and Str.fastdampen or 0, StrFstDmp) ITI = ITI+1
			InfoT[ITI] = Import_TableRound(Str and Str.steeringexponent or 0, StrExpnt) ITI = ITI+1
			InfoT[ITI] = Import_TableRound(Str and Str.slowcarspeed or 0, SlwCarSpd) ITI = ITI+1
			InfoT[ITI] = Import_TableRound(Str and Str.fastcarspeed or 0, FstCarSpd) ITI = ITI+1
			InfoT[ITI] = Import_TableRound(Str and Str.slowsteeringrate or 0, SlwStrngRt) ITI = ITI+1
			InfoT[ITI] = Import_TableRound(Str and Str.faststeeringrate or 0, FstStrngRt) ITI = ITI+1
			InfoT[ITI] = Import_TableRound(Str and Str.steeringrestrateslow or 0, StrRstRtSlw) ITI = ITI+1
			InfoT[ITI] = Import_TableRound(Str and Str.steeringrestratefast or 0, StrRstRtFst) ITI = ITI+1
			InfoT[ITI] = Import_TableRound(Str and Str.turnthrottlereduceslow or 0, TrnThrRdcSlw) ITI = ITI+1
			InfoT[ITI] = Import_TableRound(Str and Str.turnthrottlereducefast or 0, TrnThrRdcFst) ITI = ITI+1
			InfoT[ITI] = Import_TableRound(Str and Str.brakesteeringratefactor or 0, BrkStrRtFctr) ITI = ITI+1
			InfoT[ITI] = Import_TableRound(Str and Str.throttlesteeringrestratefactor or 0, ThrStrRstRtFctr) ITI = ITI+1
			InfoT[ITI] = Import_TableRound(Str and Str.booststeeringrestratefactor or 0, BstStrRstRtFctr) ITI = ITI+1
			InfoT[ITI] = Import_TableRound(Str and Str.booststeeringratefactor or 0, BstStrRtFctr) ITI = ITI+1
			InfoT[ITI] = Import_TableRound(Str and Str.powerslideaccel or 0, PwrtSldAccl) ITI = ITI+1
			InfoT[ITI] = {Str and Str.skidallowed or 0, SkidAlwd} ITI = ITI+1
			InfoT[ITI] = {Str and Str.dustcloud or 0, DstCld}
			if RdOnl then return InfoT else Import_Specific(InfoT) end
		end
		local function GetInfo_FAxle(Script, RdOnl)
			local InfoT, ITI = {}, 1
			local Axl = Script.axle_front
			InfoT[ITI] = Import_TableRound(Axl and Axl.torquefactor or 0, FXTrgFctr) ITI = ITI+1
			InfoT[ITI] = Import_TableRound(Axl and Axl.brakefactor or 0, FXBrkFctr) ITI = ITI+1
			local Whl = Axl and Axl.wheel
			InfoT[ITI] = Import_TableRound(Whl and Whl.radius or 0, FXRadius) ITI = ITI+1
			InfoT[ITI] = Import_TableRound(Whl and Whl.mass or 0, FXMass) ITI = ITI+1
			InfoT[ITI] = Import_TableRound(Whl and Whl.inertia or 0, FXInert) ITI = ITI+1
			InfoT[ITI] = Import_TableRound(Whl and Whl.damping or 0, FXDamp) ITI = ITI+1
			InfoT[ITI] = Import_TableRound(Whl and Whl.rotdamping or 0, FXRtDamp) ITI = ITI+1
			InfoT[ITI] = {Whl and Whl.material or "", FXMat.VC_TxtNtr} ITI = ITI+1
			InfoT[ITI] = {Whl and Whl.skidmaterial or "", FXSkdMat.VC_TxtNtr} ITI = ITI+1
			InfoT[ITI] = {Whl and Whl.brakematerial or "", FXBrkMat.VC_TxtNtr} ITI = ITI+1
			local Sus = Axl and Axl.suspension
			InfoT[ITI] = Import_TableRound(Sus and Sus.springconstant or 0, FXSprngCn) ITI = ITI+1
			InfoT[ITI] = Import_TableRound(Sus and Sus.springdamping or 0, FXSprngDmp) ITI = ITI+1
			InfoT[ITI] = Import_TableRound(Sus and Sus.stabilizerConstant or 0, FXStblCn) ITI = ITI+1
			InfoT[ITI] = Import_TableRound(Sus and Sus.springdampingcompression or 0, FXSprngDmpCmpr) ITI = ITI+1
			InfoT[ITI] = Import_TableRound(Sus and Sus.maxbodyforce or 0, FXMxBdFrc)
			if RdOnl then return InfoT else Import_Specific(InfoT) end
		end
		local function GetInfo_RAxle(Script, RdOnl)
			local InfoT, ITI = {}, 1
			local Axl = Script.axle_rear
			InfoT[ITI] = Import_TableRound(Axl and Axl.torquefactor or 0, RXTrgFctr) ITI = ITI+1
			InfoT[ITI] = Import_TableRound(Axl and Axl.brakefactor or 0, RXBrkFctr) ITI = ITI+1
			local Whl = Axl and Axl.wheel
			InfoT[ITI] = Import_TableRound(Whl and Whl.radius or 0, RXRadius) ITI = ITI+1
			InfoT[ITI] = Import_TableRound(Whl and Whl.mass or 0, RXMass) ITI = ITI+1
			InfoT[ITI] = Import_TableRound(Whl and Whl.inertia or 0, RXInert) ITI = ITI+1
			InfoT[ITI] = Import_TableRound(Whl and Whl.damping or 0, RXDamp) ITI = ITI+1
			InfoT[ITI] = Import_TableRound(Whl and Whl.rotdamping or 0, RXRtDamp) ITI = ITI+1
			InfoT[ITI] = {Whl and Whl.material or "", RXMat.VC_TxtNtr} ITI = ITI+1
			InfoT[ITI] = {Whl and Whl.skidmaterial or "", RXSkdMat.VC_TxtNtr} ITI = ITI+1
			InfoT[ITI] = {Whl and Whl.brakematerial or "", RXBrkMat.VC_TxtNtr} ITI = ITI+1
			local Sus = Axl and Axl.suspension
			InfoT[ITI] = Import_TableRound(Sus and Sus.springconstant or 0, RXSprngCn) ITI = ITI+1
			InfoT[ITI] = Import_TableRound(Sus and Sus.springdamping or 0, RXSprngDmp) ITI = ITI+1
			InfoT[ITI] = Import_TableRound(Sus and Sus.stabilizerConstant or 0, RXStblCn) ITI = ITI+1
			InfoT[ITI] = Import_TableRound(Sus and Sus.springdampingcompression or 0, RXSprngDmpCmpr) ITI = ITI+1
			InfoT[ITI] = Import_TableRound(Sus and Sus.maxbodyforce or 0, RXMxBdFrc)
			if RdOnl then return InfoT else Import_Specific(InfoT) end
		end
		local function GetInfo_Sound(Script, RdOnl, SGr, SSt, SCr)
			local InfoT, ITI = {}, 1
			local OTbl, Opt = {}, nil for i=1, SGr do local COpt = Script["gear_"..i] OTbl[i] = {MaxSpeed = {math.Round((COpt.max_speed and tonumber(COpt.max_speed) or 0)*100)/100, "Max Speed"}, AprcFctr = {math.Round((COpt.speed_approach_factor or 0)*1000)/1000, "Speed Approach factor"}} Opt = i end
			InfoT[ITI] = {OTbl, SndGrLst, "Table", SndGrTbl}
			if !RdOnl then SndGrLst:Clear() SndGrTbl = {} for Ok, Ov in pairs(OTbl) do SndGrLst:AddChoice("Gear "..Ok) local SGT = {} for Gk, Gv in pairs(Ov) do SGT[Gk] = Gv[1] end SndGrTbl[Ok] = SGT end if Opt then SndGrLst:ChooseOptionID(Opt) else SndMaxSpd:SetValue(0) SndAprcFctr:SetValue(0) end end ITI = ITI+1
			local OTbl = {} for i=1, SSt do local COpt = Script["state_"..i] OTbl[COpt.name] = {MinTime = {math.Round((COpt.min_time or 0)*100)/100, "Min Time"}, Sound = {COpt.sound or "", "Sound"}} end InfoT[ITI] = {OTbl, SndStLst, "Table", SndStTbl}
			if !RdOnl then for Ok,_ in pairs(SndStTbl) do SndStTbl[Ok] = {} end for Gk, Gv in pairs(OTbl) do local SGT = {} for SOk, SOv in pairs(Gv) do SGT[SOk] = SOv[1] end SndStTbl[Gk] = SGT end SndStLst:ChooseOptionID(1) end ITI = ITI+1
			local OTbl, Opt = {}, nil for i=1, SCr do local COpt = Script["crashsound_"..i] OTbl[i] = {MinSpeed = {math.Round(COpt.min_speed or 0), "Min Speed"}, MinSpeedChng = {math.Round(COpt.min_speed_change or 0), "Min Speed Change"}, GearLimit = {math.Round(COpt.gear_limit or 0), "Gear Limit"}, Sound = {COpt.sound or "", "Sound"}} Opt = i end InfoT[ITI] = {OTbl, SndCrLst, "Table", SndCrTbl}
			if !RdOnl then SndCrLst:Clear() SndCrTbl = {} for Ok, Ov in pairs(OTbl) do SndCrLst:AddChoice("Crash Sound "..Ok) local SGT = {} for Gk, Gv in pairs(Ov) do SGT[Gk] = Gv[1] end SndCrTbl[Ok] = SGT end if Opt then SndCrLst:ChooseOptionID(Opt) else SndCrMnSpd:SetValue(0) SndCrMnSpdCn:SetValue(0) SndCrGrlmt:SetValue(0) SndCrSnd.VC_TxtNtr:SetValue("") end end ITI = ITI+1
			InfoT[ITI] = {Script.skid_lowfriction or "", SndSkdLwFrc.VC_TxtNtr} ITI = ITI+1 InfoT[ITI] = {Script.skid_normalfriction or "", SndSkdNmFrc.VC_TxtNtr} ITI = ITI+1 InfoT[ITI] = {Script.skid_highfriction or "", SndSkdHgFrc.VC_TxtNtr} ITI = ITI+1
			if RdOnl then return InfoT else Import_Specific(InfoT) end
		end
		local function Import_Handling(Script, Type, RdOnl)
			local HndScrt, SLn = file.Read(Script, "GAME"), nil
				if HndScrt then
				VCMsg("Script imported.")
				HndScrt = string.lower(HndScrt) HndScrt = string.Explode("\n", HndScrt)
				for Stk, Stv in pairs(HndScrt) do if string.find(Stv, '"vehicle_sounds"') then SLn = Stk break end end
				if SLn then
				local VehSnd, VehGnrl = {}, table.Copy(HndScrt)
				for i=1, #HndScrt- SLn+1 do VehGnrl[SLn+i-1] = nil end for i=1, SLn-1 do HndScrt[i] = nil end for _, Str in pairs(HndScrt) do table.insert(VehSnd, Str) end
				local Axl = nil for Sk, Sv in pairs(VehGnrl) do if string.find(Sv, '"axle"') then VehGnrl[Sk] = string.gsub(Sv, "axle", "axle_"..(!Axl and "front" or "rear")) Axl = true end end
				local EGr = 0 for Sk, Sv in pairs(VehGnrl) do if string.find(Sv, '"gear"') then EGr = EGr+1 VehGnrl[Sk] = string.gsub(Sv, "gear", "gear_"..EGr) end end
				local SGr = 0 for Sk, Sv in pairs(VehSnd) do if string.find(Sv, '"gear"') then SGr = SGr+1 VehSnd[Sk] = string.gsub(Sv, "gear", "gear_"..SGr) end end
				local SSt = 0 for Sk, Sv in pairs(VehSnd) do if string.find(Sv, '"state"') then SSt = SSt+1 VehSnd[Sk] = string.gsub(Sv, "state", "state_"..SSt) end end
				local SCr = 0 for Sk, Sv in pairs(VehSnd) do if string.find(Sv, '"crashsound"') then SCr = SCr+1 VehSnd[Sk] = string.gsub(Sv, "crashsound", "crashsound_"..SCr) end end
				VehGnrl = util.KeyValuesToTable(string.Implode("\n", VehGnrl))
				local InfoT = {}
				if !Type or Type == "Everything" or Type == "Body" then InfoT["Body"] = GetInfo_Body(VehGnrl, RdOnl) end
				if !Type or Type == "Everything" or Type == "Engine" then InfoT["Engine"] = GetInfo_Engine(VehGnrl, RdOnl, EGr) end
				if !Type or Type == "Everything" or Type == "Steering" then InfoT["Steering"] = GetInfo_Steering(VehGnrl, RdOnl) end
				if !Type or Type == "Everything" or Type == "Front Axle" then InfoT["Front Axle"] = GetInfo_FAxle(VehGnrl, RdOnl) end
				if !Type or Type == "Everything" or Type == "Rear Axle" then InfoT["Rear Axle"] = GetInfo_RAxle(VehGnrl, RdOnl) end
				if !Type or Type == "Everything" or Type == "Sound" then InfoT["Sound"] = GetInfo_Sound(util.KeyValuesToTable(string.Implode("\n", VehSnd)), RdOnl, SGr, SSt, SCr) end
				if !RdOnl then if !Type or STN:GetValue() == "" then local ENm = string.Explode("/", Script) ENm = string.gsub(ENm[#ENm], ".txt", "") if string.find(ENm, "_vc") then ENm = string.Explode("_vc", ENm)[1] end STN:SetValue(ENm) end ManageAddButton() else return InfoT end
				end
			else
			VCMsg("Error: can't load (file not found).")
			end
		end
		local function Export_Axles(STbl, STVar)
			STVar = STVar+1 STbl[STVar] = '	"Axle"'
			STVar = STVar+1 STbl[STVar] = "	{"
			STVar = STVar+1 STbl[STVar] = '		"Wheel"'
			STVar = STVar+1 STbl[STVar] = "		{"
			local CSld, CSNm = FXRadius, "Radius" local VDc = 10^ CSld.VC_Decimals STVar = STVar+1 STbl[STVar] = '			"'..CSNm..'"						"'..tostring(math.Round(CSld:GetValue()*VDc)/VDc)..'"'
			local CSld, CSNm = FXMass, "Mass" local VDc = 10^ CSld.VC_Decimals STVar = STVar+1 STbl[STVar] = '			"'..CSNm..'"							"'..tostring(math.Round(CSld:GetValue()*VDc)/VDc)..'"'
			local CSld, CSNm = FXInert, "Inertia" local VDc = 10^ CSld.VC_Decimals STVar = STVar+1 STbl[STVar] = '			"'..CSNm..'"						"'..tostring(math.Round(CSld:GetValue()*VDc)/VDc)..'"'
			local CSld, CSNm = FXDamp, "Damping" local VDc = 10^ CSld.VC_Decimals STVar = STVar+1 STbl[STVar] = '			"'..CSNm..'"						"'..tostring(math.Round(CSld:GetValue()*VDc)/VDc)..'"'
			local CSld, CSNm = FXRtDamp, "RotDamping" local VDc = 10^ CSld.VC_Decimals STVar = STVar+1 STbl[STVar] = '			"'..CSNm..'"					"'..tostring(math.Round(CSld:GetValue()*VDc)/VDc)..'"'
			STVar = STVar+1 STbl[STVar] = '			"Material"						"'..FXMat.VC_TxtNtr:GetValue()..'"'
			STVar = STVar+1 STbl[STVar] = '			"SkidMaterial"					"'..FXSkdMat.VC_TxtNtr:GetValue()..'"'
			STVar = STVar+1 STbl[STVar] = '			"BrakeMaterial"					"'..FXBrkMat.VC_TxtNtr:GetValue()..'"'
			STVar = STVar+1 STbl[STVar] = "		}"
			STVar = STVar+1 STbl[STVar] = '		"Suspension"'
			STVar = STVar+1 STbl[STVar] = "		{"
			local CSld, CSNm = FXSprngCn, "SpringConstant" local VDc = 10^ CSld.VC_Decimals STVar = STVar+1 STbl[STVar] = '			"'..CSNm..'"				"'..tostring(math.Round(CSld:GetValue()*VDc)/VDc)..'"'
			local CSld, CSNm = FXSprngDmp, "SpringDamping" local VDc = 10^ CSld.VC_Decimals STVar = STVar+1 STbl[STVar] = '			"'..CSNm..'"					"'..tostring(math.Round(CSld:GetValue()*VDc)/VDc)..'"'
			local CSld, CSNm = FXStblCn, "StabilizerConstant" local VDc = 10^ CSld.VC_Decimals STVar = STVar+1 STbl[STVar] = '			"'..CSNm..'"			"'..tostring(math.Round(CSld:GetValue()*VDc)/VDc)..'"'
			local CSld, CSNm = FXSprngDmpCmpr, "SpringDampingCompression" local VDc = 10^ CSld.VC_Decimals STVar = STVar+1 STbl[STVar] = '			"'..CSNm..'"		"'..tostring(math.Round(CSld:GetValue()*VDc)/VDc)..'"'
			local CSld, CSNm = FXMxBdFrc, "MaxBodyForce" local VDc = 10^ CSld.VC_Decimals STVar = STVar+1 STbl[STVar] = '			"'..CSNm..'"					"'..tostring(math.Round(CSld:GetValue()*VDc)/VDc)..'"'
			STVar = STVar+1 STbl[STVar] = "		}"
			local CSld, CSNm = FXTrgFctr, "TorqueFactor" local VDc = 10^ CSld.VC_Decimals STVar = STVar+1 STbl[STVar] = '		"'..CSNm..'"						"'..tostring(math.Round(CSld:GetValue()*VDc)/VDc)..'"'
			local CSld, CSNm = FXBrkFctr, "BrakeFactor" local VDc = 10^ CSld.VC_Decimals STVar = STVar+1 STbl[STVar] = '		"'..CSNm..'"						"'..tostring(math.Round(CSld:GetValue()*VDc)/VDc)..'"'
			STVar = STVar+1 STbl[STVar] = "	}"
			STVar = STVar+1 STbl[STVar] = '	"Axle"'
			STVar = STVar+1 STbl[STVar] = "	{"
			STVar = STVar+1 STbl[STVar] = '		"Wheel"'
			STVar = STVar+1 STbl[STVar] = "		{"
			local CSld, CSNm = RXRadius, "Radius" local VDc = 10^ CSld.VC_Decimals STVar = STVar+1 STbl[STVar] = '			"'..CSNm..'"						"'..tostring(math.Round(CSld:GetValue()*VDc)/VDc)..'"'
			local CSld, CSNm = RXMass, "Mass" local VDc = 10^ CSld.VC_Decimals STVar = STVar+1 STbl[STVar] = '			"'..CSNm..'"							"'..tostring(math.Round(CSld:GetValue()*VDc)/VDc)..'"'
			local CSld, CSNm = RXInert, "Inertia" local VDc = 10^ CSld.VC_Decimals STVar = STVar+1 STbl[STVar] = '			"'..CSNm..'"						"'..tostring(math.Round(CSld:GetValue()*VDc)/VDc)..'"'
			local CSld, CSNm = RXDamp, "Damping" local VDc = 10^ CSld.VC_Decimals STVar = STVar+1 STbl[STVar] = '			"'..CSNm..'"						"'..tostring(math.Round(CSld:GetValue()*VDc)/VDc)..'"'
			local CSld, CSNm = RXRtDamp, "RotDamping" local VDc = 10^ CSld.VC_Decimals STVar = STVar+1 STbl[STVar] = '			"'..CSNm..'"					"'..tostring(math.Round(CSld:GetValue()*VDc)/VDc)..'"'
			STVar = STVar+1 STbl[STVar] = '			"Material"						"'..RXMat.VC_TxtNtr:GetValue()..'"'
			STVar = STVar+1 STbl[STVar] = '			"SkidMaterial"					"'..RXSkdMat.VC_TxtNtr:GetValue()..'"'
			STVar = STVar+1 STbl[STVar] = '			"BrakeMaterial"					"'..RXBrkMat.VC_TxtNtr:GetValue()..'"'
			STVar = STVar+1 STbl[STVar] = "		}"
			STVar = STVar+1 STbl[STVar] = '		"Suspension"'
			STVar = STVar+1 STbl[STVar] = "		{"
			local CSld, CSNm = RXSprngCn, "SpringConstant" local VDc = 10^ CSld.VC_Decimals STVar = STVar+1 STbl[STVar] = '			"'..CSNm..'"				"'..tostring(math.Round(CSld:GetValue()*VDc)/VDc)..'"'
			local CSld, CSNm = RXSprngDmp, "SpringDamping" local VDc = 10^ CSld.VC_Decimals STVar = STVar+1 STbl[STVar] = '			"'..CSNm..'"					"'..tostring(math.Round(CSld:GetValue()*VDc)/VDc)..'"'
			local CSld, CSNm = RXStblCn, "StabilizerConstant" local VDc = 10^ CSld.VC_Decimals STVar = STVar+1 STbl[STVar] = '			"'..CSNm..'"			"'..tostring(math.Round(CSld:GetValue()*VDc)/VDc)..'"'
			local CSld, CSNm = RXSprngDmpCmpr, "SpringDampingCompression" local VDc = 10^ CSld.VC_Decimals STVar = STVar+1 STbl[STVar] = '			"'..CSNm..'"		"'..tostring(math.Round(CSld:GetValue()*VDc)/VDc)..'"'
			local CSld, CSNm = RXMxBdFrc, "MaxBodyForce" local VDc = 10^ CSld.VC_Decimals STVar = STVar+1 STbl[STVar] = '			"'..CSNm..'"					"'..tostring(math.Round(CSld:GetValue()*VDc)/VDc)..'"'
			STVar = STVar+1 STbl[STVar] = "		}"
			local CSld, CSNm = RXTrgFctr, "TorqueFactor" local VDc = 10^ CSld.VC_Decimals STVar = STVar+1 STbl[STVar] = '		"'..CSNm..'"						"'..tostring(math.Round(CSld:GetValue()*VDc)/VDc)..'"'
			local CSld, CSNm = RXBrkFctr, "BrakeFactor" local VDc = 10^ CSld.VC_Decimals STVar = STVar+1 STbl[STVar] = '		"'..CSNm..'"						"'..tostring(math.Round(CSld:GetValue()*VDc)/VDc)..'"'
			STVar = STVar+1 STbl[STVar] = "	}"
			return STbl, STVar
		end
		local function Export_Handling(ONm)
			local STbl, STVar = {}, 0
			STVar = STVar+1 STbl[STVar] = "// "..(ONm or STN:GetValue())..", created by "..LocalPlayer():Nick().." in "..tostring(os.date())..", using Vehicle Controller (VCMod)."
			STVar = STVar+1 STbl[STVar] = ""
			STVar = STVar+1 STbl[STVar] = '"Vehicle"'
			STVar = STVar+1 STbl[STVar] = "{"
			-- STVar = STVar+1 STbl[STVar] = '	"WheelsPerAxle"		"'..tostring(math.Round(WhlsAxl:GetValue()))..'"'
			STVar = STVar+1 STbl[STVar] = '	"WheelsPerAxle"		"2"'
			STVar = STVar+1 STbl[STVar] = '	"Body"'
			STVar = STVar+1 STbl[STVar] = "	{"
			local CSld, CSNm = CTrgFctr, "CounterTorqueFactor" local VDc = 10^ CSld.VC_Decimals STVar = STVar+1 STbl[STVar] = '		"'..CSNm..'"	"'..tostring(math.Round(CSld:GetValue()*VDc)/VDc)..'"'
			STVar = STVar+1 STbl[STVar] = '		"MassCenterOverride"	"'..tostring(string.Implode(" ",MssCntrOvrd.VC_Change or {MssCntrOvrd.VC_VecX:GetValue(), MssCntrOvrd.VC_VecY:GetValue(), MssCntrOvrd.VC_VecZ:GetValue()}))..'"'
			local CSld, CSNm = MssOvrd, "MassOverride" local VDc = 10^ CSld.VC_Decimals STVar = STVar+1 STbl[STVar] = '		"'..CSNm..'"			"'..tostring(math.Round(CSld:GetValue()*VDc)/VDc)..'"'
			local CSld, CSNm = Gravity, "AddGravity" local VDc = 10^ CSld.VC_Decimals STVar = STVar+1 STbl[STVar] = '		"'..CSNm..'"			"'..tostring(math.Round(CSld:GetValue()*VDc)/VDc)..'"'
			local CSld, CSNm = MxAngVl, "MaxAngularVelocity" local VDc = 10^ CSld.VC_Decimals STVar = STVar+1 STbl[STVar] = '		"'..CSNm..'"	"'..tostring(math.Round(CSld:GetValue()*VDc)/VDc)..'"'
			STVar = STVar+1 STbl[STVar] = "	}"
			STVar = STVar+1 STbl[STVar] = '	"Engine"'
			STVar = STVar+1 STbl[STVar] = "	{"
			local CSld, CSNm = HrsPwr, "HorsePower" local VDc = 10^ CSld.VC_Decimals STVar = STVar+1 STbl[STVar] = '		"'..CSNm..'"			"'..tostring(math.Round(CSld:GetValue()*VDc)/VDc)..'"'
			local CSld, CSNm = MxRPM, "MaxRPM" local VDc = 10^ CSld.VC_Decimals STVar = STVar+1 STbl[STVar] = '		"'..CSNm..'"				"'..tostring(math.Round(CSld:GetValue()*VDc)/VDc)..'"'
			local CSld, CSNm = MxSpd, "MaxSpeed" local VDc = 10^ CSld.VC_Decimals STVar = STVar+1 STbl[STVar] = '		"'..CSNm..'"				"'..tostring(math.Round(CSld:GetValue()*VDc)/VDc)..'"'
			local CSld, CSNm = MxRvSpd, "MaxReverseSpeed" local VDc = 10^ CSld.VC_Decimals STVar = STVar+1 STbl[STVar] = '		"'..CSNm..'"		"'..tostring(math.Round(CSld:GetValue()*VDc)/VDc)..'"'
			local CSld, CSNm = ABrkSpdGn, "AutobrakeSpeedGain" local VDc = 10^ CSld.VC_Decimals STVar = STVar+1 STbl[STVar] = '		"'..CSNm..'"	"'..tostring(math.Round(CSld:GetValue()*VDc)/VDc)..'"'
			local CSld, CSNm = ABrkSpdFc, "AutobrakeSpeedFactor" local VDc = 10^ CSld.VC_Decimals STVar = STVar+1 STbl[STVar] = '		"'..CSNm..'"	"'..tostring(math.Round(CSld:GetValue()*VDc)/VDc)..'"'
			STVar = STVar+1 STbl[STVar] = '		"Autotransmission"		"'..tostring(AutoTr:GetChecked() and 1 or 0)..'"'
			local CSld, CSNm = AxlRto, "AxleRatio" local VDc = 10^ CSld.VC_Decimals STVar = STVar+1 STbl[STVar] = '		"'..CSNm..'"				"'..tostring(math.Round(CSld:GetValue()*VDc)/VDc)..'"'
			for _, Gr in pairs(GrTbl) do if Gr > 0 then STVar = STVar+1 STbl[STVar] = '		"Gear"					"'..tostring(math.Round(Gr*100)/100)..'"' end end
			STVar = STVar+1 STbl[STVar] = ""
			local CSld, CSNm = SftUpRPM, "ShiftUpRPM" local VDc = 10^ CSld.VC_Decimals STVar = STVar+1 STbl[STVar] = '		"'..CSNm..'"			"'..tostring(math.Round(CSld:GetValue()*VDc)/VDc)..'"'
			local CSld, CSNm = SftDwRPM, "ShiftDownRPM" local VDc = 10^ CSld.VC_Decimals STVar = STVar+1 STbl[STVar] = '		"'..CSNm..'"			"'..tostring(math.Round(CSld:GetValue()*VDc)/VDc)..'"'
				if Boost:GetChecked() then
				STVar = STVar+1 STbl[STVar] = ""
				STVar = STVar+1 STbl[STVar] = '		"Boost"'
				STVar = STVar+1 STbl[STVar] = "		{"
				local CSld, CSNm = BstFrc, "Force" local VDc = 10^ CSld.VC_Decimals STVar = STVar+1 STbl[STVar] = '			"'..CSNm..'"			"'..tostring(math.Round(CSld:GetValue()*VDc)/VDc)..'"'
				local CSld, CSNm = BstDur, "Duration" local VDc = 10^ CSld.VC_Decimals STVar = STVar+1 STbl[STVar] = '			"'..CSNm..'"		"'..tostring(math.Round(CSld:GetValue()*VDc)/VDc)..'"'
				local CSld, CSNm = BstDel, "Delay" local VDc = 10^ CSld.VC_Decimals STVar = STVar+1 STbl[STVar] = '			"'..CSNm..'"			"'..tostring(math.Round(CSld:GetValue()*VDc)/VDc)..'"'
				STVar = STVar+1 STbl[STVar] = '			"TorqueBoost"	"'..tostring(BstTBst:GetChecked() and 1 or 0)..'"'
				local CSld, CSNm = BstMxSpd, "MaxSpeed" local VDc = 10^ CSld.VC_Decimals STVar = STVar+1 STbl[STVar] = '			"'..CSNm..'"		"'..tostring(math.Round(CSld:GetValue()*VDc)/VDc)..'"'
				STVar = STVar+1 STbl[STVar] = "		}"
				end
			STVar = STVar+1 STbl[STVar] = "	}"
			STVar = STVar+1 STbl[STVar] = '	"Steering"'
			STVar = STVar+1 STbl[STVar] = "	{"
			local CSld, CSNm = DgrsSlow, "DegreesSlow" local VDc = 10^ CSld.VC_Decimals STVar = STVar+1 STbl[STVar] = '		"'..CSNm..'"						"'..tostring(math.Round(CSld:GetValue()*VDc)/VDc)..'"'
			local CSld, CSNm = DgrsFast, "DegreesFast" local VDc = 10^ CSld.VC_Decimals STVar = STVar+1 STbl[STVar] = '		"'..CSNm..'"						"'..tostring(math.Round(CSld:GetValue()*VDc)/VDc)..'"'
			local CSld, CSNm = DgrsBst, "DegreesBoost" local VDc = 10^ CSld.VC_Decimals STVar = STVar+1 STbl[STVar] = '		"'..CSNm..'"						"'..tostring(math.Round(CSld:GetValue()*VDc)/VDc)..'"'
			local CSld, CSNm = StrFstDmp, "FastDampen" local VDc = 10^ CSld.VC_Decimals STVar = STVar+1 STbl[STVar] = '		"'..CSNm..'"						"'..tostring(math.Round(CSld:GetValue()*VDc)/VDc)..'"'
			local CSld, CSNm = StrExpnt, "SteeringExponent" local VDc = 10^ CSld.VC_Decimals STVar = STVar+1 STbl[STVar] = '		"'..CSNm..'"					"'..tostring(math.Round(CSld:GetValue()*VDc)/VDc)..'"'
			local CSld, CSNm = SlwCarSpd, "SlowCarSpeed" local VDc = 10^ CSld.VC_Decimals STVar = STVar+1 STbl[STVar] = '		"'..CSNm..'"						"'..tostring(math.Round(CSld:GetValue()*VDc)/VDc)..'"'
			local CSld, CSNm = FstCarSpd, "FastCarSpeed" local VDc = 10^ CSld.VC_Decimals STVar = STVar+1 STbl[STVar] = '		"'..CSNm..'"						"'..tostring(math.Round(CSld:GetValue()*VDc)/VDc)..'"'
			local CSld, CSNm = SlwStrngRt, "SlowSteeringRate" local VDc = 10^ CSld.VC_Decimals STVar = STVar+1 STbl[STVar] = '		"'..CSNm..'"					"'..tostring(math.Round(CSld:GetValue()*VDc)/VDc)..'"'
			local CSld, CSNm = FstStrngRt, "FastSteeringRate" local VDc = 10^ CSld.VC_Decimals STVar = STVar+1 STbl[STVar] = '		"'..CSNm..'"					"'..tostring(math.Round(CSld:GetValue()*VDc)/VDc)..'"'
			local CSld, CSNm = StrRstRtSlw, "SteeringRestRateSlow" local VDc = 10^ CSld.VC_Decimals STVar = STVar+1 STbl[STVar] = '		"'..CSNm..'"				"'..tostring(math.Round(CSld:GetValue()*VDc)/VDc)..'"'
			local CSld, CSNm = StrRstRtFst, "SteeringRestRateFast" local VDc = 10^ CSld.VC_Decimals STVar = STVar+1 STbl[STVar] = '		"'..CSNm..'"				"'..tostring(math.Round(CSld:GetValue()*VDc)/VDc)..'"'
			local CSld, CSNm = TrnThrRdcSlw, "TurnThrottleReduceSlow" local VDc = 10^ CSld.VC_Decimals STVar = STVar+1 STbl[STVar] = '		"'..CSNm..'"			"'..tostring(math.Round(CSld:GetValue()*VDc)/VDc)..'"'
			local CSld, CSNm = TrnThrRdcFst, "TurnThrottleReduceFast" local VDc = 10^ CSld.VC_Decimals STVar = STVar+1 STbl[STVar] = '		"'..CSNm..'"			"'..tostring(math.Round(CSld:GetValue()*VDc)/VDc)..'"'
			local CSld, CSNm = BrkStrRtFctr, "BrakeSteeringRateFactor" local VDc = 10^ CSld.VC_Decimals STVar = STVar+1 STbl[STVar] = '		"'..CSNm..'"			"'..tostring(math.Round(CSld:GetValue()*VDc)/VDc)..'"'
			local CSld, CSNm = ThrStrRstRtFctr, "ThrottleSteeringRestRateFactor" local VDc = 10^ CSld.VC_Decimals STVar = STVar+1 STbl[STVar] = '		"'..CSNm..'"	"'..tostring(math.Round(CSld:GetValue()*VDc)/VDc)..'"'
			local CSld, CSNm = BstStrRstRtFctr, "BoostSteeringRestRateFactor" local VDc = 10^ CSld.VC_Decimals STVar = STVar+1 STbl[STVar] = '		"'..CSNm..'"		"'..tostring(math.Round(CSld:GetValue()*VDc)/VDc)..'"'
			local CSld, CSNm = BstStrRtFctr, "BoostSteeringRateFactor" local VDc = 10^ CSld.VC_Decimals STVar = STVar+1 STbl[STVar] = '		"'..CSNm..'"			"'..tostring(math.Round(CSld:GetValue()*VDc)/VDc)..'"'
			local CSld, CSNm = PwrtSldAccl, "PowerSlideAccel" STVar = STVar+1 STbl[STVar] = "" local VDc = 10^ CSld.VC_Decimals STVar = STVar+1 STbl[STVar] = '		"'..CSNm..'"					"'..tostring(math.Round(CSld:GetValue()*VDc)/VDc)..'"'
			STVar = STVar+1 STbl[STVar] = ""
			STVar = STVar+1 STbl[STVar] = '		"SkidAllowed"						"'..tostring(SkidAlwd:GetChecked() and 1 or 0)..'"'
			STVar = STVar+1 STbl[STVar] = '		"DustCloud"							"'..tostring(DstCld:GetChecked() and 1 or 0)..'"'
			STVar = STVar+1 STbl[STVar] = "	}"
			STbl, STVar = Export_Axles(STbl, STVar)
			STVar = STVar+1 STbl[STVar] = "}"
			STVar = STVar+1 STbl[STVar] = ""
			STVar = STVar+1 STbl[STVar] = '"Vehicle_Sounds"'
			STVar = STVar+1 STbl[STVar] = "{"
			for _, Gr in pairs(SndGrTbl) do
			STVar = STVar+1 STbl[STVar] = '	"Gear"'
			STVar = STVar+1 STbl[STVar] = "	{"
			STVar = STVar+1 STbl[STVar] = '		"Max_Speed"				"'..tostring(math.Round(Gr.MaxSpeed*100)/100)..'"'
			STVar = STVar+1 STbl[STVar] = '		"Speed_Approach_Factor"	"'..tostring(math.Round(Gr.AprcFctr*1000)/1000)..'"'
			STVar = STVar+1 STbl[STVar] = "	}"
			end
			for Stk, Stv in pairs(SndStTbl) do
				if Stv.Sound and Stv.Sound != "" then
				STVar = STVar+1 STbl[STVar] = '	"State"'
				STVar = STVar+1 STbl[STVar] = "	{"
				STVar = STVar+1 STbl[STVar] = '		"Name"		"'..string.upper(tostring(Stk))..'"'
				STVar = STVar+1 STbl[STVar] = '		"Sound"		"'..tostring(Stv.Sound)..'"'
				STVar = STVar+1 STbl[STVar] = '		"Min_Time"	"'..tostring(math.Round(Stv.MinTime*100)/100)..'"'
				STVar = STVar+1 STbl[STVar] = "	}"
				end
			end
			for _, CSv in pairs(SndCrTbl) do
				if CSv.Sound then
				STVar = STVar+1 STbl[STVar] = '	"CrashSound"'
				STVar = STVar+1 STbl[STVar] = "	{"
				STVar = STVar+1 STbl[STVar] = '		"Min_Speed"			"'..tostring(math.Round(CSv.MinSpeed))..'"'
				STVar = STVar+1 STbl[STVar] = '		"Min_Speed_Change"	"'..tostring(math.Round(CSv.MinSpeedChng))..'"'
				STVar = STVar+1 STbl[STVar] = '		"Sound"				"'..tostring(CSv.Sound)..'"'
				STVar = STVar+1 STbl[STVar] = '		"Gear_Limit"		"'..tostring(math.Round(CSv.GearLimit))..'"'
				STVar = STVar+1 STbl[STVar] = "	}"
				end
			end
			STVar = STVar+1 STbl[STVar] = ""
			STVar = STVar+1 STbl[STVar] = '	"Skid_LowFriction"		"'..SndSkdLwFrc.VC_TxtNtr:GetValue()..'"'
			STVar = STVar+1 STbl[STVar] = '	"Skid_NormalFriction"	"'..SndSkdNmFrc.VC_TxtNtr:GetValue()..'"'
			STVar = STVar+1 STbl[STVar] = '	"Skid_HighFriction"		"'..SndSkdHgFrc.VC_TxtNtr:GetValue()..'"'
			STVar = STVar+1 STbl[STVar] = "}"
			return string.Implode("\n", STbl)
		end

		do
			El_Load.DoClick = function() local ent = VC.GetVehicle(ply) if !IsValid(VC.GetVehicle(ply)) then VCPopup("Look at a vehicle or be inside of one first.", "cross") return end RunConsoleCommand("VC_Dev_Handl_Get_Script") end


				Insane.DoClick = function() if VC.Hdl_Insane then VC.Hdl_Insane = false VCPopup("Switching back to safe mode.", "info") else VC.Hdl_Insane = true VCPopup("Switching to insane limits, use carefully as it might cause crashing.", "info") end for k,v in pairs(VC.Hdl_PanelData) do if VC.Hdl_Insane then v:SetMin(-1733216255) v:SetMax(1733216255) else v:SetMin(v.VC_Defaults[3]) v:SetMax(v.VC_Defaults[4]) end end
				Insane:SetText(VC.Hdl_Insane and VC.Lng("Enabled safe slider limits") or VC.Lng("Disable safe slider limits (use with caution)")) Insane:SetColor(VC.Hdl_Insane and Color(0,155,0) or Color(155,0,0))
				end
			El_Load.DoRightClick = function()
				local ent = VC.GetVehicle(ply) if !IsValid(VC.GetVehicle(ply)) then VCPopup("Look at a vehicle or be inside of one first.", "cross") return end
				local DDM = VC.DermaMenu("Import")
				DDM:AddButton(VC.Lng("Everything"), function() if IsValid(VC.GetVehicle(ply)) then RunConsoleCommand("VC_Dev_Handl_Get_Script", 7) end end):SetImage("icon16/key.png")
				DDM:AddSpacer()
				DDM:AddButton(VC.Lng("Body"), function() if IsValid(VC.GetVehicle(ply)) then RunConsoleCommand("VC_Dev_Handl_Get_Script", 1) end end):SetImage("icon16/car.png")
				DDM:AddButton(VC.Lng("Engine"), function() if IsValid(VC.GetVehicle(ply)) then RunConsoleCommand("VC_Dev_Handl_Get_Script", 2) end end):SetImage("icon16/cog.png")
				DDM:AddButton(VC.Lng("Steering"), function() if IsValid(VC.GetVehicle(ply)) then RunConsoleCommand("VC_Dev_Handl_Get_Script", 3) end end):SetImage("icon16/arrow_rotate_clockwise.png")
				DDM:AddButton(VC.Lng("FrontAxle"), function() if IsValid(VC.GetVehicle(ply)) then RunConsoleCommand("VC_Dev_Handl_Get_Script", 4) end end):SetImage("icon16/arrow_up.png")
				DDM:AddButton(VC.Lng("RearAxle"), function() if IsValid(VC.GetVehicle(ply)) then RunConsoleCommand("VC_Dev_Handl_Get_Script", 5) end end):SetImage("icon16/arrow_down.png")
				DDM:AddButton(VC.Lng("Sound"), function() if IsValid(VC.GetVehicle(ply)) then RunConsoleCommand("VC_Dev_Handl_Get_Script", 6) end end):SetImage("icon16/sound.png")
				DDM:Open()
			end
		end

		AplHnd.DoClick = function() local ent = VC.GetVehicle(ply) if !IsValid(VC.GetVehicle(ply)) then VCPopup("Look at a vehicle or be inside of one first.", "cross") return end LocalPlayer().VC_Dev_RVWCS = true end

		local function ChangeLog_Append(Seq, Nm, Arg)
		Nm = Nm or SLst:GetLine(SLst:GetSelectedLine()):GetValue(1) local CLCS, CLCCS, FDir, CurT, CurA, Div = nil, nil, "vcmod/handling/changelogs/"..Nm..".txt", tostring(os.date()), LocalPlayer():Nick(), "\n"
			local function Append_Create(MMsg)
				if Seq == "Create" then
				CLCCS = (MMsg or "Creating")..", "..CurT..".\nName: '"..Nm.."'\nAuthor: "..CurA
				elseif file.Exists("Data/vcmod/handling/"..Nm..".txt", "GAME") then
				local Str = string.Explode("\n", file.Read("Data/vcmod/handling/"..Nm..".txt", "GAME"))[1]
				CLCCS = "Auto Creating, "..CurT..".\nChangeLog not found, creating one\nName: '"..Nm.."'\nAuthor: "..(string.find(Str, " created by ") and string.Explode(" in ", string.Explode(" created by ", Str)[2])[1] or "Unknown")
				end
			if CLCCS then file.Append(FDir, Div..CLCCS.."\n") end
			end
			if !file.Exists("Data/"..FDir, "GAME") then Append_Create() else local CLF = file.Read("Data/"..FDir, "GAME") local CA, RA = 0, 0 for _ in string.gmatch(CLF, "Creating") do CA = CA+ 1 end for _ in string.gmatch(CLF, "Removing") do RA = RA+ 1 end if CA <= RA then Append_Create("Re-Creating") end end
			if Seq == "Update" then




			-- local RTbl, FDir = {[1] = "Updating, "..CurT.."."}, "vcmod/handling/"..Nm..".txt"
				-- local function RetrieveInfo(OpL)
					-- for _, Opt in pairs(OpL) do
						-- local Val, TAM = Opt[3] and (Opt[3] == "Vector" and Opt[4]() or Opt[4]) or Opt[2]:GetValue(), nil
						-- if Opt[2].VC_Decimals then local VDc = 10^ Opt[2].VC_Decimals Val = math.Round(Val*VDc)/VDc elseif Opt[2].VC_CheckBox then Val = Opt[2]:GetChecked() end
						-- if Opt[3] and Opt[3] == "Table" or Opt[2].VC_CheckBox or Val != Opt[1] then
							-- if Opt[3] and Opt[3] == "Table" then
								-- local GAm, LOp = #Opt[1]- #Val, nil
									-- if GAm != 0 then if !LOp then table.insert(RTbl, "---------------------------------") LOp = true end if !TAM then table.insert(RTbl, Opt[2].VC_Text.."s:") TAM = true end table.insert(RTbl, "Amount "..(GAm > 0 and "reduced" or "increased")..", from '"..#Opt[1].."', to '"..#Val.."'.") end
									-- for Vk, Vv in pairs(Val) do
										-- if Opt[1][Vk] then
											-- if type(Vv) == "table" then
											-- for FTk, FTv in pairs(Vv) do if FTv != Opt[1][Vk][FTk][1] then if !LOp then table.insert(RTbl, "---------------------------------") LOp = true end if !TAM then table.insert(RTbl, Opt[2].VC_Text.."s:") TAM = true end table.insert(RTbl, Opt[2].VC_Text.." "..Vk..", "..Opt[1][Vk][FTk][2].." changed from '"..Opt[1][Vk][FTk][1].."', to '"..FTv.."'.") end end
											-- elseif Vv != Opt[1][Vk] then
											-- if !LOp then table.insert(RTbl, "---------------------------------") LOp = true end if !TAM then table.insert(RTbl, Opt[2].VC_Text.."s:") TAM = true end table.insert(RTbl, Opt[2].VC_Text.." "..Vk.." changed from '"..Opt[1][Vk].."', to '"..Vv.."'.")
											-- end
										-- end
									-- end
								-- if LOp then table.insert(RTbl, "---------------------------------") end
							-- elseif Opt[2].VC_CheckBox then
							-- if Val != tobool(Opt[1]) then
							-- table.insert(RTbl, Opt[2].VC_Text..", "..(Val and "enabled." or "disabled.")) end
							-- elseif !Opt[3] or Opt[3] != "Table" then
							-- table.insert(RTbl, (Opt[2].VC_Text or Opt[2]:GetParent().VC_Text)..", from '"..Opt[1].."', to '"..Val.."'.")
							-- end
						-- end
					-- end
				-- end
			-- table.insert(RTbl, "-----------------------------------\nBody\n-----------------------------------")
			-- RetrieveInfo(Import_Handling("Data/"..FDir, "Body", true)["Body"])
			-- table.insert(RTbl, "-----------------------------------\nEngine\n-----------------------------------")
			-- RetrieveInfo(Import_Handling("Data/"..FDir, "Engine", true)["Engine"])
			-- table.insert(RTbl, "-----------------------------------\nSteering\n-----------------------------------")
			-- RetrieveInfo(Import_Handling("Data/"..FDir, "Steering", true)["Steering"])
			-- table.insert(RTbl, "-----------------------------------\nFront Axle\n-----------------------------------")
			-- RetrieveInfo(Import_Handling("Data/"..FDir, "Front Axle", true)["Front Axle"])
			-- table.insert(RTbl, "-----------------------------------\nRear Axle\n-----------------------------------")
			-- RetrieveInfo(Import_Handling("Data/"..FDir, "Rear Axle", true)["Rear Axle"])
			-- table.insert(RTbl, "-----------------------------------\nSound\n-----------------------------------")
			-- RetrieveInfo(Import_Handling("Data/"..FDir, "Sound", true)["Sound"])
			-- CLCS = string.Implode("\n", RTbl)
			elseif Seq == "Remove" then
			CLCS = "Removing, "..CurT.."."
			elseif Seq == "Rename" and file.Exists("Data/"..FDir, "GAME") then
			local PHS = file.Read("Data/"..FDir, "GAME") file.Write("vcmod/handling/changelogs/"..Arg..".txt", PHS) file.Delete(FDir) CLCS = "Renaming, "..CurT..".\nOld name: '"..Nm.."'\nNew name: '"..Arg.."'" FDir = "vcmod/handling/changelogs/"..Arg..".txt"
			end
		if CLCS and (!CLCCS or Seq != "Create") then file.Append(FDir, Div..CLCS.."\n") end
		end
		STN.OnTextChanged = function() ManageAddButton() end
		SLst.DoDoubleClick = function(prnt, idx, lst) local LVl = "Data/vcmod/handling/"..SLst:GetLine(idx):GetValue(1)..".txt" if file.Exists(LVl, "GAME") then Import_Handling(LVl) end end
			SLst.OnRowRightClick = function(pnl, ln)
			local DDM = VC.DermaMenu("Import")
			local ISM = DDM:VC_AddSubMenu(VC.Lng("Import"))
				ISM:AddButton(VC.Lng("Everything"), function() local LVl = "Data/vcmod/handling/"..SLst:GetLine(ln):GetValue(1)..".txt" if file.Exists(LVl, "GAME") then Import_Handling(LVl, "Everything") end end):SetImage("icon16/key.png")
				ISM:AddSpacer()
				ISM:AddButton(VC.Lng("Body"), function() local LVl = "Data/vcmod/handling/"..SLst:GetLine(ln):GetValue(1)..".txt" if file.Exists(LVl, "GAME") then Import_Handling(LVl, "Body") end end):SetImage("icon16/car.png")
				ISM:AddButton(VC.Lng("Engine"), function() local LVl = "Data/vcmod/handling/"..SLst:GetLine(ln):GetValue(1)..".txt" if file.Exists(LVl, "GAME") then Import_Handling(LVl, "Engine") end end):SetImage("icon16/cog.png")
				ISM:AddButton(VC.Lng("Steering"), function() local LVl = "Data/vcmod/handling/"..SLst:GetLine(ln):GetValue(1)..".txt" if file.Exists(LVl, "GAME") then Import_Handling(LVl, "Steering") end end):SetImage("icon16/arrow_rotate_clockwise.png")
				ISM:AddButton(VC.Lng("FrontAxle"), function() local LVl = "Data/vcmod/handling/"..SLst:GetLine(ln):GetValue(1)..".txt" if file.Exists(LVl, "GAME") then Import_Handling(LVl, "Front Axle") end end):SetImage("icon16/arrow_up.png")
				ISM:AddButton(VC.Lng("RearAxle"), function() local LVl = "Data/vcmod/handling/"..SLst:GetLine(ln):GetValue(1)..".txt" if file.Exists(LVl, "GAME") then Import_Handling(LVl, "Rear Axle") end end):SetImage("icon16/arrow_down.png")
				ISM:AddButton(VC.Lng("Sound"), function() local LVl = "Data/vcmod/handling/"..SLst:GetLine(ln):GetValue(1)..".txt" if file.Exists(LVl, "GAME") then Import_Handling(LVl, "Sound") end end):SetImage("icon16/sound.png")
			-- DDM:AddButton(VC.Lng("ChangeLog"), function()
				-- local LVl, SL = SLst:GetLine(ln):GetValue(1), nil
				-- if !file.Exists("Data/vcmod/handling/changelogs/"..LVl..".txt", "GAME") then ChangeLog_Append("", nil, true) end SL = file.Read("Data/vcmod/handling/changelogs/"..LVl..".txt", "GAME")
				-- local Sx, Sy = math.Clamp(ScrW(), 0, 1000), math.Clamp(ScrH(), 0, 800) local CLF = vgui.Create("DFrame") CLF:SetSize(Sx, Sy) CLF:SetTitle("Handling Scripts '"..LVl.."' ChangeLog") CLF:SetDraggable(true) CLF:SetBackgroundBlur(true) CLF:ShowCloseButton(true) CLF:MakePopup() CLF:Center() local CLP = vgui.Create("DPanelList", CLF) CLP:SetPos(5, 28) CLP:SetSize(Sx-10, Sy-28) CLP:EnableVerticalScrollbar(true)
				-- for _, Str in pairs(string.Explode("---------------------------------------------------------------------------------", SL)) do
					-- local SST = string.Explode("\n", Str)
					-- if string.len(Str[2]) > 0 then
					-- local CLCC = vgui.Create("DCollapsibleCategory", CLP) CLCC:SetExpanded(false) CLCC:SetLabel(SST[2]) local CLCCPL = vgui.Create("DPanelList") CLCCPL:SetAutoSize(true) CLCC:SetContents(CLCCPL) CLP:AddItem(CLCC)
					-- for i=1, table.Count(SST)-2 do if string.len(SST[i+2]) > 0 then if SST[i+2] == "-----------------------------------" then VC.Add_El_Line(CLCCPL) elseif SST[i+2] == "---------------------------------" then VC.Add_El_Line(CLCCPL, Color(200, 255, 0, 150)) else local CLL = vgui.Create("DLabel", CLCCPL) CLL:SetText(SST[i+2]) CLCCPL:AddItem(CLL) end end end
					-- end
				-- end
			-- end):SetImage("icon16/calendar.png")
			DDM:AddButton(VC.Lng("Rename"), function() Derma_StringRequest("Handling Editor script name change", "Write the new handling script name", SLst:GetLine(ln):GetValue(1), function(txt) local SIN = SLst:GetLine(ln):GetValue(1) local LVl = "vcmod/handling/"..SIN..".txt" if SIN != txt and file.Exists("Data/"..LVl, "GAME") then local PHS = file.Read("Data/"..LVl, "GAME") PHS = string.Explode("\n", PHS) PHS[1] = string.gsub(PHS[1], SIN, txt) PHS = string.Implode("\n", PHS) file.Delete(LVl) file.Write("vcmod/handling/"..txt..".txt", PHS) ChangeLog_Append("Rename", SIN, txt) RefreshList() end end) end):SetImage("icon16/text_allcaps.png")
			DDM:AddButton(VC.Lng("Delete"), function() local LVl = "vcmod/handling/"..SLst:GetLine(ln):GetValue(1)..".txt" if file.Exists("Data/"..LVl, "GAME") then ChangeLog_Append("Remove") file.Delete(LVl) RefreshList() ManageAddButton() end end):SetImage("icon16/delete.png")
			DDM:Open()
			end

		ARB.DoClick = function() if STN:GetValue() == "" then VCPopup("First set the name.", "cross") return end local FDir = "vcmod/handling/"..STN:GetValue()..".txt" if file.Exists("Data/"..FDir, "GAME") then ChangeLog_Append("Update", STN:GetValue()) else ChangeLog_Append("Create", STN:GetValue()) end file.Write(FDir, Export_Handling()) VCMsg('Saved ("Data/'..FDir..'").', ply) RefreshList() ManageAddButton() end

		local TSFC = 0
		Pnl.Think = function()
		if LocalPlayer().VC_Dev_RVWCS then if IsValid(VC.GetVehicle(ply)) and CurTime() >= RsDel and STN:GetValue() != "" then TSFC = TSFC+1 local SNm = STN:GetValue() SNm = SNm.."_vc"..TSFC file.Write("vcmod/handling/temp/"..SNm..".txt", Export_Handling()) RunConsoleCommand("VC_Dev_Respawn_Vehicle", SNm) RsDel = CurTime()+ 0.2 end LocalPlayer().VC_Dev_RVWCS = nil end
		if LocalPlayer().VC_Dev_Scrpt then Import_Handling(LocalPlayer().VC_Dev_Scrpt.Script, LocalPlayer().VC_Dev_Scrpt.Type) LocalPlayer().VC_Dev_Scrpt = nil end
		local PWth = Pnl_Left:GetWide()-81
	end
end
if !VC.Menu_Items_P then VC.Menu_Items_P = {} end
VC.Menu_Items_P.Handling = {"Handling", BuildMenu}

net.Receive("VC_Dev_Script_Handling", function() local scr = net.ReadString() local Type = net.ReadInt(4) LocalPlayer().VC_Dev_Scrpt = {} LocalPlayer().VC_Dev_Scrpt.Script = scr if Type and Type != 0 then LocalPlayer().VC_Dev_Scrpt.Type = Type end end)

concommand.Add("VC_Dev_Apply_Handling", function(ply, cmd, arg) if IsValid(VC.GetVehicle(ply)) and vgui.CursorVisible() then ply.VC_Dev_RVWCS = true end end)

--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher
