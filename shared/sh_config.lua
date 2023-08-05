Config = {}

-- Stuck Props Command --
Config.StuckPropCommand = {
    enable = true,
    command = 'propstuck'
}

-- Alocohl / Drunk Config --
Config.ReduceAlcoholCount = 30 -- Time between drinks to reduce the alcohol count (Set in Seconds)
Config.Drunk = {
    min = 2, -- Slightly drunk
    max = 4 -- Very drunk
}

-- Consumable Items --
Config.Consumables = {

    -- Food --
    ['bread'] = {
        type = 'food',
        fill = math.random(10,20),
        emote = 'eat',
        length = 5,
        effects = {
            heal = 5,
            stress = 0,
            armor = 0,
        }
    },
    ['sandwich'] = {
        type = 'food',
        fill = math.random(10,20),
        emote = 'eat',
        length = 5,
        effects = {
            heal = 5,
            stress = 0,
            armor = 0,
        }
    },
    ['apple'] = {
        type = 'food',
        fill = math.random(10,20),
        emote = 'eat',
        length = 5,
        effects = {
            heal = 5,
            stress = 0,
            armor = 0,
        }
    },
    ['cannedbeans'] = {
        type = 'food',
        fill = math.random(10,20),
        emote = 'eat',
        length = 5,
        effects = {
            heal = 5,
            stress = 0,
            armor = 0,
        }
    },
    ['chocolate'] = {
        type = 'food',
        fill = math.random(10,20),
        emote = 'eat',
        length = 5,
        effects = {
            heal = 5,
            stress = 0,
            armor = 0,
        }
    },

    -- Drinks --
    ['water'] = {
        type = 'drink',
        fill = math.random(10,20),
        emote = 'drink',
        length = 5,
        effects = {
            heal = 0,
            stress = 10,
            armor = 0,
        }
    },
    ['coffee'] = {
        type = 'drink',
        fill = math.random(10,20),
        emote = 'drink',
        length = 5,
        effects = {
            heal = 0,
            stress = 0,
            armor = 10,
        }
    },
    ['beer'] = {
        type = 'alcohol',
        fill = math.random(10,20),
        emote = 'beer',
        length = 5,
        effects = {
            heal = 0,
            stress = 0,
            armor = 10,
        }
    },
    ['whiskey'] = {
        type = 'alcohol',
        fill = math.random(10,20),
        emote = 'beer',
        length = 5,
        effects = {
            heal = 0,
            stress = 0,
            armor = 10,
        }
    },
    ['vodka'] = {
        type = 'alcohol',
        fill = math.random(10,20),
        emote = 'beer',
        length = 5,
        effects = {
            heal = 0,
            stress = 0,
            armor = 10,
        }
    },
}

Config.Smokes = {
    ['cigarette'] = {
        emote = 'cigarette',
        length = 15,
        effects = {
            heal = 0,
            stress = 0,
            armor = 10,
        }
    },
    ['cigar'] = {
        emote = 'cigar',
        length = 25,
        effects = {
            heal = 0,
            stress = 0,
            armor = 10,
        }
    },
}

--------------------------------------------

QRCore = exports['qr-core']:GetCoreObject()