-- modules/universal.lua
return {
    Name = "Universal",
    Load = function(Tab)
        local Players = game:GetService("Players")
        local RunService = game:GetService("RunService")
        local LocalPlayer = Players.LocalPlayer

        local flyEnabled = false
        local speedValue = 50

        Tab:CreateToggle("Fly (F)", false, function(state)
            flyEnabled = state
            if state then
                local bodyGyro = Instance.new("BodyGyro")
                local bodyVelocity = Instance.new("BodyVelocity")
                bodyGyro.P = 9000
                bodyGyro.maxTorque = Vector3.new(9000, 9000, 9000)
                bodyGyro.Parent = LocalPlayer.Character.HumanoidRootPart
                bodyVelocity.Velocity = Vector3.new(0, 0, 0)
                bodyVelocity.maxForce = Vector3.new(9000, 9000, 9000)
                bodyVelocity.Parent = LocalPlayer.Character.HumanoidRootPart

                spawn(function()
                    while flyEnabled and LocalPlayer.Character do
                        local cam = workspace.CurrentCamera
                        local move = Vector3.new()
                        if UserInputService:IsKeyDown(Enum.KeyCode.W) then move = move + cam.CFrame.LookVector end
                        if UserInputService:IsKeyDown(Enum.KeyCode.S) then move = move - cam.CFrame.LookVector end
                        if UserInputService:IsKeyDown(Enum.KeyCode.A) then move = move - cam.CFrame.RightVector end
                        if UserInputService:IsKeyDown(Enum.KeyCode.D) then move = move + cam.CFrame.RightVector end
                        bodyVelocity.Velocity = move * speedValue
                        bodyGyro.CFrame = cam.CFrame
                        task.wait()
                    end
                    bodyGyro:Destroy()
                    bodyVelocity:Destroy()
                end)
            end
        end)

        Tab:CreateToggle("Noclip", false, function(state)
            if state then
                RunService.Stepped:Connect(function()
                    if LocalPlayer.Character then
                        for _, part in pairs(LocalPlayer.Character:GetDescendants()) do
                            if part:IsA("BasePart") then
                                part.CanCollide = false
                            end
                        end
                    end
                end)
            end
        end)
    end
}
