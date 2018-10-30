class RacePicker
  SUBRACES = {
    "Dwarf" => {
      "1" => "Hill Dwarf",
      "2" => "Mountain Dwarf"
    },
    "Elf" => {
      "1" => "Dark Elf",
      "2" => "Wood Elf",
      "3" => "High Elf"
    },
    "Halfling" => {
      "1" => "Lightfoot Halfling",
      "2" => "Stout Halfling"
    },
    "Gnome" => {
      "1" => "Rock Gnome",
      "2" => "Forest Gnome"
    }
  }

  RACES = {
    "1" => "Dwarf",
    "2" => "Elf",
    "3" => "Halfling",
    "4" => "Human",
    "5" => "Dragonboard",
    "6" => "Gnome",
    "7" => "Half-Elf",
    "8" => "Half-Orc",
    "9" => "Tiefling",
  }

  def initialize
    display_race_table

    @race = get_race
  end

  def display_race_table
    header = [
      "@" + "-"*78 + "@",
      "| Select a Race",
      "@" + "-"*78 + "@"
    ]

    puts header

    RACES.each do |k,v|
      puts "|\t#{k}:\t#{v}"
    end

    puts "@------------------------------------------------------------------------------@"
  end

  def display_subrace_table(race)
    header = [
      "@" + "-"*78 + "@",
      "| Select a Subrace",
      "@" + "-"*78 + "@"
    ]

    puts header

    SUBRACES[race].each do |k,v|
      puts "|\t#{k}:\t#{v}"
    end

    puts "@------------------------------------------------------------------------------@"
  end

  def get_race
    race    = ""
    subrace = ""

    until RACES.values.include?(race) do
      printf "Race: "
      race = RACES[STDIN.gets.chomp]
    end

    if SUBRACES.keys.include?(race)
      display_subrace_table(race)

      until SUBRACES[race].values.include?(subrace) do
        printf "Subrace: "
        subrace = SUBRACES[race][STDIN.gets.chomp]
      end

      return subrace
    end

    race
  end
end

race = RacePicker.new
puts race.inspect
