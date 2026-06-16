--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher

if SERVER then
    resource.AddWorkshop('3379948449') -- Content
end

dev = dev or {}

function dev.print(text, sub, prefix, show_src) 
    local call = debug.getinfo(2, 'Sln')
    if type(text) == 'table' then
        for i,v in ipairs(text) do
            dev.print(i..': '..tostring(v), sub, prefix, show_src)
        end
        return true
    end

    if type(text) == 'string' and show_src then
        text = (call.currentline or '0')..':'..(call.short_src or 'unknown')..': '..(call.name or 'main chunk')..': '.. text
    end
    text = tostring(text)
    prefix = type(prefix) == 'string' and prefix or '·'; 
    sub = type(sub) == 'string' and sub or ' ~ '; 
    MsgC(Color(3, 252, 128), prefix .. sub); 
    MsgC(Color(255, 255, 255), text .. '\n') 
end

local function errorHandler(err)
    local trace = debug.traceback("Ошибка: " .. tostring(err), 2)
    MsgC(Color(255, 0, 0), trace .. '\n')
    return trace
end

local loader = {
    loaded = {},

    client = function(self, path)
        local success, err = xpcall(function()
            
        --    error('test error')
        dev.print('Loaded to client: '.. path)
        if CLIENT then include(path) end
        if SERVER then AddCSLuaFile(path) end
    
        
        end, errorHandler)
    end,

    server = function(self, path)
        local success, err = xpcall(function()
            
        
        dev.print('Loaded to server: '.. path)
        if SERVER then include(path) end
    
        end, errorHandler)
    end,

    shared = function(self, path)
        local success, err = xpcall(function()
            
        
        if self.loaded[path] then return end
        dev.print('Loaded to shared: '.. path)
        self:server(path)
        self:client(path)
        self.loaded[path] = true
    
    
        end, errorHandler)
    end,

    dir = function(self, path)
        local success, err = xpcall(function()
            
        
        path = 'workspace/' .. path
        local files = file.Find(path .. '/*', 'LUA')

        for _, script in ipairs(files) do
            local side = string.sub(script, 1, 3)
            local fp = path .. '/' .. script
            if self.loaded[fp] then continue end

            if side ~= 'cl_' and side ~= 'sv_' then
                self:shared(fp)
            elseif side == 'cl_' then
                self:client(fp)
            elseif side == 'sv_' then
                self:server(fp)
            end

            self.loaded[fp] = true
        end

        dev.print('Loaded path: "' .. path .. '" \n', ' + ')
    
    
        end, errorHandler)
    end
}

loader:shared('workspace/config.lua')
loader:dir('libs')
loader:dir('scripts')

MsgC(Color(161, 3, 252), '----------------------------------\n')

hook.Call('loader_loaded')


--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher
