--
--    (\ /)       ~ p4ncake [author]
--    ( . .)      ~ f3x-api [package]
--    c(")(")     ~ 0.01    [version]
--

-- @-->--- Declaring variables:
local Players = game:GetService("Players");
local RunService = game:GetService("RunService");

local LocalPlayer = Players["LocalPlayer"];

-- @-->--- Declaring functions:
local GetF3X = function()
	return
		LocalPlayer:FindFirstChild("Backpack") and
			LocalPlayer.Backpack:FindFirstChild("Building Tools")
		or
			LocalPlayer.Character and
			LocalPlayer.Character:FindFirstChild("Building Tools")
end

local GetServerEndPoint = function()
	local F3X = GetF3X()
	if
		F3X and
		F3X:IsA("Tool") and
		F3X:FindFirstChild("SyncAPI")
	then
		return F3X.SyncAPI.ServerEndpoint;
	end
end

-- @-->--- Declaring module:
local Module = {}; do
    Module.UserPlot = workspace:FindFirstChild("Private Building Areas") and
        workspace["Private Building Areas"]:FindFirstChild(
            ("%sBuildArea"):format(LocalPlayer.Name)
        )

    Module.RunMethod =
        function(Method: string, ...: any)
            local ServerEndpoint = GetServerEndPoint()
            if(ServerEndpoint) then
                return ServerEndpoint:InvokeServer(
                    Method,
                    ...
                )
            end

            return Module
        end
end

return(Module)
