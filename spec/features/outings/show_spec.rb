require "rails_helper"

RSpec.describe Outing, type: :feature do
  describe "As a visitor" do
    before :each do
      @bachelorette_1 = Bachelorette.create!(name: "Ann Franks", season_number: 15)
      @bachelorette_2 = Bachelorette.create!(name: "Hannah Banana", season_number: 13)
      
      @contestant_1 = @bachelorette_1.contestants.create!(name: "Dylan Barbour", age: 24, hometown: "San Diego, CA")
      @contestant_2 = @bachelorette_1.contestants.create!(name: "Tyler Cameron", age: 26, hometown: "Jupiter, FL")
      @contestant_3 = @bachelorette_2.contestants.create!(name: "Peter Weber", age: 27, hometown: "Westlake Village, CA")

      @outing_1 = Outing.create!(name: "Skydiving", location: "New York City, NY", date: "01/01/2020")
      @outing_2 = Outing.create!(name: "Rollercoaster", location: "Denver, CO", date: "02/02/2020")
      @outing_3 = Outing.create!(name: "Hot Air Balloon", location: "San Diego, CA", date: "03/03/2020")

      @contestant_outing_1 = ContestantOuting.create!(contestant_id: @contestant_1.id, outing_id: @outing_1.id)
      @contestant_outing_2 = ContestantOuting.create!(contestant_id: @contestant_2.id, outing_id: @outing_2.id)
      @contestant_outing_3 = ContestantOuting.create!(contestant_id: @contestant_3.id, outing_id: @outing_3.id)
    end

    it "I see that outing's name, location, and date" do
      visit "/outings/#{@outing_1.id}"

      expect(page).to have_content(@outing_1.name)
      expect(page).to have_content(@outing_1.location)
      expect(page).to have_content(@outing_1.date)
      expect(page).to have_content(@outing_1.contestant_count)
      expect(page).to have_content(@contestant_1.name)
    end

    it "I see a link next to each contestant to remove them from the outing" do
      # User Story 5 of 7 - Remove a Contestant from an Outing

      # As a visitor, 
      # When I visit an outings show page, 
      # I see a link next to each contestant's name that says "Remove"
      # When I click that link, I am redirected to the outings show page
      # Where I no longer see the name of that contestant listed. 
      # When I visit a different outings show page with that contestant, 
      # I still see that contestant's name listed.
      visit "/outings/#{@outing_1.id}"

      expect(page).to have_link("Remove")
      expect(page).to have_content(@contestant_1.name)

      click_link "Remove"
      expect(current_path).to eq("/outings/#{@outing_1.id}")

      expect(page).to_not have_content(@contestant_1.name)
      expect(page).to have_content("Contestant Count: 0")
    end
  end
end