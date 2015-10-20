#!/usr/bin/python -tt
# -*- coding: utf-8 -*-

import codecs
import os
import sys
import feedparser
import re

defenc = "utf-8" if sys.getdefaultencoding() == "ascii" else sys.getdefaultencoding()

FedMag = ['http://fedoraplanet.org/rss20.xml']


HTML = u"""
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
        if int(cnt) % 2 == 0:
            HTML += u"""
    <div class="col-sm-6 blog-headlines">
    """
        item.title = item.title.replace("&", "&#38;")
        author, title = item.title.split(':')
        link = item.links[0]['href']
        # Remove image tag from beginning
        article_desc = '\n'.join(item.description.split('\n')[1:])
        if len(article_desc) > 140:
            article_desc = ' '.join(article_desc.split()[0:25]) + '...'
        # we got
        # Tue, 20 Oct 2015 03:28:42 +0000
        # But we expect
        # Tue, 20 Oct 2015
        article_date = ' '.join(item.updated.split()[:4])
        HTML += u"""
        <article>
        <h3><a href="{article_url}">{article_title}</a></h3>
        <p>{article_desc}</p>
        <p><a href="{article_url}">Read more</a></p>
        <p class="byline">by <span class="author">{author}</span> <span class="date">{article_date}</span></p>
        </article>
""".format(article_url=link,
           article_title=title,
           article_desc=article_desc,
           article_date=article_date,
           author=author)
        cnt += 1
        if int(cnt) % 2 == 0:
            HTML += u"""
    </div>
"""
    HTML += u"""
</div>
</div>
</div>
"""

INDEX_FILE = os.path.join('.', '_site', 'index.html')
with codecs.open(INDEX_FILE, 'r', 'utf8') as f:
    contents = [line for line in f.readlines()]
if contents:
    with codecs.open(INDEX_FILE, 'w', 'utf8') as f:
        found_start = False
        for line in contents:
            if not found_start:
                f.write(line)
            if '<!-- BLOG_HEADLINES_START -->' in line:
                f.write(HTML)
                found_start = True
                continue
            if '<!-- BLOG_HEADLINES_END -->' in line:
                found_start = False
                continue

    #regexp = r'.*(<!-- BLOG_HEADLINES_START -->)(.*)(<!-- BLOG_HEADLINES_END -->).*'
    #print (re.search(regexp, contents, re.MULTILINE | re.DOTALL))
    #contents = re.sub(regexp, r'\1 MYREPLACE \3', contents, re.DOTALL | re.MULTILINE)
