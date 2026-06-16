--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher


    local PANEL = {}

    function PANEL:Init()
        self.PanelList = vgui.Create("DPanelList", self)
        self.PanelList:SetPadding(4)
        self.PanelList:SetSpacing(2)
        self.PanelList:EnableVerticalScrollbar(true)
        self:BuildList()
    end

    local function AddComma(n)
        local sn = tostring(n)
        sn = string.ToTable(sn)
        local tab = {}

        for i = 0, #sn - 1 do
            if i % 3 == #sn % 3 and not (i == 0) then
                table.insert(tab, ",")
            end

            table.insert(tab, sn[i + 1])
        end

        return string.Implode("", tab)
    end

    function PANEL:BuildList()
        self.PanelList:Clear()


        for CategoryName, v in SortedPairs(PropWhiteList) do
            local Category = vgui.Create("DCollapsibleCategory", self)
            self.PanelList:AddItem(Category)
            Category:SetExpanded(false)
            Category:SetLabel(CategoryName)
            Category:SetCookieName("EntitySpawn." .. CategoryName)
            local Content = vgui.Create("DPanelList")
            Category:SetContents(Content)
            Content:EnableHorizontal(true)
            Content:SetDrawBackground(false)
            Content:SetSpacing(2)
            Content:SetPadding(2)
            Content:SetAutoSize(true)
            number = 1

            for k, v in pairs(PropWhiteList[CategoryName]) do
              
                local Icon = vgui.Create("SpawnIcon", self)
                local Model = v
          
                Icon:SetModel(v)
            
                Icon.DoClick = function()
                    RunConsoleCommand("gm_spawn", Model)
                end

                local lable = vgui.Create("DLabel", Icon)
                lable:SetFont("DebugFixedSmall")
                lable:SetTextColor(color_black)
                lable:SetText(Model)
                lable:SetContentAlignment(5)
                lable:SetWide(self:GetWide())
                lable:AlignBottom(-42)
                Content:AddItem(Icon)
                number = number + 1
            end
        end

        self.PanelList:InvalidateLayout()
    end

    function PANEL:PerformLayout()
        self.PanelList:StretchToParent(0, 0, 0, 0)
    end

    local CreationSheet = vgui.RegisterTable(PANEL, "Panel")

    local function CreateContentPanel()
        local ctrl = vgui.CreateFromTable(CreationSheet)

        return ctrl
    end

    local function RemoveSandboxTabs()
        local AccsesGroup = {"*","project-team","manager","vice-manager", "supervisior"}
        local tabstoremove = {
                language.GetPhrase("spawnmenu.content_tab"), 
                language.GetPhrase("spawnmenu.category.npcs"), 
                language.GetPhrase("spawnmenu.category.entities"), 
                language.GetPhrase("spawnmenu.category.weapons"), 
                language.GetPhrase("spawnmenu.category.vehicles"), 
                language.GetPhrase("spawnmenu.category.postprocess"), 
                language.GetPhrase("spawnmenu.category.dupes"), 
                language.GetPhrase("spawnmenu.category.saves")
        }
        local tabstoremoveSup = {
                language.GetPhrase("spawnmenu.content_tab"), 
                language.GetPhrase("spawnmenu.category.npcs"), 
                language.GetPhrase("spawnmenu.category.entities"),  
                language.GetPhrase("spawnmenu.category.vehicles"), 
                language.GetPhrase("spawnmenu.category.postprocess"), 
                language.GetPhrase("spawnmenu.category.dupes"), 
                language.GetPhrase("spawnmenu.category.saves")
        }
       if LocalPlayer():IsRoot() or LocalPlayer():HasAccess('d') then 
            if !LocalPlayer():IsRoot() and !LocalPlayer():HasAccess('d') then 
                for k, v in pairs(g_SpawnMenu.CreateMenu.Items) do
                    if table.HasValue(tabstoremoveSup, v.Tab:GetText()) then
                        g_SpawnMenu.CreateMenu:CloseTab(v.Tab, true)
                        RemoveSandboxTabs()
                    end
                end
            end
        else
            for k, v in pairs(g_SpawnMenu.CreateMenu.Items) do
                if table.HasValue(tabstoremove, v.Tab:GetText()) then
                    g_SpawnMenu.CreateMenu:CloseTab(v.Tab, true)
                    RemoveSandboxTabs()
                end
            end
        end
    end

    hook.Add("SpawnMenuOpen", "blockmenutabs", RemoveSandboxTabs)

    local function BunkMenu()
        return
    end

    spawnmenu.AddCreationTab("Разрешенные пропы", CreateContentPanel, "icon16/application_view_tile.png", 4)

--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher
