require "textmath/operations"
require "pp"

module TextMath
  class Parser
    include Operations

    attr_accessor :output

    def initialize(token_groups)
      @groups = token_groups
      @output = parse("$0").join("")
    end

    def parse(group_key)
      parse_expression(@groups[group_key])
    end

    def parse_expression(tokens)
      pp tokens if ARGV[1] == "debug"
      output = []
      skip_next = false
      tokens.each_with_index do |token, index|
        if skip_next
          skip_next = false
          next
        end

        if token.type == :polish
          output.slice! -1
          output << polish(token, evaluate(tokens[index - 1]), evaluate(tokens[index + 1]))
          skip_next = true
        elsif token.type == :exp
          output << sub_group(token.value)
        else
          output << evaluate(token)
        end
      end
      output
    end

    def polish(token, lhs, rhs)
      if token.value == "/"
        divide(lhs, rhs)
      else
        "#{token.value} #{lhs} #{rhs}"
      end
    end

    def evaluate(token)
      if token.type == :exp
        sub_group(token.value, "", "")
      else
        case token.value
        when '!='  then ' \neq '
        when '\d'  then ' \div '
        when '\s{' then '\sqrt{'
        when '=~'  then ' \doteq '
        when '|'   then ' \vert '
        when '>='  then ' \geq '
        when '<='  then ' \leq '
        when 'in'  then ' \in '
        when '['   then ' \lbrace '
        when ']'   then ' \rbrace '
        when 'R'   then ' R '
        else token.value
        end
      end
    end

    def sub_group(group_key, prefix = "(", suffix = ")")
      result = parse_expression(@groups[group_key])
      prefix, suffix = "","" if result.first[2..7] == '\dfrac'
      prefix + result.join("") + suffix
    end
  end
end
