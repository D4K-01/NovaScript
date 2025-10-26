-- core/ui.lua
local Library = {}

-- Créer le GUI
function Library:CreateWindow(title)
    local ScreenGui = Instance.new("ScreenGui")
    local Main = Instance.new("Frame")
    local Title = Instance.new("TextLabel")
    local Container = Instance.new("Frame")
    local UICorner = Instance.new("UICorner")
    local UIStroke = Instance.new("UIStroke")

    ScreenGui.Parent = game.CoreGui
    ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

    Main.Name = "Main"
    Main.Parent = ScreenGui
    Main.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    Main.BorderSizePixel = 0
    Main.Position = UDim2.new(0.3, 0, 0.2, 0)
    Main.Size = UDim2.new(0, 400, 0, 500)
    Main.Active = true
    Main.Draggable = true

    UICorner.CornerRadius = UDim.new(0, 12)
    UICorner.Parent = Main

    UIStroke.Parent = Main
    UIStroke.Color = Color3.fromRGB(100, 100, 255)
    UIStroke.Thickness = 2

    Title.Name = "Title"
    Title.Parent = Main
    Title.BackgroundTransparency = 1
    Title.Position = UDim2.new(0, 15, 0, 10)
    Title.Size = UDim2.new(1, -30, 0, 30)
    Title.Font = Enum.Font.GothamBold
    Title.Text = title
    Title.TextColor3 = Color3.fromRGB(255, 255, 255)
    Title.TextSize = 18
    Title.TextXAlignment = Enum.TextXAlignment.Left

    Container.Name = "Container"
    Container.Parent = Main
    Container.BackgroundTransparency = 1
    Container.Position = UDim2.new(0, 15, 0, 50)
    Container.Size = UDim2.new(1, -30, 1, -65)

    local Tabs = {}
    local TabCount = 0

    function Tabs:CreateTab(name)
        TabCount += 1
        local TabButton = Instance.new("TextButton")
        local TabFrame = Instance.new("ScrollingFrame")

        TabButton.Parent = Container
        TabButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
        TabButton.Position = UDim2.new(0, 0, 0, (TabCount-1)*40)
        TabButton.Size = UDim2.new(1, 0, 0, 35)
        TabButton.Font = Enum.Font.Gotham
        TabButton.Text = name
        TabButton.TextColor3 = Color3.fromRGB(200, 200, 200)
        TabButton.TextSize = 14

        TabFrame.Parent = Container
        TabFrame.BackgroundTransparency = 1
        TabFrame.Position = UDim2.new(0, 0, 0, 40)
        TabFrame.Size = UDim2.new(1, 0, 1, -40)
        TabFrame.ScrollBarThickness = 4
        TabFrame.Visible = (TabCount == 1)

        local Content = {}
        local Count = 0

        TabButton.MouseButton1Click:Connect(function()
            for _, v in pairs(Container:GetChildren()) do
                if v:IsA("ScrollingFrame") then v.Visible = false end
            end
            TabFrame.Visible = true
        end)

        function Content:CreateButton(text, callback)
            Count += 1
            local Button = Instance.new("TextButton")
            Button.Parent = TabFrame
            Button.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
            Button.Position = UDim2.new(0, 10, 0, (Count-1)*40 + 10)
            Button.Size = UDim2.new(1, -20, 0, 35)
            Button.Font = Enum.Font.Gotham
            Button.Text = text
            Button.TextColor3 = Color3.fromRGB(255, 255, 255)
            Button.TextSize = 14

            local Corner = Instance.new("UICorner")
            Corner.CornerRadius = UDim.new(0, 8)
            Corner.Parent = Button

            Button.MouseButton1Click:Connect(callback)
            return Button
        end

        function Content:CreateToggle(text, default, callback)
            Count += 1
            local Toggle = Instance.new("TextButton")
            local Indicator = Instance.new("Frame")
            local UICornerInd = Instance.new("UICorner")

            Toggle.Parent = TabFrame
            Toggle.BackgroundTransparency = 1
            Toggle.Position = UDim2.new(0, 10, 0, (Count-1)*40 + 10)
            Toggle.Size = UDim2.new(1, -20, 0, 35)
            Toggle.Font = Enum.Font.Gotham
            Toggle.Text = text
            Toggle.TextColor3 = Color3.fromRGB(255, 255, 255)
            Toggle.TextSize = 14
            Toggle.TextXAlignment = Enum.TextXAlignment.Left

            Indicator.Name = "Indicator"
            Indicator.Parent = Toggle
            Indicator.BackgroundColor3 = default and Color3.fromRGB(100, 255, 100) or Color3.fromRGB(70, 70, 70)
            Indicator.Position = UDim2.new(1, -45, 0.5, -10)
            Indicator.Size = UDim2.new(0, 40, 0, 20)

            UICornerInd.CornerRadius = UDim.new(0, 10)
            UICornerInd.Parent = Indicator

            local state = default
            Toggle.MouseButton1Click:Connect(function()
                state = not state
                Indicator.BackgroundColor3 = state and Color3.fromRGB(100, 255, 100) or Color3.fromRGB(70, 70, 70)
                callback(state)
            end)

            return {Toggle = Toggle, Set = function(val) state = val; Indicator.BackgroundColor3 = val and Color3.fromRGB(100, 255, 100) or Color3.fromRGB(70, 70, 70) end}
        end

        return Content
    end

    return Tabs
end

getgenv().UI = Library
