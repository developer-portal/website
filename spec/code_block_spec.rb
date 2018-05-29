require 'spec_helper'
require 'kramdown'
require 'ap'
require 'pp'
site = File.join(File.dirname(__FILE__), '..','content', '**', '*.md')
PAGES = Dir.glob(site)

def extract_code(element,prev_element)
  codes = [] 
  if element.type == :codespan \
    && !element.value.nil? \
    && !codes.include?(element.value) \
    && ((prev_element.children.size == 1) || (element.value[/^\n/])) #element value hasn't got any sibling or begin with '\n' 
      codes.push element.value
  end
  element.children.each do |child|
    codes += extract_code(child, element)
  end
  codes
end

PAGES.each do |page|
  generated_page = Kramdown::Document.new(File.read(page))
  codes = extract_code(generated_page.root,generated_page)
  
  describe 'Code blocks on markdown' do

    
    before :each do 
      codes.each do |code|
        code.gsub! "\n",''
      end
    end  
    it 'have good syntax' do
      codes.each do |code|
        if code[/^\$/] #code starts with '$'
          expect(system('bash', '-n', '-c', code, '&>/dev/null')).to be_truthy,"Something wrong with: '#{code}'"
        elsif code[/^\#/] #code starts with '#'
          #ap code
        else #code starts with something else
          #ap code
        end
      end
    end
  end
end
