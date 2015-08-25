require 'pathname'

module Jekyll
  module LogoFilter
    def page_logo(page)
      "/static/logo/#{page}.png"
    end
  end
end

Liquid::Template.register_filter(Jekyll::LogoFilter)
