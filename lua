local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "Zeroonclips Cheats",
   Icon = 0, -- Icon in Topbar. Can use Lucide Icons (string) or Roblox Image (number). 0 to use no icon (default).
   LoadingTitle = "Be Patient Damn",
   LoadingSubtitle = "by Aj",
   Theme = "Ocean", -- Check https://docs.sirius.menu/rayfield/configuration/themes

   DisableRayfieldPrompts = false,
   DisableBuildWarnings = false, -- Prevents Rayfield from warning when the script has a version mismatch with the interface

   ConfigurationSaving = {
      Enabled = true,
      FolderName = nil, -- Create a custom folder for your hub/game
      FileName = "Big Hub"
   },

   Discord = {
      Enabled = false, -- Prompt the user to join your Discord server if their executor supports it
      Invite = "noinvitelink", -- The Discord invite code, do not include discord.gg/. E.g. discord.gg/ ABCD would be ABCD
      RememberJoins = true -- Set this to false to make them join the discord every time they load it up
   },

   KeySystem = true, -- Set this to true to use our key system
   KeySettings = {
      Title = "Untitled",
      Subtitle = "Key System",
      Note = "No method of obtaining the key is provided", -- Use this to tell the user how to get a key
      FileName = "Key", -- It is recommended to use something unique as other scripts using Rayfield may overwrite your key file
      SaveKey = false, -- The user's key will be saved, but if you change the key, they will be unable to use your script
      GrabKeyFromSite = true, -- If this is true, set Key below to the RAW site you would like Rayfield to get the key from
      Key = {"https://raw.githubusercontent.com/Overkilz11/haks/refs/heads/main/KEY%20FILE"} -- List of keys that will be accepted by the system, can be RAW file links (pastebin, github etc) or simple strings ("hello","key22")
   }
})

local PlayerTab = Window:CreateTab("Player", nil) -- Title, Image

local Section = PlayerTab:CreateSection("Walkspeed")
local Slider = PlayerTab:CreateSlider({
   Name = "WalkSpeed",
   Range = {16, 500},
   Increment = 1,
   Suffix = "Speed",
   CurrentValue = 16,
   Flag = "Slider1",
   Callback = function(Value)
        game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = (Value)
   end,
})  


local Section = PlayerTab:CreateSection("Jump Power")
local Slider = PlayerTab:CreateSlider({
   Name = "Jump Power",
   Range = {50, 500},
   Increment = 1,
   Suffix = "Speed",
   CurrentValue = 50,
   Flag = "Slider2",
   Callback = function(Value)
        game.Players.LocalPlayer.Character.Humanoid.JumpPower = (Value)
   end,
})

local Button = PlayerTab:CreateButton({
   Name = "Infinite Jump",
   Callback = function()
      loadstring(game:HttpGet("https://cdn.wearedevs.net/scripts/Infinite%20Jump.txt"))()
   end,
})

local Section = PlayerTab:CreateSection("Test and other stuff")
local Button = PlayerTab:CreateButton({
   Name = "Test if Scripts running",
   Callback = function()
print("YEs iitt works")
   end,
})

local Section = PlayerTab:CreateSection("Fly")
local Button = PlayerTab:CreateButton({
   Name = "Fly",
   Callback = function() 
      local main = Instance.new("ScreenGui")
      local onof = Instance.new("TextButton")
      main.Name = "main"
      main.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
      main.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
      
      onof.Name = "onof"
      onof.Parent = main
      onof.BackgroundColor3 = Color3.fromRGB(255, 249, 74)
      onof.Position = UDim2.new(0.100320168, 0, 0.379746825, 0)
      onof.Size = UDim2.new(0, 56, 0, 28)
      onof.Font = Enum.Font.SourceSans
      onof.Text = "Fly"
      onof.TextColor3 = Color3.fromRGB(0, 0, 0)
      onof.TextSize = 14.000
      
      -- Fly functionality
      local player = game.Players.LocalPlayer
      local character = player.Character or player.CharacterAdded:Wait()
      local humanoid = character:FindFirstChildOfClass("Humanoid")
      local flying, speed = false, 100
      local upVelocity, forwardVelocity, rightVelocity = 0, 0, 0
      local bodyGyro, bodyVelocity
      
      -- Fly toggle
      onof.MouseButton1Down:Connect(function()
          flying = not flying
          if flying then
              bodyGyro = Instance.new("BodyGyro", character.PrimaryPart)
              bodyGyro.P, bodyGyro.maxTorque = 9e4, Vector3.new(9e9, 9e9, 9e9)
              bodyGyro.cframe = character.PrimaryPart.CFrame
              bodyVelocity = Instance.new("BodyVelocity", character.PrimaryPart)
              bodyVelocity.maxForce = Vector3.new(9e9, 9e9, 9e9)
              humanoid.PlatformStand = true
          else
              bodyGyro:Destroy()
              bodyVelocity:Destroy()
              humanoid.PlatformStand = false
          end
      end)
      
      -- Handle movement
      local userInput = game:GetService("UserInputService")
      local move = {E = speed, Space = speed, Q = -speed, W = speed, S = -speed, A = -speed, D = speed}
      
      userInput.InputBegan:Connect(function(input)
          if flying then
              local key = input.KeyCode.Name
              if move[key] then
                  if key == "E" or key == "Space" then
                      upVelocity = move[key]
                  elseif key == "Q" then
                      upVelocity = move[key]
                  elseif key == "W" or key == "S" then
                      forwardVelocity = move[key]
                  elseif key == "A" or key == "D" then
                      rightVelocity = move[key]
                  end
              end
          end
      end)
      
      userInput.InputEnded:Connect(function(input)
          if flying then
              local key = input.KeyCode.Name
              if key == "E" or key == "Space" then upVelocity = 0
              elseif key == "Q" then upVelocity = 0
              elseif key == "W" or key == "S" then forwardVelocity = 0
              elseif key == "A" or key == "D" then rightVelocity = 0 end
          end
      end)
      
      -- Update fly mech
      game:GetService("RunService").RenderStepped:Connect(function()
          if flying and character.PrimaryPart then
              bodyGyro.cframe = workspace.CurrentCamera.CFrame
              bodyVelocity.velocity = workspace.CurrentCamera.CFrame.LookVector * forwardVelocity
                  + workspace.CurrentCamera.CFrame.RightVector * rightVelocity + Vector3.new(0, upVelocity, 0)
          end
      end)
      
   end,
})

local Section = PlayerTab:CreateSection("Aimbot and ESP")
local Button = PlayerTab:CreateButton({
   Name = "ESP",
   Callback = function()
      local Players = game:GetService("Players"):GetChildren()

local RunService = game:GetService("RunService")

local highlight = Instance.new("Highlight")

highlight.Name = "Highlight"



for i, v in pairs(Players) do

    repeat wait() until v.Character

    if not v.Character:FindFirstChild("HumanoidRootPart"):FindFirstChild("Highlight") then

        local highlightClone = highlight:Clone()

        highlightClone.Adornee = v.Character

        highlightClone.Parent = v.Character:FindFirstChild("HumanoidRootPart")

        highlightClone.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop

        highlightClone.Name = "Highlight"

    end

end



game.Players.PlayerAdded:Connect(function(player)

    repeat wait() until player.Character

    if not player.Character:FindFirstChild("HumanoidRootPart"):FindFirstChild("Highlight") then

        local highlightClone = highlight:Clone()

        highlightClone.Adornee = player.Character

        highlightClone.Parent = player.Character:FindFirstChild("HumanoidRootPart")

        highlightClone.Name = "Highlight"

    end

end)



game.Players.PlayerRemoving:Connect(function(playerRemoved)

    playerRemoved.Character:FindFirstChild("HumanoidRootPart").Highlight:Destroy()

end)



RunService.Heartbeat:Connect(function()

    for i, v in pairs(Players) do

        repeat wait() until v.Character

        if not v.Character:FindFirstChild("HumanoidRootPart"):FindFirstChild("Highlight") then

            local highlightClone = highlight:Clone()

            highlightClone.Adornee = v.Character

            highlightClone.Parent = v.Character:FindFirstChild("HumanoidRootPart")

            highlightClone.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop

            highlightClone.Name = "Highlight"

            task.wait()

        end

end

end)
   end,
})

local Button = PlayerTab:CreateButton({
   Name = "Hitbox",
   Callback = function()
      loadstring(game:HttpGet("https://scriptblox.com/raw/Universal-Script-Update-script-hitbox-9326"))()
   end,
})

local Section = PlayerTab:CreateSection("Scripts")


local PlayerTab = Window:CreateTab("The Scripts", nil) -- Title, Image
local Button = PlayerTab:CreateButton({
Name = "⚔️BladeBall⚔️ Hub that has many other games Too",
   Callback = function()
      loadstring(game:HttpGet("https://raw.githubusercontent.com/PawsThePaw/Plutonium.AA/main/Plutonium.Loader.lua", true))()
   end,
})

local Button = PlayerTab:CreateButton({
   Name = "🏀Basketball Legends🏀",
      Callback = function()
         loadstring(game:HttpGet("https://raw.githubusercontent.com/vnausea/absence-mini/refs/heads/main/absencemini.lua"))()
      end,
   })


local Button = PlayerTab:CreateButton({
   Name = "🚪Doors🚪",
      Callback = function()
         loadstring(game:HttpGet("https://raw.githubusercontent.com/KINGHUB01/BlackKing-obf/main/Doors%20Blackking%20And%20BobHub"))()
      end,
   })

 
   local Button = PlayerTab:CreateButton({
      Name = "🤚Slap Battles🤚",
         Callback = function()
            loadstring(game:HttpGet("https://raw.githubusercontent.com/DonjoScripts/Public-Scripts/refs/heads/Slap-Battles/Mastery-HelperGui"))()
         end,
      })


 
      local Button = PlayerTab:CreateButton({
         Name = "🔒Emotes🔒",
            Callback = function()
               loadstring(game:HttpGet(('https://pastebin.com/raw/1p6xnBNf'),true))()
            end,
         })
   

         local Button = PlayerTab:CreateButton({
            Name = "🐟Fisch🐟",
               Callback = function()
                  loadstring(game:HttpGet("https://raw.githubusercontent.com/Efe0626/RaitoHub/refs/heads/main/Script"))()
               end,
            })



            local Button = PlayerTab:CreateButton({
               Name = "🔫Arsenal🔫",
                  Callback = function()
                     loadstring(game:HttpGet("https://raw.githubusercontent.com/Nickyangtpe/Vapa-v2/refs/heads/main/Vapav2-Arsenal.lua", true))()
                  end,
               })

          

               local Button = PlayerTab:CreateButton({
                  Name = "🔫Rivals🔫",
                     Callback = function()
                        loadstring(game:HttpGet("https://api.luarmor.net/files/v3/loaders/1cd6fc0d685d8dcae4a3c05f01182061.lua"))()
                     end,
                  })


                  local Button = PlayerTab:CreateButton({
                     Name = "🏀Hoopz🏀",
                        Callback = function()
                           loadstring(game:HttpGet("https://raw.githubusercontent.com/Brothatslit5/Hoopz-Aimbot-Version-1.2/main/V1.2"))();
                        end,
                     })


 local Button = PlayerTab:CreateButton({
               Name = "🏈FF2🏈",
                  Callback = function()
                     loadstring(game:HttpGet("https://api.luarmor.net/files/v3/loaders/7b4f22e1726966f40c91521aaeb11953.lua"))()
                  end,
               })


                  
                           
               local Button = PlayerTab:CreateButton({
                  Name = "🏈NFL Universe Football🏈 This one has auto catch every time and speed",
                     Callback = function()
                        loadstring(game:HttpGet("https://api.luarmor.net/files/v3/loaders/03624f832da93e45f8dc1d8234f7bfca.lua"))()
                     end,
                  })



               local PlayerTab = Window:CreateTab("Universe Football",) -- Title, Image
               local Button = PlayerTab:CreateButton({
                  Name = "🏈NFL Universe Football🏈 This has free Emotes!!!",
                     Callback = function()
                        loadstring(game:HttpGet("https://raw.githubusercontent.com/IAmJamal10/Scripts/refs/heads/main/Football"))()
                     end,
                  })



                  
               local Button = PlayerTab:CreateButton({
                  Name = "🏈NFL Universe Football🏈 This one has auto catch every time and speed",
                     Callback = function()
                        loadstring(game:HttpGet("https://api.luarmor.net/files/v3/loaders/03624f832da93e45f8dc1d8234f7bfca.lua"))()
                     end,
                  })


            
