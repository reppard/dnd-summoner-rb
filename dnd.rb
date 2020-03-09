require 'erb'

require_relative 'lib/class_picker'
require_relative 'lib/character'
require_relative 'lib/race_picker'
require_relative 'lib/scoreset'

FOLDER = ARGV[0] ? ARGV[0] + "/" : "./"

module DnD
WELCOME = '''
»»———————————————————————————————————-　☠　-——————————————————————————————————««
▐▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░▏
▐▓▒░▏V~v~V~v~V~v~V~v~V~v~V~v~V~v~V~v~V~v~~V~v~V~v~V~v~V~v~V~v~V~v~V~v~V~v~V▐▓▒░▏
▐▓▒░▏!  ____, _,  _,____,  ____,_, _, __, _,__, _,____, _,  _,____,____,  !▐▓▒░▏
▐▓▒░▏: (-|  \(-|\ |(-|  \ (-(__(-|  \(-|\/|(-|\/|(-/  \(-|\ |(-|_,(-|__)  .▐▓▒░▏
▐▓▒░▏.  _|__/ _| \|,_|__/  ____)_|__/ _| _|,_| _|,_\__/,_| \|,_|__,_|  \,  ▐▓▒░▏
▐▓▒░▏. (     (     (      (    (     (     (     (     (     (    (       .▐▓▒░▏
▐▓▒░▏:                                                                    :▐▓▒░▏
▐▓▒░▏W~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^W▐▓▒░▏
▐▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░▏
»»———————————————————————————————————-　☠　-——————————————————————————————————««
'''
THEMES = {
  "arrows": {
    "top":    "»»———————————————————————————————————-　☠　-——————————————————————————————————««",
    "bottom": "»»———————————————————————————————————-　☠　-——————————————————————————————————««",
    "side":   "│",
    "spacer": "»»———————————————————————————————————-　☠　-——————————————————————————————————««",
  },
  "lines": {
    "top":    "╭─━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━─╮",
    "bottom": "╰─━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━─╯",
    "side":   "│",
    "spacer": "──━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━──"
  },
  "double_lines": {
    "top":    "╔══════════════════════════════════════════════════════════════════════════════╗",
    "bottom": "╚══════════════════════════════════════════════════════════════════════════════╝",
    "side":   "║",
    "spacer": "─══════════════════════════════════════════════════════════════════════════════─"
  },
  "gradient": {
    "top":    "▐▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░▏",
    "bottom": "▐▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░▏",
    "side":   "▐▓▒░▏",
    "spacer": "─══════════════════════════════════════════════════════════════════════════════─"
  }
}

  def self.header_wrapper(header, style=:lines)
    theme   = DnD::THEMES[style]
    spaces  = 79 - ((theme[:side].length*2) + header.length)

    [
      "#{theme[:top]}",
      "#{theme[:side]} #{header}#{" "*spaces}#{theme[:side]}",
      "#{theme[:bottom]}"
    ].join("\n")
  end

  def self.menu_with_prompt(header, data, prompt)
    menu_header = DnD::header_wrapper(header, :double_lines)

    lines = data.each.with_index.collect do |d, i|
      entry = d.is_a?(String) ? d : d[0]
      "#{i + 1}#{'.'*8}#{entry}"
    end

    ERB.new(
%{<%= menu_header %>
<%= DnD::content_with_border(lines) %>
<%= prompt %> }).result(binding)
  end

  def self.content_with_border(data, style=:lines)
    theme = DnD::THEMES[style]

    lines = data.collect do |d|
      spaces  = 79 - ((theme[:side].length*2) + d.length)
      "#{theme[:side]} #{d}#{" "*spaces}#{theme[:side]}"
    end

    ERB.new(
%{<%= theme[:top] %>
<% lines.each do |line| %><%= line %>
<% end %><%= theme[:bottom] %>
}).result(binding)

  end
end

printf DnD::WELCOME
char = DnD::Character.new

printf char.to_s
filename = "#{char.race.race}-#{char.klass.name}-(#{char.name}).txt"
File.open(FOLDER + filename, 'w') { |file| file.write(char)}
