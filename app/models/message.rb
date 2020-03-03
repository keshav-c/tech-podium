class Message < ApplicationRecord
  belongs_to :user
  has_many :likes
  validates :text,
            presence: true,
            length: { minimum: 1, maximum: 300 }

  default_scope { order(created_at: :desc) }
end
