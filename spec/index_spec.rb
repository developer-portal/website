require 'spec_helper'

describe "Tile page" do
  it_behaves_like 'Page'

  before :each do
    visit "/index.html"
  end

  it "has a correct title" do
    expect(page).to have_title("Fedora Developer Portal")
  end

  it "has a correct headline" do
    expect(page).to have_css("h1", text: "Fedora Developer Portal")
  end

  it "has front navigation" do
    expect(page).to have_css("div#front-nav h3 a", count: 4)
  end

  it "has featured blog posts" do
    expect(page).to have_css("div#blog-features article", count: 2)
  end

  it "has blog headlines" do
    expect(page).to have_css("div#blog-headlines article", count: 4)
  end
end
