class RacePicker
  MENU_BORDER        = "@" + "-"*78 + "@"
  HALF_ELF_ABILITIES = [
    "Strength", "Dexterity", "Constitution", "Intelligence", "Wisdom"
  ]
  RACES = {
    "1" => {
      "Name"             => "Dwarf",
      "Speed"            => 25,
      "AbilityIncreases" => {
        "Constitution" => 2
      },
      "Subraces" => {
        "1" => {
          "Name"             => "Hill Dwarf",
          "AbilityIncreases" => {
            "Wisdom" => 1
          },
        },
        "2" => {
          "Name"             => "Mountain Dwarf",
          "AbilityIncreases" => {
            "Strength" => 2
          },
        }
      }
    },
    "2" => {
      "Name"             => "Elf",
      "Speed"            => 30,
      "AbilityIncreases" => {
        "Dexterity" => 2
      },
      "Subraces" => {
        "1" => {
          "Name"             => "Dark Elf",
          "AbilityIncreases" => {
            "Charisma" => 1
          },
        },
        "2" => {
          "Name"             => "Wood Elf",
          "Speed"            => 35,
          "AbilityIncreases" => {
            "Wisdom" => 1
          },
        },
        "3" => {
          "Name"             => "High Elf",
          "AbilityIncreases" => {
            "Intelligence" => 1
          },
        }
      }
    },
    "3" => {
      "Name"             => "Halfling",
      "Speed"            => 25,
      "AbilityIncreases" => {
        "Dexterity" => 2
      },
      "Subraces" => {
        "1" => {
          "Name"             => "Lightfoot Halfling",
          "AbilityIncreases" => {
            "Charisma" => 1
          },
        },
        "2" => {
          "Name"             => "Stout Halfling",
          "AbilityIncreases" => {
            "Constitution" => 1
          },
        }
      }
    },
    "4" => {
      "Name"             => "Human",
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
    "5" => {
      "Name"             => "Dragonborn",
      "Speed"            => 30,
      "AbilityIncreases" => {
        "Strength" => 2,
        "Charisma" => 1
      },
    },
    "6" => {
      "Name"             => "Gnome",
      "Speed"            => 25,
      "AbilityIncreases" => {
        "Intelligence" => 2,
      },
      "Subraces" => {
        "1" => {
          "Name"             => "Forest Gnome",
          "AbilityIncreases" => {
            "Dexterity" => 1
          },
        },
        "2" => {
          "Name"             => "Rock Gnome",
          "AbilityIncreases" => {
            "Constitution" => 1
          },
        },
      }
    },
    "7" => {
      "Name"             => "Half-Elf",
      "Speed"            => 30,
      "AbilityIncreases" => {
        "Charisma" => 2,
        # need logic to pick next 2 increases dynamically
      },
    },
    "8" => {
      "Name"             => "Half-Orc",
      "Speed"            => 30,
      "AbilityIncreases" => {
        "Strength"     => 2,
        "Constitution" => 1
      },
    },
    "9" => {
      "Name"             => "Tiefling",
      "Speed"            => 30,
      "AbilityIncreases" => {
        "Intelligence" => 1,
        "Charisma"     => 2
      },
    }
  }

  attr_accessor :race, :speed, :ability_increases

  def initialize
    @speed             = 0
    @ability_increases = {}
    @race              = set_race
  end
  
  def get_race_header
    [ MENU_BORDER, "| Select a Race", MENU_BORDER]
  end

  def display_race_table_prompt(data)
    puts get_race_header()
    data.each{|k,v| puts "|\t#{k}#{'.'*8}#{v["Name"]}" }

    printf "#{MENU_BORDER}\nRace: "
  end

  def get_half_elf_header
    [MENU_BORDER, "| Select a Ability to increase(+1)", MENU_BORDER]
  end

  def display_half_elf_prompt(data)
    puts get_half_elf_header()
    data.each.with_index{|v,i| puts "|\t#{i + 1}#{'.'*8}#{v}"}

    printf "#{MENU_BORDER}\nAbility: "
  end

  def set_half_elf_increases
    abilities = HALF_ELF_ABILITIES

    2.times do
      ability = ""
      until abilities.include?(ability) do
        display_half_elf_prompt(abilities)
        ability = abilities[STDIN.gets.chomp.to_i - 1]
      end

      @ability_increases[ability] = 1
      abilities.delete(ability)
    end
  end

  def apply_ability_increases(race)
    race["AbilityIncreases"].each { |k,v| @ability_increases[k] = v}

    set_half_elf_increases if race["Name"] == "Half-Elf"
  end

  def apply_speed(race)
    @speed = race["Speed"] if race["Speed"]
  end

  def get_race(races)
    race = ""

    until races.values.include?(race) do
      display_race_table_prompt(races)
      race = races[STDIN.gets.chomp]
    end

    race
  end

  def set_race
    race = get_race(RACES)
    apply_ability_increases(race)
    apply_speed(race)

    if race["Subraces"]
      race = get_race(race["Subraces"])
      apply_ability_increases(race)
      apply_speed(race)
    end

    race["Name"]
  end
end
