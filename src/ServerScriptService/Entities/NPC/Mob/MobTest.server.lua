local Mob = require(script.Parent)

local start = os.clock()


---- make the mob
--local mob = Mob.new(Instance.new("Part"), 100)
--mob:bark()


--adjust the model size and put it into workspace
--mob.Size = Vector3.new(5,5,5)
--mob.Position = game.Workspace.SpawnLocation.Position
--mob.Parent = game.Workspace


--print(mob)
--while mob:isAlive() do
--	mob:damage(10)
--	print(-10)
--	wait(1)
--end
--print(mob:bark())


local stop = os.clock()

print(script.Name.." delta: "..stop-start)
