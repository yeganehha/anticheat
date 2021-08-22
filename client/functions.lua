--[[
ESX       = nil
Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent("esx:getSharedObject",function(obj) ESX = obj end)
		Citizen.Wait(10)
	end
end)
]]

function isPelayerDead()
	--return ESX.GetPlayerData().IsDead 
	return false
end