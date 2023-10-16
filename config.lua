Config = {}

Config.Options = {
    showTimer = true,
    timeRent = 30, -- seconds the player get when rent a vehicle. Default 120 seconds | 2 minutes.
    deleteVehicleWhenFinished = true, -- delete vehicle when rent time is finished and not delivered? Default true
    deleteTime = 25000, -- time in MS that vehicle will be deleted if 'deleteVehicleWhenFinished' is active and after rent time is finished. Default 25000MS | 25Seconds. 

    refundMoneyWhenDelivered = true,

    donthaveMoney = "You don't have enought money to rent the vehicle.", -- message when don't have money.
    spawnPointBlocked = "Another vehicle is taking the spawn place.",  -- message when spawnPoint is blocked by other vehicle.
    rentFinished = 'Your rental time is up, thank you.',
    returnSuccess = 'Successfully returned the vehicle, thank you!', -- message when return the vehicle is Successfully.
    returnError = 'You need to be in the vehicle you rented.', -- message when the player its not in the rented vehicle.
    cantRent = 'You already rented a vehicle', -- message when the player already have a rented vehicle.
}

Config.Locations = {
    ['rent1'] = {
        coords = vector3(-1028.55, -2740.08, 20.16),
        spawn_coords = {x =-1024.80, y =-2734.81, z=20.09, h=243.77}, -- coord where vehicle will spawn.
        return_coords = vector3(-1032.65,-2732.00,20.16), -- coord for return the vehicle.
        markers = {
            spawn = {
                key = 38, -- key to open the menu. Default E
                type = 2, -- type of marker.
                size  = {x = 0.3, y = 0.3, z = 0.3},  -- size of marker.
                color = {r = 255, g = 255, b = 255},  -- color of marker.
                text = '[ ~g~E~w~ ] Rent Vehicle', -- text of marker.
            },
            return_spot = {
                key = 47, -- key to open the menu. Default G
                type = 2, -- type of marker.
                size  = {x = 0.3, y = 0.3, z = 0.3},  -- size of marker.
                color = {r = 255, g = 0, b = 0},  -- color of marker.
                text = '[ ~r~G~w~ ] Return Vehicle', -- text of marker.
            }
        },
        blips = {
            spawn = {
                name = 'Rent Vehicle', -- name of the blip in map.
                sprite = 523, -- sprite of the blip.
                scale = 0.8, -- scale of the.
                color = 2 -- color of the. 
            },
            return_spot = {
                name = 'Return rented Vehicle', -- name of the return blip in map.
                sprite = 523, -- sprite of the return blip.
                scale = 0.8, -- scale of the return blip.
                color = 4 -- color of the return blip. 
            }
        },
        vehicles = {
            [1] = {
                model = 'zentorno', -- vehicle spawn model name.
                label = 'Mercedes AMG', -- name of vehicle in menu.
                description = 'description', -- description of vehicle in menu.
                image_name = 'amg.png', -- image name in html/assets folder.
                -- IMAGE RESOLUTION --
                -- 310x250 Pixels --
                -- IMAGE RESOLUTION --
                price = 1000, -- price of the vehicle.
                type = 'car' -- type of the vehicle.
            },
            [2] = {
                model = 't20', -- vehicle spawn model name.
                label = 'BMW', -- name of vehicle in menu.
                description = 'description', -- description of vehicle in menu.
                image_name = 'bmw.png', -- image name in html/assets folder.
                -- IMAGE RESOLUTION --
                -- 310x250 Pixels --
                -- IMAGE RESOLUTION --
                price = 1000, -- price of the vehicle.
                type = 'bike' -- type of the vehicle.
            },
            [3] = {
                model = 'zentorno', -- vehicle spawn model name.
                label = 'Nissan GTR', -- name of vehicle in menu.
                description = 'description', -- description of vehicle in menu.
                image_name = 'gtr.png', -- image name in html/assets folder.
                -- IMAGE RESOLUTION --
                -- 310x250 Pixels --
                -- IMAGE RESOLUTION --
                price = 1000, -- price of the vehicle.
                type = 'car' -- type of the vehicle.
            },
            [4] = {
                model = 'cruiser', -- vehicle spawn model name.
                label = 'Bicycle', -- name of vehicle in menu.
                description = 'description', -- description of vehicle in menu.
                image_name = 'bike.png', -- image name in html/assets folder.
                -- IMAGE RESOLUTION --
                -- 310x250 Pixels --
                -- IMAGE RESOLUTION --
                price = 1000, -- price of the vehicle.
                type = 'bicycle' -- type of the vehicle.
            },
        }
    },
    ['rent2'] = {
        coords = vector3(83.15, -1615.71, 29.58),
        spawn_coords = {x = 78.47, y =-1626.42, z=29.58, h=306.14}, -- coord where vehicle will spawn.
        return_coords = vector3(63.87, -1632.76, 29.41), -- coord for return the vehicle.
        markers = {
            spawn = {
                key = 38, -- key to open the menu. Default E
                type = 2, -- type of marker.
                size  = {x = 0.3, y = 0.3, z = 0.3},  -- size of marker.
                color = {r = 255, g = 255, b = 255},  -- color of marker.
                text = '[ ~g~E~w~ ] Rent Vehicle', -- text of marker.
            },
            return_spot = {
                key = 47, -- key to open the menu. Default G
                type = 2, -- type of marker.
                size  = {x = 0.3, y = 0.3, z = 0.3},  -- size of marker.
                color = {r = 255, g = 0, b = 0},  -- color of marker.
                text = '[ ~r~G~w~ ] Return Vehicle', -- text of marker.
            }
        },
        blips = {
            spawn = {
                name = 'Rent Vehicle', -- name of the blip in map.
                sprite = 523, -- sprite of the blip.
                scale = 0.8, -- scale of the.
                color = 2 -- color of the. 
            },
            return_spot = {
                name = 'Return rented Vehicle', -- name of the return blip in map.
                sprite = 523, -- sprite of the return blip.
                scale = 0.8, -- scale of the return blip.
                color = 4 -- color of the return blip. 
            }
        },
        vehicles = {
            [1] = {
                model = 't20', -- vehicle spawn model name.
                label = 't20', -- name of vehicle in menu.
                description = 'description', -- description of vehicle in menu.
                image_name = 'gtr.png', -- image name in html/assets folder.
                -- IMAGE RESOLUTION --
                -- 310x250 Pixels --
                -- IMAGE RESOLUTION --
                price = 1000, -- price of the vehicle.
                type = 'car' -- type of the vehicle.
            },
            [2] = {
                model = 't20', -- vehicle spawn model name.
                label = 't20', -- name of vehicle in menu.
                description = 'description', -- description of vehicle in menu.
                image_name = 'gtr.png', -- image name in html/assets folder.
                -- IMAGE RESOLUTION --
                -- 310x250 Pixels --
                -- IMAGE RESOLUTION --
                price = 1000, -- price of the vehicle.
                type = 'car' -- type of the vehicle.
            },
            [3] = {
                model = 't20', -- vehicle spawn model name.
                label = 't20', -- name of vehicle in menu.
                description = 'description', -- description of vehicle in menu.
                image_name = 'gtr.png', -- image name in html/assets folder.
                -- IMAGE RESOLUTION --
                -- 310x250 Pixels --
                -- IMAGE RESOLUTION --
                price = 1000, -- price of the vehicle.
                type = 'car' -- type of the vehicle.
            },
            [4] = {
                model = 't20', -- vehicle spawn model name.
                label = 't20', -- name of vehicle in menu.
                description = 'description', -- description of vehicle in menu.
                image_name = 'gtr.png', -- image name in html/assets folder.
                -- IMAGE RESOLUTION --
                -- 310x250 Pixels --
                -- IMAGE RESOLUTION --
                price = 1000, -- price of the vehicle.
                type = 'car' -- type of the vehicle.
            },
            [5] = {
                model = 't20', -- vehicle spawn model name.
                label = 't20', -- name of vehicle in menu.
                description = 'description', -- description of vehicle in menu.
                image_name = 'gtr.png', -- image name in html/assets folder.
                -- IMAGE RESOLUTION --
                -- 310x250 Pixels --
                -- IMAGE RESOLUTION --
                price = 1000, -- price of the vehicle.
                type = 'car' -- type of the vehicle.
            },
            [6] = {
                model = 't20', -- vehicle spawn model name.
                label = 't20', -- name of vehicle in menu.
                description = 'description', -- description of vehicle in menu.
                image_name = 'gtr.png', -- image name in html/assets folder.
                -- IMAGE RESOLUTION --
                -- 310x250 Pixels --
                -- IMAGE RESOLUTION --
                price = 1000, -- price of the vehicle.
                type = 'car' -- type of the vehicle.
            },
            [7] = {
                model = 't20', -- vehicle spawn model name.
                label = 't20', -- name of vehicle in menu.
                description = 'description', -- description of vehicle in menu.
                image_name = 'gtr.png', -- image name in html/assets folder.
                -- IMAGE RESOLUTION --
                -- 310x250 Pixels --
                -- IMAGE RESOLUTION --
                price = 1000, -- price of the vehicle.
                type = 'car' -- type of the vehicle.
            },
        }
    },
}