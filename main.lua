getgenv().assetid = Text
getgenv().placeid = Text
getgenv().buyitemafterteleport = false

local response = request({
	Url = "https://raw.githubusercontent.com/bestadamdagoat/ingame-sniper/main/VERSION.md",
	Method = "GET",
})

local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()
local Window = Rayfield:CreateWindow({
    Name = "SNIPE TOOL",
    LoadingTitle = "Powered by the Rayfield Interface Suite",
    LoadingSubtitle = "uhhhh hammed burger",
    ConfigurationSaving = {
        Enabled = false,
        FolderName = nil, -- Create a custom folder for your hub/game
        FileName = "Snipe Tool"
    },
    Discord = {
        Enabled = false,
        Invite = "noinvitelink", -- The Discord invite code, do not include discord.gg/. E.g. discord.gg/ABCD would be ABCD
        RememberJoins = true -- Set this to false to make them join the discord every time they load it up
    },
    KeySystem = false, -- Set this to true to use our key system
    KeySettings = {
        Title = "Untitled",
        Subtitle = "Key System",
        Note = "No method of obtaining the key is provided",
        FileName = "Key", -- It is recommended to use something unique as other scripts using Rayfield may overwrite your key file
        SaveKey = true, -- The user's key will be saved, but if you change the key, they will be unable to use your script
        GrabKeyFromSite = false, -- If this is true, set Key below to the RAW site you would like Rayfield to get the key from
        Key = {"Hello"} -- List of keys that will be accepted by the system, can be RAW file links (pastebin, github etc) or simple strings ("hello","key22")
    }
})

local Tab = Window:CreateTab("Main") -- Title, Image
local Section = Tab:CreateSection("Prompt Purchase (Sniper)")
local Input = Tab:CreateInput({
    Name = "Asset ID",
    PlaceholderText = "ex: 13023433259",
    RemoveTextAfterFocusLost = false,
    Callback = function(Text)
        getgenv().assetid = Text
    end,
})
local Button = Tab:CreateButton({
    Name = "Prompt Purchase",
    Callback = function()
        game:GetService("MarketplaceService"):PromptPurchase(game.Players.LocalPlayer, assetid)
    end,
})
local Toggle = Tab:CreateToggle({
    Name = "Spam Purchase (CAN'T BE TURNED OFF YET)",
    CurrentValue = false,
    Flag = "PurchaseToggle", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
    Callback = function(Value)
        while Value == true do
            game:GetService("MarketplaceService"):PromptPurchase(game.Players.LocalPlayer, assetid)
            wait(1)
        end
    end,
})

local Section = Tab:CreateSection("Teleport")
local Input = Tab:CreateInput({
    Name = "Place ID",
    PlaceholderText = "ex: 263761432",
    RemoveTextAfterFocusLost = false,
    Callback = function(Text)
        getgenv().placeid = Text
    end,
})
local Input = Tab:CreateInput({
    Name = "Asset ID (reqs toggle to be on)",
    PlaceholderText = "ex: 13023433259",
    RemoveTextAfterFocusLost = false,
    Callback = function(Text)
        writefile("afterassetid.txt", Text)
    end,
})
local Toggle = Tab:CreateToggle({
    Name = "Buy an Item After Teleporting?",
    CurrentValue = false,
    Flag = "TPafterPurchase", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
    Callback = function(Value)
        getgenv().buyitemafterteleport = Value
    end,
})
local Button = Tab:CreateButton({
    Name = "Teleport to Game",
    Callback = function()
        if buyitemafterteleport == true then
            queue_on_teleport("loadstring(game:HttpGet('https://raw.githubusercontent.com/bestadamdagoat/ingame-sniper/main/buyafterteleport.lua'))()")
            game:GetService("TeleportService"):Teleport(placeid, game:GetService("Players").LocalPlayer)
        else
            game:GetService("TeleportService"):Teleport(placeid, game:GetService("Players").LocalPlayer)
        end
    end,
})

local Tab = Window:CreateTab("Scripts") -- Title, Image
local Button = Tab:CreateButton({
    Name = "Secured Dark Dex v3 (Explorer)",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/Babyhamsta/RBLX_Scripts/main/Universal/BypassedDarkDexV3.lua", true))()
    end,
})
local Button = Tab:CreateButton({
    Name = "Infinite Yield (Admin)",
    Callback = function()
        loadstring(game:HttpGet('https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source'))()
    end,
})
local Button = Tab:CreateButton({
    Name = "Simple Spy (Remotes)",
    Callback = function()
        loadstring(game:HttpGet("https://github.com/exxtremestuffs/SimpleSpySource/raw/master/SimpleSpy.lua"))()
    end,
})

local Tab = Window:CreateTab("About") -- Title, Image
local Section = Tab:CreateSection("Info")
local Paragraph = Tab:CreateParagraph({Title = "Version 1.0", Content = "Latest Version is " .. response.Body .. " Make sure to launch using the script provided in the README. If you don't, you'll be running an outdated version! bestadamdagoat/ingame-sniper"})
