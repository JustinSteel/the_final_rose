class Bachelorette < ApplicationRecord
  has_many :contestants
  
  def season_description
    "Most Violent Season Ever!"
  end

  def average_age
    contestants.average(:age)
  end

  def hometowns
    contestants.pluck(:hometown).uniq
  end
end
