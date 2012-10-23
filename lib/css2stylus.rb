module Css2Stylus

  class Converter

    def initialize(css=nil)
      if not css.nil?
        @css = css
      end
    end

    def process
      @stylus = ''
      if @css.nil? || @css.empty?
        return @stylus
      end
      @tree = {}
      generate_tree
      render
      return true
    end

    def get
      return @stylus
    end

    private

    def add_rule(tree, selectors, style)
      return if style.nil? || style.empty?
      if selectors.empty?
        (tree[:style] ||= '') << style
      else
        first, rest = selectors.first, selectors[1..-1]
        node = (tree[first] ||= {})
        add_rule(node, rest, style)
      end
    end

    def generate_tree
      @css.split("\n").map { |line| line.strip }.join.gsub(/\/\*+[^\*]*\*+\//, '').split(/[\{\}]/).each_slice(2) do |style|
        rules = style[0].strip
        if rules.include?(',')
          add_rule(@tree, [rules], style[1])
        else
          add_rule(@tree, rules.split(/\s+/), style[1])
        end
      end
    end

    def render(tree=nil, indent=0)
      if tree.nil?
        tree = @tree
      end
      tree.each do |element, children|
        @stylus = @stylus + ' ' * indent + element + "\n"
        style = children.delete(:style)
        if style
          @stylus = @stylus + style.split(';').map { |s| s.strip }.reject { |s| s.empty? }.map { |s| ' ' * (indent + 2) + s.gsub(/:(\s)*/, ' ') }.join("\n") + "\n"
        end
        render(children, indent + 2)
      end
    end

  end
end