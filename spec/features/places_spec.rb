require 'rails_helper'

describe "Places" do
  it "if one is returned by the API, it is shown at the page" do
    allow(BeermappingApi).to receive(:places_in).with("kumpula").and_return(
      [ Place.new( name:"Oljenkorsi", id: 1 ) ]
    )

    visit places_path
    fill_in('city', with: 'kumpula')
    click_button "Search"

    expect(page).to have_content "Oljenkorsi"
  end

  it "if multiple is returned by the API, they are shown at the page" do
  	allow(BeermappingApi).to receive(:places_in).with("kuusamo").and_return(
      [ Place.new( name:"Huono", id: 1 ), Place.new( name:"Vitsi", id: 2 ) ]
    )

    visit places_path
    fill_in('city', with: 'kuusamo')
    click_button "Search"

    expect(page).to have_content "Huono"
    expect(page).to have_content "Vitsi"
  end

  it "if none is returned by the API, notice is shown at the page" do
  	allow(BeermappingApi).to receive(:places_in).with("kontula").and_return(
      []
    )

    visit places_path
    fill_in('city', with: 'kontula')
    click_button "Search"

    expect(page).to have_content "No locations in kontula"
   end
end