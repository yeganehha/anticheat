ServerConfig = {}


--//DiscordLog//--
ServerConfig.DiscordLog = false
ServerConfig.DiscordWarn                = ""
ServerConfig.Discordexplosion           = ""
ServerConfig.DiscordObject              = ""
ServerConfig.DiscordOVehicle            = ""
ServerConfig.DiscordPeds                = ""
ServerConfig.DiscordBan                 = ""
ServerConfig.DiscordBanAnnounce         = ""
ServerConfig.DiscordUnKnownResource     = ""
ServerConfig.DiscordScreenShot		    = ""
ServerConfig.Discord                    = ""
ServerConfig.DiscordLeftAndJoin         = ""


ServerConfig.BanMassage = "You have ban from server. for unban join to our discord."

--//LoliHunter//--
ServerConfig.ConfigVersion = 1 -- Don't touch, it's better


ServerConfig.ConnectCheck = false -- Check Player connect to anticheat


ServerConfig.CheckIP = false -- Check Player palyer IP connect


ServerConfig.SendBanAnnounce = true -- send Cheat and Cheater Information To Discord

--//Chat Control Stuff//--
ServerConfig.BlacklistedWordsDetection = true -- Detects and log the player that tried to say something blacklisted (configs/blacklistedwords.lua)
ServerConfig.BlacklistedWordsKick = true -- Kick the player that tried to say a blacklisted word (require BlacklistedWordsDetection = true)
ServerConfig.BlacklistedWordsBan = false -- Ban the player that tried to say a blacklisted word (require BlacklistedWordsDetection = true)

--//Default Stuff//--
ServerConfig.TriggerDetection = true -- Kick the player that tried to execute or call a blacklisted trigger (remember to edit or obfuscate your original triggers), this will find all newbie cheaters/skids

--//Anti Explosion System (tables are in tables folder)//--
ServerConfig.DetectExplosions = true -- Automatically detect blacklisted explosions from (tables/blacklistedexplosions.lua)
ServerConfig.ExplosionsScreenShot = false


ServerConfig.AntiNuke = true
ServerConfig.AntiSpawnVehicles = true
ServerConfig.AntiSpawnPeds     = true



ServerConfig.detectUnknownClientResource     = false
ServerConfig.UnknownClientResourceLog     = false
ServerConfig.ClientResourcesCheckStatusByServer     = false
ServerConfig.UnknownClientResourceKick     = false
ServerConfig.UnknownClientResourceBan     = false


ServerConfig.nameOfDiscordScreenshotResource = "discord-screenshot" -- required https://github.com/jaimeadf/discord-screenshot if you donot have, change to nil
ServerConfig.sendScreenShotOnDiscordLog = true
