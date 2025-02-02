require "rails_helper"

RSpec.describe Contestant, type: :feature do
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

    it "I see the names of that bachelorette's contestants" do
      # User Story 2 of 7 - Bachelorette's Contestants Index

      # As a visitor,
      # When I visit a bachelorette's contestants index '/bachelorettes/:bachelorette_id/contestants',
      # I see the names of that bachelorette's contestants along with the following information:
      # -Age
      # -Hometown
      # (e.g. "Name: Pilot Pete, Age: 34, Hometown: Irving, TX")
      # And I can click on any contestants name (as a link) to go to that contestants show page "/contestants/:id"
      visit "/bachelorettes/#{@bachelorette_1.id}/contestants"

      expect(page).to have_link(@contestant_1.name)
      expect(page).to have_content(@contestant_1.age)
      expect(page).to have_content(@contestant_1.hometown)
      expect(page).to have_link(@contestant_2.name)
      expect(page).to have_content(@contestant_2.age)
      expect(page).to have_content(@contestant_2.hometown)
      expect(page).to_not have_content(@contestant_3.name)

      click_link @contestant_1.name
      expect(current_path).to eq("/contestants/#{@contestant_1.id}")
    end

    it "I see a unique list of all of the hometowns that these contestants are from" do
      # User Story 7 of 7 - Bachelorette's Contestants Index: unique hometowns

      # As a visitor,
      # When I visit a bachelorette's contestants index '/bachelorettes/:bachelorette_id/contestants',
      
      # I see a UNIQUE list of all of the hometowns that these contestants are from.
      
      # (e.g. "These Contestants are from these hometowns: Denver, Aurora, San Diego, Boston")
      visit "/bachelorettes/#{@bachelorette_1.id}/contestants"
        
      within "#hometowns" do
          expect(page).to have_content("These Contestants are from these hometowns:")
          expect(page).to have_content(@contestant_1.hometown)
          expect(page).to have_content(@contestant_2.hometown)
      end
    end
  end
end