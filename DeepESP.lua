-- Made By Code X Dev ...

local Service = {};
local metatable = setmetatable(Service,{ 
__index = function(self,key) 
    return game:GetService(tostring(key)); 
end;});
    
local mt_service = setmetatable(Service,{__index = function(self,key)return game:GetService(tostring(key));end;});

local PlaceId = game.PlaceId;
local RunService = Service['RunService'];
local Players = Service['Players'];
local LocalPlayer = Players.LocalPlayer;
local CurrentCamera = workspace.CurrentCamera

local Library = {
    ['Settigs'] = {
        enabled = false,
        box = false, 
        boxColor = Color3.fromRGB(255, 255, 255),
        healthbar = false,
        nametag = false,
        nametagColor = Color3.fromRGB(143, 50, 232),
        distance = false,
        distanceColor = Color3.fromRGB(50, 198, 232),
        power = false,
        powerColor = Color3.fromRGB(220, 223, 38),
        oath = false,
        oathColor = Color3.fromRGB(255, 255, 255),
        guild = false,
        guildColor = Color3.fromRGB(255, 255, 255),
        tracer = false,
        tracerColor = Color3.fromRGB(255, 0, 0),
        healthtext = false,
        showMaxHealth = false,
        healthTextColor = Color3.fromRGB(50, 232, 50),
        chams = false,
        chamsColor = Color3.fromRGB(255, 0, 0),
        chamsOutlineColor = Color3.fromRGB(255, 0, 0),
        uselimitDistance = false,
        limitDistance = 500,
        entity_enabled = false,
        entity_ShowHealth = false,
        entity_ShowDistance = false,
        entity_limitDistance = 15000,
        entity_TextColor  = Color3.fromRGB(255, 255, 255),
        unopened_Chests = false,
    },
}


if getgenv().LoadCustomDrawing then 
    loadstring(game:HttpGet("https://raw.githubusercontent.com/CodexHubX/CodexHubX/refs/heads/main/Module/Drawing.lua"))();
end;

local Settigs = Library.Settigs;
local functions = setmetatable(Library,{
    __call = function(self,...)
        return getmetatable(self)
    end,

    newquad = function(color ,thickness)
        local quad = Drawing.new("Quad")
        quad.Color = color
        quad.Filled = false
        quad.Visible = false
        quad.Thickness = thickness
        quad.Transparency = 1
        return quad
    end,

    newline = function(color ,thickness) 
        local line = Drawing.new("Line")
        line.Visible = false
        line.Color = color 
        line.Thickness = thickness
        line.Transparency = 1
        return line
    end,

    newtext = function(text, color , size) 
        local Text = Drawing.new("Text")

        Text.Visible = false
        Text.Center = true
        Text.Outline = true
        Text.Font = 1
        Text.Color = color
        Text.Size = size
        Text.Text = tostring(text)

        return Text
    end,

    setquadpoint = function(Quad,onscreenPosition,height)
        Quad.PointA = Vector2.new(onscreenPosition.X + height, onscreenPosition.Y - height*2);
        Quad.PointB = Vector2.new(onscreenPosition.X - height, onscreenPosition.Y - height*2);
        Quad.PointC = Vector2.new(onscreenPosition.X - height, onscreenPosition.Y + height*2);
        Quad.PointD = Vector2.new(onscreenPosition.X + height, onscreenPosition.Y + height*2);
    end,
})  

local function GetWeapon(playerName)
    for int,weapon in next, ViewModels:GetChildren() do 
        if weapon.Name == 'FirstPerson' then continue end;
        if not weapon.Name:find(playerName) then continue end;
        
        return weapon.Name:split('- ')[2];
    end;

    return 'None';
end;

function Library.AddPlayer(player)
     local asset = functions();
     local object = {
        ['class'] = 'Player',
        ['drawing'] = {},
        ['player'] = player,
        ['name'] = player.Name,
        ['userid'] = player.UserId,
        ['highlight'] = nil,
        ['displayname'] = nil,
        ['connections'] = {},
        ['PlayerOath'] = 'None',
     };

     object.drawing.box = asset.newquad(Color3.fromRGB(255, 0, 0),1);
     object.drawing.black = asset.newquad(Color3.fromRGB(255, 0, 0),1);

     object.drawing._healthbar = asset.newline(Color3.fromRGB(255, 255, 255),1);
     object.drawing._greenhealth = asset.newline(Color3.fromRGB(255, 255, 255),1);
 
     object.drawing.helath_label = asset.newtext('',Color3.fromRGB(255, 255, 255),12);
     object.drawing.name_label  = asset.newtext('',Color3.fromRGB(255, 255, 255),12);
     object.drawing.distance_label  = asset.newtext('',Color3.fromRGB(255, 255, 255),12);

     object.drawing.power_label  = asset.newtext('',Color3.fromRGB(255, 255, 255),12);
     object.drawing.oath_label  = asset.newtext('',Color3.fromRGB(255, 255, 255),12);
     object.drawing.guild_label  = asset.newtext('',Color3.fromRGB(255, 255, 255),12);

     object.drawing.line = asset.newline(Color3.fromRGB(255, 255, 255),1);
     object.drawing.blackline = asset.newline(Color3.fromRGB(255, 255, 255),2);

     if (player:FindFirstChild('Backpack')) then 
        for _,v in next, player:FindFirstChild('Backpack'):GetChildren() do
            if (v:IsA('Folder') and v.Name:find('Talent:Oath')) then
                object.PlayerOath = v.Name:split(':Oath: ')[2]
            end;
        end;
    end;

    function object.Toggle(value)

        for int,drawing in next, object.drawing do 
            if not drawing then continue end;
            if drawing.Visible then drawing.Visible = value;end;
        end;
    end;

     function object.Visible(value)
        if not value then 
            return object.Toggle(false);
        end;

        object.drawing.box.Visible = Settigs.box;
        object.drawing.black.Visible = Settigs.box;

        object.drawing._healthbar.Visible = Settigs.healthbar;
        object.drawing._greenhealth.Visible = Settigs.healthbar;
    
        object.drawing.helath_label.Visible = Settigs.healthtext;
        object.drawing.name_label.Visible = Settigs.nametag;
        object.drawing.distance_label.Visible = Settigs.distance;

        object.drawing.power_label.Visible  = Settigs.power;
        object.drawing.oath_label.Visible  = Settigs.oath;
        object.drawing.guild_label.Visible  = Settigs.guild;
   
        object.drawing.line.Visible = Settigs.tracer;
        object.drawing.blackline.Visible = Settigs.tracer;
     end;

     local function updater()

         if not player or not player.Character or not Settigs.enabled then 
            return object.Visible(false)
         end;

         local character = player.Character;
         local humanoid = character:FindFirstChildOfClass('Humanoid');
         local rootPart = humanoid and humanoid.RootPart;

         if not humanoid then 
            return object.Visible(false)
         end;

         local onscreenPosition, onscreen
         local height;
         local headOnscreen;
         local distance_check;

         if not rootPart then 
            local map_pos = player.Character:GetAttribute('MapPos')

            if (not map_pos) then 
                return object.Visible(false);
            end;
            
            onscreenPosition,onscreen = CurrentCamera:WorldToViewportPoint(Vector3.new(map_pos.X,LocalPlayer.Character.HumanoidRootPart.Position.Y,map_pos.Z));
            distance_check = Vector3.new(map_pos.X,LocalPlayer.Character.HumanoidRootPart.Position.Y,map_pos.Z);
            headOnscreen = CurrentCamera:WorldToViewportPoint(Vector3.new(map_pos.X,LocalPlayer.Character.Head.Position.Y,map_pos.Z));
            height = math.clamp((Vector2.new(headOnscreen.X, headOnscreen.Y) - Vector2.new(onscreenPosition.X, onscreenPosition.Y)).magnitude, 2, math.huge); 
        else 

            onscreenPosition,onscreen = CurrentCamera:WorldToViewportPoint(rootPart.Position);
            distance_check = rootPart.Position
            headOnscreen = CurrentCamera:WorldToViewportPoint(character:FindFirstChild('Head').Position);
            height = math.clamp((Vector2.new(headOnscreen.X, headOnscreen.Y) - Vector2.new(onscreenPosition.X, onscreenPosition.Y)).magnitude, 2, math.huge); 
         end;

         if humanoid.Health <= 0 then 
            return object.Visible(false)
         end;

         --local onscreenPosition, onscreen = CurrentCamera:WorldToViewportPoint(rootPart.Position);
         --local head = character:FindFirstChild('Head');

         if not onscreen then 
            return object.Visible(false);
         end;

         local distance = LocalPlayer:DistanceFromCharacter(distance_check);
         --local headOnscreen = CurrentCamera:WorldToViewportPoint(head_pos);

         if Settigs.uselimitDistance and distance > Settigs.limitDistance then 
            return object.Visible(false);
         end;
         
        --  if getgenv().Duelers and not table.find(getgenv().Duelers,player) then 
        --     return object.Visible(false);
        --  end;
         

        -- local height = math.clamp((Vector2.new(headOnscreen.X, headOnscreen.Y) - Vector2.new(onscreenPosition.X, onscreenPosition.Y)).magnitude, 2, math.huge);
         object.Visible(true);

         asset.setquadpoint(object.drawing.box,onscreenPosition,height);
         asset.setquadpoint(object.drawing.black,onscreenPosition,height);
         
         object.drawing.box.Color = Settigs.boxColor; 
         object.drawing.black.Color = Settigs.boxColor;

        --  if not object.highlight or not object.highlight.Parent then 
        -- 	object.highlight = Instance.new("Highlight");
        -- 	object.highlight.Parent = character;
        -- 	warn('create Highlight')
        --  end;
        
        --  object.highlight.FillColor = Settigs.chamsColor;
        --  object.highlight.OutlineColor = Settigs.chamsOutlineColor;
         
         local bar = (Vector2.new(onscreenPosition.X - height, onscreenPosition.Y - height*2) - Vector2.new(onscreenPosition.X - height, onscreenPosition.Y + height*2)).magnitude;
         local healthoffset = humanoid.Health/humanoid.MaxHealth * bar;

         -- // Health Bar
 
         object.drawing._greenhealth.From = Vector2.new(onscreenPosition.X - height - 4, onscreenPosition.Y + height*2);
         object.drawing._greenhealth.To = Vector2.new(onscreenPosition.X - height - 4, onscreenPosition.Y + height*2 - healthoffset);

         object.drawing._healthbar.From = Vector2.new(onscreenPosition.X - height - 4, onscreenPosition.Y + height*2);
         object.drawing._healthbar.To = Vector2.new(onscreenPosition.X - height - 4, onscreenPosition.Y - height*2);
         object.drawing._greenhealth.Color = Color3.fromRGB(255, 0, 0):lerp(Color3.fromRGB(0, 255, 0), humanoid.Health/humanoid.MaxHealth);

         -- // Name Tag 
         local vector_convert_name = Vector2.new((object.drawing.box.PointA.X + object.drawing.box.PointB.X) / 2,(object.drawing.box.PointA.Y + object.drawing.box.PointB.Y) / 2);

         object.drawing.name_label.Text = object.name;
         object.drawing.name_label.Position = Vector2.new(vector_convert_name.X,vector_convert_name.Y - 15); 
         object.drawing.name_label.Color = Settigs.nametagColor;

         -- // Health & MaxHealth Text

         object.drawing.helath_label.Text = tostring(humanoid.Health):split('.')[1]..' hp';
         object.drawing.helath_label.Position = object.drawing._greenhealth.To + Vector2.new(-20,0)
         object.drawing.helath_label.Color = Settigs.healthTextColor;

         -- // Distance Text
         local vector_convert_distance = Vector2.new((object.drawing.box.PointC.X + object.drawing.box.PointD.X) / 2,(object.drawing.box.PointC.Y + object.drawing.box.PointD.Y) / 2)

         object.drawing.distance_label.Text = tostring(distance):split('.')[1]..' studs';
         object.drawing.distance_label.Position = Vector2.new(vector_convert_distance.X,vector_convert_distance.Y + 5);
         object.drawing.distance_label.Color = Settigs.distanceColor;

        --  if not Settigs.weapon then  
        --     object.drawing.weapon_label.Position = Vector2.new(vector_convert_distance.X,vector_convert_distance.Y + 5);
        --  else 
        --     object.drawing.weapon_label.Position = object.drawing.distance_label.Position  + Vector2.new(0,13);
        --  end;   

        --  object.drawing.weapon_label.Text = GetWeapon(object['name'])
        --  object.drawing.weapon_label.Color = Settigs.weaponColor;

         -- // Tracer
         object.drawing.line.From  = Vector2.new(CurrentCamera.ViewportSize.X*0.5, CurrentCamera.ViewportSize.Y);
         object.drawing.blackline.From = Vector2.new(CurrentCamera.ViewportSize.X*0.5, CurrentCamera.ViewportSize.Y);

         object.drawing.line.To = Vector2.new(onscreenPosition.X, onscreenPosition.Y + height*2);
         object.drawing.blackline.To = Vector2.new(onscreenPosition.X, onscreenPosition.Y + height*2);
         object.drawing.line.Color = Settigs.tracerColor;
         object.drawing.blackline.Color = Settigs.tracerColor;

          -- // Power
          object.drawing.power_label.Text = 'Power: '..tostring(player.Character:GetAttribute('Level'));                  
          object.drawing.power_label.Color = Settigs.powerColor;
          
          if (Settigs.nametag) then 
              object.drawing.power_label.Position = object.drawing.name_label.Position + Vector2.new(0,-13) 
          else 
              object.drawing.power_label.Position = Vector2.new(vector_convert_name.X,vector_convert_name.Y - 15); 
          end;

          -- // Guild
          local guild = player:GetAttribute('Guild');

          if (not guild or guild == '') then
              guild = 'None'
          end;

          object.drawing.guild_label.Text = 'Guid: '..tostring(guild);             
          object.drawing.guild_label.Color = Settigs.guildColor;

          if (Settigs.distance) then 
              object.drawing.guild_label.Position = object.drawing.distance_label.Position + Vector2.new(0,13);
          else 
              object.drawing.guild_label.Position = Vector2.new(vector_convert_distance.X,vector_convert_distance.Y + 5);
          end;

          if (Settigs.oath) then 
              object.drawing.oath_label.Text = 'Oath: '..tostring(object.PlayerOath);
          else 
              object.drawing.oath_label.Text = 'Oath: None';
          end;
           
          if (Settigs.guild and Settigs.distance) then 
              object.drawing.oath_label.Position = object.drawing.guild_label.Position + Vector2.new(0,13)
          elseif (Settigs.distance and not Settigs.guild) then 
              object.drawing.oath_label.Position = object.drawing.distance_label.Position + Vector2.new(0,13);
          elseif (not Settigs.distance and Settigs.guild) then 
              object.drawing.oath_label.Position = object.drawing.guild_label.Position + Vector2.new(0,13)
          else 
              object.drawing.oath_label.Position = Vector2.new(vector_convert_distance.X,vector_convert_distance.Y + 5);
          end;

          object.drawing.oath_label.Color = Settigs.oathColor;
     end;

    function object.destroy()
        for _,connection in next, object.connections do 
            if not connection then continue end;
            connection:Disconnect()
            connection = nil;
        end;

        -- if object.highlight then 
        -- 	object.highlight:Destroy();
        -- end;

        for _,drawing in next, object.drawing do  drawing:Remove();drawing = nil;end;
    end;

    object.connections.updater = RunService.Heartbeat:Connect(function(Time)
        updater();
    end);

    object.connections.ancestrychange = object.player.AncestryChanged:Connect(function(_,parent)
        if parent then return end; 
        object.destroy();
    end);

    return object;
end;


-- entity_enabled
-- entity_ShowHealth
-- entity_ShowDistance
-- entity_TextColor
-- entity_limitDistance

function Library.AddEntity(Instance)
    local asset = functions();

    local object = {
       ['class'] = 'Entity',
       ['drawing'] = {
            label = asset.newtext('',Color3.fromRGB(255, 255, 255),12),
       },
       ['instance'] = Instance,
       ['name'] = (Instance.Parent and Instance.Parent:GetAttribute('MOB_rich_name')) or Instance.Parent.Name,
       ['uuid'] = 'uid_'..tostring(math.random(100000,1000000)),
       ['connections'] = {},
    };

    local function updater()
        if not object.instance then return end;

        if not Settigs.entity_enabled or not object.instance or not object.instance.Parent then 
            object.drawing.label.Visible = false;
            return;
        end;

        local distance = LocalPlayer:DistanceFromCharacter(object.instance.Position);

        if distance > Settigs.entity_limitDistance then 
            object.drawing.label.Visible = false;
            return;
        end;

        local instance, onscreen = CurrentCamera:WorldToViewportPoint(object.instance.Position);
        if not onscreen then  object.drawing.label.Visible = false;return end;

        local humanoid = object.instance.Parent:FindFirstChildOfClass('Humanoid')

        if not humanoid then 
            object.drawing.label.Visible = false;
            return;
        end;

        object.drawing.label.Visible = true;
        object.drawing.label.Position = Vector2.new(instance.X,instance.Y);
        object.drawing.label.Color = Settigs.entity_TextColor;

        if Settigs.entity_ShowDistance and Settigs.entity_ShowHealth then 
            object.drawing.label.Text = '['..tostring(math.floor(humanoid.Health))..'/'..tostring(math.floor(humanoid.MaxHealth))..']['..tostring(object.name)
            ..']['..tostring(math.floor(distance))..' away]'

        elseif Settigs.entity_ShowHealth and not Settigs.entity_ShowDistance then 
            object.drawing.label.Text = '['..tostring(math.floor(humanoid.Health))..'/'..tostring(math.floor(humanoid.MaxHealth))..']['..tostring(object.name)..']'

        elseif Settigs.entity_ShowDistance and not Settigs.entity_ShowHealth then 
            object.drawing.label.Text = '['..tostring(object.name)..']['..tostring(math.floor(distance))..' away]'
            
        else 
            object.drawing.label.Text = '['..tostring(object.name)..']'
        end;
    end;

    function object.destroy()

        for _,connection in next, object.connections do 
            if not connection then continue end;
            connection:Disconnect()
            connection = nil;
        end;

        if object.Enabled then 
            object.Enabled = function() return end;
        end;

        return object.drawing.label:Remove();
    end;

    object.connections.updater = RunService.Heartbeat:Connect(function(Time)
        updater();
    end);

    object.connections.ancestrychange = object.instance.AncestryChanged:Connect(function(_,parent)
        if parent then return end; 

        object.destroy();
    end);

    return object;
end;

function Library.AddInstance(Instance,Name)
    local asset = functions();

    local object = {
       ['Settigs'] = {
            Color = Color3.fromRGB(255, 255, 255),
            ShowDistance = false,
            UseLimitDistance = false,
            LimitDistance = 1000,
       },
       ['class'] = 'Instance',
       ['drawing'] = {
            label = asset.newtext('',Color3.fromRGB(255, 255, 255),12),
       },
       ['instance'] = Instance,
       ['name'] = Name or Instance.Name,
       ['uuid'] = 'uid_'..tostring(math.random(100000,1000000)),
       ['connections'] = {},
    };

    local function updater()
        if not object.instance then return end;
        local distance = LocalPlayer:DistanceFromCharacter(object.instance.Position);
        local settigs = object.Settigs;

        if settigs.UseLimitDistance and distance > settigs.LimitDistance then 
            object.drawing.label.Visible = false;
            return;
        end;

        local instance, onscreen = CurrentCamera:WorldToViewportPoint(object.instance.Position);
        if not onscreen then  object.drawing.label.Visible = false;return end;

        object.drawing.label.Visible = true;
        object.drawing.label.Position = Vector2.new(instance.X,instance.Y);
        object.drawing.label.Color = settigs.Color;

        if settigs.ShowDistance then 
            object.drawing.label.Text = tostring(object.name)..' ['..tostring(distance):split('.')[1]..' away]';
            return;
        end;

        object.drawing.label.Text = tostring(object.name);
    end;

    function object.destroy()
        for _,connection in next, object.connections do 
            if not connection then continue end;
            connection:Disconnect()
            connection = nil;
        end;

        if object.Enabled then 
            object.Enabled = function() return end;
        end;

        return object.drawing.label:Remove();
    end;

    function object.Enabled(value)
        if not value then 
            if not object.connections.updater then 
                object.drawing.label.Visible = false;
                return;
            end;

            object.connections.updater:Disconnect();
            object.drawing.label.Visible = false;
            return;
        end;

        object.connections.updater = RunService.Heartbeat:Connect(function(Time)
            updater();
        end);
    end;
    
    object.connections.ancestrychange = object.instance.AncestryChanged:Connect(function(_,parent)
        if parent then return end; 

        object.destroy();
    end);

    return object;
end;

for _,player in next, Players:GetPlayers() do 
    if (player ~= LocalPlayer) then 
        Library.AddPlayer(player);
    end;
end;

Players.PlayerAdded:Connect(function(player)
    Library.AddPlayer(player);
end);


-- for i,v in next, workspace.Live:GetChildren() do 
--     if not Players:FindFirstChild(v.Name) and v:FindFirstChild('HumanoidRootPart') then 
--         Library.AddEntity(v.HumanoidRootPart)
--     end;
-- end;

--Library.AddEntity(Instance)
return Library;
