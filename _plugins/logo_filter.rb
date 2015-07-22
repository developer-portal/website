require 'pathname'

module Jekyll
  module LogoFilter
    def page_logo(url)
      path = Pathname.new(url).dirname
      "#{path}/logo.png"
    end
  end
end

Liquid::Template.register_filter(Jekyll::LogoFilter)
