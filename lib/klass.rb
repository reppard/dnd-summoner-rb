module DnD
  class Klass
    attr_accessor :name, :hit_dice, :features

    def initialize
      @name     = get_class
      @hit_dice = DnD::CLASSES[@name]["HitDice"]
      @features = DnD::CLASSES_META[@name]["Class Features"]
    end

    def display_class_table_prompt
      printf DnD.menu_with_prompt("Select Class", DnD::CLASSES, "Class (default random):")
    end

    def get_class
      klass = ""

      until DnD::CLASSES.keys.include?(klass) do
        display_class_table_prompt
        select = STDIN.gets.chomp.to_i - 1

        klass = select == -1 ? DnD::CLASSES.keys.sample
          : DnD::CLASSES.keys[select]
      end

      puts "...class_picker.get_class: #{klass} selected"
      klass
    end
  end
end
