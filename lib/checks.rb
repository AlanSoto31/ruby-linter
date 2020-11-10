# rubocop:disable Metrics/CyclomaticComplexity,Metrics/PerceivedComplexity,Metrics/MethodLength

class Checks
  attr_accessor :err

  def initialize
    @err = {}
  end

  def paren_syn(file)
    file.each_line.with_index do |line, index|
      line = line.gsub(/".*?"/, '')
      line = line.gsub(%r{/.*?/}, '')

      open_par = line.scan(/\(/)
      close_par = line.scan(/\)/)
      co_par = line.scan(/\)\(/)

      count = open_par.length <=> close_par.length

      @err.store((index + 1), "(") if count.positive?
      @err.store((index + 1), ")") if count.negative?
      @err.store((index + 1), ")") unless co_par.empty?
    end
    @err
  end

  def doend_syn(fil)
    sc = []
    ec = []
    fil.each_line.with_index do |line, index|
      line = line.gsub(/".*?"/, '')
      line = line.gsub(%r{/.*?/}, '')

      starting = line.scan(/\b(do|if|while|def)\b/)
      ending = line.scan(/end/)

      puts "line:#{index + 1} Lint/Syntax: unexpected token (do-if-while-def)".colorize(:red) if starting.length > 1

      unless starting.empty?
        i = starting.length
        while i.positive?
          sc.push(index + 1)
          i -= 1
        end
      end

      unless ending.empty?
        i = ending.length
        while i.positive?
          ec.push(index + 1)
          i -= 1
        end
      end
    end
    counts = sc.length <=> ec.length
    @err.store(sc.last, "(do-if-while-def)") if counts.positive?
    @err.store(ec.last, "end") if counts.negative?
  end
  @err
end

# rubocop:enable Metrics/CyclomaticComplexity,Metrics/PerceivedComplexity,Metrics/MethodLength
