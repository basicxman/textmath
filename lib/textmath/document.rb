require "erb"
require "textmath/latex"

module TextMath
  class Document
    def initialize(filepath)
      @contents = File.readlines(filepath).map(&:strip)
    end

    def generate
      @document = ""
      @contents.each do |line|
        if line[0, 2] == "--"
          @text = line[2..-1]
          @document += r(:justified).result(binding)
          next
        end
        line = Latex.new(line)
        @document += if line.equation?
          line.equation
        else
          line.line
        end
      end

      r(:document).result(binding)
    end

    def r(filename)
      path = File.join(File.dirname(__FILE__), "templates", filename.to_s + ".erb")
      ERB.new(File.read(path))
    end
  end
end
