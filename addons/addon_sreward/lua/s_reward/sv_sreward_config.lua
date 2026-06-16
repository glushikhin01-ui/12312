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
sReward.config["steam"] = sReward.config["steam"] or {}
sReward.config["discord"] = sReward.config["discord"] or {}

--   ______                                   
--  / _____) _                                
-- ( (____ _| |_ ___   ____ _____  ____ _____ 
--  \____ (_   _) _ \ / ___|____ |/ _  | ___ |
--  _____) )| || |_| | |   / ___ ( (_| | ____|
-- (______/  \__)___/|_|   \_____|\___ |_____)
--                               (_____|      

sReward.config["storage_type"] = "sql_local" -- (sql_local, mysql)

sReward.config["mysql_info"] = {
    host = "192.168.153.2",
    port = 3306,
    database = "s2706_viberp",
    username = "u2706_hsIOjmenS0",
    password = "gGy1e+fHmVC1hpLl.ZRnG@k@"
}


--  _______       _          _______              ___ _       
-- (_______)     (_)        (_______)            / __|_)      
--  _  _  _ _____ _ ____     _       ___  ____ _| |__ _  ____ 
-- | ||_|| (____ | |  _ \   | |     / _ \|  _ (_   __) |/ _  |
-- | |   | / ___ | | | | |  | |____| |_| | | | || |  | ( (_| |
-- |_|   |_\_____|_|_| |_|   \______)___/|_| |_||_|  |_|\___ |
--                                                     (_____|

sReward.config["chat_commands"] = { -- People are used to other commands, lets just make it easier for them!
    ["!sreward"] = true,
    ["!srewards"] = true,
    ["!reward"] = true,
    ["!rewards"] = true
}

sReward.config["discord"]["client_secret"] = "YYOFKK6-scljvxryfzJsJVbPGjqLrq9d" -- Look uptop for information! ^
sReward.config["discord"]["bot_token"] = "MTQ5MzIyODgyNzk0MDIyNTAyNA.G-rfyZ.k9ZPgUkwDp3Ax9ejkz1a-xpduwWQYBXgeiJGWY"

sReward.config["steam"]["api_key"] = "9A3204790323183F41170701798BC68E" -- https://steamcommunity.com/dev/apikey
sReward.config["steam"]["group_id"] = "45380873" -- https://steamcommunity.com/groups/GROUPNAME/edit : Look for the ID


--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher
