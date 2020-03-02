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
  has_many :follower_relationships,
           class_name: 'Relationship',
           foreign_key: 'followed_id',
           dependent: :destroy
  has_many :followers,
           through: :follower_relationships

  def follow(other)
    following << other
  end

  def unfollow(other)
    following.delete(other)
  end

  def following?(other)
    following.where('followed_id = ?', other.id).exists?
  end

  def relationship_with(user)
    Relationship.find_by(follower_id: id, followed_id: user.id)
  end
end
