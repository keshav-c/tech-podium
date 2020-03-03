class Message < ApplicationRecord
  belongs_to :user
  validates :text,
            presence: true,
            length: { minimum: 1, maximum: 300 }

  default_scope { order(created_at: :desc) }
end
