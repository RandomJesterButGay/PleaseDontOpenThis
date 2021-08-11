local BtnIcons = {
    "rbxassetid://3926305904", Vector2.new(964, 924), -- Local
    "rbxassetid://3926307971", Vector2.new(964, 4), -- Tools
    "rbxassetid://3926307971", Vector2.new(84, 44), -- Visual
    "rbxassetid://3926305904", Vector2.new(138, 4), -- Teleport
    "rbxassetid://3926305904", Vector2.new(644, 364), -- Misc
    "rbxassetid://3926307971", Vector2.new(324, 124), -- Settings
    "rbxassetid://3926305904", Vector2.new(564, 564), -- Credits
}

local TweenService = game:GetService("TweenService")
local UserInput = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local GetMouse = game.Players.LocalPlayer:GetMouse()

-- Toggle Button

local FirstTogglePos = UDim2.new(0, 0,0.027, 0)
local LastTogglePos = UDim2.new(0, 27,0.027, 0)

-- Slider Button

local FirstSliderPos = UDim2.new(0.035, 0,0.55, 0)
local LastSliderPos = UDim2.new(0.9, 0,0.55, 0)

-- Dropdown Button

local FirstDropdownRot = 90
local LastDropdownRot = 270

-- Button Color

local FirstButtonCol = Color3.fromRGB(25, 25, 25)
local LastButtonCol = Color3.fromRGB(208, 124, 27)

-- ToggleBtn_TransparentUI

local IsToggleTransparentUI = false

-- Slider

local SliderPos = UDim2.new(0.035, 0,0.63, 0)
local SliderSize = UDim2.new(0, 266, 0, 7)

local function TweenObj(obj, properties, duration)
    TweenService:Create(obj,TweenInfo.new(duration, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), properties):Play()
end

local function Ripple(obj)
    spawn(
        function()
            local Mouse = game.Players.LocalPlayer:GetMouse()
            local Circle = Instance.new("ImageLabel")
            Circle.Name = "Circle"
            Circle.Parent = obj
            Circle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Circle.BackgroundTransparency = 1.000
            Circle.ZIndex = 10
            Circle.Image = "rbxassetid://266543268"
            Circle.ImageColor3 = Color3.fromRGB(211, 211, 211)
            Circle.ImageTransparency = 0.6
            local NewX, NewY = Mouse.X - Circle.AbsolutePosition.X, Mouse.Y - Circle.AbsolutePosition.Y
            Circle.Position = UDim2.new(0, NewX, 0, NewY)
            local Size = 0
            if obj.AbsoluteSize.X > obj.AbsoluteSize.Y then
                Size = obj.AbsoluteSize.X * 1
            elseif obj.AbsoluteSize.X < obj.AbsoluteSize.Y then
                Size = obj.AbsoluteSize.Y * 1
            elseif obj.AbsoluteSize.X == obj.AbsoluteSize.Y then
                Size = obj.AbsoluteSize.X * 1
            end
            Circle:TweenSizeAndPosition(
                UDim2.new(0, Size, 0, Size),
                UDim2.new(0.5, -Size / 2, 0.5, -Size / 2),
                "Out",
                "Quad",
                0.2,
                false
            )
            for i = 1, 15 do
                Circle.ImageTransparency = Circle.ImageTransparency + 0.05
                wait()
            end
            Circle:Destroy()
        end
    )
end

local function DraggingEnabled(frame, parent)

    parent = parent or frame

    -- stolen from kavo loolololololololololol
    local dragging = false
    local dragInput, mousePos, framePos

    frame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            mousePos = input.Position
            framePos = parent.Position

            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)

    frame.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement then
            dragInput = input
        end
    end)

    UserInput.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            local delta = input.Position - mousePos
            parent.Position  = UDim2.new(framePos.X.Scale, framePos.X.Offset + delta.X, framePos.Y.Scale, framePos.Y.Offset + delta.Y)
        end
    end)
end

local function notify(name,text,length)
    for i,v in pairs(game.CoreGui:GetChildren()) do
        if v:IsA("ScreenGui") and v.Name == "NotificationGUI" then
            v:Destroy()
        end
    end 
    name = name or "Notification"
    text = text or "Hello!"
    length = length or 5

    local tweenservice = game:GetService("TweenService")

    local NotifyFirstPosition = UDim2.new(-0.3, 0,0.885, 0)
    local NotifyLastPosition = UDim2.new(0.008, 0,0.885, 0)

    local NotificationGUI = Instance.new("ScreenGui")
    local Background = Instance.new("Frame")
    local UIGradient = Instance.new("UIGradient")
    local Top = Instance.new("Frame")
    local UICorner = Instance.new("UICorner")
    local UICorner_2 = Instance.new("UICorner")
    local Title = Instance.new("TextLabel")
    local Text = Instance.new("TextLabel")
    local Button = Instance.new("TextButton")

    NotificationGUI.Name = "NotificationGUI"
    NotificationGUI.Parent = game:GetService("CoreGui")

    Background.Name = "Background"
    Background.Parent = NotificationGUI
    Background.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Background.Position = UDim2.new(-0.300000012, 0, 0.88499999, 0)
    Background.Size = UDim2.new(0, 315, 0, 57)
    Background.Visible = false
    Background.ZIndex = 0

    UIGradient.Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3.fromRGB(25, 25, 25)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(56, 56, 56))}
    UIGradient.Parent = Background

    Top.Name = "Top"
    Top.Parent = Background
    Top.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    Top.Size = UDim2.new(0, 315, 0, 21)

    UICorner.CornerRadius = UDim.new(0, 5)
    UICorner.Parent = Top

    UICorner_2.CornerRadius = UDim.new(0, 5)
    UICorner_2.Parent = Background

    Title.Name = "Title"
    Title.Parent = Background
    Title.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Title.BackgroundTransparency = 1.000
    Title.Size = UDim2.new(0, 315, 0, 21)
    Title.ZIndex = 2
    Title.Font = Enum.Font.SourceSansBold
    Title.Text = "Notify"
    Title.TextColor3 = Color3.fromRGB(208, 124, 27)
    Title.TextSize = 20.000

    Text.Name = "Text"
    Text.Parent = Background
    Text.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Text.BackgroundTransparency = 1.000
    Text.Position = UDim2.new(0, 0, 0.368421048, 0)
    Text.Size = UDim2.new(0, 315, 0, 36)
    Text.ZIndex = 2
    Text.Font = Enum.Font.SourceSansSemibold
    Text.Text = "Hi"
    Text.TextColor3 = Color3.fromRGB(208, 124, 27)
    Text.TextSize = 14.000
    Text.TextWrapped = true

    Button.Name = "Button"
    Button.Parent = Background
    Button.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Button.BackgroundTransparency = 1.000
    Button.Position = UDim2.new(0.933333337, 0, 0, 0)
    Button.Size = UDim2.new(0, 21, 0, 21)
    Button.ZIndex = 2
    Button.Font = Enum.Font.SourceSansBold
    Button.Text = "X"
    Button.TextColor3 = Color3.fromRGB(208, 124, 27)
    Button.TextSize = 20.000

    Button.MouseButton1Click:Connect(function()
        tweenservice:Create(Background,TweenInfo.new(0.4, Enum.EasingStyle.Sine, Enum.EasingDirection.Out),{Position = NotifyFirstPosition}):Play()
        wait(2)
        Background.Visible = false
    end)
    spawn(function()
        Title.Text = name
        Text.Text = text
        Background.Visible = true
        tweenservice:Create(Background,TweenInfo.new(0.4, Enum.EasingStyle.Sine, Enum.EasingDirection.Out),{Position = NotifyLastPosition}):Play()
        wait(length)
        tweenservice:Create(Background,TweenInfo.new(0.4, Enum.EasingStyle.Sine, Enum.EasingDirection.Out),{Position = NotifyFirstPosition}):Play()
        wait(2)
        Background.Visible = false
    end)
end

local HankLib = {}

function HankLib:Window(name, text)
    name = name or "Window"
    text = text or "HUB"
    local FirstTab = true
    local toggled = false
    local ClonedUI = name or "Window"
    for i,v in pairs(game.CoreGui:GetChildren()) do
        if v:IsA("ScreenGui") and v.Name == ClonedUI then
            v:Destroy()
        end
    end
    local Hub = Instance.new("ScreenGui")
    local MainBackground = Instance.new("Frame")
    local TopBar = Instance.new("Frame")
    local UICorner = Instance.new("UICorner")
    local TopTitle = Instance.new("TextLabel")
    local TopButton = Instance.new("TextButton")
    local HankButton = Instance.new("TextButton")
    local UICorner_2 = Instance.new("UICorner")
    local SideBar = Instance.new("Frame")
    local UICorner_3 = Instance.new("UICorner")
    local MainTitle = Instance.new("TextLabel")
    local UICorner_4 = Instance.new("UICorner")
    local Container = Instance.new("Folder")
    local UIListLayout = Instance.new("UIListLayout")
    
    Hub.Name = name
    Hub.Parent = game:GetService("CoreGui")
    Hub.ResetOnSpawn = false

    MainBackground.Name = "MainBackground"
    MainBackground.Parent = TopBar
    MainBackground.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    MainBackground.ClipsDescendants = true
    MainBackground.Size = UDim2.new(0, 480, 0, 300)
    MainBackground.ZIndex = 0
    
    DraggingEnabled(TopBar, TopBar)

    TopBar.Name = "TopBar"
    TopBar.Parent = Hub
    TopBar.BackgroundColor3 = Color3.fromRGB(208, 124, 27)
    TopBar.Position = UDim2.new(0.27956003, 0, 0.23456791, 0)
    TopBar.Size = UDim2.new(0, 480, 0, 35)

    UICorner.CornerRadius = UDim.new(0, 5)
    UICorner.Parent = TopBar

    TopTitle.Name = "TopTitle"
    TopTitle.Parent = TopBar
    TopTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    TopTitle.BackgroundTransparency = 1.000
    TopTitle.Position = UDim2.new(0.18, 0, 0, 0)
    TopTitle.Size = UDim2.new(0, 145, 0, 35)
    TopTitle.ZIndex = 2
    TopTitle.Font = Enum.Font.SourceSansBold
    TopTitle.Text = name
    TopTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
    TopTitle.TextSize = 20.000
    TopTitle.TextWrapped = true
    
    MainTitle.Name = "MainTitle"
    MainTitle.Parent = TopBar
    MainTitle.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    MainTitle.BackgroundTransparency = 1
    MainTitle.Position = UDim2.new(0.385, 0, 0, 0)
    MainTitle.Size = UDim2.new(0, 145, 0, 35)
    MainTitle.ZIndex = 2
    MainTitle.Font = Enum.Font.SourceSansBold
    MainTitle.TextWrapped = true
    MainTitle.Text = " - "..text
    MainTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
    MainTitle.TextSize = 20.000

    UICorner_4.CornerRadius = UDim.new(0, 5)
    UICorner_4.Parent = MainTitle

    TopButton.Name = "TopButton"
    TopButton.Parent = TopBar
    TopButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    TopButton.BackgroundTransparency = 1.000
    TopButton.Position = UDim2.new(0.922916651, 0, 0.0571428575, 0)
    TopButton.Rotation = 90.000
    TopButton.Size = UDim2.new(0, 30, 0, 30)
    TopButton.ZIndex = 2
    TopButton.Font = Enum.Font.SourceSansBold
    TopButton.Text = ">"
    TopButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    TopButton.TextSize = 20.000

    HankButton.Name = "HankButton"
    HankButton.Parent = TopBar
    HankButton.AutoButtonColor = false
    HankButton.BackgroundColor3 = Color3.fromRGB(208, 124, 27)
    HankButton.BorderSizePixel = 0
    HankButton.Position = UDim2.new(0.0145833334, 0, 0.0571428575, 0)
    HankButton.Size = UDim2.new(0, 30, 0, 30)
    HankButton.ZIndex = 2
    HankButton.Font = Enum.Font.SourceSansBold
    HankButton.Text = "H"
    HankButton.TextColor3 = Color3.fromRGB(25, 25, 25)
    HankButton.TextSize = 14.000

    UICorner_2.CornerRadius = UDim.new(0, 5)
    UICorner_2.Parent = MainBackground

    SideBar.Name = "SideBar"
    SideBar.Parent = MainBackground
    SideBar.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    SideBar.Position = UDim2.new(0, 0, 0.116666667, 0)
    SideBar.ClipsDescendants = true
    SideBar.Size = UDim2.new(0, 140, 0, 265)

    UICorner_3.CornerRadius = UDim.new(0, 5)
    UICorner_3.Parent = SideBar
    
    UIListLayout.Parent = SideBar
    UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
    UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
    UIListLayout.Padding = UDim.new(0, 5)

    Container.Name = "Container"
    Container.Parent = MainBackground
    
    TopButton.MouseButton1Click:Connect(function()
        if toggled == false then
            toggled = true
            print(name.." UI Closed")
            TweenObj(TopButton,{Rotation = 270},0.4)
            TweenObj(MainBackground,{Size = UDim2.new(0, 480,0, 1)},0.4)
        elseif toggled == true then
            toggled = false
            print(name.." UI Opened")
            TweenObj(TopButton,{Rotation = 90},0.4)
            TweenObj(MainBackground,{Size = UDim2.new(0, 480,0, 300)},0.4)
        end
    end)
    
    HankButton.MouseButton1Click:Connect(function()
        local clipBoard = setclipboard or toclipboard or set_clipboard or (Clipboard and Clipboard.set)
        
        notify("Hank HUB","Hank HUB invite link copied",5)
        
        clipBoard("https://discord.io/hankhub")
    end)
    
    local TabsLib = {}
    
    function TabsLib:Tab(text, icon, offset)
        text = text or "Tab"
        icon = icon or "rbxassetid://3926307971"
        offset = offset or Vector2.new(124, 204)
        local TabButton = Instance.new("TextButton")
        local UICorner_5 = Instance.new("UICorner")
        local ButtonIcon = Instance.new("ImageButton")
        local Tab = Instance.new("ScrollingFrame")
        local UIListLayout_2 = Instance.new("UIListLayout")
        
        TabButton.Name = text.." TabButton"
        TabButton.Parent = SideBar
        TabButton.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
        TabButton.Position = UDim2.new(0.0500000007, 0, 0.139622644, 0)
        TabButton.Size = UDim2.new(0, 125, 0, 25)
        TabButton.ZIndex = 2
        TabButton.Text = text
        TabButton.ClipsDescendants = true
        TabButton.Font = Enum.Font.SourceSansSemibold
        TabButton.TextColor3 = Color3.fromRGB(208, 124, 27)
        TabButton.TextSize = 14.000
        TabButton.TextWrapped = true

        UICorner_5.CornerRadius = UDim.new(0, 5)
        UICorner_5.Parent = TabButton

        ButtonIcon.Name = "ButtonIcon"
        ButtonIcon.Parent = TabButton
        ButtonIcon.BackgroundTransparency = 1.000
        ButtonIcon.Position = UDim2.new(0.0320000015, 0, 0.0799999982, 0)
        ButtonIcon.Size = UDim2.new(0, 20, 0, 20)
        ButtonIcon.ZIndex = 2
        ButtonIcon.Image = icon
        ButtonIcon.ImageColor3 = Color3.fromRGB(208, 124, 27)
        ButtonIcon.ImageRectOffset = offset
        ButtonIcon.ImageRectSize = Vector2.new(36, 36)

        Tab.Name = "Tab"
        Tab.Parent = Container
        Tab.Active = true
        Tab.Visible = false
        Tab.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        Tab.BackgroundTransparency = 1.000
        Tab.BorderSizePixel = 0
        Tab.Position = UDim2.new(0.291666657, 0, 0.116666667, 0)
        Tab.Size = UDim2.new(0, 340, 0, 265)
        Tab.CanvasSize = UDim2.new(0, 0, 50, 0)
        Tab.ScrollBarThickness = 8
        Tab.VerticalScrollBarInset = Enum.ScrollBarInset.Always

        UIListLayout_2.Parent = Tab
        UIListLayout_2.HorizontalAlignment = Enum.HorizontalAlignment.Center
        UIListLayout_2.SortOrder = Enum.SortOrder.LayoutOrder
        UIListLayout_2.Padding = UDim.new(0, 8)
        
        if FirstTab == true then
            FirstTab = false
            Tab.Visible = false
        end
        
        TabButton.MouseButton1Click:Connect(function()
            TweenObj(TabButton,{BackgroundColor3 = Color3.fromRGB(35, 35, 35)},0.4)
            Ripple(TabButton)
            for i,v in next, Container:GetChildren() do
                v.Visible = false
            end
            Tab.Visible = true
            wait(0.5)
            TweenObj(TabButton,{BackgroundColor3 = Color3.fromRGB(0,0,0)},0.4)
        end)
        
        TabButton.MouseEnter:Connect(function()
            TweenObj(TabButton,{BackgroundColor3 = Color3.fromRGB(25, 25, 25)},0.4)
        end)

        TabButton.MouseLeave:Connect(function()
            TweenObj(TabButton,{BackgroundColor3 = Color3.fromRGB(0,0,0)},0.4)
        end)
        
        local SectionLib = {}
        
        function SectionLib:Section(text)
            text = text or "Section"
            local Section = Instance.new("TextLabel")
            local UICorner_6 = Instance.new("UICorner")
            
            Section.Name = text.." Section"
            Section.Parent = Tab
            Section.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
            Section.Position = UDim2.new(0.0294117648, 0, 0, 0)
            Section.Size = UDim2.new(0, 320, 0, 35)
            Section.ZIndex = 2
            Section.Font = Enum.Font.SourceSansBold
            Section.Text = text
            Section.TextColor3 = Color3.fromRGB(208, 124, 27)
            Section.TextSize = 20.000
            Section.TextWrapped = true

            UICorner_6.CornerRadius = UDim.new(0, 5)
            UICorner_6.Parent = Section
            
            function SectionLib:Label(text)
                text = text or "Label"
                local Label = Instance.new("TextLabel")
                local UICorner_17 = Instance.new("UICorner")
                
                Label.Name = text.." Label"
                Label.Parent = Tab
                Label.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
                Label.Size = UDim2.new(0, 300, 0, 30)
                Label.ZIndex = 2
                Label.Font = Enum.Font.SourceSansSemibold
                Label.Text = text
                Label.TextColor3 = Color3.fromRGB(208, 124, 27)
                Label.TextSize = 14.000
                Label.TextWrapped = true

                UICorner_17.CornerRadius = UDim.new(0, 5)
                UICorner_17.Parent = Label
            end
            
            function SectionLib:Button(text, callback)
                text = text or "Button"
                callback = callback or function() end
                local Button = Instance.new("TextButton")
                local UICorner_7 = Instance.new("UICorner")
                
                Button.Name = text.." Button"
                Button.Parent = Tab
                Button.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
                Button.Size = UDim2.new(0, 300, 0, 30)
                Button.Font = Enum.Font.SourceSansSemibold
                Button.ClipsDescendants = true
                Button.Text = text
                Button.TextColor3 = Color3.fromRGB(255, 255, 255)
                Button.TextSize = 14.000
                Button.TextWrapped = true

                UICorner_7.CornerRadius = UDim.new(0, 5)
                UICorner_7.Parent = Button
                
                Button.MouseButton1Click:Connect(function()
                    callback()
                    Ripple(Button)
                    TweenObj(Button,{BackgroundColor3 = Color3.fromRGB(208, 124, 27)},0.4)
                    wait(0.5)
                    TweenObj(Button,{BackgroundColor3 = Color3.fromRGB(0,0,0)},0.4)
                end)
                
                Button.MouseEnter:Connect(function()
                    TweenObj(Button,{BackgroundColor3 = Color3.fromRGB(25,25,25)},0.4)
                end)

                Button.MouseLeave:Connect(function()
                    TweenObj(Button,{BackgroundColor3 = Color3.fromRGB(0,0,0)},0.4)
                end)
            end
            
            function SectionLib:Toggle(text, callback)
                text = text or "Toggle"
                callback = callback or function() end
                local IsToggled = false
                local Toggle_Back = Instance.new("Frame")
                local UICorner_8 = Instance.new("UICorner")
                local Toggle_Text = Instance.new("TextLabel")
                local Toggle_Button = Instance.new("TextButton")
                local UICorner_9 = Instance.new("UICorner")
                
                Toggle_Back.Name = text.." Toggle_Back"
                Toggle_Back.Parent = Tab
                Toggle_Back.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
                Toggle_Back.Size = UDim2.new(0, 300, 0, 30)

                UICorner_8.CornerRadius = UDim.new(0, 5)
                UICorner_8.Parent = Toggle_Back

                Toggle_Text.Name = "Toggle_Text"
                Toggle_Text.Parent = Toggle_Back
                Toggle_Text.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                Toggle_Text.BackgroundTransparency = 1.000
                Toggle_Text.Position = UDim2.new(0.0333333351, 0, 0, 0)
                Toggle_Text.Size = UDim2.new(0, 140, 0, 30)
                Toggle_Text.Font = Enum.Font.SourceSansSemibold
                Toggle_Text.Text = text
                Toggle_Text.TextColor3 = Color3.fromRGB(255, 255, 255)
                Toggle_Text.TextSize = 14.000
                Toggle_Text.TextWrapped = true
                Toggle_Text.TextXAlignment = Enum.TextXAlignment.Left

                Toggle_Button.Name = "Toggle_Button"
                Toggle_Button.Parent = Toggle_Back
                Toggle_Button.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
                Toggle_Button.Position = UDim2.new(0.899999976, 0, 0.13333334, 0)
                Toggle_Button.Size = UDim2.new(0, 20, 0, 20)
                Toggle_Button.Font = Enum.Font.SourceSansSemibold
                Toggle_Button.Text = ""
                Toggle_Button.TextColor3 = Color3.fromRGB(25, 25, 25)
                Toggle_Button.TextSize = 14.000
                Toggle_Button.TextWrapped = true

                UICorner_9.CornerRadius = UDim.new(0, 5)
                UICorner_9.Parent = Toggle_Button
                
                Toggle_Button.MouseButton1Click:Connect(function()
                    if IsToggled == false then
                        TweenObj(Toggle_Button,{BackgroundColor3 = Color3.fromRGB(208, 124, 27)},0.4)
                    else
                        TweenObj(Toggle_Button,{BackgroundColor3 = Color3.fromRGB(25, 25, 25)},0.4)
                    end
                    IsToggled = not IsToggled
                    pcall(callback, IsToggled)
                end)
            end
            
            function SectionLib:Dropdown(text, list, callback)
                text = text or "Dropdown"
                local callback = callback or function() end
                local IsDrop = false
                local BodySize = 0
                local DropYSize = 0
                list = list or {}
                
                local Dropdown_Back = Instance.new("Frame")
                local UICorner_10 = Instance.new("UICorner")
                local Dropdown_Text = Instance.new("TextLabel")
                local Dropdown_Button = Instance.new("TextButton")
                local UICorner_11 = Instance.new("UICorner")
                local Dropdown_List = Instance.new("Frame")
                local UICorner_12 = Instance.new("UICorner")
                local UIListLayout_3 = Instance.new("UIListLayout")
                
                local function Resize(value)
                    BodySize = BodySize + value
                    Dropdown_List.Size = UDim2.new(0, 300, 0, BodySize)
                end
                
                Dropdown_Back.Name = text.." Dropdown_Back"
                Dropdown_Back.Parent = Tab
                Dropdown_Back.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
                Dropdown_Back.Size = UDim2.new(0, 300, 0, 30)
 
                UICorner_10.CornerRadius = UDim.new(0, 5)
                UICorner_10.Parent = Dropdown_Back
 
                Dropdown_Text.Name = "Dropdown_Text"
                Dropdown_Text.Parent = Dropdown_Back
                Dropdown_Text.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                Dropdown_Text.BackgroundTransparency = 1.000
                Dropdown_Text.Size = UDim2.new(0, 140, 0, 30)
                Dropdown_Text.Position = UDim2.new(0.033, 0,0, 0)
                Dropdown_Text.Font = Enum.Font.SourceSansSemibold
                Dropdown_Text.TextXAlignment = Enum.TextXAlignment.Left
                Dropdown_Text.Text = text
                Dropdown_Text.TextColor3 = Color3.fromRGB(255, 255, 255)
                Dropdown_Text.TextSize = 14.000
                Dropdown_Text.TextWrapped = true
 
                Dropdown_Button.Name = "Dropdown_Button"
                Dropdown_Button.Parent = Dropdown_Back
                Dropdown_Button.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
                Dropdown_Button.BackgroundTransparency = 1.000
                Dropdown_Button.Position = UDim2.new(0.899999976, 0, 0.13333334, 0)
                Dropdown_Button.Rotation = 90.000
                Dropdown_Button.Size = UDim2.new(0, 20, 0, 20)
                Dropdown_Button.Font = Enum.Font.SourceSansSemibold
                Dropdown_Button.Rotation = 270
                Dropdown_Button.Text = ">"
                Dropdown_Button.TextColor3 = Color3.fromRGB(208, 124, 27)
                Dropdown_Button.TextSize = 14.000
                Dropdown_Button.TextWrapped = true
 
                UICorner_11.CornerRadius = UDim.new(0, 5)
                UICorner_11.Parent = Dropdown_Button
 
                Dropdown_List.Name = text.." Dropdown_List"
                Dropdown_List.Parent = Tab
                Dropdown_List.ClipsDescendants = true
                Dropdown_List.ZIndex = 3
                Dropdown_List.Visible = false
                Dropdown_List.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
                Dropdown_List.Position = UDim2.new(0, 0, 1.16666663, 0)
                Dropdown_List.Size = UDim2.new(0, 300, 0, 120)
 
                UICorner_12.CornerRadius = UDim.new(0, 5)
                UICorner_12.Parent = Dropdown_List
 
                UIListLayout_3.Parent = Dropdown_List
                UIListLayout_3.HorizontalAlignment = Enum.HorizontalAlignment.Center
                UIListLayout_3.SortOrder = Enum.SortOrder.LayoutOrder
                UIListLayout_3.VerticalAlignment = Enum.VerticalAlignment.Center
                UIListLayout_3.Padding = UDim.new(0, 5)
                
                Dropdown_Button.MouseButton1Down:Connect(function()
                    if IsDrop == true then
                        TweenObj(Dropdown_Button,{Rotation = 90},0.4)
                        TweenObj(Dropdown_List,{Size = UDim2.new(0, 300,0, 0)},0.4)
                        wait(0.5)
                        Dropdown_List.Visible = false
                    else
                        TweenObj(Dropdown_Button,{Rotation = 270},0.4)
                        TweenObj(Dropdown_List,{Size = UDim2.new(0, 300,0, DropYSize)},0.4)
                        wait(0.5)
                        Dropdown_List.Visible = true
                    end
                    IsDrop = not IsDrop
                end)
                
                for i,v in next, list do
                    local Button_Option = Instance.new("TextButton")
                    local UICorner_13 = Instance.new("UICorner")
                    
                    Button_Option.Name = v.."Button"
                    Button_Option.Parent = Dropdown_List
                    Button_Option.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
                    Button_Option.Position = UDim2.new(0, 0, 0.375, 0)
                    Button_Option.Size = UDim2.new(0, 280, 0, 30)
                    Button_Option.Text = " "..v
                    Button_Option.ZIndex = 4
                    Button_Option.Font = Enum.Font.SourceSansSemibold
                    Button_Option.ClipsDescendants = true
                    Button_Option.TextColor3 = Color3.fromRGB(255, 255, 255)
                    Button_Option.TextSize = 14.000
                    Button_Option.TextWrapped = true
                    DropYSize = DropYSize + 45
 
                    UICorner_13.CornerRadius = UDim.new(0, 5)
                    UICorner_13.Parent = Button_Option
                    
                    Button_Option.MouseButton1Click:Connect(function()
                        callback(v)
                        Ripple(Button_Option)
                        TweenObj(Button_Option,{BackgroundColor3 = Color3.fromRGB(208, 124, 27)},0.4)
                        wait(0.5)
                        TweenObj(Button_Option,{BackgroundColor3 = Color3.fromRGB(0, 0, 0)},0.4)
                    end)
                    
                    Button_Option.MouseEnter:Connect(function()
                        TweenObj(Button_Option,{BackgroundColor3 = Color3.fromRGB(25, 25, 25)},0.4)
                    end)
                    
                    Button_Option.MouseLeave:Connect(function()
                        TweenObj(Button_Option,{BackgroundColor3 = Color3.fromRGB(0, 0, 0)},0.4)
                    end)
                end
            end
            
            function SectionLib:TextBox(text, callback)
                callback = callback or function() end
                local TextBox_Back = Instance.new("Frame")
                local UICorner_15 = Instance.new("UICorner")
                local TextBox_Text = Instance.new("TextLabel")
                local TextBox = Instance.new("TextBox")
                local UICorner_16 = Instance.new("UICorner")
                
                TextBox_Back.Name = text.." TextBox_Back"
                TextBox_Back.Parent = Tab
                TextBox_Back.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
                TextBox_Back.Size = UDim2.new(0, 300, 0, 30)

                UICorner_15.CornerRadius = UDim.new(0, 5)
                UICorner_15.Parent = TextBox_Back

                TextBox_Text.Name = "TextBox_Text"
                TextBox_Text.Parent = TextBox_Back
                TextBox_Text.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                TextBox_Text.BackgroundTransparency = 1.000
                TextBox_Text.Position = UDim2.new(0.0333333351, 0, 0, 0)
                TextBox_Text.Size = UDim2.new(0, 140, 0, 30)
                TextBox_Text.Font = Enum.Font.SourceSansSemibold
                TextBox_Text.Text = text
                TextBox_Text.TextColor3 = Color3.fromRGB(255, 255, 255)
                TextBox_Text.TextSize = 14.000
                TextBox_Text.TextWrapped = true
                TextBox_Text.TextXAlignment = Enum.TextXAlignment.Left

                TextBox.Parent = TextBox_Back
                TextBox.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
                TextBox.Position = UDim2.new(0.629999995, 0, 0.166666672, 0)
                TextBox.Size = UDim2.new(0, 100, 0, 20)
                TextBox.Font = Enum.Font.SourceSans
                TextBox.PlaceholderColor3 = Color3.fromRGB(255, 255, 255)
                TextBox.PlaceholderText = "Insert"
                TextBox.Text = ""
                TextBox.TextColor3 = Color3.fromRGB(208, 124, 27)
                TextBox.TextSize = 14.000
                TextBox.TextWrapped = true

                UICorner_16.CornerRadius = UDim.new(0, 5)
                UICorner_16.Parent = TextBox
                
                TextBox.FocusLost:Connect(function()
                    callback(TextBox.Text)
                end)
            end

            function SectionLib:Slider(text, minvalue, maxvalue, callback)
                text = text or "Slider"
                minvalue = minvalue or 0
                maxvalue = maxvalue or 500
                callback = callback or function() end
                local Value;
                
                local Slider_Back = Instance.new("Frame")
                local UICorner = Instance.new("UICorner")
                local Slider_Text = Instance.new("TextLabel")
                local Slider_Button = Instance.new("TextButton")
                local UICorner_2 = Instance.new("UICorner")
                local Slider_Bar = Instance.new("Frame")
                local UICorner_3 = Instance.new("UICorner")
                local Slider_Value = Instance.new("TextLabel")
 
                Slider_Back.Name = text.." Slider_Back"
                Slider_Back.Parent = Tab
                Slider_Back.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
                Slider_Back.Size = UDim2.new(0, 300, 0, 30)
 
                UICorner.CornerRadius = UDim.new(0, 5)
                UICorner.Parent = Slider_Back
 
                Slider_Text.Name = "Slider_Text"
                Slider_Text.Parent = Slider_Back
                Slider_Text.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                Slider_Text.BackgroundTransparency = 1.000
                Slider_Text.Size = UDim2.new(0, 140, 0, 30)
                Slider_Text.Position = UDim2.new(0.033, 0,0, 0)
                Slider_Text.Font = Enum.Font.SourceSansSemibold
                Slider_Text.TextXAlignment = Enum.TextXAlignment.Left
                Slider_Text.Text = text
                Slider_Text.TextColor3 = Color3.fromRGB(255, 255, 255)
                Slider_Text.TextSize = 14.000
                Slider_Text.TextWrapped = true
 
                Slider_Button.Name = "Slider_Button"
                Slider_Button.Parent = Slider_Back
                Slider_Button.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
                Slider_Button.Position = UDim2.new(0.502850533, 0, 0.333333343, 0)
                Slider_Button.Size = UDim2.new(0, 147, 0, 10)
                Slider_Button.ZIndex = 2
                Slider_Button.Font = Enum.Font.SourceSans
                Slider_Button.Text = ""
                Slider_Button.TextColor3 = Color3.fromRGB(0, 0, 0)
                Slider_Button.TextSize = 14.000
                Slider_Button.TextWrapped = true
 
                UICorner_2.CornerRadius = UDim.new(0, 5)
                UICorner_2.Parent = Slider_Button
 
                Slider_Bar.Name = "Slider_Bar"
                Slider_Bar.Parent = Slider_Button
                Slider_Bar.BackgroundColor3 = Color3.fromRGB(208, 124, 27)
                Slider_Bar.Size = UDim2.new(0, 0, 0, 10)
                Slider_Bar.ZIndex = 3
 
                UICorner_3.CornerRadius = UDim.new(0, 5)
                UICorner_3.Parent = Slider_Bar
 
                Slider_Value.Name = "Slider_Value"
                Slider_Value.Parent = Slider_Bar
                Slider_Value.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                Slider_Value.BackgroundTransparency = 1.000
                Slider_Value.Size = UDim2.new(0, 147, 0, 10)
                Slider_Value.ZIndex = 4
                Slider_Value.Font = Enum.Font.SourceSansSemibold
                Slider_Value.Text = ""
                Slider_Value.TextColor3 = Color3.fromRGB(255, 255, 255)
                Slider_Value.TextSize = 14.000
                Slider_Value.TextWrapped = true
                
                Slider_Button.MouseButton1Down:Connect(function()
                    Value = math.floor((((tonumber(maxvalue) - tonumber(minvalue)) / 147) * Slider_Bar.AbsoluteSize.X) + tonumber(minvalue)) or 0
                    pcall(function()
                        callback(Value)
                    end)
                    Slider_Bar.Size = UDim2.new(0, math.clamp(GetMouse.X - Slider_Bar.AbsolutePosition.X, 0, 147), 0, 10)
                    moveconnection = GetMouse.Move:Connect(function()
                        Slider_Value.Text = Value
                        Value = math.floor((((tonumber(maxvalue) - tonumber(minvalue)) / 147) * Slider_Bar.AbsoluteSize.X) + tonumber(minvalue))
                        pcall(function()
                            callback(Value)
                        end)
                            Slider_Bar.Size = UDim2.new(0, math.clamp(GetMouse.X - Slider_Bar.AbsolutePosition.X, 0, 147), 0, 10)
                    end)
                    releaseconnection = UserInput.InputEnded:Connect(function(Mouse)
                        if Mouse.UserInputType == Enum.UserInputType.MouseButton1 then
                            Value = math.floor((((tonumber(maxvalue) - tonumber(minvalue)) / 147) * Slider_Bar.AbsoluteSize.X) + tonumber(minvalue))
                            pcall(function()
                                callback(Value)
                            end)
                            Slider_Bar.Size = UDim2.new(0, math.clamp(GetMouse.X - Slider_Bar.AbsolutePosition.X, 0, 147), 0, 10)
                            moveconnection:Disconnect()
                            releaseconnection:Disconnect()
                        end
                    end)
                end)
            end
            
            function SectionLib:ColorPicker(text, default, callback)
                text = text or "ColorPicker"
                default = default or Color3.fromRGB(1,1,1)
                callback = callback or function() end
                local ColorShow = false
                local Color;
                
                local ColorPicker_Back = Instance.new("Frame")
                local UICorner_20 = Instance.new("UICorner")
                local ColorPicker_Text = Instance.new("TextLabel")
                local Preview = Instance.new("TextButton")
                local UICorner_21 = Instance.new("UICorner")
                local ColorPicker_Back_2 = Instance.new("Frame")
                local UICorner_22 = Instance.new("UICorner")
                local RGB = Instance.new("ImageButton")
                local Marker = Instance.new("Frame")
                local UICorner_23 = Instance.new("UICorner")
                local Value = Instance.new("ImageButton")
                local Marker_2 = Instance.new("Frame")
                local UICorner_24 = Instance.new("UICorner")
                
                ColorPicker_Back.Name = text.." ColorPicker_Back"
                ColorPicker_Back.Parent = Tab
                ColorPicker_Back.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
                ColorPicker_Back.Size = UDim2.new(0, 300, 0, 30)

                UICorner_20.CornerRadius = UDim.new(0, 5)
                UICorner_20.Parent = ColorPicker_Back

                ColorPicker_Text.Name = "ColorPicker_Text"
                ColorPicker_Text.Parent = ColorPicker_Back
                ColorPicker_Text.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                ColorPicker_Text.BackgroundTransparency = 1.000
                ColorPicker_Text.Position = UDim2.new(0.0333333351, 0, 0, 0)
                ColorPicker_Text.Size = UDim2.new(0, 140, 0, 30)
                ColorPicker_Text.Font = Enum.Font.SourceSansSemibold
                ColorPicker_Text.Text = text
                ColorPicker_Text.TextColor3 = Color3.fromRGB(255, 255, 255)
                ColorPicker_Text.TextSize = 14.000
                ColorPicker_Text.TextWrapped = true
                ColorPicker_Text.TextXAlignment = Enum.TextXAlignment.Left

                Preview.Name = "Preview"
                Preview.Parent = ColorPicker_Back
                Preview.BackgroundColor3 = default
                Preview.Position = UDim2.new(0.629999995, 0, 0.166999996, 0)
                Preview.Size = UDim2.new(0, 100, 0, 20)
                Preview.ZIndex = 3
                Preview.Font = Enum.Font.SourceSansBold
                Preview.Text = ""
                Preview.TextColor3 = Color3.fromRGB(0, 0, 0)
                Preview.TextSize = 14.000
                Preview.TextWrapped = true

                UICorner_21.CornerRadius = UDim.new(0, 5)
                UICorner_21.Parent = Preview

                ColorPicker_Back_2.Name = text.." ColorPicker_Back"
                ColorPicker_Back_2.Parent = Tab
                ColorPicker_Back_2.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
                ColorPicker_Back_2.ClipsDescendants = true
                ColorPicker_Back_2.Position = UDim2.new(0, 0, 1.16666663, 0)
                ColorPicker_Back_2.Size = UDim2.new(0, 300, 0, 0)
                ColorPicker_Back_2.Visible = false

                UICorner_22.CornerRadius = UDim.new(0, 5)
                UICorner_22.Parent = ColorPicker_Back_2

                RGB.Name = "RGB"
                RGB.Parent = ColorPicker_Back_2
                RGB.AutoButtonColor = false
                RGB.AnchorPoint = Vector2.new(0.5, 0)
                RGB.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                RGB.BorderColor3 = Color3.fromRGB(40, 40, 40)
                RGB.BorderSizePixel = 2
                RGB.Position = UDim2.new(0.400000006, 0, 0.100000001, 0)
                RGB.Size = UDim2.new(0.600000024, 0, 0.791666687, 0)
                RGB.ZIndex = 4
                RGB.Image = "rbxassetid://1433361550"
                RGB.SliceCenter = Rect.new(10, 10, 90, 90)

                Marker.Name = "Marker"
                Marker.Parent = RGB
                Marker.AnchorPoint = Vector2.new(0.5, 0.5)
                Marker.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                Marker.BorderColor3 = Color3.fromRGB(0, 0, 0)
                Marker.BorderSizePixel = 2
                Marker.Position = UDim2.new(0.5, 0, 1, 0)
                Marker.Size = UDim2.new(0, 10, 0, 10)
                Marker.ZIndex = 5

                UICorner_23.CornerRadius = UDim.new(0, 5)
                UICorner_23.Parent = Marker

                Value.Name = "Value"
                Value.Parent = ColorPicker_Back_2
                Value.AutoButtonColor = false
                Value.AnchorPoint = Vector2.new(0.5, 0)
                Value.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
                Value.BorderColor3 = Color3.fromRGB(40, 40, 40)
                Value.BorderSizePixel = 2
                Value.Position = UDim2.new(0.850000024, 0, 0.100000001, 0)
                Value.Size = UDim2.new(0.100000001, 0, 0.791666687, 0)
                Value.ZIndex = 4
                Value.Image = "rbxassetid://359311684"
                Value.SliceCenter = Rect.new(10, 10, 90, 90)

                Marker_2.Name = "Marker"
                Marker_2.Parent = Value
                Marker_2.AnchorPoint = Vector2.new(0.5, 0.5)
                Marker_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                Marker_2.BorderColor3 = Color3.fromRGB(0, 0, 0)
                Marker_2.BorderSizePixel = 2
                Marker_2.Position = UDim2.new(0.5, 0, 0, 0)
                Marker_2.Size = UDim2.new(1, 4, 0, 2)
                Marker_2.ZIndex = 5

                UICorner_24.CornerRadius = UDim.new(0, 5)
                UICorner_24.Parent = Marker_2

                Preview.MouseButton1Click:Connect(function()
                    if ColorShow == false then
                        TweenObj(ColorPicker_Back_2,{Size = UDim2.new(0, 300, 0, 120)},0.2)
                        ColorShow = true
                        ColorPicker_Back_2.Visible = true
                    else
                        TweenObj(ColorPicker_Back_2,{Size = UDim2.new(0, 300, 0, 0)},0.2)
                        ColorShow = false
                        wait(1)
                        ColorPicker_Back_2.Visible = false
                    end
                end)

                local plr = game.Players.LocalPlayer
                local mouse = plr:GetMouse()
                local uis = game:GetService('UserInputService')
                local rs = game:GetService("RunService")
                local colorpicker = false
                local darknesss = false
                local dark = false
                local rgb = RGB    
                local dark = Value
                local preview = Preview    
                local cursor = Marker
                local cursor2 = Marker_2
                local colorData = {1,1,1}

                local function mouseLocation()
                    return plr:GetMouse()
                end

                local function setColor(hue,sat,val)
                    colorData = {hue or colorData[1],sat or colorData[2],val or colorData[3]}
                    realcolor = Color3.fromHSV(colorData[1],colorData[2],colorData[3])
                    preview.BackgroundColor3 = realcolor
                    Color = realcolor
                    default = Color
                    callback(Color)
                    dark.ImageColor3 = Color3.fromHSV(colorData[1],colorData[2],1)
                end
                
                local function inBounds(frame)
                    local x,y = mouse.X - frame.AbsolutePosition.X,mouse.Y - frame.AbsolutePosition.Y
                    local maxX,maxY = frame.AbsoluteSize.X,frame.AbsoluteSize.Y
                    if x >= 0 and y >= 0 and x <= maxX and y <= maxY then
                        return x/maxX,y/maxY
                    end
                end

                local function cp()
                    if colorpicker then
                        local x,y = inBounds(rgb)
                        if x and y then
                            cursor.Position = UDim2.new(x,0,y,0)
                            setColor(1 - x,1 - y)
                        end
                    end
                    if darknesss then
                        local x,y = inBounds(dark)
                        if x and y then
                            cursor2.Position = UDim2.new(0.5,0,y,0)
                            setColor(nil,nil,1 - y)
                        end
                    end
                end

                mouse.Move:connect(cp)
                rgb.MouseButton1Down:connect(function()colorpicker=true end)
                dark.MouseButton1Down:connect(function()darknesss=true end)
                uis.InputEnded:Connect(function(input)
                    if input.UserInputType.Name == 'MouseButton1' then
                        if darknesss then darknesss = false end
                        if colorpicker then colorpicker = false end
                    end
                end)
            end
        end
        return SectionLib;
    end
    return TabsLib;
end
return HankLib;
