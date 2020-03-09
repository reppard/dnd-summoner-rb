require 'erb'

require_relative 'lib/class_picker'
require_relative 'lib/character'
require_relative 'lib/race_picker'
require_relative 'lib/scoreset'

FOLDER = ARGV[0] ? ARGV[0] + "/" : "./"

module DnD
MENU_BORDER_TOP    = "╭─━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━─╮"
MENU_SPACER        = "──━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━──"
MENU_BORDER_BOTTOM = "╰─━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━─╯"
DBL_BORDER_TOP     = "╔══════════════════════════════════════════════════════════════════════════════╗"
DBL_SPACER         = "─══════════════════════════════════════════════════════════════════════════════─"
DBL_BORDER_BOTTOM  = "╚══════════════════════════════════════════════════════════════════════════════╝"
WELCOME            = '''
»»———————————————————————————————————-　☠　——————————————————————————————————-««
]▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░[
│▓▒░│v~v~v~v~v~v~v~v~v~v~v~v~v~v~v~v~v~v~v~v~v~v~v~v~v~v~v~v~v~v~v~v~v~v~v~│▓▒░│
│▓▒░│   ____, _,  _,____,  ____,_, _, __, _,__, _,____, _,  _,____,____,   │▓▒░│
│▓▒░│  (-|  \(-|\ |(-|  \ (-(__(-|  \(-|\/|(-|\/|(-/  \(-|\ |(-|_,(-|__)   │▓▒░│
│▓▒░│   _|__/ _| \|,_|__/  ____)_|__/ _| _|,_| _|,_\__/,_| \|,_|__,_|  \,  │▓▒░│
│▓▒░│  (     (     (      (    (     (     (     (     (     (    (        │▓▒░│
│▓▒░│                                                                      │▓▒░│
│▓▒░│^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~│▓▒░│
]▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░[
»»———————————————————————————————————-　☠　——————————————————————————————————-««
'''

  def self.header_wrapper(header)
    spaces   = 77 - header.length
    [DnD::MENU_BORDER_TOP, "│ #{header}#{" "*spaces}│", DnD::MENU_BORDER_BOTTOM].join("\n")
  end

  def self.double_header_wrapper(header)
    spaces   = 77 - header.length
    [DnD::DBL_BORDER_TOP, "║ #{header}#{" "*spaces}║", DnD::DBL_BORDER_BOTTOM].join("\n")
  end

  def self.menu_with_prompt(header, data, prompt)
    lines = data.each.with_index.collect do |d, i|
      base = "│   #{i + 1}#{'.'*8}#{d[0]}"
      spaces = 79 - base.length
      "#{base}#{" "*spaces}│"
    end

    printf ERB.new(%{
<%= double_header_wrapper(header) %>
<%= DnD::MENU_BORDER_TOP %>
<% lines.each do |line| %><%= line %>
<% end %><%= DnD::MENU_BORDER_BOTTOM %>
<%= prompt %> }).result(binding)
  end

  def self.content_with_border(data)
    lines = data.collect do |d|
      base = "│ #{d}"
      spaces = 79 - base.length
      "#{base}#{" "*spaces}│"
    end

    ERB.new(%{<%= DnD::MENU_BORDER_TOP %>
<% lines.each do |line| %><%= line %>
<% end %><%= DnD::MENU_BORDER_BOTTOM %>
}).result(binding)
  end

  def self.content_with_dbl_border(data)
    lines = data.collect do |d|
      base = "│ #{d}"
      spaces = 79 - base.length
      "#{base}#{" "*spaces}│"
    end

    ERB.new(%{<%= DnD::DBL_BORDER_TOP %>
<% lines.each do |line| %><%= line %>
<% end %><%= DnD::DBL_BORDER_BOTTOM %>
}).result(binding)
  end
end

printf ERB.new(%{<%= DnD::WELCOME %>}).result(binding)

char = DnD::Character.new

puts char
filename = "#{char.race.race}-#{char.klass.name}-(#{char.name}).txt"
File.open(FOLDER + filename, 'w') { |file| file.write(char)}
