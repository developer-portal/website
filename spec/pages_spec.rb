require 'spec_helper'

# Array of all generated pages
site = File.join(File.dirname(__FILE__), '..', '_site', '**', '*.html')
PAGES = Dir.glob(site).map{ |p| p.gsub(/[^_]+\/_site(.*)/, '\\1') }

PAGES.each do |page|
  describe page do
    it_behaves_like 'Page'
    it_behaves_like 'Page with search box' unless page == '/search.html'

    before :each do
      visit page
    end
  end
end
