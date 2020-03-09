require_relative 'race_data'

module DnD
  class RacePicker

    attr_accessor :name, :name_type, :race, :sex, :subrace, :speed, :ability_increases

    def initialize
      @speed             = 0
      @ability_increases = {}
      @subrace           = ""
      @name              = ""
      @name_type         = ""
      @race              = set_race
    end

    def set_random_name()
      race = ""

      if @race == "Half-Elf"
        race = ["Human", "Elf"].sample
      else
        race = @race
      end

      name_types = ["Child", "Male", "Female"]
      name_types.delete("Child") if DnD::RACES[race]["Names"]["Child"].nil?

      @name_type  = name_types.sample
      name = DnD::RACES[race]["Names"][@name_type].sample
      sir  = DnD::RACES[race]["Names"]["Sir"].sample

      @name = sir ? "#{name} #{sir}" : name
    end

    def display_race_table_prompt(data)
      puts DnD.menu_with_prompt("Select Race", data,"Race (<ENTER> for Random):")
    end

    def display_custom_ability_prompt(data)
      puts DnD.menu_with_prompt("Select an Ability to increase(+1)", data,"Ability:")
    end

    def set_custom_increases(data)
      abilities = data["Abilities"]
      data["Limit"].times do
        ability = ""
        until abilities.include?(ability) do
          display_custom_ability_prompt(abilities)
          ability = abilities[STDIN.gets.chomp.to_i - 1]
        end

        @ability_increases[ability] = 1
        abilities.delete(ability)
      end
    end

    def apply_ability_increases(race)
      race["AbilityIncreases"].each { |k,v| @ability_increases[k] = v}

      set_custom_increases(race["CustomAbilities"]) if race["CustomAbilities"]
    end

    def apply_speed(race)
      @speed = race["Speed"] if race["Speed"]
    end

    def get_race(races)
      race = ""

      until races.keys.include?(race) do
        display_race_table_prompt(races)

        select = STDIN.gets.chomp.to_i - 1

        race = select == -1 ? races.keys.sample : races.keys[select]
      end

      puts "[ INFO ]: " + race + " selected\n"
      race
    end

    def set_race
      race = get_race(DnD::RACES)
      apply_ability_increases(DnD::RACES[race])
      apply_speed(DnD::RACES[race])

      if DnD::RACES[race]["Subraces"]
        @subrace = get_race(DnD::RACES[race]["Subraces"])
        apply_ability_increases(DnD::RACES[race]["Subraces"][subrace])
        apply_speed(DnD::RACES[race]["Subraces"][subrace])
      end

      race
    end
  end
end
