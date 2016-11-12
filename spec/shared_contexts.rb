# What every single page should contain
RSpec.shared_examples_for 'Page' do
  it "has top-level menu" do
    expect(page).to have_css("#logo-col a[href~='/']")
    expect(page).to have_link("Start a project", href: '/start.html')
    expect(page).to have_link("Get tools", href: '/tools.html')
    expect(page).to have_link("Languages & databases", href: '/tech.html')
    expect(page).to have_link("Deploy and distribute", href: '/deployment.html')
    expect(page).to have_css("ul.nav li", count: 4)
  end

  it "has footer" do
    expect(page).to have_css(".footer")

    # 4 sections: About, Download, Support, Join
    expect(page).to have_css(".footer h3.widget-title", count: 4)

    # Footer links
    expect(page).to have_link("About Developer Portal", href: '/about.html')
    expect(page).to have_link("About Fedora", href: '//getfedora.org/en/sponsors')
    expect(page).to have_link("Sponsors", href: '//getfedora.org/en/sponsors')
    expect(page).to have_link("Fedora Magazine", href: 'http://fedoramagazine.org')
    expect(page).to have_link("Legal", href: '//fedoraproject.org/wiki/Legal:Main#Legal')
    expect(page).to have_link("Get Fedora Workstation", href: '//getfedora.org/en/workstation/download')
    expect(page).to have_link("Get Fedora Server", href: '//getfedora.org/en/server/download')
    expect(page).to have_link("Get Fedora Cloud", href: '//getfedora.org/en/cloud/download')
    expect(page).to have_link("Fedora Spins", href: '//spins.fedoraproject.org')
    expect(page).to have_link("Fedora Labs", href: '//labs.fedoraproject.org')
    #expect(page).to have_link("Fedora ARM@", href: '//arm.fedoraproject.org')
    expect(page).to have_link("Torrent Downloads", href: 'http://torrents.fedoraproject.org')
    expect(page).to have_link("Get Help", href: '//fedoraproject.org/wiki/Communicating_and_getting_help')
    expect(page).to have_link("Ask Fedora", href: '//ask.fedoraproject.org/')
    expect(page).to have_link("Forums", href: 'http://fedoraforum.org/')
    expect(page).to have_link("Common Bugs", href: '//fedoraproject.org/wiki/Common_bugs')
    expect(page).to have_link("Installation Guide", href: '//docs.fedoraproject.org/en-US/Fedora/24/html/Installation_Guide')
    expect(page).to have_link("Join Fedora", href: '//fedoraproject.org/wiki/Join')
    expect(page).to have_link("Planet Fedora", href: 'http://fedoraplanet.org')
    expect(page).to have_link("Fedora SIGs", href: '//fedoraproject.org/wiki/SIGs')
    expect(page).to have_link("Fedora Account System", href: '//admin.fedoraproject.org/accounts/')
    expect(page).to have_link("Fedora Community", href: 'http://fedoracommunity.org/')
    expect(page).to have_link("Learn more about the relationship between Red Hat and Fedora »", href: '//www.redhat.com/en/technologies/linux-platforms/articles/relationship-between-fedora-and-rhel')
    expect(page).to have_css(".footer a", count: 27)

    expect(page).to have_css(".footer p.copy", text: "© 2015 Red Hat, Inc. and others.")
  end
end

# Search page does not contain form#search
RSpec.shared_examples_for 'Page with search box' do
  it "has a search box next to the top-level navigation" do
    expect(page).to have_css("form#search")
    expect(page).to have_css("form#search input")
    expect(page).to have_css("form#search button")
  end
end
