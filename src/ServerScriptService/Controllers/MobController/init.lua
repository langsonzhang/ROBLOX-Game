local MobManager = require(game.ServerScriptService.UseCases.MobManager)
local Mob = require(game.ServerScriptService.Entities.NPC.Mob)
local Item = require(game.ServerScriptService.Entities.Core.Item)


local MobController = {}

--------------------- Functions ---------------------------------------------

function MobController.updateMobs()
	MobManager.updateAll()
end

-- Spawns a mob
function MobController.spawnMob()
	local newMob = MobManager.spawnMob()
	newMob():PivotTo(game.Workspace.ItemSpawner.CFrame + Vector3.new(math.random(-50, 50), math.random(-50, 50), math.random(-50, 50)))
	newMob.Parent = game.Workspace
	return newMob
end

-- Drops some basic loot for <mob>
function MobController.dropLoot(mob: Mob)
	local loot = Item.new(game.ServerStorage.Items.Gold:Clone(), 100)
	loot():PivotTo(mob:getCFrame())
	loot.Parent = game.Workspace
end

-- Handler for when <mob> dies
function MobController.onMobDied(mob: Mob)
	MobController.dropLoot(mob)
	mob.Parent = nil
	mob():Destroy()
	MobManager.removeMob(mob.id)
end

--------------------- Events ------------------------------------------------

MobManager.MobDied:Connect(MobController.onMobDied)


return MobController
