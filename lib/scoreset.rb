module DnD
  class ScoreSet
    attr_accessor :scores, :modifiers, :default_ac, :hp

    def initialize(race, klass)
      @race        = race
      @klass       = klass
      @modifiers   = {}
      @scores = get_base_scores()

      apply_increases
      set_modifiers
      set_default_ac
      set_hp
    end

    def get_base_scores
      {
        "Strength"     => get_sum_of_best_of_4d6,
        "Dexterity"    => get_sum_of_best_of_4d6,
        "Constitution" => get_sum_of_best_of_4d6,
        "Intelligence" => get_sum_of_best_of_4d6,
        "Wisdom"       => get_sum_of_best_of_4d6,
        "Charisma"     => get_sum_of_best_of_4d6,
      }
    end

    def apply_increases
      @race.ability_increases.each{ |k,v| @scores[k] += v }
    end

    def set_modifiers
      @scores.each do |k,v|
        @modifiers[k] = get_modifier(v)
      end
    end

    def set_default_ac
      @default_ac = 10 + @modifiers["Dexterity"]
    end

    def set_hp
      @hp = @modifiers["Constitution"] + @klass.hit_dice
    end

    def get_sum_of_best_of_4d6
      roll = []

      puts "Rolling 4D6..."
      4.times do
        roll << 1 + rand(6)
      end

      puts "Rolled: #{roll}"

      roll.sort!
      roll.shift

      puts "Sum of best: #{roll.sum}"
      roll.sum
    end

    def get_modifier(score)
      if score == 1
        -5
      elsif score.between?(2,3)
        -4
      elsif score.between?(4,5)
        -3
      elsif score.between?(6,7)
        -2
      elsif score.between?(8,9)
        -1
      elsif score.between?(10,11)
        0
      elsif score.between?(12,13)
        1
      elsif score.between?(14,15)
        2
      elsif score.between?(16,17)
        3
      elsif score.between?(17,18)
        4
      elsif score.between?(19,20)
        5
      elsif score.between?(21,22)
        6
      elsif score.between?(23,24)
        7
      elsif score.between?(25,26)
        8
      elsif score.between?(27,28)
        9
      else score.between?(29,30)
        10
      end
    end
  end
end
