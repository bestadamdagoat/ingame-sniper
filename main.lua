local buyitemafterteleport = false
local assetid = nil
local placeid = nil
getgenv().afterassetid = nil

local versionreq = request({
	Url = "https://raw.githubusercontent.com/bestadamdagoat/ingame-sniper/main/VERSION.md",
	Method = "GET",
})

local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()
print("Don't worry, Rayfield IS loading. It might take a second due to it being a good UI.")
local Window = Rayfield:CreateWindow({
    Name = "ingame-sniper",
    LoadingTitle = "Loading the UI",
    LoadingSubtitle = "i dunno what to put here gimme ideas. there's spiders in the walls they are crawling in your skin rip off your skin and get the spiders out.",
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
local Section = Tab:CreateSection("Prompt Purchase")
local Input = Tab:CreateInput({
    Name = "Asset ID",
    PlaceholderText = "ex: 13023433259",
    RemoveTextAfterFocusLost = false,
    Callback = function(Text)
        assetid = Text
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
local Paragraph = Tab:CreateParagraph({Title = "Info", Content = "This is for buying an item within a game. Don't use this unless you already have it executed prior to the item dropping. Running the two basic lines is much faster than loading the Rayfield UI every time."})

local Section = Tab:CreateSection("Teleport Sniper")
local Input = Tab:CreateInput({
    Name = "Place ID",
    PlaceholderText = "ex: 263761432",
    RemoveTextAfterFocusLost = false,
    Callback = function(Text)
        placeid = Text
    end,
})
local Input = Tab:CreateInput({
    Name = "Asset ID (reqs toggle to be on)",
    PlaceholderText = "ex: 13023433259",
    RemoveTextAfterFocusLost = false,
    Callback = function(Text)
        afterassetid = Text
    end,
})
local Toggle = Tab:CreateToggle({
    Name = "Buy an Item After Teleporting?",
    CurrentValue = false,
    Flag = "TPafterPurchase", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
    Callback = function(Value)
        buyitemafterteleport = Value
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
Paragraph:Set({Title = "Info", Content = "This is completely unrelated to the Prompt Purchase sniper and requires you to enter the info again."})

local Section = Tab:CreateSection("Misc")
local Button = Tab:CreateButton({
    Name = "Rejoin Game",
    Callback = function()
        queue_on_teleport("loadstring(game:HttpGet('https://raw.githubusercontent.com/bestadamdagoat/ingame-sniper/main/main.lua'))()")
        game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, game.JobId, game:GetService("Players").LocalPlayer)
    end,
})
local Input = Tab:CreateInput({
    Name = "Join Game",
    PlaceholderText = "ex: 13023433259",
    RemoveTextAfterFocusLost = false,
    Callback = function(Text)
        game:GetService("TeleportService"):Teleport(Text, game:GetService("Players").LocalPlayer)
    end,
})
local Button = Tab:CreateButton({
    Name = "Find Subplaces",
    Callback = function()
        local pages = game:GetService("AssetService"):GetGamePlacesAsync()
        while true do
            for _,place in pairs(pages:GetCurrentPage()) do
                print("Name: " .. place.Name)
                print("PlaceId: " .. tostring(place.PlaceId))
            end
            if pages.IsFinished then
                break
            end
            pages:AdvanceToNextPageAsync()
        end
    end,
})
local Paragraph = Tab:CreateParagraph({Title = "OUTPUTS TO THE CONSOLE", Content = "Press F9 to open the console."})

local Tab = Window:CreateTab("Player") -- Title, Image
local Input = Tab:CreateInput({
    Name = "Speed",
    PlaceholderText = "ex: 80",
    RemoveTextAfterFocusLost = false,
    Callback = function(Text)
        game:GetService("Players").LocalPlayer.Character.Humanoid.WalkSpeed = Text
    end,
})
local Input = Tab:CreateInput({
    Name = "Jump Height",
    PlaceholderText = "ex: 80",
    RemoveTextAfterFocusLost = false,
    Callback = function(Text)
        game:GetService("Players").LocalPlayer.Character.Humanoid.JumpPower = Text
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
local Paragraph = Tab:CreateParagraph({Title = "Version 1.1", Content = "Latest Version is " .. versionreq.Body .. " \nMake sure to launch using the script provided in the README. If you don't, you'll be running an outdated version! bestadamdagoat/ingame-sniper"})
