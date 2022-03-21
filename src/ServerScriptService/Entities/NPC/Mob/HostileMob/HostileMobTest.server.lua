local super = require(script.Parent)

local start = os.clock()

local dist = game.Workspace.ItemSpawner.Position - game.Workspace.SpawnLocation.Position

local stop = os.clock()

print(script.Name.." delta: "..stop-start)