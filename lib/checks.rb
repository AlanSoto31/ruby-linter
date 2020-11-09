# rubocop:disable Metrics/CyclomaticComplexity

require 'colorize'

class Checks
  def initialize; end

  def paren_syn(file)
    @no_offenses = true
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
      puts "line:#{index + 1} Lint/Syntax: unexpected token )".colorize(:red) unless @co_par.empty?
    end
    puts 'No offenses'.colorize(:green) if @no_offenses
  end
end

# rubocop:enable Metrics/CyclomaticComplexity
