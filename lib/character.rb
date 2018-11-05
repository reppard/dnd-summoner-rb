class Character
  attr_accessor :race, :klass, :score_set, :name

  def initialize
    @race      = RacePicker.new
    @klass     = ClassPicker.new
    @score_set = ScoreSet.new(@race, @klass)
    @name      = get_name
  end

  def to_s
    frame  = "@" + "-"*78 +"@"
    increases = @race.ability_increases.collect{|k,v| "#{k} (+#{v})"}.join(', ') 
    header = [
      "| Name:  #{@name}",
      "| Race:  #{@race.race}",
      "| Class: #{@klass.name}",
      "| HP: #{@score_set.hp}\tAC: #{@score_set.default_ac}\t Speed: #{@race.speed}",
      "| Ability Increases: \t#{increases}",
    ].join("\n")

    [
      "#{frame}","#{header}","#{frame}","#{scores_display}","#{frame}"
    ].join("\n")
  end

  def scores_display
    scores = @score_set.scores.collect do |k,v|
      spaces   = 13 - k.length
      modifier = @score_set.modifiers[k]
      "| #{k}:" + " "*spaces + "\t(#{'+' if modifier >= 0}#{modifier})#{v}"
    end

    scores.join("\n")
  end

  def get_name
    printf "Enter Character's Name: "

    STDIN.gets.chomp
  end
end

