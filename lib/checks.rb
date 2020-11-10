# rubocop:disable Metrics/CyclomaticComplexity

require 'colorize'

class Checks
  def initialize; end

  def paren_syn(file)
    @no_offenses = true
    @open_par = []
    @close_par = []
    @co_par = []
    file.each_line.with_index do |line, index|
      line = line.gsub(/".*?"/, '')
      line = line.gsub(%r{/.*?/}, '')

      @open_par = line.scan(/\(/)
      @close_par = line.scan(/\)/)
      @co_par = line.scan(/\)\(/)

      @count = @open_par.length <=> @close_par.length

      @no_offenses = false if @count != 0

      puts "line:#{index + 1} Lint/Syntax: unexpected token (".colorize(:red) if @count.positive?
      puts "line:#{index + 1} Lint/Syntax: unexpected token )".colorize(:red) if @count.negative? && @co_par.empty?
      puts "line:#{index + 1} Lint/Syntax: unexpected token )".colorize(:red) if !@co_par.empty?
    end
    puts 'No offenses'.colorize(:green) if @no_offenses
  end

  def doend_syn(fil)
    sc = []
    ec = []
    
    fil.each_line.with_index do |line, index|
  
      line = line.gsub(/".*?"/, '')
      line = line.gsub(/\/.*?\//, '')

      starting = line.scan(/\b(do|if|while|def)\b/)
      ending = line.scan(/end/)

      puts "line:#{index + 1} Lint/Syntax: unexpected token (do-if-while-def)".colorize(:red)  if starting.length > 1
          
      if !starting.empty? 
        i = starting.length
        while i.positive? 
          sc.push(index + 1)
          i -= 1
        end
      end

      if !ending.empty? 
        i = ending.length
        while i.positive?
          ec.push(index + 1)
          i -= 1
        end
      end
    end
    @counts = sc.length <=> ec.length
    puts "line:#{sc.last()} Lint/Syntax: unexpected token (do-if-while-def)".colorize(:red)  if @counts.positive?
    puts "line:#{ec.last()} Lint/Syntax: unexpected token end".colorize(:red)  if @counts.negative?
    puts 'No offenses'.colorize(:green) if @counts == 0
  end
end

# rubocop:enable Metrics/CyclomaticComplexity