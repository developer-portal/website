# What every single page should contain
RSpec.shared_examples_for 'Page' do
  it "has top-level menu" do
    expect(page).to have_css("ul.nav li", count: 4)
  end

  it "has a search box" do
    expect(page).to have_css("form#search")
    expect(page).to have_css("form#search input")
    expect(page).to have_css("form#search button")
  end

  it "has footer" do
    expect(page).to have_css(".footer")

    # 4 sections: About, Download, Support, Join
    expect(page).to have_css(".footer h3.widget-title", count: 4)

    expect(page).to have_css(".footer p.copy", text: "© 2015 Red Hat, Inc. and others.")
  end
end
