class Cat < ApplicationRecord
  COLORS = [
    "black",
    "white",
    "grey"
  ]

  GENDERS = [
    "M",
    "F"
  ]
  
  validates :name, :birth_date, :color, :sex, :description, presence: true
  validates :color, inclusion: COLORS
  validates :sex, inclusion: GENDERS
  
  has_many :cat_rental_requests, dependent: :destroy

  
end