require "textmath/lexer"

module TextMath
  class Equation
    attr_accessor :output

    def initialize(obj)
      @obj = obj
      @raw = obj.raw
      @output = "$"
      parse
      @output += "$"
    end

    def parse
      if @raw[0] == "="
        if @raw[1] == "~"
          2.times { @raw.slice!(0) }
          @output += '\doteq\ '
        else
          @raw.slice! 0
          @output += '=\ '
        end
      else
        @output += '\ \ '
      end
      @output += Lexer.new(@raw).output
    end
  end
end
