class Like < ApplicationRecord
  belongs_to :user
  belongs_to :message
  validates :message, uniqueness: { scope: :user }
end
