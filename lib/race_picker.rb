class RacePicker
  RACES = {
    "1" => {
      "Name"             => "Dwarf",
      "AbilityIncreases" => {
      },
      "Subraces" => {
        "1" => {
          "Name" => "Hill Dwarf"
          "AbilityIncreases" => {
          },
        },
        "2" => {
          "Name" => "Mountain Dwarf"
          "AbilityIncreases" => {
          },
        }
      }
    },
    "2" => {
      "Name"     => "Elf",
      "AbilityIncreases" => {
      },
      "Subraces" => {
        "1" => {
          "Name" => "Dark Elf"
          "AbilityIncreases" => {
          },
        },
        "2" => {
          "Name" => "Wood Elf"
          "AbilityIncreases" => {
          },
        },
        "3" => {
          "Name" => "High Elf"
          "AbilityIncreases" => {
          },
        }
      }
    },
    "3" => {
      "Name" => "Halfling",
      "AbilityIncreases" => {
      },
      "Subraces" => {
        "1" => {
          "Name" => "Lightfoot Halfling"
          "AbilityIncreases" => {
          },
        },
        "2" => {
          "Name" => "Stout Halfling"
          "AbilityIncreases" => {
          },
        }
      }
    },
    "4" => {
      "Name" => "Human"
      "AbilityIncreases" => {
      },
    },
    "5" => {
      "Name" => "Dragonboard"
      "AbilityIncreases" => {
      },
    },
    "6" => {
      "Name" => "Gnome",
      "AbilityIncreases" => {
      },
      "Subraces" => {
        "1" => {
          "Name" => "Rock Gnome"
          "AbilityIncreases" => {
          },
        },
        "2" => {
          "Name" => "Forest Gnome"
          "AbilityIncreases" => {
          },
        }
      }
    },
    "7" => {
      "Name" => "Half-Elf"
      "AbilityIncreases" => {
      },
    },
    "8" => {
      "Name" => "Half-Orc"
      "AbilityIncreases" => {
      },
    },
    "9" => {
      "Name" => "Tiefling"
      "AbilityIncreases" => {
      },
    }
  }

  def initialize
    @race          = get_race
    @abl_score_inc = {}
  end

  def get_header(type)
    [
      "@" + "-"*78 + "@",
      "| Select a #{type}-Race",
      "@" + "-"*78 + "@"
    ]
  end

  def display_race_table_prompt(type, data)
    puts get_header(type)

    data.each do |k,v|
      puts "|\t#{k}:\t#{v["Name"]}"
    end

    puts "@------------------------------------------------------------------------------@"
    printf "#{type}-Race: "
  end

  def get_race
    race    = ""
    subrace = ""

    until RACES.values.include?(race) do
      display_race_table_prompt("Main", RACES)
      race = RACES[STDIN.gets.chomp]
    end

    if race["Subraces"]
      display_race_table_prompt("Sub", race["Subraces"])

      until race["Subraces"].values.include?(subrace) do
        subrace = race["Subraces"][STDIN.gets.chomp]
      end

      return subrace["Name"]
    end

    race["Name"]
  end
end

race = RacePicker.new
puts race.inspect
