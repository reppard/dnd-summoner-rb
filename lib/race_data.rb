module DnD
  RACES = {
    "Dwarf" => {
      "Speed"            => 25,
      "AbilityIncreases" => { "Constitution" => 2 },
      "Subraces" => {
        "Hill Dwarf" => {
          "AbilityIncreases" => { "Wisdom" => 1 }
        },
        "Mountain Dwarf" => {
          "AbilityIncreases" => { "Strength" => 2 }
        }
      }
    },
    "Elf" => {
      "Speed"            => 30,
      "AbilityIncreases" => { "Dexterity" => 2 },
      "Subraces" => {
        "Dark Elf" => {
          "AbilityIncreases" => { "Charisma" => 1 }
        },
        "Wood Elf" => {
          "Speed"            => 35,
          "AbilityIncreases" => { "Wisdom" => 1 }
        },
        "High Elf" => {
          "AbilityIncreases" => { "Intelligence" => 1 }
        }
      }
    },
    "Halfling" => {
      "Speed"            => 25,
      "AbilityIncreases" => { "Dexterity" => 2 },
      "Subraces" => {
        "Lightfoot Halfling" => {
          "AbilityIncreases" => { "Charisma" => 1 }
        },
        "Stout Halfling" => {
          "AbilityIncreases" => { "Constitution" => 1 }
        }
      }
    },
    "Human" => {
      "Speed"            => 30,
      "AbilityIncreases" => {
        "Strength"     => 1,
        "Dexterity"    => 1,
        "Constitution" => 1,
        "Intelligence" => 1,
        "Wisdom"       => 1,
        "Charisma"     => 1
      },
    },
    "Dragonborn" => {
      "Speed"            => 30,
      "AbilityIncreases" => { "Strength" => 2, "Charisma" => 1 }
    },
    "Gnome" => {
      "Speed"            => 25,
      "AbilityIncreases" => { "Intelligence" => 2 },
      "Subraces" => {
        "Forest Gnome" => {
          "AbilityIncreases" => { "Dexterity" => 1 }
        },
        "Rock Gnome" => {
          "AbilityIncreases" => { "Constitution" => 1 }
        }
      }
    },
    "Half-Elf" => {
      "Speed"            => 30,
      "AbilityIncreases" => { "Charisma" => 2 },
      "CustomAbilities" => {
        "Limit"     => 2,
        "Abilities" => [
          "Strength", "Dexterity", "Constitution", "Intelligence", "Wisdom"
        ]
      }
    },
    "Half-Orc" => {
      "Speed"            => 30,
      "AbilityIncreases" => { "Strength" => 2, "Constitution" => 1 }
    },
    "Tiefling" => {
      "Speed"            => 30,
      "AbilityIncreases" => { "Intelligence" => 1, "Charisma" => 2 }
    }
  }
end
