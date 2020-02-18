require_relative 'lib/class_picker'
require_relative 'lib/character'
require_relative 'lib/race_picker'
require_relative 'lib/scoreset'

module DnD
  MENU_BORDER = "@" + "-"*78 +"@"
  MENU_SPACER = "+" + "-"*78 +"+"

  def self.header_wrapper(string)
    [DnD::MENU_BORDER, string , DnD::MENU_BORDER]
  end
end

puts "Welcome to the D&D Character Creator"

char = DnD::Character.new

puts char
