module DnD
  class ScoreSet
    attr_accessor :scores, :modifiers, :default_ac, :hp

    def initialize(race, klass)
      @race        = race
      @klass       = klass
      @modifiers   = {}
      @scores      = get_base_scores()

      puts "...scoreset.initialize: rolled base scores"

      @scores.each do|k,v|
        puts "...scoreset.initialize: result #{k[0..2]}: #{v}"
      end

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
      @scores.each{ |k,v| @modifiers[k] = get_modifier(v) }
    end

    def set_default_ac
      @default_ac = 10 + @modifiers["Dexterity"]
    end

    def set_hp
      @hp = @modifiers["Constitution"] + @klass.hit_dice
    end

    def get_sum_of_best_of_4d6
      roll = 4.times.collect{ 1 + rand(6) }.sort[1..3].sum
      puts "...scoreset.get_sum_of_best_of_4d6: #{roll}"
      roll
    end

    def get_modifier(score)
      (score - 10) / 2
    end
  end
end
