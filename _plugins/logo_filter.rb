require 'pathname'

module Jekyll
  module LogoFilter
    def subsection_logo(subsection)
      "/static/logo/#{subsection}.png"
    end
  end
end

Liquid::Template.register_filter(Jekyll::LogoFilter)
