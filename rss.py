#!/usr/bin/python -tt
# -*- coding: utf-8 -*-

import codecs
import os
import sys
import feedparser
import re

#FedMag = ['http://fedoramagazine.org/feed']
FedMag = ['http://fedoraplanet.org/rss20.xml']


HTML = u"""
<!-- BLOG_HEADLINES_START -->
"""


for feed in map(feedparser.parse, FedMag):
    # We will parse last ten items
    HTML += u"""
<div class="container" id="blog-headlines">
    <div class="container">
    <div class="row">
      <div class="col-sm-12">
          <h2><span>Other headlines from our blog</span></h2>
      </div>
    </div>
    <div class="row">
"""
    cnt = 0
    for item in feed["items"][:4]:
        if cnt % 2 == 0:
            HTML += u"""
    <div class="col-sm-6 blog-headlines">
    """
        # Date format: '%a, %d %b %Y %H:%M:%S +0000'
        # removing '[...]' from the summary, so its cleaner
        summary = item.summary.rstrip(' [&#8230;]').replace("&#8217;", "'").replace("&#8217", "'")
        item.title = item.title.replace("&", "&#38;")
        author, title = item.title.split(':')
        link = item.links[0]['href']
        article_desc = item.description
        if len(article_desc) > 140:
            article_desc = article_desc[120:] + '...'
        # we got
        # Tue, 20 Oct 2015 03:28:42 +0000
        # But we expect
        # Tue, 20 Oct 2015
        article_date = ' '.join(item.updated.split()[:4])
        HTML += u"""
        <article>
        <h3><a href="{article_url}>{article_title}</a></h3>
        <p>{article_desc}</p>
        <p><a href="{article_url}">Read more</a></p>
        <p class="byline">by <span class="author">{author}</span> <span class="date">{article_date}</span></p>
        </article>
""".format(article_url=link,
           article_title=item.title,
           article_desc=article_desc,
           article_date=article_date,
           author=author)
        if cnt % 2 == 0:
            HTML += u"""
    </div>
"""
        cnt += 1
    HTML += u"""
</div>
</div>
</div>
<!-- BLOG_HEADLINES_END -->
"""

INDEX_FILE = os.path.join(os.getcwd(), '_site', 'index.html')
with open(INDEX_FILE, 'r') as f:
    contents = f.read()
if contents:
    with open(INDEX_FILE, 'w') as f:
        regexp = r'<!-- BLOG_HEADLINES_START -->.*<!-- BLOG_HEADLINES_END -->'
        #print (re.search(regexp, contents, re.M | re.DOTALL))
        #print (HTML)
        contents = re.sub(regexp, HTML, contents, re.M | re.DOTALL)
        #print (contents)
        f.write(contents)
