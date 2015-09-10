#!/usr/bin/ruby
# This script can update the title page from any RSS feed.
#
# It replaces the content between <!-- BLOG_HEADLINES_START -->
# and <!-- BLOG_HEADLINES_END --> in _site/index.html

require 'rss'

# Templating
require 'liquid'

# For striping HTML tags from post descriptions
require 'action_view'

# Following adjustments are based on Fedora Planet RSS feed.
# If you are changing the feed make sure the changes still apply!
FEED_URL = 'http://fedoraplanet.org/rss20.xml'.freeze

class Article
  attr_accessor :author, :title, :description, :date, :url
  liquid_methods :author, :title, :description, :date, :url

  def initialize(author, title, description, date, url)
    @author, @title, @description, @date, @url = author, title, description, date, url
  end
end
@articles = []

puts "Fetching #{FEED_URL} feed..."
rss = RSS::Parser.parse(FEED_URL, false)
rss.items.take(4).each do |item|
  # Extract name from the title
  #  Original title: NAME: TITLE
  #  Expected title: TITLE
  #  Expected name: NAME
  author = item.title.gsub(/([^:]*):(.*)/, '\\1').strip
  title = item.title.gsub(/([^:]*):(.*)/, '\\2').strip

  # Avoid HTML in description
  description = ActionView::Base.full_sanitizer.sanitize(item.description)

  # Shorter description if necessary
  if description && description.length > 140
    # Take whole words rather than xy letters
    description = description.split[0...25].join(' ')
    description += '&hellip;' unless ['!', '?', '.'].include? description[-1]
  end

  # Adjust date, strip time
  #   Original date: Tue, 08 Sep 2015 10:54:28 +0000
  #   Expected date: Tue, 08 Sep 2015
  regexp = /([a-zA-Z]{3}\, [0-9]{2} [a-zA-Z]{3} [0-9]{4}).*/
  date = item.pubDate.to_s.gsub(regexp, '\\1')

  @articles << Article.new(author, title, description, date, item.link)
end

template = <<TEMPLATE
<!-- BLOG_HEADLINES_START -->
<div class="container" id="blog-headlines">
<div class="container">
<div class="row">
  <div class="col-sm-12">
      <h2><span>Other headlines from our blog</span></h2>
  </div>
</div>
<div class="row">
  <div class="col-sm-6 blog-headlines">
  <article>
  <h3><a href="{{ articles[0].url }}">{{ articles[0].title }}</a></h3>
  <p>{{ articles[0].description }}</p>
  <p><a href="{{ articles[0].url }}">Read more&hellip;</a></p>
  <p class="byline">by <span class="author">{{ articles[0].author }}</span> <span class="date">{{ articles[0].date }}</span></p>
  </article>
  <article>
  <h3><a href="{{ articles[1].url }}">{{ articles[1].title }}</a></h3>
  <p>{{ articles[1].description }}</p>
  <p><a href="{{ articles[1].url }}">Read more&hellip;</a></p>
  <p class="byline">by <span class="author">{{ articles[1].author }}</span> <span class="date">{{ articles[1].date }}</span></p>
  </article>
  </div>
  <div class="col-sm-6 blog-headlines">
    <article>
  <h3><a href="{{ articles[1].url }}">{{ articles[2].title }}</a></h3>
  <p>{{ articles[2].description }}</p>
  <p><a href="{{ articles[2].url }}">Read more&hellip;</a></p>
  <p class="byline">by <span class="author">{{ articles[2].author }}</span> <span class="date">{{ articles[2].date }}</span></p>
  </article>
  <article>
  <h3><a href="{{ articles[3].url }}">{{ articles[3].title }}</a></h3>
  <p>{{ articles[3].description }}</p>
  <p><a href="{{ articles[3].url }}">Read more&hellip;</a></p>
  <p class="byline">by <span class="author">{{ articles[3].author }}</span> <span class="date">{{ articles[3].date }}</span></p>
  </article>
  </div>
</div>
</div>
</div>
<!-- BLOG_HEADLINES_END -->
TEMPLATE

blog_posts = Liquid::Template.parse(template).render 'articles' => @articles

INDEX_FILE = File.expand_path('_site/index.html', '.')
contents = File.open(INDEX_FILE).read
contents.gsub!(/<!-- BLOG_HEADLINES_START -->.*<!-- BLOG_HEADLINES_END -->/im, "\\1#{blog_posts}\\3")

File.open(File.expand_path(INDEX_FILE, '.'), 'w') { |file|
  file.write(contents)
}
