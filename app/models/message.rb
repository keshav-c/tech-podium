class Message < ApplicationRecord
  belongs_to :user
  validates :text,
            presence: true,
            length: { minimum: 1, maximum: 300 }
end
