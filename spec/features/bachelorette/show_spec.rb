require "rails_helper"

RSpec.describe Bachelorette, type: :feature do
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
    
    it "I see that bachelorette's name, season number, and season description" do
      # User Story 1 of 7 - Bachelorette Show Page & Bachelorette's Contestants Index

      # As a visitor,
      # When I visit '/bachelorettes/:id',
      # I see that bachelorette's:
      # -Name
      # -Season Number
      # -Description of Season that they were on
      # (e.g.             
      #                   Hannah Brown
      #     Season 15 - The Most Dramatic Season Yet!
      #   )
      # I also see a link to see that bachelorette's contestants
      # When I click on that link
      # I'm taken to "/bachelorettes/:bachelorette_id/contestants"
      # and I can see only that bachelorette's contestants
      visit "/bachelorettes/#{@bachelorette_1.id}"

      expect(page).to have_content(@bachelorette_1.name)
      expect(page).to have_content(@bachelorette_1.season_number)
      expect(page).to have_content("Most Violent Season Ever!")
    end

    it "I see a link to that bachelorette's contestants" do
      visit "/bachelorettes/#{@bachelorette_1.id}"

      expect(page).to have_link("Contestants")
      
      click_link "Contestants"
      expect(current_path).to eq("/bachelorettes/#{@bachelorette_1.id}/contestants")

      expect(page).to have_content(@contestant_1.name)
      expect(page).to have_content(@contestant_2.name)
      expect(page).to_not have_content(@contestant_3.name)
    end
  end
end