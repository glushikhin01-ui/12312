local PANEL = {}
function PANEL:Init()
self.ContainerID = 0
self.slots = {}
self.list = vgui.Create("DIconLayout", self)
self.list:Dock(FILL)
self.list:SetSpaceX(5)
self.list:SetSpaceY(5)
self:Refresh()
hook.Add("enc_inv.refresh."..tostring(self), "enc_inv_cstore_refresh", function()
if IsValid(self) then self:Refresh() end
end)
end
function PANEL:SetContainerID(id)
self.ContainerID = id
self:Refresh()
end
function PANEL:Refresh()
if !IsValid(self.list) then return end
self.list:Clear()
self.slots = {}
local inv = LocalPlayer().inventory or {}
for i = 1, 30 do
local s = vgui.Create("enc.inv.slot", self.list)
s:SetSize(58, 58)
s:SetSlot(i)
self.slots[i] = s
end
end
function PANEL:OnRemove()
hook.Remove("enc_inv.refresh."..tostring(self), "enc_inv_cstore_refresh")
end
function PANEL:Paint(w,h)
end
vgui.Register("ItemStoreContainer", PANEL, "DPanel")
