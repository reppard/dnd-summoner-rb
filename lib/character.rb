require 'erb'

module DnD
  class Character
    attr_accessor :race, :klass, :score_set, :name, :type

    def initialize
      @level      = get_lvl
      @race       = DnD::Race.new
      @klass      = DnD::ClassPicker.new
      @background = DnD::BackgroundPicker.new
      @score_set  = DnD::ScoreSet.new(@race, @klass)
      @name       = get_name
      @alignment  = generate_alignment
      @size       = DnD::RACES[@race.race]["Size"]
    end

    def generate_alignment
      [
        DnD::RACES[@race.race]["Alignments"]["Ethical"].sample,
        DnD::RACES[@race.race]["Alignments"]["Moral"].sample
      ].uniq.join(" ")
    end

    def to_s
      race = @race.subrace == "" ? @race.race : @race.subrace
      display = []
      display.append(
        DnD::header_wrapper(
          [
            "NAME: \"#{@name}\"",
            "CLASS: #{@klass.name}"
          ], :double_lines_open_bottom
        )
      )
      display.append("\n")
      display.append(
        DnD::row_wrapper_with_spaces(
          [
            "RACE: #{race} (#{@type})",
            "ALIGNMENT: #{@alignment}",
            "LVL: #{@level}"
          ], :double_lines
        )
      )
      display.append("\n")
      display.append(
        DnD::content_with_border(attr_display, :double_lines_open_top)
      )
      display.append(
        DnD::content_with_border(
          DnD::wrap_multi_line_text(@race.traits, 74), :arrows
        )
      )
      display.append(
        DnD::content_with_border(@race.ancestry.collect{|a| a.join})
      ) if !@race.ancestry.empty?

      display.join("")
    end

    def attr_display
      i         = 0
      increases = @race.ability_increases.collect{|k,v| "#{k[0..2].upcase}(+#{v})"}.join(',')
      atts      = [
        "HP:         #{@score_set.hp}",
        "AC:         #{@score_set.default_ac}",
        "SPEED:      #{@race.speed}",
        "SIZE:       #{@size["Height"]} ft. #{@size["Weight"]} lbs.",
        "INCREASES:  #{increases}",
      ]

      scores = @score_set.scores.collect do |k,v|
        key         = k[0..2].upcase
        spaces      = " "*(5 - key.length)
        modifier    = @score_set.modifiers[k]
        score_entry = "#{key}:#{spaces}(#{'+' if modifier >= 0}#{modifier})#{v}"
        spacer      = " "*(14 - score_entry.length)
        score_line  = [
          score_entry, spacer, "│  #{atts[i]}"
        ].join("")
        i += 1

        score_line
      end

      scores
    end

    def get_name
      input = ""

      while input != "y"
        @race.set_random_name
        printf DnD::header_wrapper(
          "Random Name:  \"#{@race.name}\"  (#{@race.name_type})", :double_lines
        )
        printf "\nKeep?('y' to keep, <ENTER> regen): "

        input = STDIN.gets.chomp
      end

      @type = @race.name_type
      @name = @race.name
    end

    def get_lvl
      level = 0

      while !(1..20).include?(level) do
        printf "\nStart Lvl (default 1): "

        input = STDIN.gets.chomp

        if input == ""
          level = 1
        end

        if (1..20).include?(input.to_i)
          level = input.to_i
        end
      end

      puts "...character.get_lvl: #{level} selected"
      level
    end
  end
end
