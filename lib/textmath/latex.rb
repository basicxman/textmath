require "textmath/equation"

module TextMath
  class Latex
    attr_accessor :raw

    def initialize(str)
      @raw = str
    end

    def equation?
      not blank? || marker? || title?
    end

    def blank?
      @raw =~ /^\s+$/
    end

    def marker?
      @raw =~ /^(([a-z]{1})|([ivx]+)|([0-9]+))$/
    end

    def title?
      @raw =~ /^[a-zA-Z\s0-9]{4,}$/
    end

    def line
      temp = if marker?
        if @raw[0] =~ /[0-9]/
          @raw + "."
        else
          @raw + ")"
        end
      else
        @raw
      end
      temp + line_ending
    end

    def line_ending
      "\\\\\n"
    end

    def equation
      Equation.new(self).output + line_ending
    end
  end
end
