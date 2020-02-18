module DnD
  class ClassPicker
    HIT_DICE    = {
      "Barbarian" => 12,
      "Bard"      => 8,
      "Cleric"    => 8,
      "Druid"     => 8,
      "Fighter"   => 10,
      "Monk"      => 8,
      "Paladin"   => 10,
      "Ranger"    => 10,
      "Rogue"     => 8,
      "Sorcerer"  => 6,
      "Warlock"   => 8,
      "Wizard"    => 6,
    }

    attr_accessor :name, :hit_dice

    def initialize
      @name     = get_class
      @hit_dice = HIT_DICE[@name]
    end

    def display_class_table_prompt
      puts DnD.header_wrapper "| Select a Class"

      HIT_DICE.each.with_index{|v,i| puts "|\t#{i + 1}#{'.'*8}#{v[0]}"}
      printf "#{DnD::MENU_BORDER}\nClass: "
    end

    def get_class
      klass = ""

      until HIT_DICE.keys.include?(klass) do
        display_class_table_prompt
        klass = HIT_DICE.keys[STDIN.gets.chomp.to_i - 1]
      end

      klass
    end
  end
end
