class ClassPicker
  MENU_BORDER = "@" + "-"*78 + "@"
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
  
  def get_class_header
    [ MENU_BORDER, "| Select a Class", MENU_BORDER]
  end

  def display_class_table_prompt
    puts get_class_header()
    HIT_DICE.each.with_index{|v,i| puts "|\t#{i + 1}#{'.'*8}#{v[0]}"}
    printf "#{MENU_BORDER}\nClass: "
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
