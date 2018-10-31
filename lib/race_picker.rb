class RacePicker
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
  
  def get_header
    [
      "@" + "-"*78 + "@",
      "| Select a Race",
      "@" + "-"*78 + "@"
    ]
  end

  def display_race_table_prompt(data)
    puts get_header()

    data.each do |k,v|
      puts "|\t#{k}:\t#{v["Name"]}"
    end

    puts "@------------------------------------------------------------------------------@"
    printf "Race: "
  end

  def apply_ability_increases(race)
    race["AbilityIncreases"].each { |k,v| @ability_increases[k] = v}
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
