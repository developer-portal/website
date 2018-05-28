require 'spec_helper'

# Array of all generated pages
site = File.join(File.dirname(__FILE__), '..', '_site', '**', '*.html')
PAGES = Dir.glob(site).map{ |p| p.gsub(/[^_]+\/_site(.*)/, '\\1') }

urls = ['http://localhost:4000', 'http://localhost']
status=''

PAGES.each do |p|
  describe p do
    it_behaves_like 'Page'
    it_behaves_like 'Page with search box' unless p == '/search.html'

    before :each do
      visit p
    end

    it 'has only valid internal hyperlinks' do
      page.all(:css, 'a').each do |link|
        next if link.text.nil? || link.text.empty? || link[:href].match(/^http.*/) || link.path.nil? || urls.include?(link[:href])
        begin
          page.find(:xpath, link.path).click
	rescue NoMethodError
	  require 'irb';binding.irb
	end
        urls.push link.path
	expect(page.status_code).to be(200), "expected link '#{link.text}' to work"
        visit p
      end
    end

    it 'has valid external hyperlinks' do
      page.all(:css, 'a').each do |link|
        next if link.text.nil? || link.text.empty? || !link[:href].match(/^http.*/) || urls.include?(link[:href])
	urls.push(link[:href])
	expect(url_exists? link[:href], status).to be_truthy, "expected link '#{link.text}' => '#{link[:href]}' to work (Error '#{status}')"
        visit p
      end
    end
  end
end
