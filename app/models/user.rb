class User < ApplicationRecord
  validates :username,
            presence: true,
            length: { minimum: 4, maximum: 30 },
            uniqueness: true
  validates :fullname,
            presence: true,
            length: { minimum: 4, maximum: 50 }

  has_many :messages
  has_many :following_relationships,
           class_name: 'Relationship',
           foreign_key: 'follower_id',
           dependent: :destroy
  has_many :following,
           through: :following_relationships,
           source: :followed
end
