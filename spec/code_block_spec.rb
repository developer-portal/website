require 'spec_helper'
require 'kramdown'
require 'ap'

content = File.join(File.dirname(__FILE__), '..','content', '**', '*.md')
PAGES = Dir.glob(content)

def extract_code(parent)
  codespans = []
  parent.children.each do |child|
    
    # Checks ... parent value hasn't got any sibling or begin with '\n'
                                                                    #<<< TODO: ^^^ Why?
    if child.type == :codespan \
        && !child.value.nil? \                                      #<<< remove?, investigate
        && !codespans.include?(child.value) \                       #<<< remove, keep context
        && ((parent.children.size == 1) || (child.value[/^\n/]))    #<<< use start_with?
      
      codespans.push child.value.gsub "\n",' '                      #<<< .split and add to codespans
                                                                    #<<< add .trim - white space in the beginning and end
    end

    codespans += extract_code(child)
  end
  codespans
end

PAGES.each do |page|
  generated_page = Kramdown::Document.new(File.read(page))          #<<< MD
  codespans = extract_code(generated_page.root)                     #<<< lines of code, rename?
  results = []                                                      #<<< to Hash: {codespan => result}

  describe 'Command in Markdown file' do

    it 'has a good syntax' do                                       #<<< passes syntax check
      codespans.each do |code|
        if code[/^\$/] #code starts with '$'
          results.push([code,system('bash', '-n', '-c', code, "&>/dev/null")])       #<<< do not execute here
          expect(results[-1][1]).to be_truthy,"Something wrong with: '#{code}'"
        elsif code[/^\#/]                                           #<<< code.starts_with? ?#
          #ap code
        else #code starts with something else
          #ap code
        end
      end
    end
    
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
