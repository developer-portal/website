require 'spec_helper'
require 'kramdown'

content = File.join(File.dirname(__FILE__), '..','content', '**', '*.md')
MD_FILES = Dir.glob(content)

def extract_code(parent)
  code_lines = []

  parent.children.each do |child|
    # Checks if child.value hasn't got any sibling or begin with '\n', because only code is needed
    if child.type == :codespan \
      && ((parent.children.size == 1) || (child.value.start_with? ?\n))
        code_lines += child.value
          .split(?\n)
          .map(&:strip)
          .inject([]) do |res, cu|
            if !res.last.nil? && res.last.end_with?("\\")
              res.last[0..-2].concat cu
            else
              res.push cu
            end
            res
          end
    end

    code_lines += extract_code child
  end
  code_lines.reject(&:empty?)
end

MD_FILES.each do |file|
  markdown_document = Kramdown::Document.new(File.read(file))
  code_lines = extract_code(markdown_document.root)

  results = code_lines.inject({}) do |r, code|
    r[code] = system("bash", "-n", "-c", code, :err => File::NULL)
    r
  end

  describe "Command in Markdown file '#{file.gsub(/[^_]+\/\.\.\/(content\/.*)/, '\\1')}'" do
    results.each do |code, result|
      it 'has a good syntax' do
        expect(result).to be_truthy,"Something wrong with: '#{code}'"
      end
      next
      it 'does not begin with #' do
        skip
      end

      it 'starts with $' do
        skip
      end

      it 'runs dnf with sudo' do
        skip
      end
    end
  end
end
