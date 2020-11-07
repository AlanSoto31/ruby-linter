class Checks
  def initialize
  end

  def missing_tag(file)
    reading_file = ''
    file.each_line { |lin| lin = reading_file }
    if reading_file == "'Hello'"
      puts 'OK'
      return
    end
    file.each_line.with_index do |line, index|
      count = 0
      line.each_char do |char|
        if char.match(/[(]/)
          count += 1
        elsif char.match(/[)]/) && count == 0
          p "You have an extra ) in line #{index + 1}"
          break
        elsif char.match(/[)]/) 
          count -= 1
        end
      end
      if count > 0 
        p "You have an extra ( in line #{index + 1}"
      elsif count < 0
        p "You have an extra ) in line #{index + 1}"
      end
    end
  end
end

