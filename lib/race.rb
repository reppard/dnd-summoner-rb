require_relative 'data'

module DnD
  class Race

    attr_accessor :traits, :name, :name_type, :race, :sex, :subrace, :speed,
      :ability_increases, :ancestry

    def initialize
      @speed             = 0
      @ability_increases = {}
      @subrace           = ""
      @name              = ""
      @name_type         = ""
      @race              = set_race
      @traits            = set_traits
      @ancestry          = get_ancestry_table
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
      printf DnD.menu_with_prompt("Select Race", data,"Race (default random):")
    end

    def display_custom_ability_prompt(data)
      printf DnD.menu_with_prompt("Select an Ability to increase(+1)", data,"Ability (default random):")
    end

    def set_custom_increases(data)
      abilities = data["Abilities"]
      data["Limit"].times do
        ability = ""
        until abilities.include?(ability) do
          display_custom_ability_prompt(abilities)
          ability = abilities[STDIN.gets.chomp.to_i - 1]

          ability == -1 ? (1..abilities.length).to_a.sample : ability
        end

        @ability_increases[ability] = 1

        puts "...race.set_custom_increases: #{ability} chosen"

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

      puts "...race_picker.get_race: #{race} selected"
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

    def set_traits
      traits = DnD::RACES[@race]["Traits"]

      if @subrace != ""
        subrace_traits = DnD::RACES[@race]["Subraces"][@subrace]["Traits"]

        if subrace_traits != nil
          traits.append("~~~[ #{@subrace} Traits ]~~~:")

          subrace_traits.each do |trait|
            traits.append(trait)
          end
        end
      end

      traits
    end

    def get_ancestry_table
      table      = []
      table_data = DnD::RACES_META["Dragonborn"]["Traits"]["Ancestry"]["Table"]

      if @race == "Dragonborn"
        table.append(table_data.keys)

        table_data[table[0][0]].each_with_index do |d, i|
          dragon = d
          type   = table_data[table[0][1]][i]
          breath = table_data[table[0][2]][i]
          dragon = "#{dragon}#{" "*(23-dragon.length)}"
          type   = "#{type}#{" "*(23-type.length)}"

          table.append([dragon, type, breath])
        end

        table[0].map!{|i| "#{i}#{" "*(23-i.length)}"}
      end

      table
    end
  end
end
