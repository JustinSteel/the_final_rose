require "rails_helper"

RSpec.describe Bachelorette, type: :model do
  describe "relationships" do
    it {should have_many :contestants}
  end

  describe "instance methods" do
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

    it "#season_description" do
    expect(@bachelorette_1.season_description).to eq("Most Violent Season Ever!")
    end

    it "#average_age" do
      expect(@bachelorette_1.average_age).to eq(25)
    end

    it "#hometowns" do
      expect(@bachelorette_1.hometowns).to eq(["San Diego, CA", "Jupiter, FL"])
    end
  end
end
