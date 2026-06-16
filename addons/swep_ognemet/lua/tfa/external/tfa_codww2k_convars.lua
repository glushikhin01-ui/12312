-- Copyright (c) 2018-2020 TFA Base Devs

-- Permission is hereby granted, free of charge, to any person obtaining a copy
-- of this software and associated documentation files (the "Software"), to deal
-- in the Software without restriction, including without limitation the rights
-- to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
-- copies of the Software, and to permit persons to whom the Software is
-- furnished to do so, subject to the following conditions:

-- The above copyright notice and this permission notice shall be included in all
-- copies or substantial portions of the Software.

-- THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
-- IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
-- FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
-- AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
-- LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
-- OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
-- SOFTWARE.

local function CreateReplConVar(cvarname, cvarvalue, description, ...)
	return CreateConVar(cvarname, cvarvalue, CLIENT and {FCVAR_REPLICATED} or {FCVAR_REPLICATED, FCVAR_ARCHIVE, FCVAR_NOTIFY}, description, ...)
end -- replicated only on clients, archive/notify on server

if GetConVar("sv_tfa_codww2k_flamethrower_regen") == nil then
	CreateReplConVar("sv_tfa_codww2k_flamethrower_regen", "0", "Enable or disable flamethrowers regenerating ammo. (1 true, 0 false). Default is 0")
end

if GetConVar("sv_tfa_codww2k_flamethrower_regendelay") == nil then
	CreateReplConVar("sv_tfa_codww2k_flamethrower_regendelay", "0.15", "Ammo Regen delay for flamethrowers. Default is 0.15")
end

if GetConVar("sv_tfa_codww2k_flamethrower_regendelayPaP") == nil then
	CreateReplConVar("sv_tfa_codww2k_flamethrower_regendelayPaP", "0.05", "Ammo Regen delay for flamethrowers when PaP'd. Default is 0.05")
end