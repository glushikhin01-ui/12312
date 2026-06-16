--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher

-- Discord Tutorial:
-- 1. https://discord.com/developers/applications - Create a new application!
-- 2. Copy and fill in client_id [sh_config]
-- 3. Copy and fill in client_secret [sv_config]
-- 4. Enable Developer Mode in discord [Enabling Developer Mode is easy. Open your Discord settings (the next to your name at the bottom left) and click on Appearance. There you will find Developer Mode. Click the toggle to enable it.] - https://discordia.me/en/developer-mode
-- 5. Right Click Discord Server and press Copy ID and fill that into the guild_id [sh_config]
-- 6. Create a permanent invite link and add the end of the url into invite_id [sh_config]
-- 7. Enter the bot tab in your discord application and copy token into the bot_token [sv_config]
-- 8. Go into OAuth2 tab of the discord application and add a redirect link, example commuinity website
-- 9. Invite the bot to the server by using this link! [https://discordapp.com/api/oauth2/authorize?client_id=CLIENTIDHERE&permissions=8&response_type=code&scope=bot%20guilds]

-- Steam Tutorial:
-- 1. Add group_name, you can find it in the end of group link! Example: https://steamcommunity.com/groups/*GROUP_NAME* [sh_config]
-- 2. Setup a name tag, can be anything you see suited. [sh_config]
-- 3. Add steam api_key, you can find it here [https://steamcommunity.com/dev/apikey] [sv_config]
-- 4. Add steam group_id, to find it you need to press edit on your steam group.
-- Link: https://steamcommunity.com/groups/*GROUP_NAME*/edit then near the top it will say ID.
-- Copy and paste this ID into group_id [sv_config]

sReward = sReward or {}
sReward.config = sReward.config or {}
sReward.config["discord"] = sReward.config["discord"] or {} -- There is more to do in the sv_sreward_config file!
sReward.config["steam"] = sReward.config["steam"] or {} -- There is more to do in the sv_sreward_config file!

--  _______       _          _______              ___ _       
-- (_______)     (_)        (_______)            / __|_)      
--  _  _  _ _____ _ ____     _       ___  ____ _| |__ _  ____ 
-- | ||_|| (____ | |  _ \   | |     / _ \|  _ (_   __) |/ _  |
-- | |   | / ___ | | | | |  | |____| |_| | | | || |  | ( (_| |
-- |_|   |_\_____|_|_| |_|   \______)___/|_| |_||_|  |_|\___ |
--                                                     (_____|

sReward.config["language"] = "en"

sReward.config["prefix"] = "[sReward] "

sReward.config["size"] = { -- Size of the reward menu
    w = 670, -- Width (def. 670)
    h = 520 -- Height (def. 520)
}

sReward.config["steam"]["group_name"] = "justrprussia" -- Custom URL
sReward.config["steam"]["name_tag"] = {"example.gg"} -- You can add multiple in here!

sReward.config["discord"]["client_id"] = "1493228827940225024"  -- Look uptop for information!
sReward.config["discord"]["invite_id"] = "arizonaroleplay"
sReward.config["discord"]["guild_id"] = "1493228827940225024"

sReward.config["max_referrals"] = 1

sReward.config["open_on_join"] = true

sReward.config["receive_referral_reward"] = { -- This is what you receive for referring someone.
    ["darkrp_money"] = 40000
}

sReward.config["give_referral_reward"] = { -- This is what you receive for referring.
    -- ["sr_tokens"] = 100,
    ["darkrp_money"] = 20000
}

sReward.config["permissions"] = {
    ["sReward_AdminMenu"] = {
        ["*"] = true,
    },
    ["sReward_AddTokenCommand"] = {
        ["*"] = true,
    }
}

sReward.config["enabled_tabs"] = { -- You can disable/enable tabs in here.
    ["tasks"] = true,
    ["referral"] = true,
    ["shop"] = true,
    ["leaderboard"] = true
}


--  ______                             _      
-- (_____ \                           | |     
--  _____) )_____ _ _ _ _____  ____ __| | ___ 
-- |  __  /| ___ | | | (____ |/ ___) _  |/___)
-- | |  \ \| ____| | | / ___ | |  ( (_| |___ |
-- |_|   |_|_____)\___/\_____|_|   \____(___/ 

sReward.config["rewards"] = { -- This is where you can configure your rewards.
    {
        enabled = true,
        name = "Группа Steam",
        instruction = "Подключись к нашей группе стим!",
        funcname = "VerifySteamGroup",
        instructionFunc = function() gui.OpenURL("https://steamcommunity.com/groups/"..sReward.config["steam"]["group_name"]) end,
        maxuse = 1,
        cooldown = 0,
        net_cd = 5,
        reward = {
            ["donate_kyl"] = 50,
        },
        -- custom = function(ply)
        --     Anything custom in here!
        -- end
    },
    {
        enabled = true,
        name = "Discord",
        funcname = "VerifyDiscordJoin",
        instruction = "Подключись к нашему дискорду!",
        instructionFunc = function() gui.OpenURL("https://discord.gg/"..sReward.config["discord"]["invite_id"]) end,
        maxuse = 1, -- Lets allow them to use it daily!
        cooldown = 0, -- One day!
        net_cd = 5,
        reward = {
            ["donate_kyl"] = 75,
        }
    },
}


--   ______ _                 
--  / _____) |                
-- ( (____ | |__   ___  ____  
--  \____ \|  _ \ / _ \|  _ \ 
--  _____) ) | | | |_| | |_| |
-- (______/|_| |_|\___/|  __/ 
--                     |_|    

sReward.config["shop"] = { -- These are examples, also you dont really need these as you can add items from the admin menu!
    -- [1] = {
    --     enabled = true,
    --     name = "VIP Rank",
    --     imgurid = "kMut76q",
    --     price = 200,
    --     reward = {
    --         ["reward_rank"] = "vip"
    --     }
    -- },
    -- [2] = {
    --     enabled = false,
    --     name = "20$ Gift Card",
    --     imgurid = "2YVOI55",
    --     price = 500,
    --     reward = {
    --         ["reward_rank"] = "vip"
    --     }
    -- },
    -- [3] = {
    --     enabled = true,
    --     name = "Spotify - 1 Month",
    --     imgurid = "GsS6Vg0",
    --     price = 400,
    --     reward = {
    --         ["coupon"] = "Spotify - 1 Month"
    --     }
    -- },
    -- [4] = {
    --     enabled = false,
    --     name = "Rocket League - Steam",
    --     imgurid = "hFIWT0u",
    --     price = 400,
    --     reward = {
    --         ["reward_rank"] = "vip"
    --     }
    -- },
    -- [5] = {
    --     enabled = false,
    --     name = "Minecraft - Mojang",
    --     imgurid = "F9hk4y9",
    --     price = 300,
    --     reward = {
    --         ["reward_rank"] = "vip"
    --     }
    -- },
    -- [6] = {
    --     enabled = false,
    --     name = "GTA V - Steam",
    --     imgurid = "TW38boy",
    --     price = 500,
    --     reward = {
    --         ["reward_rank"] = "vip"
    --     }
    -- },
    -- [7] = {
    --     enabled = false,
    --     name = "Cyberpunk 2077 - GOG",
    --     imgurid = "toU6qwS",
    --     price = 1300,
    --     reward = {
    --         ["reward_rank"] = "vip"
    --     }
    -- }
}

--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher
