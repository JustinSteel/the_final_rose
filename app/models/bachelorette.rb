class Bachelorette < ApplicationRecord
  has_many :contestants
  
  def season_description
    "Most Violent Season Ever!"
  end
end
