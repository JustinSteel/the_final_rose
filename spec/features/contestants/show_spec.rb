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

    it "I see that contestant's name as well as the season number and season description they were on" do
      # User Story 3 of 7 - Contestant's Show Page

      # As a visitor,
      # When I visit a contestants show page,
      # I see that contestants name as well as the season number and season description that this contestant was on.
      # I also see a list of names of the outings that this contestant has been on while on the show.
      # (e.g.
      #                         Ben Higgins
      # Season 20 - No wait, THIS is the most dramatic season yet
      
      # Outings: Kickball
      #         Hot Springs
      #         Helicopter Ride
      # )
      # When I click on an outing name, I'm taken to that outings show page
      visit "/contestants/#{@contestant_1.id}"

      expect(page).to have_content(@contestant_1.name)
      expect(page).to have_content(@bachelorette_1.season_number)
      expect(page).to have_content("Most Violent Season Ever!")
      expect(page).to have_link(@outing_1.name)

      click_link @outing_1.name
      expect(current_path).to eq("/outings/#{@outing_1.id}")
    end
  end
end