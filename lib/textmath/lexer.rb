require "textmath/expressions"

module TextMath
  class Token < Struct.new(:value, :prec, :type); end
  class Lexer
    attr_accessor :output

    def initialize(string)
      @string = string
      @output = parse
    end

    def tokenize(c)
      return if c == " "
      data = \
        case c
        when "("      then [4, :lp]
        when ")"      then [4, :rp]
        when "^"      then [3, :static]
        when "*"      then [2, :static]
        when "/"      then [2, :polish]
        when "+", "-" then [1, :static]
        else [0, :none]
        end
      Token.new(c, *data)
    end

    def parse
      tokens = @string.scan(/[|\[\]\>\<!\.\\A-Za-z=~\{\}]+|[0-9]+|[\(\)+\-^\/*\s+]{1}/).map { |c| tokenize(c) }.compact
      expressions = Expressions.new(tokens).output
    end
  end
end
