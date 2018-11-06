module DnD
  class Character
    attr_accessor :race, :klass, :score_set, :name

    def initialize
      @race      = RacePicker.new
      @klass     = ClassPicker.new
      @score_set = ScoreSet.new(@race, @klass)
      @name      = get_name
    end

    def to_s
      increases = @race.ability_increases.collect{|k,v| "#{k} (+#{v})"}.join(', ')
      header = [
        "| Class: #{@klass.name}\tName:  \"#{@name}\"", "#{DnD::MENU_SPACER}",
        "| Race: #{@race.race}\tAlignment: TODO", "#{DnD::MENU_SPACER}",
        "| HP: #{@score_set.hp}\tAC: #{@score_set.default_ac}\t Speed: #{@race.speed}",
        "#{DnD::MENU_SPACER}",
        "| Ability Increases: \t#{increases}",
      ].join("\n")

      [
        "#{DnD::MENU_BORDER}",
        "#{header}",
        "#{DnD::MENU_BORDER}",
        "#{scores_display}",
        "#{DnD::MENU_BORDER}"
      ].join("\n")
    end

    def scores_display
      scores = @score_set.scores.collect do |k,v|
        spaces   = 13 - k.length
        modifier = @score_set.modifiers[k]

        [
          "| #{k}:",
          " "*spaces,
          "\t(#{'+' if modifier >= 0}#{modifier})#{v}"
        ].join(" ")
      end

      scores.join("\n")
    end

    def get_name
      printf "Enter Character's Name: "

      STDIN.gets.chomp
    end
  end
end
