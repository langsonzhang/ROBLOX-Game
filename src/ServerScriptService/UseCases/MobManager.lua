local GoodSignal = require(game.ServerScriptService.Frameworks.GoodSignal)
local Mob = require(game.ServerScriptService.Entities.NPC.Mob)
local HostileMob = require(game.ServerScriptService.Entities.NPC.Mob.HostileMob)
local StatsProfile = require(game.ServerScriptService.Entities.Profiles.StatsProfile)

local MobManager = {
	MobDied = GoodSignal.new()
}

-- Dictionary of all mobs in the game 
-- (key, value) = (id: GUID, mob: Mob)
local MobList = {}

------------------------------------ Functions ---------------------------------------

function MobManager.spawnMob()
	local part = game.ReplicatedStorage.Mobs["Drooling Zombie"]:Clone()
	local mobStats = StatsProfile.new()
	local newMob = HostileMob.new(part, mobStats)
	MobList[newMob.id] = newMob
	return newMob
end

function MobManager.damageMob(mobId: string, damage: number)
	MobList[mobId]:damage(damage)
end

function MobManager.getMob(mobId: string): Mob
	return MobList[mobId]
end

function MobManager.removeMob(mobId: string): Mob
	local temp = MobManager.getMob(mobId)
	MobList[mobId] = nil
	temp.Parent = nil
	return temp
end

function MobManager.setClosestPlayer(mobId: string, player: Player)
	MobList[mobId]:setClosestPlayer(player)
end

function MobManager.updateAll()
	for i, v in pairs(MobList) do
		v:update()
	end
end

function MobManager.killAll()
	for i, v in pairs(MobList) do
		v:damage(1e10)
	end
end

------------------------------ Events ----------------------------------------------------

Mob.Died:Connect(function(mob: Mob)
	MobManager.MobDied:Fire(mob)
end)


return MobManager
