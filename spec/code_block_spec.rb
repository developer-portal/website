require 'spec_helper'
require 'kramdown'
require 'ap'

content = File.join(File.dirname(__FILE__), '..','content', '**', '*.md')
PAGES = Dir.glob(content)

def extract_code(parent)
  codespans = []
  parent.children.each do |child|
    # Checks if child.value hasn't got any sibling or begin with '\n', because only code is needed
    if child.type == :codespan \
      && ((parent.children.size == 1) || (child.value.start_with? ?\n))
        codespans += child.value.strip().split("\n").map! { |x| x.strip()}
    end
    codespans += extract_code(child)
  end
  codespans
end

PAGES.each do |page|
  markdown_document = Kramdown::Document.new(File.read(page))
  code_lines = extract_code(markdown_document.root)
  results = {}
  code_lines.each do |code|
    results[code] = system("bash", "-n", "-c", code, :err => File::NULL)
  end
  describe 'Command in Markdown file' do
    results.keys.each do |code|
      it 'has a good syntax' do
        expect(results[code]).to be_truthy,"Something wrong with: '#{code}'"
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
