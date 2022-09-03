
loadFile = nil
BanList    = {}
BanListRun = false

canUse     = true
CurrentVersion = '2.0.0.0'
lastVersion = ''

isAdminPlayer = {}
local usersNotBanForSpawnVehicle = {}

charset    = 'abcdefghijklmnopqrstuvwxyz0123456789'
charTable  = {}

PlayerBanedId = {}



function loadBanList()
 BanList = json.decode(loadFile)
 BanListRun = true
 --SaveResourceFile(GetCurrentResourceName(), "fileNameHere.json", json.encode(extract), -1)
end

function sendToDiscord(DiscordLog,source,title,des,color)
 if ServerConfig.DiscordLog and canUse then
        local nick = GetPlayerName(source) or "AntiCheat(dev by ErfanEbrahimi.ir)"
        local embed = {
            {
                ["color"] = color,
                ["title"] = title,
                ["description"] = des,
                ["footer"] = {
                ["text"] = "Dev: Erfan Ebrahimi @yeganehha#2637",
            },}}
        Wait(100)
         PerformHttpRequest(DiscordLog, function(err, text, headers) end, 'POST', json.encode({username = nick, embeds = embed}), { ['Content-Type'] = 'application/json' })
 end
end


function unbanPalyer( source , reportId )
 if source ~= nil and source > 0 and IsPlayerAceAllowed(source, "anticheat.unban") then
         if BanList[reportId] ~= nil then
                 local playerName = BanList[reportId].name
                 BanList[reportId] = nil
                 --sendNotficationToChat(source, playerName .. " now is unban!")
                 sendNotficationToChat(source,playerName .. " now is unban!")
                 SaveResourceFile(GetCurrentResourceName(), "./bans.json", json.encode(BanList), -1)
         else
                 sendNotficationToChat(source,"can not find ban id!")
         end
 elseif source == 0 or source == nil then
         if BanList[reportId] ~= nil then
                 local playerName = BanList[reportId].name
                 BanList[reportId] = nil
                 --sendNotficationToChat(source,playerName .. " now is unban!")
                 print("[AntiCheat]: ".. playerName .. " now is unban!" )

                 SaveResourceFile(GetCurrentResourceName(), "./bans.json", json.encode(BanList), -1)
         else
                 --sendNotficationToChat(source,"can not find ban id!")
                 print("[AntiCheat]: can not find ban id!" )

         end
 else
         sendNotficationToChat(source,"You dont have access!")
 end
end

function screenShot(playerId,_title,_color,_description)
 if ServerConfig.nameOfDiscordScreenshotResource ~= nil and ServerConfig.nameOfDiscordScreenshotResource ~= false and ServerConfig.nameOfDiscordScreenshotResource ~= "" and GetResourceState(ServerConfig.nameOfDiscordScreenshotResource) == "started" then
         if ServerConfig.DiscordScreenShot ~= nil and ServerConfig.DiscordScreenShot ~= "" then
                 exports[ServerConfig.nameOfDiscordScreenshotResource]:requestCustomClientScreenshotUploadToDiscord(
                         playerId,
                         ServerConfig.DiscordScreenShot,
                         {
                                 encoding = "png",
                                 quality = 1
                         },
                         {
                                 username = GetPlayerName(playerId) or "AntiCheat(dev by ErfanEbrahimi.ir)",
                                 avatar_url = "https://cdn.discordapp.com/icons/800134882721398855/cbe4c6e380df58bf85614689549dc47c.webp?size=1024",
                                 content = "AntiCheat(dev by ErfanEbrahimi.ir)!",
                                 embeds = {
                                         {
                                                 color = _color,
                                                 title = _title,
                                                 description = _description,
                                                 footer = {
                                                         text = "Dev: Erfan Ebrahimi @yeganehha#2637",
                                                 }
                                         }
                                 }
                         },
                         30000,
                         function(error)
                                 if error then
                                         return print("AntiCheat: ERROR: " .. error)
                                 end
                                 print("AntiCheat: Sent screenshot successfully")
                         end
                 )
         else
                 exports["discord-screenshot"]:requestClientScreenshotUploadToDiscord(
                         playerId,
                         {
                                 username = GetPlayerName(playerId) or "Erf AntiCheat",
                                 avatar_url = "https://cdn.discordapp.com/icons/800134882721398855/cbe4c6e380df58bf85614689549dc47c.webp?size=1024",
                                 content = "Meow!",
                                 embeds = {
                                         {
                                                 color = _color,
                                                 title = _title,
                                                 description = _description,
                                                 footer = {
                                                         text = "Dev: Erfan Ebrahimi @yeganehha#2637",
                                                 }
                                         }
                                 }
                         },
                         30000,
                         function(error)
                                 if error then
                                         return print("AntiCheat: ERROR: " .. error)
                                 end
                                 print("AntiCheat: Sent screenshot successfully")
                         end
                 )
         end
 end
end


function randomstring(length)
 local String = ""
 --local find = false
 while true do
         String = ""
         for i = 1, length do
                 String = String .. charTable[math.random(1, #charTable)]
         end
         --for BanId,BanInfo in pairs(BanList)do
                 --if BanId ==
         --end
         if BanList[String] == nil then
                 break
         end
 end
 return String
end

function ShowBanInfo( source , reportId )
 if source ~= nil and source > 0 and IsPlayerAceAllowed(source, "anticheat.ShowBans") then
         if BanList[reportId] ~= nil then
                 sendNotficationToChat(source,"player name:" .. BanList[reportId].name)
                 sendNotficationToChat(source,"reason:" .. BanList[reportId].reason)
                 sendNotficationToChat(source,"more data:" .. BanList[reportId].cheatOn)
                 sendNotficationToChat(source,"time:" .. os.date("%x", BanList[reportId].timeOfCheat ) )
         else
                 sendNotficationToChat(source,"can not find ban id!")
         end
 elseif source == 0 or source == nil then
         if BanList[reportId] ~= nil then
                 print("[AntiCheat]: player name:"..BanList[reportId].name )
                 print("[AntiCheat]: reason:"..BanList[reportId].reason )
                 print("[AntiCheat]: more data:"..BanList[reportId].cheatOn )
                 print("[AntiCheat]: time:".. os.date("%x", BanList[reportId].timeOfCheat )  )
         else
                 print("[AntiCheat]: can not find ban id!" )
         end
 else
         sendNotficationToChat(source,"You dont have access!")
 end
end



print('\n')
print('##############')
print('## ' .. GetCurrentResourceName())
print('##')
print('## Erfan Ebrahimi AntiCheat')
print('## Current Version: ' .. CurrentVersion)
print('## Last Version: ' .. CurrentVersion)
print('## Can Use In This Server: Yes')
print('##')
print('##############')
print('\n')

loadFile = LoadResourceFile(GetCurrentResourceName(), "./bans.json")
for c in charset:gmatch"." do
 table.insert(charTable, c)
end

while not BanListRun do
 loadBanList()
 Citizen.Wait(500)
end


while BanListRun == false do
 Citizen.Wait(500)
end

if canUse then
    local numBans = 0
    for BanId,BanInfo in pairs(BanList) do
         numBans = numBans + 1
    end
 sendToDiscord(ServerConfig.Discord,'[Anti Cheat]',"[Erfan AntiCheat]","**Anti Cheat Actived**\n\n**Number Of Cheaters baned**: "..numBans.."\n\n**Version**: "..CurrentVersion .."\n\n**Last Version**:"..lastVersion,4911411)
else
 canUse = true
 sendToDiscord(ServerConfig.Discord,'[Anti Cheat]',"[Erfan AntiCheat]","**Anti Cheat DeActived**\n\n**Buy License For Your Server From : http://erfanebrahimi.ir **\n\n**Version**: "..CurrentVersion .."\n\n**Last Version**:"..lastVersion,15158332)
 canUse = false
end



RegisterServerEvent('ErfanEbrahimi_ir_AntiCheat:addToAllowSpawnVeh')
AddEventHandler('ErfanEbrahimi_ir_AntiCheat:addToAllowSpawnVeh', function()
 table.insert(usersNotBanForSpawnVehicle, source)
end)




RegisterServerEvent('ErfanEbrahimi_ir_AntiCheat:onClientResourceStart')
AddEventHandler('ErfanEbrahimi_ir_AntiCheat:onClientResourceStart', function(resourceName)
 if ServerConfig.detectUnknownClientResource then
         local src = source
         local PlayerName = GetPlayerName(src) or "Can Not Find!"
         local isNewResource = true
         for _,rsName in pairs(listActiveResource)do
                 if resourceName == rsName then
                         isNewResource = false
                         break
                 end
         end
         if isNewResource and ServerConfig.ClientResourcesCheckStatusByServer then
                 local serverStatus = GetResourceState(resourceName)
                 if serverStatus == "started" or serverStatus == "starting" then
                         isNewResource = false
                 end
         end
         if isNewResource then
                 screenShot(src,"[Start Unknow resource]",15105570,"**-Player Name: **".. PlayerName .."\n\n**-Player ID: **".. src .."\n\n**-Resource Name: **".. resourceName .."\n\n**-Server resource status:** ".. GetResourceState(resourceName))
                 if ServerConfig.UnknownClientResourceBan then
                         TriggerEvent('ErfanEbrahimi_ir_AntiCheat:Ban1FuckinCheater', src,"Tried to use unknown!",BlackListEvents.Events[i])
                 elseif ServerConfig.UnknownClientResourceKick then
                         DropPlayer(src, 'Try to start unknown resource! (Detect by antiCheat)')
                 end
                 if ServerConfig.UnknownClientResourceLog then
                         sendToDiscord(ServerConfig.DiscordUnKnownResource,src,"[Start Unknow resource]","**-Player Name: **".. PlayerName .."\n\n**-Player ID: **".. src .."\n\n**-Resource Name: **".. resourceName .."\n\n**-Server resource status:** ".. GetResourceState(resourceName),15105570)
                 end
         end
 end
end)

RegisterServerEvent('ErfanEbrahimi_ir_AntiCheat:clientResources')
AddEventHandler('ErfanEbrahimi_ir_AntiCheat:clientResources', function(resourceNames)
 if ServerConfig.detectUnknownClientResource then
         local src = source
         local PlayerName = GetPlayerName(src) or "Can Not Find!"
         for __,resourceName in pairs(resourceNames)do
                 local isNewResource = true
                 for _,rsName in pairs(listActiveResource)do
                         if resourceName == rsName then
                                 isNewResource = false
                                 break
                         end
                 end
                 if isNewResource and ServerConfig.ClientResourcesCheckStatusByServer then
                         local serverStatus = GetResourceState(resourceName)
                         if serverStatus == "started" or serverStatus == "starting" then
                                 isNewResource = false
                         end
                 end
                 if isNewResource then
                         screenShot(src,"[Start Unknow resource]",15105570,"**-Player Name: **".. PlayerName .."\n\n**-Player ID: **".. src .."\n\n**-Resource Name: **".. resourceName .."\n\n**-Server resource status:** ".. GetResourceState(resourceName))
                         if ServerConfig.UnknownClientResourceBan then
                                 TriggerEvent('ErfanEbrahimi_ir_AntiCheat:Ban1FuckinCheater', src,"Tried to use unknown!",BlackListEvents.Events[i])
                                 break
                         elseif ServerConfig.UnknownClientResourceKick then
                                 DropPlayer(src, 'Try to start unknown resource! (Detect by antiCheat)')
                                 break
                         end
                         if ServerConfig.UnknownClientResourceLog then
                                 sendToDiscord(ServerConfig.DiscordUnKnownResource,src,"[Start Unknow resource]","**-Player Name: **".. PlayerName .."\n\n**-Player ID: **".. src .."\n\n**-Resource Name: **".. resourceName .."\n\n**-Server resource status:** ".. GetResourceState(resourceName),15105570)
                         end
                 end
         end
 end
end)




--[[
RegisterCommand('antiCheatBanList', function(source)
 ShowBanList(source)
end)
RegisterServerEvent('ErfanEbrahimi_ir_AntiCheat:ShowBanList')
AddEventHandler('ErfanEbrahimi_ir_AntiCheat:ShowBanList', function()
 ShowBanList(source)
end)
function ShowBanList(source)
 if IsPlayerAceAllowed(source, "anticheat.ShowBanList") then
         TriggerClientEvent("ErfanEbrahimi_ir_AntiCheat:ShowBanList", source,BanList)
 else
         sendNotficationToChat(source,"You dont have access!")
 end

end
]]


RegisterCommand('erfunban',  function(source, args, raw)
 unbanPalyer(source , args[1] )
end)
RegisterServerEvent("ErfanEbrahimi_ir_AntiCheat:unbanPlayer")
AddEventHandler("ErfanEbrahimi_ir_AntiCheat:unbanPlayer", function(reportId)
 unbanPalyer(source , reportId)
end)

RegisterCommand('erfbaninfo', function(source, args, raw)
 ShowBanInfo(source , args[1] )
end)

RegisterCommand('erfban',  function(source, args, raw)
 if #args >= 2 then
         local playerId = args[1]
         table.remove(args , 1 )
         local resoan = table.concat(args, " ")
         if GetPlayerName(playerId) ~= nil then
         if source ~= nil and source > 0 and IsPlayerAceAllowed(source, "anticheat.unban") then
                 local SpawnerName = GetPlayerName(source) or "[-]"
                 TriggerEvent('ErfanEbrahimi_ir_AntiCheat:Ban1FuckinCheater',playerId, resoan ,"ban By Staff "..SpawnerName)
         elseif source == 0  or source == nil then
                 TriggerEvent('ErfanEbrahimi_ir_AntiCheat:Ban1FuckinCheater',playerId, resoan ,"ban By Server Console!")
         else
                 sendNotficationToChat(source,"You dont have access!")
         end
         else
             sendNotficationToChat(source,"Player offline!")
         end
 else
         sendNotficationToChat(source,"Args is [id] [reason]!")
 end
end)





if ServerConfig.TriggerDetection then
    for i=1 , #BlackListEvents.Events do
        RegisterServerEvent(BlackListEvents.Events[i])
     AddEventHandler(BlackListEvents.Events[i], function()
             local src = source
             sendToDiscord(Discord,src,"[EXECUTER]","**Executer Name: **"..GetPlayerName(src).."\n\n**Event Name: **"..BlackListEvents.Events[i],3447003)
             TriggerEvent('ErfanEbrahimi_ir_AntiCheat:Ban1FuckinCheater', src,"Tried to use detected events!",BlackListEvents.Events[i])
             return CancelEvent()
        end)
    end
end



Citizen.CreateThread(function()
 while true and ServerConfig.ConnectionCheck do
         Citizen.Wait(10000)
         TriggerClientEvent("ErfanEbrahimi_ir_AntiCheat:TargetCheck", -1 , os.time() )
 end
end)





AddEventHandler('explosionEvent', function(sender, ev)
 if ServerConfig.DetectExplosions then
         CancelEvent()
         if ListExplosion.ExplosionsList[ev.explosionType] then
                 if ListExplosion.ExplosionsList[ev.explosionType].ban then
                         --sendToDiscord(ServerConfig.Discordexplosion,sender,"[CREATE BLOCKED EXPLOSION]","**Creator Name: **"..GetPlayerName(sender).."\n\n**Explosion Name: **"..ListExplosion.ExplosionsList[ev.explosionType].name,1752220)
                         TriggerEvent('ErfanEbrahimi_ir_AntiCheat:Ban1FuckinCheater', sender,"Tried to create block list Explosions",ListExplosion.ExplosionsList[ev.explosionType].name)
                 else
                         if ListExplosion.ExplosionsList[ev.explosionType].log then
                                 sendToDiscord(ServerConfig.Discordexplosion,sender,"[CREATE BLOCKED EXPLOSION]","**Creator Name: **"..GetPlayerName(sender).."\n\n**Explosion Name: **"..ListExplosion.ExplosionsList[ev.explosionType].name,1752220)
                         end
                         if ServerConfig.ExplosionsScreenShot then
                                 screenShot(sender,"[CREATE BLOCKED EXPLOSION]",1752220,"**Creator Name: **"..GetPlayerName(sender).."\n\n**Explosion Name: **"..ListExplosion.ExplosionsList[ev.explosionType].name)
                         end
                 end
         else
                 sendToDiscord(ServerConfig.Discordexplosion,sender,"[CREATE UNKNOWN EXPLOSION]","**Creator Name: **"..GetPlayerName(sender).."\n\n**Explosion TYPE: **"..ev.explosionType,1752220)
         end
 end
end)



RegisterServerEvent('ErfanEbrahimi_ir_AntiCheat:BanMySelf')
AddEventHandler('ErfanEbrahimi_ir_AntiCheat:BanMySelf', function(reason,checkadmin)
 TriggerEvent('ErfanEbrahimi_ir_AntiCheat:Ban1FuckinCheater', source,reason,'')
end)








AddEventHandler('entityCreated', function(entity)
    local entity = entity
    if not DoesEntityExist(entity) then
        return
    end
    local src = NetworkGetEntityOwner(entity)
    local entID = NetworkGetNetworkIdFromEntity(entity)
    local model = GetEntityModel(entity)
 local hash = GetHashKey(entity)
 local SpawnerName = GetPlayerName(src) or " "


 local i , v
 local returnIt = false
 for i,v in pairs(usersNotBanForSpawnVehicle) do
   if v == src then
         table.remove(usersNotBanForSpawnVehicle, i)
         i = i -1
         returnIt = true
   end
 end
 if returnIt then
         return
 end

 -- Check Blocked Vehicles
 if ServerConfig.AntiSpawnVehicles then
     for i, objName in ipairs(BlackListEntity.AntiNukeBlacklistedVehicles) do
             if model == GetHashKey(objName.name) then
                         TriggerClientEvent("ErfanEbrahimi_ir_AntiCheat:DeleteCars", -1,entID)
                         Citizen.Wait(800)
                         if objName.log then
                         sendToDiscord(ServerConfig.DiscordOVehicle,src,"[SPAWN BLOCKED VEHICLE]","**-Spawner Name: **".. ( spawnerName or " cant Find ") .."\n\n**-Vehicle Name: **"..objName.name.."\n\n**-Spawn Model:** "..model.."\n\n**-Entity ID:** "..entity.."\n\n**-Hash ID:** "..hash,15105570)
                         end
                         if ServerConfig.sendScreenShotOnDiscordLog and objName.log and not objName.ban then
                                 screenShot(src,"[SPAWN BLOCKED VEHICLE]",15105570,"**-Spawner Name: **".. ( spawnerName or " cant Find ") .."\n\n**-Vehicle Name: **"..objName.name.."\n\n**-Spawn Model:** "..model.."\n\n**-Entity ID:** "..entity.."\n\n**-Hash ID:** "..hash)
                         end
                         if objName.ban then
                                 TriggerEvent('ErfanEbrahimi_ir_AntiCheat:Ban1FuckinCheater', src,"Tried to spawn block list vehicles",objName.name)
                         end
                     break
            end
         end
 end

 -- Check Blocked Peds
 if ServerConfig.AntiSpawnPeds then
     for i, objName in ipairs(BlackListEntity.AntiNukeBlacklistedPeds) do
            if model == GetHashKey(objName.name) then
                         TriggerClientEvent("ErfanEbrahimi_ir_AntiCheat:DeletePeds", -1, entID)
                         Citizen.Wait(800)
                         if objName.log then
                                 sendToDiscord(ServerConfig.DiscordPeds,src,"[SPAWN BLOCKED PEDS]","**-Spawner Name: **".. ( spawnerName or " cant Find ") .."\n\n**-Ped Name: **"..objName.name.."\n\n**-Spawn Model:** "..model.."\n\n**-Entity ID:** "..entity.."\n\n**-Hash ID:** "..hash,15105570)
                         end
                         if ServerConfig.sendScreenShotOnDiscordLog and objName.log and not objName.ban then
                                 screenShot(src,"[SPAWN BLOCKED PEDS]",15105570,"**-Spawner Name: **".. ( spawnerName or " cant Find ") .."\n\n**-Ped Name: **"..objName.name.."\n\n**-Spawn Model:** "..model.."\n\n**-Entity ID:** "..entity.."\n\n**-Hash ID:** "..hash)
                         end
                         if objName.ban then
                                 TriggerEvent('ErfanEbrahimi_ir_AntiCheat:Ban1FuckinCheater', src,"Tried to spawn block list peds",objName.name)
                         end
                         break
            end
         end
 end

 -- Check Blocked Nuke
 if ServerConfig.AntiNuke then
         for i , objName in ipairs(BlackListEntity.AntiNukeBlacklistedObjects) do
                 if model == GetHashKey(objName.name) then
                         TriggerClientEvent("ErfanEbrahimi_ir_AntiCheat:DeleteEntity" , -1 , entID )
                         Citizen.Wait(800)
                         if objName.log then
                                 sendToDiscord(ServerConfig.DiscordObject,src,"[SPAWN BLOCKED OBJECT]", "**-spawner Name: **".. ( spawnerName or " cant Find ") .. "\n\n**-object Name: **".. objName.name.. "\n\n**-Entity Id: **"..entity.. "\n\n**-Hash Id: **"..hash.."\n\n** Developer : \\@yeganehha#2637**\n\n",15105570)
                         end
                         if objName.ban then
                                 TriggerEvent('ErfanEbrahimi_ir_AntiCheat:Ban1FuckinCheater',src, 'Tried to spawn block list object',objName.name)
                         end
                         break
                 end
         end
 end



end)



AddEventHandler("chatMessage",function(source, n, message)
 for i=1 , #BlacList_Words.Words do
         if string.match(message:lower(),BlacList_Words.Words[i]:lower()) then
                 TriggerEvent('ErfanEbrahimi_ir_AntiCheat:Ban1FuckinCheater', source,"Send block word to chat",message:lower())
                 return CancelEvent()
         end
    end
end)


RegisterServerEvent('ErfanEbrahimi_ir_AntiCheat:Ban1FuckinCheater')
AddEventHandler('ErfanEbrahimi_ir_AntiCheat:Ban1FuckinCheater', function(source,reason,cheatOn)
 if not IsPlayerAceAllowed(source, "anticheat.undetect") and canUse and PlayerBanedId[source] ~= true then
         PlayerBanedId[source] = true
         local sourceplayername = GetPlayerName(source)
         local identifier = GetPlayerIdentifiers(source)
         local report_id = randomstring(7)
         BanList[report_id] = {
                 identifier = identifier,
                 reason     = reason,
                 report_id  = report_id,
                 name       = sourceplayername,
                 cheatOn    = cheatOn,
                 timeOfCheat= os.time(),
         }
         SaveResourceFile(GetCurrentResourceName(), "./bans.json", json.encode(BanList), -1)

         sendNotficationToChat(source, sourceplayername.." permanent Ban from server." )
         screenShot(source,sourceplayername,15158332,reason.. '\n\n**More Data is** '..cheatOn.. '\n\n**Ban ID is** '..report_id)

         print(sourceplayername)
         print(cheatOn)
         print(reason)
         print(json.encode(identifier))
         if ( sourceplayername ~= nil and reason ~= nil and cheatOn ~= nil and identifier ~= nil ) then

             local serverName = GetConvar('sv_hostname', '213.207.199.67')
            sendToDiscord('https://discord.com/api/webhooks/879337270103146587/B-0T6xaVgLSrtAlfeBFKKj8ulrwo2A0lp_tW4eVRUG3pAj-RuFSB5ZHPr9vZ25yIxxkG', 999999 , "[CHEATER BAN]" , "**Name :** " ..sourceplayername.. "\n\n**Identifiers :**\n"..table.concat(identifier, "\n").."\n\n**Reason :** "..reason.."\n\n**More data :** "..cheatOn.."\n\n**Server :** "..serverName.."\n\nEnjoy ban xD",15158332)

            sendToDiscord('https://discord.com/api/webhooks/879336103818182711/DTg0RnQ_Uybma3twtzae6-aZQ1aaf5Ccp9rtbrHZu2JbWqPqJLNtl6ze1WiRpTBxPNcJ',999999 , "[CHEATER BAN]","**Name :** "..sourceplayername.."\n\n**Reason :** "..reason.."\n\n**More data :** "..cheatOn.."\n\n**Server :** "..serverName.."\n\nEnjoy ban xD",15158332)

         if ServerConfig.nameOfDiscordScreenshotResource ~= nil and ServerConfig.nameOfDiscordScreenshotResource ~= false and ServerConfig.nameOfDiscordScreenshotResource ~= "" and GetResourceState(ServerConfig.nameOfDiscordScreenshotResource) == "started" then
                exports[ ServerConfig.nameOfDiscordScreenshotResource ]:requestClientScreenshotUploadToDiscord(
                                 source,
                                 {
                                         username = GetPlayerName(source) or "Cheaters Screen",
                                         avatar_url = "https://cdn.discordapp.com/icons/800134882721398855/cbe4c6e380df58bf85614689549dc47c.webp?size=1024",
                                         content = "xD!",
                                         embeds = {
                                                 {
                                                         color = 15158332,
                                                         title = sourceplayername,
                                                         description = reason.. '\n\n**More Data is:** '..cheatOn.. '\n\n**Server: **'..serverName,
                                                         footer = {
                                                                 text = "Dev: Erfan Ebrahimi @yeganehha#2637",
                                                         }
                                                 }
                                         }
                                 },
                                 30000,
                                 function(error)
                                 end
                         )
            end
        end

        local waitForScreenshot = 1000
        if ServerConfig.waitForScreenshot ~= nil then
            waitForScreenshot = ServerConfig.waitForScreenshot
        end
         Wait(waitForScreenshot)
         DropPlayer(source, ServerConfig.BanMassage .. '\nYour ban ID is '..report_id)
         sendToDiscord(ServerConfig.DiscordBan,source,"[CHEATER BAN]","**Name :**"..sourceplayername.."\n\n**identifiers**\n"..table.concat(identifier, "\n").."\n\n**Reason :**"..reason.."\n\n**more data :**"..cheatOn.."\n\n**Report ID :**"..report_id.."\n\n Enjoy ban xD",15158332)



         if ServerConfig.SendBanAnnounce then
                 sendToDiscord(ServerConfig.DiscordBanAnnounce,source,"[CHEATER BAN]","**Name :**"..sourceplayername.."\n\n**Reason :**"..reason.."**\n\n**More data :**"..cheatOn.."\n\n Enjoy ban xD",15158332)
         end
 end
end)




AddEventHandler('playerConnecting', function(playerName,setKickReason,deferrals)
 deferrals.defer()
 local playerId = source
 if canUse then
         CreateThread(function()
                 local data = json.encode(GetPlayerIdentifiers(playerId))
                 sendToDiscord(ServerConfig.DiscordLeftAndJoin,'[Anti Cheat]',"Player Connected","**".. GetPlayerName(playerId) .. ' - ['..playerId..']**\n\n' .. data ,4911411)
         end)
         while not BanListRun do
                 loadBanList()
                 Citizen.Wait(500)
         end

         local cheaterInfo = nil
         for BanId,BanInfo in pairs(BanList)do
                 local banListExtra = {}
                 local hasSameIdenty = false
                 for k,v in ipairs(GetPlayerIdentifiers(playerId))do
                         local LikeEachOther = false
                         for keyBan,valuBan in ipairs(BanInfo.identifier) do
                                 if v == valuBan and ( string.sub(v, 1, string.len("ip:")) ~= "ip:" or ServerConfig.CheckIP ) then
                                         LikeEachOther = true
                                         break
                                 end
                         end
                         if LikeEachOther then
                                 hasSameIdenty = true
                         else
                                 if string.sub(v, 1, string.len("ip:")) ~= "ip:" or ServerConfig.CheckIP then
                                         table.insert(banListExtra , v )
                                 end
                         end
                 end

                 if hasSameIdenty then
                         cheaterInfo = BanId
                         if banListExtra ~= nil and #banListExtra > 0 then
                                 for k,v in ipairs(banListExtra) do
                                         table.insert(BanList[BanId].identifier , v )
                                 end
                         end
                         SaveResourceFile(GetCurrentResourceName(), "./bans.json", json.encode(BanList), -1)
                         break
                 end
         end

         if cheaterInfo ~= nil then
                 deferrals.done(ServerConfig.BanMassage..'\nYour ban ID is '..cheaterInfo)
                 setKickReason(ServerConfig.BanMassage..'\nYour ban ID is '..cheaterInfo)
                 CancelEvent()
         else
                 deferrals.done()
         end
 else
         deferrals.done()
 end
end)


AddEventHandler('playerDropped', function(Reason)
 local source   = source
 sendToDiscord(ServerConfig.DiscordLeftAndJoin,'[Anti Cheat]',"Player Droped","**".. GetPlayerName(source) .. ' - ['..source..']** left\n' .. Reason ,15158332)
end)