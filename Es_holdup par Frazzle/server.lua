local stores = {
	["paleto_twentyfourseven"] = {
		position = { ['x'] = 1730.35949707031, ['y'] = 6416.7001953125, ['z'] = 35.0372161865234 },
		reward = 5000,
		nameofstore = "Vingt-Quatre Sept. (La baie de Paleto)",
		lastrobbed = 0
	},
	["sandyshores_twentyfoursever"] = {
		position = { ['x'] = 1960.4197998047, ['y'] = 3742.9755859375, ['z'] = 32.343738555908 },
		reward = 5000,
		nameofstore = "Vingt-Quatre Sept. (Les rives de Sandy)",
		lastrobbed = 0
	},
	["bar_one"] = {
		position = { ['x'] = 1986.1240234375, ['y'] = 3053.8747558594, ['z'] = 47.215171813965 },
		reward = 5000,
		nameofstore = "Yellow Jack. (Les rives de Sandy)",
		lastrobbed = 0
	},
	["littleseoul_twentyfourseven"] = {
		position = { ['x'] = -709.17022705078, ['y'] = -904.21722412109, ['z'] = 19.215591430664 },
		reward = 5000,
		nameofstore = "Vingt-Quatre Sept. (Petite Seoul)",
		lastrobbed = 0
	}
}

local robbers = {}

function get3DDistance(x1, y1, z1, x2, y2, z2)
	return math.sqrt(math.pow(x1 - x2, 2) + math.pow(y1 - y2, 2) + math.pow(z1 - z2, 2))
end

RegisterServerEvent('es_holdup:toofar')
AddEventHandler('es_holdup:toofar', function(robb)
	if(robbers[source])then
		TriggerClientEvent('es_holdup:toofarlocal', source)
		robbers[source] = nil
		TriggerClientEvent('chatMessage', -1, 'INFO', {255, 0, 0}, "Le braquage a été annulé à: ^2" .. stores[robb].nameofstore)
	end
end)

RegisterServerEvent('es_holdup:rob')
AddEventHandler('es_holdup:rob', function(robb)
	if stores[robb] then
		local store = stores[robb]

		if (os.time() - store.lastrobbed) < 600 and store.lastrobbed ~= 0 then
			TriggerClientEvent('chatMessage', source, 'BRAQUAGE', {255, 0, 0}, "Ça a déjà été braqué récemment. Veuillez attendre: ^2" .. (1200 - (os.time() - store.lastrobbed)) .. "^0 seconds.")
			return
		end
		TriggerClientEvent('chatMessage', -1, 'INFO', {255, 0, 0}, "Braquage en cours à ^2" .. store.nameofstore)
		TriggerClientEvent('chatMessage', source, 'SYSTÈME', {255, 0, 0}, "Vous avez commencé un braquage à: ^2" .. store.nameofstore .. "^0, ne vous éloignez pas trop de cet endroit!")
		TriggerClientEvent('chatMessage', source, 'SYSTÈME', {255, 0, 0}, "L'alarme a été déclanchée!")
		TriggerClientEvent('chatMessage', source, 'SYSTÈME', {255, 0, 0}, "Tenez l'endroit pendant ^12 ^0minutes et l'argent est pour vous!")
		TriggerClientEvent('es_holdup:currentlyrobbing', source, robb)
		stores[robb].lastrobbed = os.time()
		robbers[source] = robb
		local savedSource = source
		SetTimeout(120000, function()
			if(robbers[savedSource])then
				TriggerClientEvent('es_holdup:robberycomplete', savedSource, job)
				TriggerEvent('es:getPlayerFromId', savedSource, function(target) 
					if(target)then
					--target:addDirty_Money(store.reward) 
					target:addMoney(store.reward)
					TriggerClientEvent('chatMessage', -1, 'INFO', {255, 0, 0}, "Braquage terminé à: ^2" .. store.nameofstore)
					end
				end)
			end
		end)		
	end
end)