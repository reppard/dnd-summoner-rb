require_relative 'race_data'

module DnD
  class RacePicker

    attr_accessor :race, :speed, :ability_increases

    def initialize
      @speed             = 0
      @ability_increases = {}
      @race              = set_race
    end

    def get_race_header
      [DnD::MENU_BORDER, "| Select a Race", DnD::MENU_BORDER]
    end

    def display_race_table_prompt(data)
      puts get_race_header()
      data.each.with_index{|d,i| puts "|\t#{i + 1}#{'.'*8}#{d[0]}"}

      printf "#{DnD::MENU_BORDER}\nRace: "
    end

    def get_custom_ability_header
      [DnD::MENU_BORDER, "| Select a Ability to increase(+1)", DnD::MENU_BORDER]
    end

    def display_custom_ability_prompt(data)
      puts get_custom_ability_header()
      data.each.with_index{|v,i| puts "|\t#{i + 1}#{'.'*8}#{v}"}

      printf "#{DnD::MENU_BORDER}\nAbility: "
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
      puts race
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
        race = races.keys[(STDIN.gets.chomp.to_i - 1)]
      end

      race
    end

    def set_race
      race = get_race(DnD::RACES)
      apply_ability_increases(DnD::RACES[race])
      apply_speed(DnD::RACES[race])

      if DnD::RACES[race]["Subraces"]
        subrace = get_race(DnD::RACES[race]["Subraces"])
        apply_ability_increases(DnD::RACES[race]["Subraces"][subrace])
        apply_speed(DnD::RACES[race]["Subraces"][subrace])
      end

      race
    end
  end
end
