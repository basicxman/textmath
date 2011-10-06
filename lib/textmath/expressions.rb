require "textmath/parser"

module TextMath
  class Expressions
    attr_accessor :output

    def initialize(tokens)
      @groups = {}
      @current_group = 1
      @groups["$0"] = parse(tokens)

      @output = Parser.new(@groups).output
    end

    def parse(tokens)
      group = []
      group_start, group_end = nil
      cur_value = nil
      balance = 0
      tokens.each_with_index do |t, index|
        next unless balance == 0 or (t.type == :rp or t.type == :lp)
        if t.type == :lp
          balance += 1
          next unless balance == 1
          cur_value = "$#{@current_group}"
          @current_group += 1
          group << Token.new(cur_value, 0, :exp)
          group_start = index
        elsif t.type == :rp
          balance -= 1
          next unless balance == 0
          group_end = index
          @groups[cur_value] = parse(tokens[group_start + 1...group_end])
          cur_value = nil
        else
          group << t if balance == 0
        end
      end

      group
    end
  end
end
