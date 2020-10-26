require 'json'
require_relative 'dnd'

data          = JSON.parse(File.read('data/11 monsters.json'))["Monsters"]
monsters      = data.select{|k,v| k.match?(/Monsters/)}.keys.sample
monster       = data[monsters].keys.sample
sub_monster   = ""
attr_display  = []
stats_display = []

begin
selected = data[monsters][monster]

if !selected.keys.include?("content")
  sub_monster = selected.keys.sample
  selected = selected[sub_monster]
end

header  = DnD::header_wrapper(
  "#{monster} #{"("+sub_monster+")" if sub_monster != ""}", :double_lines)
content = selected["content"]

if content != nil
  content.each do |i|
    if i.is_a?(String)
      attr_display << i
    elsif i.is_a?(Hash) && i.keys.include?("table")
      stats = i["table"].collect{|k,v| "#{k}:#{" "*(15-(k.length+v[0].length))}#{v[0]}"}
      stats_display << DnD::THEMES[:arrows][:top]
      stats_display << DnD::row_wrapper_with_spaces(stats[0..2])
      stats_display << DnD::row_wrapper_with_spaces(stats[3..6])
      stats_display << DnD::THEMES[:arrows][:top]
    end
  end
end

rescue Exception => e
  puts monster
  puts e
end

output = [
  header,
  stats_display,
  DnD::content_with_border(
    DnD::wrap_multi_line_text(attr_display, 65), :gradient)
].join("\n")

puts output

filename = "#{monster}#{"-" + sub_monster if sub_monster != ""}.txt"
File.open("monsters/" + filename, 'w') { |file| file.write(output)}
