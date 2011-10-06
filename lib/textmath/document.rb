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
