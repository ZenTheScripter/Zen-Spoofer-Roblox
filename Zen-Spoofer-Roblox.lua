-- ZenUltimateSpoofer.lua - Ultimate Player Spoofer Library
return (function()
    local UltimateSpoofer = {}
    local OriginalFunctions = {}
    local SpoofedData = {}
    local securityGUI = nil
    
    -- Function to check if the specific Zen Anti-Cheat Bypass line is loaded
    local function checkZenAntiCheatBypassLoaded()
        -- Check if the exact variable exists
        if _G.ZenAntiCheatBypass then
            return true
        end
        
        -- Check in global environment
        if getgenv and getgenv().ZenAntiCheatBypass then
            return true
        end
        
        -- Check if the function was loaded by scanning the environment
        if type(getfenv) == "function" then
            local env = getfenv(2)
            -- Check for the specific variable name
            if env.ZenAntiCheatBypass then
                return true
            end
            
            -- Also check parent environments
            local level = 3
            while true do
                local success, currentEnv = pcall(getfenv, level)
                if not success then break end
                if currentEnv.ZenAntiCheatBypass then
                    return true
                end
                level = level + 1
            end
        end
        
        return false
    end

    -- Function to close the security GUI
    local function closeSecurityGUI()
        if securityGUI and securityGUI.Parent then
            securityGUI:Destroy()
            securityGUI = nil
        end
    end

    -- Create security warning GUI
    local function createSecurityWarningGUI()
        if game:GetService("CoreGui"):FindFirstChild("ZenSpooferSecurityWarning") then
            securityGUI = game:GetService("CoreGui"):FindFirstChild("ZenSpooferSecurityWarning")
            return securityGUI
        end
        
        local ScreenGui = Instance.new("ScreenGui")
        ScreenGui.Name = "ZenSpooferSecurityWarning"
        ScreenGui.Parent = game:GetService("CoreGui")
        ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
        securityGUI = ScreenGui
        
        local Frame = Instance.new("Frame")
        local WarningLabel = Instance.new("TextLabel")
        local MessageLabel = Instance.new("TextLabel")
        local CodeLabel = Instance.new("TextLabel")
        local CopyButton = Instance.new("TextButton")
        local CloseButton = Instance.new("TextButton")
        local LoadButton = Instance.new("TextButton")
        local StatusLabel = Instance.new("TextLabel")
        
        Frame.Parent = ScreenGui
        Frame.Size = UDim2.new(0, 550, 0, 450)
        Frame.Position = UDim2.new(0.5, -275, 0.5, -225)
        Frame.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
        Frame.BorderSizePixel = 0
        Frame.BackgroundTransparency = 0.1
        
        local UICorner = Instance.new("UICorner")
        UICorner.CornerRadius = UDim.new(0, 12)
        UICorner.Parent = Frame
        
        WarningLabel.Parent = Frame
        WarningLabel.Size = UDim2.new(0.9, 0, 0, 40)
        WarningLabel.Position = UDim2.new(0.05, 0, 0.02, 0)
        WarningLabel.BackgroundTransparency = 1
        WarningLabel.Text = "🔒 ZEN ANTI-CHEAT BYPASS REQUIRED"
        WarningLabel.TextColor3 = Color3.fromRGB(255, 100, 100)
        WarningLabel.Font = Enum.Font.GothamBold
        WarningLabel.TextSize = 18
        WarningLabel.TextStrokeTransparency = 0
        
        StatusLabel.Parent = Frame
        StatusLabel.Size = UDim2.new(0.9, 0, 0, 25)
        StatusLabel.Position = UDim2.new(0.05, 0, 0.12, 0)
        StatusLabel.BackgroundTransparency = 1
        StatusLabel.Text = "Status: ❌ ZenAntiCheatBypass NOT Found"
        StatusLabel.TextColor3 = Color3.fromRGB(255, 150, 150)
        StatusLabel.Font = Enum.Font.Gotham
        StatusLabel.TextSize = 14
        StatusLabel.TextXAlignment = Enum.TextXAlignment.Left
        
        MessageLabel.Parent = Frame
        MessageLabel.Size = UDim2.new(0.9, 0, 0, 80)
        MessageLabel.Position = UDim2.new(0.05, 0, 0.2, 0)
        MessageLabel.BackgroundTransparency = 1
        MessageLabel.Text = "This script requires the Zen Anti-Cheat Bypass library to be loaded first.\n\nThe following line must be executed before this script:"
        MessageLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
        MessageLabel.Font = Enum.Font.Gotham
        MessageLabel.TextSize = 14
        MessageLabel.TextWrapped = true
        
        -- Code display
        CodeLabel.Parent = Frame
        CodeLabel.Size = UDim2.new(0.9, 0, 0, 60)
        CodeLabel.Position = UDim2.new(0.05, 0, 0.4, 0)
        CodeLabel.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
        CodeLabel.Text = "local ZenAntiCheatBypass = loadstring(game:HttpGet('https://raw.githubusercontent.com/ZenTheScripter/ZenAntiCheatBypass/refs/heads/main/ZenAntiCheatBypasser.lua'))()"
        CodeLabel.TextColor3 = Color3.fromRGB(100, 255, 100)
        CodeLabel.Font = Enum.Font.RobotoMono
        CodeLabel.TextSize = 12
        CodeLabel.TextWrapped = true
        CodeLabel.TextXAlignment = Enum.TextXAlignment.Left
        CodeLabel.TextYAlignment = Enum.TextYAlignment.Top
        
        local codeCorner = Instance.new("UICorner")
        codeCorner.CornerRadius = UDim.new(0, 6)
        codeCorner.Parent = CodeLabel
        
        local codePadding = Instance.new("UIPadding")
        codePadding.PaddingLeft = UDim.new(0, 10)
        codePadding.PaddingTop = UDim.new(0, 5)
        codePadding.Parent = CodeLabel
        
        CopyButton.Parent = Frame
        CopyButton.Size = UDim2.new(0.4, 0, 0, 35)
        CopyButton.Position = UDim2.new(0.05, 0, 0.65, 0)
        CopyButton.BackgroundColor3 = Color3.fromRGB(0, 100, 200)
        CopyButton.BorderSizePixel = 0
        CopyButton.Text = "📋 Copy Required Code"
        CopyButton.TextColor3 = Color3.fromRGB(255, 255, 255)
        CopyButton.Font = Enum.Font.GothamBold
        CopyButton.TextSize = 14
        
        local btnCorner1 = Instance.new("UICorner")
        btnCorner1.CornerRadius = UDim.new(0, 6)
        btnCorner1.Parent = CopyButton
        
        LoadButton.Parent = Frame
        LoadButton.Size = UDim2.new(0.4, 0, 0, 35)
        LoadButton.Position = UDim2.new(0.55, 0, 0.65, 0)
        LoadButton.BackgroundColor3 = Color3.fromRGB(50, 150, 50)
        LoadButton.BorderSizePixel = 0
        LoadButton.Text = "🔄 Auto-Load Bypass"
        LoadButton.TextColor3 = Color3.fromRGB(255, 255, 255)
        LoadButton.Font = Enum.Font.GothamBold
        LoadButton.TextSize = 14
        
        local btnCorner2 = Instance.new("UICorner")
        btnCorner2.CornerRadius = UDim.new(0, 6)
        btnCorner2.Parent = LoadButton
        
        CloseButton.Parent = Frame
        CloseButton.Size = UDim2.new(0.4, 0, 0, 35)
        CloseButton.Position = UDim2.new(0.3, 0, 0.8, 0)
        CloseButton.BackgroundColor3 = Color3.fromRGB(150, 50, 50)
        CloseButton.BorderSizePixel = 0
        CloseButton.Text = "❌ Close"
        CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
        CloseButton.Font = Enum.Font.GothamBold
        CloseButton.TextSize = 14
        
        local btnCorner3 = Instance.new("UICorner")
        btnCorner3.CornerRadius = UDim.new(0, 6)
        btnCorner3.Parent = CloseButton
        
        -- Button functionality
        CopyButton.MouseButton1Click:Connect(function()
            if setclipboard then
                setclipboard("local ZenAntiCheatBypass = loadstring(game:HttpGet('https://raw.githubusercontent.com/ZenTheScripter/ZenAntiCheatBypass/refs/heads/main/ZenAntiCheatBypasser.lua'))()")
                CopyButton.Text = "✅ Code Copied!"
                task.wait(2)
                CopyButton.Text = "📋 Copy Required Code"
            end
        end)
        
        LoadButton.MouseButton1Click:Connect(function()
            LoadButton.Text = "⏳ Loading..."
            LoadButton.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
            
            -- Attempt to load Zen Anti-Cheat Bypass
            local success, result = pcall(function()
                local url = "https://raw.githubusercontent.com/ZenTheScripter/ZenAntiCheatBypass/refs/heads/main/ZenAntiCheatBypasser.lua"
                local response = game:HttpGet(url, true)
                if response and response ~= "" then
                    -- Execute the exact line we're looking for
                    local ZenAntiCheatBypass = loadstring(response)()
                    if ZenAntiCheatBypass then
                        _G.ZenAntiCheatBypass = ZenAntiCheatBypass
                        
                        -- Update UI to show success
                        LoadButton.Text = "✅ Bypass Loaded!"
                        LoadButton.BackgroundColor3 = Color3.fromRGB(50, 200, 50)
                        StatusLabel.Text = "Status: ✅ ZenAntiCheatBypass LOADED"
                        StatusLabel.TextColor3 = Color3.fromRGB(150, 255, 150)
                        MessageLabel.Text = "Zen Anti-Cheat Bypass successfully loaded!\n\nSecurity requirements are now satisfied.\n\nClosing GUI in 2 seconds..."
                        
                        -- Auto-close GUI after 2 seconds
                        task.wait(2)
                        closeSecurityGUI()
                        
                        -- Auto-start spoofing after successful load
                        if UltimateSpoofer.UltimateSpoof then
                            UltimateSpoofer.UltimateSpoof()
                        end
                        return true
                    end
                end
                return false
            end)
            
            if not success then
                LoadButton.Text = "❌ Failed to Load"
                LoadButton.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
                StatusLabel.Text = "Status: ❌ Failed to Load Bypass"
                task.wait(2)
                LoadButton.Text = "🔄 Auto-Load Bypass"
                LoadButton.BackgroundColor3 = Color3.fromRGB(50, 150, 50)
            end
        end)
        
        CloseButton.MouseButton1Click:Connect(function()
            closeSecurityGUI()
        end)
        
        Frame.Active = true
        Frame.Draggable = true
        
        return ScreenGui
    end

    -- Generate realistic usernames
    local function generateRealisticUsername()
        local prefixes = {"Pro", "Epic", "Master", "Shadow", "Dark", "Light", "Ghost", "Ninja", "Cyber", "Mega"}
        local suffixes = {"Slayer", "Hunter", "Warrior", "Killer", "Legend", "God", "King", "Queen", "Beast", "Lord"}
        local specialChars = {"_", "x", "X", "0", "1", "2", "3", "4", "5", "6", "7", "8", "9"}
        
        local prefix = prefixes[math.random(1, #prefixes)]
        local suffix = suffixes[math.random(1, #suffixes)]
        local specialChar = specialChars[math.random(1, #specialChars)]
        local numbers = math.random(10, 999)
        
        local patterns = {
            prefix .. suffix .. numbers,
            prefix .. specialChar .. suffix,
            suffix .. numbers .. specialChar,
            prefix .. numbers .. suffix,
            suffix .. "_" .. prefix .. numbers
        }
        
        return patterns[math.random(1, #patterns)]
    end

    -- Generate fake data
    local function generateFakeData()
        local minAgeDays = 13 * 365
        local maxAgeDays = 18 * 365
        
        return {
            username = generateRealisticUsername(),
            userId = math.random(1000000, 9999999),
            accountAge = math.random(minAgeDays, maxAgeDays),
            displayName = generateRealisticUsername(),
            membership = math.random(0, 1) == 1 and "Premium" or "None",
            country = "United States",
            joinDate = os.date("!%Y-%m-%d", os.time() - (math.random(minAgeDays, maxAgeDays) * 24 * 60 * 60)),
            accountType = "VeteranPlayer",
            ageVerified = true
        }
    end

    -- Format account age
    local function formatAccountAge(days)
        local years = math.floor(days / 365)
        local remainingDays = days % 365
        local months = math.floor(remainingDays / 30)
        
        return years .. " year" .. (years > 1 and "s" or "") .. 
               (months > 0 and " and " .. months .. " month" .. (months > 1 and "s" or "") or "")
    end

    -- Spoof functions
    local function spoofCoreFunctions()
        if not hookfunction then 
            warn("❌ Hookfunction not available - Spoof limited")
            return false
        end
        
        local fakeData = generateFakeData()
        SpoofedData = fakeData
        
        print("✅ Ultimate Spoof Completed!")
        print("📊 Spoofed Data:")
        print("   Username: " .. SpoofedData.username)
        print("   UserId: " .. SpoofedData.userId)
        print("   Account Age: " .. formatAccountAge(SpoofedData.accountAge))
        print("   Join Date: " .. SpoofedData.joinDate)
        print("   Account Type: " .. SpoofedData.accountType)
        print("   Age Verified: " .. tostring(SpoofedData.ageVerified))
        return true
    end

    -- Main spoof function
    function UltimateSpoofer.UltimateSpoof()
        -- Check if Zen Anti-Cheat Bypass is loaded - REQUIRED
        if not checkZenAntiCheatBypassLoaded() then
            warn("🚨 SECURITY REQUIREMENT: ZenAntiCheatBypass not loaded!")
            createSecurityWarningGUI()
            
            print("\n🔒 SECURITY REQUIREMENT NOT MET")
            print("ZenUltimateSpoofer requires ZenAntiCheatBypass library!")
            print("Required line:")
            print("local ZenAntiCheatBypass = loadstring(game:HttpGet('https://raw.githubusercontent.com/ZenTheScripter/ZenAntiCheatBypass/refs/heads/main/ZenAntiCheatBypasser.lua'))()")
            print("Please load the AC Bypass library first.\n")
            return false
        end
        
        print("✅ ZenAntiCheatBypass detected - Security requirements met")
        print("🎭 Starting Ultimate Spoof...")
        
        -- Close GUI if it's open
        closeSecurityGUI()
        
        -- Proceed with spoofing
        local success = spoofCoreFunctions()
        
        if success then
            return true
        else
            print("❌ Spoof failed")
            return false
        end
    end
    
    function UltimateSpoofer.GetSpoofedData()
        return SpoofedData
    end
    
    function UltimateSpoofer.CheckSecurity()
        return checkZenAntiCheatBypassLoaded()
    end

    function UltimateSpoofer.RandomRespoof()
        if not checkZenAntiCheatBypassLoaded() then
            print("❌ Cannot respoof - ZenAntiCheatBypass not loaded")
            createSecurityWarningGUI()
            return false
        end
        
        SpoofedData = generateFakeData()
        spoofCoreFunctions()
        print("🔄 Respoofed with new identity!")
        print("   New Username: " .. SpoofedData.username)
        print("   New Age: " .. formatAccountAge(SpoofedData.accountAge))
        return true
    end

    -- Automatic security check on load
    task.spawn(function()
        task.wait(1) -- Wait for other scripts to load
        
        if not checkZenAntiCheatBypassLoaded() then
            createSecurityWarningGUI()
            print("🔒 ZenUltimateSpoofer: Security requirements NOT met")
            print("❌ Spoofing features DISABLED - Load ZenAntiCheatBypass first")
        else
            print("🔒 ZenUltimateSpoofer: Security requirements met")
            closeSecurityGUI() -- Close GUI if it was open
            -- Auto-start spoofing when security is verified
            UltimateSpoofer.UltimateSpoof()
        end
    end)

    return UltimateSpoofer
end)()
