class User < ApplicationRecord
  validates :username,
            presence: true,
            length: { minimum: 4, maximum: 30 },
            uniqueness: true
  validates :fullname,
            presence: true,
            length: { minimum: 4, maximum: 50 }

  has_many :messages
end
