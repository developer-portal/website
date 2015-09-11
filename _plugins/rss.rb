# Force fetching RSS feed during build

Jekyll::Hooks.register :site, :post_write do |post|
  require_relative '../rss.rb'
end
