require_relative 'lib/scoreset'
require_relative 'lib/race_picker'
require_relative 'lib/class_picker'
require_relative 'lib/character'

module DnD
  MENU_BORDER = "@" + "-"*78 +"@"
end

puts "Welcome to the D&D Character Creator"
char  = DnD::Character.new

puts char
