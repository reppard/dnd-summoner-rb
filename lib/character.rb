module DnD
  class Character
    attr_accessor :race, :klass, :score_set, :name

    def initialize
      @race      = RacePicker.new
      @klass     = ClassPicker.new
      @score_set = ScoreSet.new(@race, @klass)
      @name      = get_name
      @alignment = generate_alignment
      @size      = DnD::RACES[@race.race]["Size"]
    end

    def generate_alignment
      [
        ["Lawful", "Neutral", "Chaotic"].sample,
        ["Good", "Neutral", "Evil"].sample
      ].uniq.join(" ")
    end

    def to_s
      increases = @race.ability_increases.collect{|k,v| "#{k} (+#{v})"}.join(', ')
      [
        DnD::MENU_BORDER,
        [
          "| Class: #{@klass.name} | Name:  \"#{@name}\"",
          "| Size: #{@size["Height"]} ft. #{@size["Weight"]} lbs."
        ].join(" "),
        DnD::MENU_SPACER,
        [
          "| Race: #{@race.subrace == "" ? @race.race : @race.subrace} ",
          "| Alignment: #{@alignment}"
        ].join(" "),
        DnD::MENU_SPACER,
        "| HP: #{@score_set.hp}\tAC: #{@score_set.default_ac}\t Speed: #{@race.speed}",
        DnD::MENU_SPACER,
        "| Ability Increases: \t#{increases}",
        DnD::MENU_BORDER,
        "#{scores_display}",
        DnD::MENU_BORDER
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
      input = ""

      while input != "y"
        @race.set_random_name
        puts "Random Character's Name: \"#{@race.name}\"(#{@race.name_type})"
        printf "\nKeep?('y' to keep): "

        input = STDIN.gets.chomp
      end

      @name = @race.name
    end
  end
end
