local addonName, addonTable = ...

-- Constants
addonTable.FRAME_BACKGROUND = "Interface\\DialogFrame\\UI-DialogBox-Background"
addonTable.BLIZZARD_FRAME_BACKGROUND = "Interface\\Tooltips\\UI-DialogBox-Background"
addonTable.FRAME_BORDER = "Interface\\ChatFrame\\ChatFrameBackground"
addonTable.CLASS_LIST = {"Warrior", "Paladin", "Hunter", "Rogue", "Priest", "Death Knight", "Shaman", "Mage", "Warlock",
                         "Druid"}
addonTable.MAIN_FRAME_TITLE = "Class Best In Slot"
addonTable.RIGHT_FRAME_TITLE = "Best In Slot Items for "
addonTable.LEFT_FRAME_TITLE = "Select Your Class"

addonTable.PHASES = {"PRE_RAID", "TIER_4", "TIER_5", "TIER_6"}

local DUNGEON_DATA = {
    ["The Shattered Halls"] = {
        name = "The Shattered Halls",
        id = 1,
        level = 70,
        type = "Dungeon",
        location = "Hellfire Peninsula",
        faction = "Horde",
        bossCount = 4,
        bosses = {{
            name = "Kargath Bladefist",
            id = 1
        }, {
            name = "Warbringer O'mrogg",
            id = 2
        }, {
            name = "Grand Warlock Nethekurse",
            id = 3
        }, {
            name = "Blood Guard Porung",
            id = 4
        }}
    },
    ["Hellfire Ramparts"] = {
        name = "Hellfire Ramparts",
        id = 1,
        level = 70,
        type = "Dungeon",
        location = "Hellfire Peninsula",
        faction = "Neutral",
        bossCount = 4,
        bosses = {{
            name = "Watchkeeper Gargolmar",
            id = 1
        }, {
            name = "Omor the Unscarred",
            id = 2
        }, {
            name = "Nekros Skullcrusher",
            id = 3
        }, {
            name = "Vazruden the Herald",
            id = 4
        }}
    },
    ["The Blood Furnace"] = {
        name = "The Blood Furnace",
        id = 1,
        level = 70,
        type = "Dungeon",
        location = "Hellfire Peninsula",
        faction = "Neutral",
        bossCount = 3,
        bosses = {{
            name = "Keli'dan the Breaker",
            id = 1
        }, {
            name = "Broggok",
            id = 2
        }, {
            name = "The Maker",
            id = 3
        }}
    },
    ["Mana-Tombs"] = {
        name = "Mana-Tombs",
        id = 1,
        level = 70,
        type = "Dungeon",
        location = "Terokkar Forest",
        faction = "Neutral",
        bossCount = 4,
        bosses = {{
            name = "Pandemonius",
            id = 1
        }, {
            name = "Tavarok",
            id = 2
        }, {
            name = "Ner'zhul",
            id = 3
        }, {
            name = "Nexus-Prince Shaffar",
            id = 4
        }}
    },
    ["Auchenai Crypts"] = {
        name = "Auchenai Crypts",
        id = 1,
        level = 70,
        type = "Dungeon",
        location = "Terokkar Forest",
        faction = "Neutral",
        bossCount = 4,
        bosses = {{
            name = "Shirrak the Dead Watcher",
            id = 1
        }, {
            name = "Exarch Maladaar",
            id = 2
        }, {
            name = "Avatar of the Martyred",
            id = 3
        }, {
            name = "K'ure",
            id = 4
        }}
    },
    ["Sethekk Halls"] = {
        name = "Sethekk Halls",
        id = 1,
        level = 70,
        type = "Dungeon",
        location = "Terokkar Forest",
        faction = "Neutral",
        bossCount = 4,
        bosses = {{
            name = "Darkweaver Syth",
            id = 1
        }, {
            name = "Talon King Ikiss",
            id = 2
        }, {
            name = "Anzu",
            id = 3
        }, {
            name = "Talon King Ikiss",
            id = 4
        }}
    },
    ["Shadow Labyrinth"] = {
        name = "Shadow Labyrinth",
        id = 1,
        level = 70,
        type = "Dungeon",
        location = "Terokkar Forest",
        faction = "Neutral",
        bossCount = 4,
        bosses = {{
            name = "Ambassador Hellmaw",
            id = 1
        }, {
            name = "Blackheart the Inciter",
            id = 2
        }, {
            name = "Grandmaster Vorpil",
            id = 3
        }, {
            name = "Muradin Bronzebeard",
            id = 4
        }}
    },
    ["Old Hillsbrad Foothills"] = {
        name = "Old Hillsbrad Foothills",
        id = 1,
        level = 70,
        type = "Dungeon",
        location = "Hillsbrad Foothills",
        faction = "Neutral",
        bossCount = 4,
        bosses = {{
            name = "Taretha",
            id = 1
        }, {
            name = "Captain Skarloc",
            id = 2
        }, {
            name = "Epoch Hunter",
            id = 3
        }, {
            name = "Dr. Weavil",
            id = 4
        }}
    },
    ["The Black Morass"] = {
        name = "The Black Morass",
        id = 1,
        level = 70,
        type = "Dungeon",
        location = "Tanaris",
        faction = "Neutral",
        bossCount = 4,
        bosses = {{
            name = "Chrono Lord Deja",
            id = 1
        }, {
            name = "Temporus",
            id = 2
        }, {
            name = "Aeonus",
            id = 3
        }, {
            name = "The Infinite Corruptor",
            id = 4
        }}
    },
    ["Hyjal Summit"] = {
        name = "Hyjal Summit",
        id = 1,
        level = 70,
        type = "Raid",
        location = "Hyjal",
        faction = "Neutral",
        bossCount = 5,
        bosses = {{
            name = "Rage Winterchill",
            id = 1
        }, {
            name = "Anetheron",
            id = 2
        }, {
            name = "Kaz'rogal",
            id = 3
        }, {
            name = "Azgalor",
            id = 4
        }, {
            name = "Archimonde",
            id = 5
        }}
    },
    ["The Steamvault"] = {
        name = "The Steamvault",
        id = 2,
        level = 70,
        type = "Dungeon",
        location = "Zangarmarsh",
        faction = "Alliance",
        bossCount = 4,
        bosses = {{
            name = "Hydromancer Thespia",
            id = 1
        }, {
            name = "Murmur",
            id = 2
        }, {
            name = "Warlord Kalithresh",
            id = 3
        }, {
            name = "Sanguinar the Bloodletter",
            id = 4
        }}
    },
    ["The Underbog"] = {
        name = "The Underbog",
        id = 3,
        level = 70,
        type = "Dungeon",
        location = "Zangarmarsh",
        faction = "Neutral",
        bossCount = 4,
        bosses = {{
            name = "Hungarfen",
            id = 1
        }, {
            name = "Ghaz'an",
            id = 2
        }, {
            name = "Swamplord Musel'ek",
            id = 3
        }, {
            name = "Earthbinder Rayge",
            id = 4
        }}
    },
    ["The Botanica"] = {
        name = "The Botanica",
        id = 4,
        level = 70,
        type = "Dungeon",
        location = "Tempest Keep",
        faction = "Neutral",
        bossCount = 5,
        bosses = {{
            name = "Commander Sarannis",
            id = 1
        }, {
            name = "High Botanist Freywinn",
            id = 2
        }, {
            name = "Laj",
            id = 3
        }, {
            name = "Warp Splinter",
            id = 4
        }, {
            name = "Captain Skarloc",
            id = 5
        }}
    },
    ["The Mechanar"] = {
        name = "The Mechanar",
        id = 5,
        level = 70,
        type = "Dungeon",
        location = "Tempest Keep",
        faction = "Neutral",
        bossCount = 4,
        bosses = {{
            name = "Gatewatcher Gyro-Copter",
            id = 1
        }, {
            name = "Gatewatcher Iron-Hand",
            id = 2
        }, {
            name = "Mechano-Lord Capacitus",
            id = 3
        }, {
            name = "Nethermancer Sepethrea",
            id = 4
        }, {
            name = "Pathaleon the Calculator",
            id = 5
        }}
    },
    ["The Arcatraz"] = {
        name = "The Arcatraz",
        id = 6,
        level = 70,
        type = "Dungeon",
        location = "Tempest Keep",
        faction = "Neutral",
        bossCount = 4,
        bosses = {{
            name = "Zereketh the Unbound",
            id = 1
        }, {
            name = "Dalliah the Doomsayer",
            id = 2
        }, {
            name = "Wrath-Scryer Soccothrates",
            id = 3
        }, {
            name = "Harbinger Skyriss",
            id = 4
        }}
    },
    ["The Black Temple"] = {
        name = "The Black Temple",
        id = 7,
        level = 70,
        type = "Raid",
        location = "Shadowmoon Valley",
        faction = "Neutral",
        bossCount = 9,
        bosses = {{
            name = "High Warlord Naj'entus",
            id = 1
        }, {
            name = "Supremus",
            id = 2
        }, {
            name = "Shade of Akama",
            id = 3
        }, {
            name = "Teron'gor",
            id = 4
        }, {
            name = "Gurtogg Bloodboil",
            id = 5
        }, {
            name = "Reliquary of Souls",
            id = 6
        }, {
            name = "Mother Shahraz",
            id = 7
        }, {
            name = "Illidari Council",
            id = 8
        }, {
            name = "Illidan Stormrage",
            id = 9
        }}
    },
    ["Karazhan"] = {
        name = "Karazhan",
        id = 8,
        level = 70,
        type = "Raid",
        location = "Deadwind Pass",
        faction = "Neutral",
        bossCount = 12,
        bosses = {{
            name = "Attumen the Huntsman",
            id = 1
        }, {
            name = "Moroes",
            id = 2
        }, {
            name = "Maiden of Virtue",
            id = 3
        }, {
            name = "Opera Event",
            id = 4
        }, {
            name = "The Curator",
            id = 5
        }, {
            name = "Terestian Illhoof",
            id = 6
        }, {
            name = "Shade of Aran",
            id = 7
        }, {
            name = "Netherspite",
            id = 8
        }, {
            name = "Prince Malchezaar",
            id = 9
        }, {
            name = "Nightbane",
            id = 10
        }, {
            name = "Chess Event",
            id = 11
        }}
    },
    ["Gruul's Lair"] = {
        name = "Gruul's Lair",
        id = 9,
        level = 70,
        type = "Raid",
        location = "Blade's Edge Mountains",
        faction = "Neutral",
        bossCount = 2,
        bosses = {{
            name = "High King Maulgar",
            id = 1
        }, {
            name = "Gruul the Dragonkiller",
            id = 2
        }}
    },
    ["Magtheridon's Lair"] = {
        name = "Magtheridon's Lair",
        id = 10,
        level = 70,
        type = "Raid",
        location = "Hellfire Peninsula",
        faction = "Neutral",
        bossCount = 1,
        bosses = {{
            name = "Magtheridon",
            id = 1
        }}
    },
    ["Serpentshrine Cavern"] = {
        name = "Serpentshrine Cavern",
        id = 11,
        level = 70,
        type = "Raid",
        location = "Zangarmarsh",
        faction = "Neutral",
        bossCount = 6,
        bosses = {{
            name = "Hydross the Unstable",
            id = 1
        }, {
            name = "The Lurker Below",
            id = 2
        }, {
            name = "Leotheras the Blind",
            id = 3
        }, {
            name = "Fathom-Lord Karathress",
            id = 4
        }, {
            name = "Morogrim Tidewalker",
            id = 5
        }, {
            name = "Lady Vashj",
            id = 6
        }}
    },
    ["Tempest Keep"] = {
        name = "Tempest Keep",
        id = 12,
        level = 70,
        type = "Raid",
        location = "Netherstorm",
        faction = "Neutral",
        bossCount = 4,
        bosses = {{
            name = "Al'ar",
            id = 1
        }, {
            name = "Solarian",
            id = 2
        }, {
            name = "Void Reaver",
            id = 3
        }, {
            name = "Kael'thas Sunstrider",
            id = 4
        }}
    }
}

addonTable.PHASED_ITEM_DATA = {
    DRUID = {
        PRE_RAID = {{
            itemID = 8345,
            location = "Leatherworking BoE - Crafted"
        }, {
            itemID = 27797,
            location = "H - " .. DUNGEON_DATA["Auchenai Crypts"].name .. " - " ..
                DUNGEON_DATA["Auchenai Crypts"].bosses[3].name
        }, {
            itemID = 31255,
            location = "World Drop - BoE"
        }, {
            itemID = 28204,
            location = DUNGEON_DATA["The Mechanar"].name .. " - " .. DUNGEON_DATA["The Mechanar"].bosses[5].name
        }, {
            itemID = 29246,
            location = "H - " .. DUNGEON_DATA["Old Hillsbrad Foothills"].name .. " - " ..
                DUNGEON_DATA["Old Hillsbrad Foothills"].bosses[3].name
        }, {
            itemID = 28396,
            location = DUNGEON_DATA["The Arcatraz"].name .. " - " .. DUNGEON_DATA["The Arcatraz"].bosses[2].name
        }, {
            itemID = 29247,
            location = "H - " .. DUNGEON_DATA["The Black Morass"].name .. " - " ..
                DUNGEON_DATA["The Black Morass"].bosses[2].name
        }, {
            itemID = 31544,
            location = "Showdown - Quest - Rexxar, V Na Riko Kosata"
        }, {
            itemID = 25686,
            location = "Leatherworking BoE - Crafted"
        }, {
            itemID = 24114,
            location = "Jewelcrafting BoE - Crafted"
        }, {
            itemID = 30834,
            location = "Lower City - Reputation - Exalted"
        }, {
            itemID = 31920,
            location = "H - Mana-Tombs - Yor"
        }, {
            itemID = 29383,
            location = "41 Badge of Justice"
        }, {
            itemID = 28034,
            location = DUNGEON_DATA["The Black Morass"].name .. " - " .. DUNGEON_DATA["The Black Morass"].bosses[2].name
        }, {
            itemID = 31334,
            location = "BoE World Drop"
        }, {
            itemID = 29390,
            location = "15 Badge of Justice"
        }},
        TIER_4 = {{
            itemID = 8345,
            location = "Leatherworking BoE - Crafted"
        }, {
            itemID = 29100,
            location = DUNGEON_DATA["Gruul's Lair"].name .. " - " .. DUNGEON_DATA["Gruul's Lair"].bosses[1].name
        }, {
            itemID = 28672,
            location = DUNGEON_DATA["Karazhan"].name .. " - " .. DUNGEON_DATA["Karazhan"].bosses[7].name
        }, {
            itemID = 29096,
            location = DUNGEON_DATA["Magtheridon's Lair"].name .. " - " ..
                DUNGEON_DATA["Magtheridon's Lair"].bosses[1].name
        }, {
            itemID = 29246,
            location = DUNGEON_DATA["Old Hillsbrad Foothills"].name .. " - " ..
                DUNGEON_DATA["Old Hillsbrad Foothills"].bosses[3].name
        }, {
            itemID = 28506,
            location = DUNGEON_DATA["Karazhan"].name .. " - " .. DUNGEON_DATA["Karazhan"].bosses[1].name
        }, {
            itemID = 28750,
            location = DUNGEON_DATA["Karazhan"].name .. " - " .. DUNGEON_DATA["Karazhan"].bosses[11].name
        }, {
            itemID = 28741,
            location = DUNGEON_DATA["Karazhan"].name .. " - " .. DUNGEON_DATA["Karazhan"].bosses[8].name
        }, {
            itemID = 28545,
            location = DUNGEON_DATA["Karazhan"].name .. " - " .. DUNGEON_DATA["Karazhan"].bosses[5].name
        }, {
            itemID = 24114,
            location = "Jewelcrafting BoE - Crafted"
        }, {
            itemID = 30834,
            location = "Lower City - Reputation - Exalted"
        }, {
            itemID = 28649,
            location = DUNGEON_DATA["Karazhan"].name .. " - " .. DUNGEON_DATA["Karazhan"].bosses[2].name
        }, {
            itemID = 29383,
            location = "41 Badge of Justice"
        }, {
            itemID = 28830,
            location = DUNGEON_DATA["Gruul's Lair"].name .. " - " .. DUNGEON_DATA["Gruul's Lair"].bosses[2].name
        }, {
            itemID = 28658,
            location = DUNGEON_DATA["Karazhan"].name .. " - " .. DUNGEON_DATA["Karazhan"].bosses[6].name
        }, {
            itemID = 29390,
            location = "15 Badge of Justice"
        }}
    },
    WARLOCK = {
        PRE_RAID = {},
        TIER_4 = {{
            itemID = 28963,
            location = "Prince Malchezaar - Karazhan"
        }, {
            itemID = 28762,
            location = "Prince Malchezaar - Karazhan"
        }, {
            itemID = 28967,
            location = "High King Maulgar - Gruul's Lair"
        }, {
            itemID = 28766,
            location = "High King Maulgar - Gruul's Lair"
        }, {
            itemID = 28964,
            location = "Magtheridon - Magtheridon's Lair"
        }, {
            itemID = 24250,
            location = "Tailoring BoE - Crafted"
        }, {
            itemID = 28968,
            location = "The Curator - Karazhan"
        }, {
            itemID = 28802,
            location = "Gruul - Gruul's Lair"
        }, {
            itemID = 29273,
            location = "25 Badge of Justice"
        }, {
            itemID = 28783,
            location = "Magtheridon - Magtheridon's Lair"
        }, {
            itemID = 24256,
            location = "Tailoring BoE - Crafted"
        }, {
            itemID = 24262,
            location = "Tailoring BoE - Crafted"
        }, {
            itemID = 21870,
            location = "Tailoring BoP"
        }, {
            itemID = 28753,
            location = "Karazhan - Chess Event"
        }, {
            itemID = 28793,
            location = "The Fall of Magtheridon - Quest"
        }, {
            itemID = 29370,
            location = "41 Badge of Justice"
        }, {
            itemID = 27683,
            location = "H - Slave Pens - Quagmirran"
        }},
        TIER_5 = {},
        TIER_6 = {}
    }
}
