RY = {}

RY.Options = {
    FrameWork = 'esx', -- esx or qb

    enableRentTimer = true, 
    rentTime = 120,

    priceMaxPerformance = 1000,
    refundMoneyWhenDelivered = true,
    deleteVehicleWhenFinished = true, -- delete vehicle when rent time is finished and not delivered? Default true
    deleteTime = 25000, -- time in MS that vehicle will be deleted if 'deleteVehicleWhenFinished' is active and after rent time is finished. 
    -- Default 25000MS | 25Seconds. 
    
    oxTarget = {
        enable = true, -- if false it will enable markers/3dtext
        icons = {
            menu = 'fa-solid fa-cube',
            returnMenu = 'fa-solid fa-cube'
        } ,
        labels = {
            menu = 'Vehicle Rental',
            returnMenu = 'Return Vehicle'
        }
    }
}

RY.Messages = {
    returnSuccess = "Successfully returned the vehicle, thank you!",
    returnError  = "You need to be in the vehicle you rented.",
    noMoney = "You don't have enought money to rent the vehicle.",
    refund = "Received refund of",
    rentFinished = "Your rental time is up, thank you.",
    alreadyRented = "You already rented a vehicle."
}

RY.Locations = {
    ['rent1'] = {
        menuCoords = vector3(-1028.55, -2740.08, 20.16),
        returnVehicleCoords = vector3(-1032.65,-2732.00,20.16),
        vehicleSpawnCoords = {x =-1024.80, y =-2734.81, z=20.09, h=243.77},

        -- Markers
        markersConfig = {
            markerMenu = {
                useKey = 38, -- E
                markerType = 2,
                markerSize  = {x = 0.3, y = 0.3, z = 0.3}, 
                markerColor = {r = 255, g = 255, b = 255},
                markerText = '[ ~g~E~w~ ] Rent Vehicle'
            },
            markerReturnMenu = {
                useKey = 47, -- G
                markerType = 2,
                markerSize  = {x = 0.3, y = 0.3, z = 0.3}, 
                markerColor = {r = 255, g = 0, b = 0},
                markerText = '[ ~g~G~w~ ] Return Vehicle'
            }
        },

        -- Blips
        blipsConfig = {
            blipMenu = {
                blipName = 'Rent Vehicle',
                blipSprite = 523,
                blipScale = 0.8,
                blipColor = 2
            },
            blipReturnMenu = {
                blipName = 'Return rented Vehicle',
                blipSprite = 523,
                blipScale = 0.8,
                blipColor = 4
            }
        },

        -- Vehicles
        vehiclesConfig = {
            [1] = {
                vehicleModel = 'zentorno',
                vehicleLabel = 'Mercedes AMG',
                vehicleDescription = 'description example',
                vehicleRentalPrice = 1000,
                vehicleType = 'car',
                vehicleImageName = 'amg.png'
                -- IMAGE RESOLUTION --
                -- 310x250 Pixels --
                -- IMAGE RESOLUTION --
            },
            [2] = {
                vehicleModel = 'bati',
                vehicleLabel = 'BMW',
                vehicleDescription = 'description example',
                vehicleRentalPrice = 999,
                vehicleType = 'car',
                vehicleImageName = 'bmw.png'
            },
            [3] = {
                vehicleModel = 'feltzer2',
                vehicleLabel = 'Nissan GTR',
                vehicleDescription = 'description example',
                vehicleRentalPrice = 1000,
                vehicleType = 'car',
                vehicleImageName = 'gtr.png'
            },
            [4] = {
                vehicleModel = 'cruiser',
                vehicleLabel = 'Bicycle',
                vehicleDescription = 'description example',
                vehicleRentalPrice = 100,
                vehicleType = 'bicycle',
                vehicleImageName = 'bike.png'
            },
            --[[[5] = {
                vehicleModel = 'cruiser',
                vehicleLabel = 'Bicycle',
                vehicleDescription = 'description example',
                vehicleRentalPrice = 100,
                vehicleType = 'bicycle',
                vehicleImageName = 'bike.png'
            },]]--
        }
    },
    -- MORE EXAMPLES --
    --[['rent2'] = {
        menuCoords = vector3(-1028.55, -2740.08, 20.16),
        returnVehicleCoords = vector3(-1032.65,-2732.00,20.16),
        vehicleSpawnCoords = {x =-1024.80, y =-2734.81, z=20.09, h=243.77},

        markersConfig = {
            markerMenu = {
                useKey = 38, -- E
                markerType = 2,
                markerSize  = {x = 0.3, y = 0.3, z = 0.3}, 
                markerColor = {r = 255, g = 255, b = 255},
                markerText = '[ ~g~E~w~ ] Rent Vehicle'
            },
            markerReturnMenu = {
                useKey = 47, -- E
                markerType = 2,
                markerSize  = {x = 0.3, y = 0.3, z = 0.3}, 
                markerColor = {r = 255, g = 0, b = 0},
                markerText = '[ ~g~E~w~ ] Return Vehicle'
            }
        },

        blipsConfig = {
            blipMenu = {
                blipName = 'Rent Vehicle',
                blipSprite = 523,
                blipScale = 0.8,
                blipColor = 2
            },
            blipReturnMenu = {
                blipName = 'Return rented Vehicle',
                blipSprite = 523,
                blipScale = 0.8,
                blipColor = 4
            }
        },

        vehiclesConfig = {
            [1] = {
                vehicleModel = 'zentorno',
                vehicleLabel = 'Mercedes AMG',
                vehicleDescription = 'description example',
                vehicleRentalPrice = 1000,
                vehicleType = 'car',
                vehicleImageName = 'amg.png'
                -- IMAGE RESOLUTION --
                -- 310x250 Pixels --
                -- IMAGE RESOLUTION --
            },
            [2] = {
                vehicleModel = 't20',
                vehicleLabel = 'BMW',
                vehicleDescription = 'description example',
                vehicleRentalPrice = 1000,
                vehicleType = 'car',
                vehicleImageName = 'bmw.png'
            },
            [3] = {
                vehicleModel = 'zentorno',
                vehicleLabel = 'Nissan GTR',
                vehicleDescription = 'description example',
                vehicleRentalPrice = 1000,
                vehicleType = 'car',
                vehicleImageName = 'gtr.png'
            },
            [4] = {
                vehicleModel = 'cruiser',
                vehicleLabel = 'Bicycle',
                vehicleDescription = 'description example',
                vehicleRentalPrice = 1000,
                vehicleType = 'bicycle',
                vehicleImageName = 'amg.png'
            },
        }
    }, ]]--
}
