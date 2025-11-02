-- ZenUltimateSpoofer.lua - Ultimate Player Spoofer Library
return (function()
    local UltimateSpoofer = {}
    local OriginalFunctions = {}
    local SpoofedData = {}
    
    -- Function to check if AC Bypass is loaded
    local function checkACBypassLoaded()
        if _G.ZenACBypassLoaded or _G.ZenAntiCheatBypass then
            return true
        end
        
        if getgenv and getgenv().ZenACBypassLoaded then
            return true
        end
        
        if _G.ScanForThreats or _G.ZenACB then
            return true
        end
        
        return false
    end

    -- Create security warning GUI
    local function createSecurityWarningGUI()
        if game:GetService("CoreGui"):FindFirstChild("ZenSpooferSecurityWarning") then
            return
        end
        
        local ScreenGui = Instance.new("ScreenGui")
        local Frame = Instance.new("Frame")
        local WarningLabel = Instance.new("TextLabel")
        local MessageLabel = Instance.new("TextLabel")
        local CopyButton = Instance.new("TextButton")
        local CloseButton = Instance.new("TextButton")
        local BlurEffect = Instance.new("BlurEffect")
        
        ScreenGui.Name = "ZenSpooferSecurityWarning"
        ScreenGui.Parent = game:GetService("CoreGui")
        ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
        
        -- Blur effect
        BlurEffect.Parent = game:GetService("Lighting")
        BlurEffect.Size = 24
        BlurEffect.Name = "ZenSpooferBlur"
        
        Frame.Parent = ScreenGui
        Frame.Size = UDim2.new(0, 450, 0, 300)
        Frame.Position = UDim2.new(0.5, -225, 0.5, -150)
        Frame.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
        Frame.BorderSizePixel = 0
        Frame.BackgroundTransparency = 0.1
        
        WarningLabel.Parent = Frame
        WarningLabel.Size = UDim2.new(0.9, 0, 0, 50)
        WarningLabel.Position = UDim2.new(0.05, 0, 0.05, 0)
        WarningLabel.BackgroundTransparency = 1
        WarningLabel.Text = "🔒 SECURITY REQUIREMENT"
        WarningLabel.TextColor3 = Color3.fromRGB(255, 100, 100)
        WarningLabel.Font = Enum.Font.SourceSansBold
        WarningLabel.TextSize = 22
        WarningLabel.TextStrokeTransparency = 0
        
        MessageLabel.Parent = Frame
        MessageLabel.Size = UDim2.new(0.9, 0, 0, 120)
        MessageLabel.Position = UDim2.new(0.05, 0, 0.25, 0)
        MessageLabel.BackgroundTransparency = 1
        MessageLabel.Text = "ZenUltimateSpoofer requires ZenAntiCheatBypass library!\n\nFor security reasons, the spoofer will NOT function without proper AC protection.\n\nPlease load ZenAntiCheatBypass first to enable spoofing features."
        MessageLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
        MessageLabel.Font = Enum.Font.SourceSans
        MessageLabel.TextSize = 16
        MessageLabel.TextWrapped = true
        
        CopyButton.Parent = Frame
        CopyButton.Size = UDim2.new(0.4, 0, 0, 35)
        CopyButton.Position = UDim2.new(0.05, 0, 0.75, 0)
        CopyButton.BackgroundColor3 = Color3.fromRGB(0, 100, 200)
        CopyButton.BorderSizePixel = 0
        CopyButton.Text = "📋 Copy GitHub Link"
        CopyButton.TextColor3 = Color3.fromRGB(255, 255, 255)
        CopyButton.Font = Enum.Font.SourceSansBold
        CopyButton.TextSize = 14
        
        CloseButton.Parent = Frame
        CloseButton.Size = UDim2.new(0.4, 0, 0, 35)
        CloseButton.Position = UDim2.new(0.55, 0, 0.75, 0)
        CloseButton.BackgroundColor3 = Color3.fromRGB(150, 50, 50)
        CloseButton.BorderSizePixel = 0
        CloseButton.Text = "❌ Close"
        CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
        CloseButton.Font = Enum.Font.SourceSansBold
        CloseButton.TextSize = 14
        
        -- Button functionality
        CopyButton.MouseButton1Click:Connect(function()
            if setclipboard then
                setclipboard("https://github.com/ZenTheScripter/ZenAntiCheatBypass")
                CopyButton.Text = "✅ Copied!"
                task.wait(2)
                CopyButton.Text = "📋 Copy GitHub Link"
            end
        end)
        
        CloseButton.MouseButton1Click:Connect(function()
            ScreenGui:Destroy()
            if BlurEffect.Parent then
                BlurEffect:Destroy()
            end
        end)
        
        Frame.Active = true
        Frame.Draggable = true
        
        return ScreenGui
    end

    -- Generate realistic usernames with special characters
    local function generateRealisticUsername()
        local prefixes = {"Pro", "Epic", "Master", "Shadow", "Dark", "Light", "Ghost", "Ninja", "Cyber", "Mega"}
        local suffixes = {"Slayer", "Hunter", "Warrior", "Killer", "Legend", "God", "King", "Queen", "Beast", "Lord"}
        local specialChars = {"_", "x", "X", "0", "1", "2", "3", "4", "5", "6", "7", "8", "9"}
        
        local prefix = prefixes[math.random(1, #prefixes)]
        local suffix = suffixes[math.random(1, #suffixes)]
        local specialChar = specialChars[math.random(1, #specialChars)]
        local numbers = math.random(10, 999)
        
        -- Different username patterns
        local patterns = {
            prefix .. suffix .. numbers,
            prefix .. specialChar .. suffix,
            suffix .. numbers .. specialChar,
            prefix .. numbers .. suffix,
            suffix .. "_" .. prefix .. numbers
        }
        
        return patterns[math.random(1, #patterns)]
    end

    -- Generate fake data with accounts over 13 years old
    local function generateFakeData()
        -- Account age: 13+ years minimum (13 to 18 years)
        local minAgeDays = 13 * 365  -- 13 years minimum
        local maxAgeDays = 18 * 365  -- 18 years maximum
        
        return {
            username = generateRealisticUsername(),
            userId = math.random(1000000, 9999999),
            accountAge = math.random(minAgeDays, maxAgeDays), -- 13 to 18 years
            displayName = generateRealisticUsername(),
            membership = math.random(0, 1) == 1 and "Premium" or "None",
            country = "United States",
            joinDate = os.date("!%Y-%m-%d", os.time() - (math.random(minAgeDays, maxAgeDays) * 24 * 60 * 60)),
            accountType = "VeteranPlayer",
            ageVerified = true
        }
    end

    -- Format account age in years
    local function formatAccountAge(days)
        local years = math.floor(days / 365)
        local remainingDays = days % 365
        local months = math.floor(remainingDays / 30)
        
        return years .. " year" .. (years > 1 and "s" or "") .. 
               (months > 0 and " and " .. months .. " month" .. (months > 1 and "s" or "") or "")
    end

    -- Advanced function spoofing
    local function spoofCoreFunctions()
        if not hookfunction then 
            warn("❌ Hookfunction not available - Spoof limited")
            return false
        end
        
        local fakeData = generateFakeData()
        SpoofedData = fakeData
        
        -- Spoof GetUserId
        if type(game.Players.LocalPlayer.GetUserId) == "function" then
            OriginalFunctions.GetUserId = game.Players.LocalPlayer.GetUserId
            hookfunction(game.Players.LocalPlayer.GetUserId, function(self)
                return fakeData.userId
            end)
        end
        
        -- Spoof GetAccountAge
        if type(game.Players.LocalPlayer.GetAccountAge) == "function" then
            OriginalFunctions.GetAccountAge = game.Players.LocalPlayer.GetAccountAge
            hookfunction(game.Players.LocalPlayer.GetAccountAge, function(self)
                return fakeData.accountAge
            end)
        end
        
        -- Spoof Name
        if game.Players.LocalPlayer then
            OriginalFunctions.Name = game.Players.LocalPlayer.Name
            local nameMt = getrawmetatable(game.Players.LocalPlayer)
            if nameMt and nameMt.__index then
                local originalIndex = nameMt.__index
                hookfunction(nameMt.__index, function(self, key)
                    if key == "Name" then
                        return fakeData.username
                    end
                    return originalIndex(self, key)
                end)
            end
        end
        
        return true
    end

    -- Main spoof function with security requirement
    function UltimateSpoofer.UltimateSpoof()
        -- Check if AC Bypass is loaded - REQUIRED
        if not checkACBypassLoaded() then
            warn("🚨 SECURITY REQUIREMENT: ZenAntiCheatBypass not loaded!")
            createSecurityWarningGUI()
            
            print("\n🔒 SECURITY REQUIREMENT NOT MET")
            print("ZenUltimateSpoofer requires ZenAntiCheatBypass library!")
            print("Spoofing features are DISABLED for security reasons.")
            print("GitHub: https://github.com/ZenTheScripter/ZenAntiCheatBypass")
            print("Please load the AC Bypass library first.\n")
            return false
        end
        
        print("✅ ZenAntiCheatBypass detected - Security requirements met")
        print("🎭 Starting Ultimate Spoof...")
        
        -- Proceed with spoofing
        local success = spoofCoreFunctions()
        
        if success then
            print("✅ Ultimate Spoof Completed!")
            print("📊 Spoofed Data:")
            print("   Username: " .. SpoofedData.username)
            print("   UserId: " .. SpoofedData.userId)
            print("   Account Age: " .. formatAccountAge(SpoofedData.accountAge))
            print("   Join Date: " .. SpoofedData.joinDate)
            print("   Account Type: " .. SpoofedData.accountType)
            print("   Age Verified: " .. tostring(SpoofedData.ageVerified))
            return true
        else
            print("❌ Spoof failed - Security requirements not met")
            return false
        end
    end
    
    function UltimateSpoofer.GetSpoofedData()
        return SpoofedData
    end
    
    function UltimateSpoofer.CheckSecurity()
        return checkACBypassLoaded()
    end

    function UltimateSpoofer.RandomRespoof()
        if not checkACBypassLoaded() then
            print("❌ Cannot respoof - AC Bypass not loaded")
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
        task.wait(2) -- Wait for other scripts to load
        
        if not checkACBypassLoaded() then
            createSecurityWarningGUI()
            print("🔒 ZenUltimateSpoofer: Security requirements NOT met")
            print("❌ Spoofing features DISABLED - Load ZenAntiCheatBypass first")
        else
            print("🔒 ZenUltimateSpoofer: Security requirements met")
            -- Auto-start spoofing when security is verified
            UltimateSpoofer.UltimateSpoof()
        end
    end)

    return UltimateSpoofer
end)()
