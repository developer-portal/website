require 'spec_helper'
class Links
  def initialize(all_links,urls)
    @n = Array.new
    all_links.each do |link|
      if !link.text.nil? \
        && !link.text.empty? \
        && !link.path.nil? \
        && !urls.include?(link[:href])
        urls.push link[:href]
        @n.push(link)
      end
    end 
  end

  def each 
    @n.each do |l| 
      yield l
    end	
  end

  def self.url_exists?(url, status)
    10.times do 
      begin
        res = Net::HTTP.get_response(URI(url))
        status.replace res.code
      rescue OpenSSL::SSL::SSLError, SocketError
        return false
      end
      case res
      when Net::HTTPRedirection
        url = res['location']
      when Net::HTTPSuccess 
        return true
      else
        break
      end
    end
    false
  end  
end

def is_uri? url
  if URI(url).scheme
    true
  else
    false
  end
end

# Array of all generated pages
site = File.join(File.dirname(__FILE__), '..', '_site', '**', '*.html')
PAGES = Dir.glob(site).map{ |p| p.gsub(/[^_]+\/_site(.*)/, '\\1') }

urls = ['http://localhost:4000', 'http://localhost']

PAGES.each do |p|
  status=''
  describe p do
    it_behaves_like 'Page'
    it_behaves_like 'Page with search box' unless p == '/search.html'

    before :each do
      visit p
    end

    it 'has valid internal hyperlinks' do
      links = Links.new(page.all(:css, 'a'),urls)
      links.each do |link|
        url=link[:href]
        if !is_uri? url
          page.find(:xpath, link.path).click
          expect(page.status_code).to be(200), "expected link '#{link.text}' to work"
        end
      end
      visit p
    end

    it 'has valid external hyperlinks' do
      links = Links.new(page.all(:css, 'a'),urls)
      links.each do |link|
        url=link[:href]
        if is_uri? url
          result = Links.url_exists? url
          expect(result).to be_truthy, "expected link '#{link.text}' => '#{link[:href]}' to work (Error code '#{status}')"
        end
      end
      visit p
    end
  end
end
