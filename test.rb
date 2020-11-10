def paren_syn(file)
  file.each_line.with_index do |line, index|
    count = 0
    line.each_char do |char|
      if char.match(/[(]/)
        count += 1
      elsif char.match(/[)]/) && count.zero?
        p "You have an extra ) in line #{index + 1}"
        break
      elsif char.match(/[)]/)
        count -= 1
      end
    end
    if count.positive?
      p "You have an extra ( in line #{index + 1}"
    elsif count.negative?
      p "You have an extra ) in line #{index + 1}"
    end
  end
end