class Review < ApplicationRecord
  belongs_to :beer
  belongs_to :user
  validates :content, presence: true, length: { minimum: 10 }
  STARS = [0, 1, 2, 3, 4, 5]
end
