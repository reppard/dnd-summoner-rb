require_relative 'dnd'

printf DnD::WELCOME
char = DnD::Character.new
printf char.to_s

if FOLDER != ""
  filename = "#{char.race.race}-#{char.klass.name}-(#{char.name}).txt"
  File.open(FOLDER + filename, 'w') { |file| file.write(char)}
end
