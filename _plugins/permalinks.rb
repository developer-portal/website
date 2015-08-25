module Jekyll
  class Page
    def url=(name)
      @url = name
    end
  end
end

module Permalinks
  class Generator < Jekyll::Generator
    def generate(site)
      site.pages.each do |page|
        if page.url.start_with? '/content/'
          page.url = page.url[8..-1]
        end
      end
    end
  end
end
