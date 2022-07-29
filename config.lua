--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- SCRIPT BY REDYY#0449
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

Config = {}

Config.Options = {
    ['spawnpoint_blocked'] = 'Another vehicle is taking the spawn place.',  -- message when spawn_point is blocked by other vehicle.
    ['no_money'] = 'You dont have enought money to rent the vehicle.', -- message when don't have money.
}

Config.Locations = {
    ['lossantosavenue'] = { -- name of the location, you can put whatever you like.
        coords = vector3(-1027.47,-2743.46,20.16), -- coord for the menu.
        spawn_coords = {x =-1024.80, y =-2734.81, z=20.09, h=243.77}, -- coord where vehicle will spawn.
        marker = {
            key = 38, -- key to open the menu. Default E
            type = 2, -- type of marker.
            size  = {x = 0.5, y = 0.5, z = 0.5},  -- size of marker.
            color = {r = 204, g = 204, b = 0}, -- color of marker.
            text = '[~g~E~w~] Rent Vehicle' -- text of marker.
        },
        blip = {
            name = 'Rent Vehicle', -- name of the blip in map.
            sprite = 523, -- sprite of the blip.
            scale = 0.8, -- scale of the.
            color = 2 -- color of the. 
        }
    },
    ['location2'] = {
        coords = vector3(-239.14,-978.44,29.27),
        spawn_coords = {x =-233.49, y =-982.20, z=29.16, h=158.07},
        marker = {
            type = 2, 
            size  = {x = 0.5, y = 0.5, z = 0.5},
            color = {r = 204, g = 204, b = 0}, 
            text = '[~g~E~w~] Rent Vehicle'
        },
        blip = {
            name = 'Rent Vehicle', 
            sprite = 523, 
            scale = 0.8,
            color = 2
        }
    },
}


Config.Vehicles = {
    ['zentorno'] = { -- vehicle spawn model name.
        label = 'mercedes amg', -- name of vehicle in menu.
        description = 'description', -- description of vehicle in menu.
        image_name = 'amg', -- image name in html/assets folder.
        -- IMAGE RESOLUTION --
        -- 310x250 Pixels --
        -- IMAGE RESOLUTION --
        price = 1000, -- price of the vehicle.
        type = 'car' -- type of the vehicle.
    },
    ['17r35'] = { -- model name.
        label = 'Nissan Gtr', -- name of vehicle in menu.
        description = 'description', -- description of vehicle in menu.
        image_name = 'gtr', -- image name in html/assets folder.
        price = 10000, -- price of the vehicle.
        type = 'car' -- type of the vehicle.
    },
    ['bmw'] = { 
        label = 'Bmw s1000',
        description = 'description',
        image_name = 'bmw',
        price = 2000,
        type = 'bike'
    },
    ['bike'] = { 
        label = 'Bicycle',
        description = 'description',
        image_name = 'bike',
        price = 200,
        type = 'bicycle'
    },
}



