class Favorite < ApplicationRecord
  belongs_to :beer
  belongs_to :user
end
