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
  has_many :likes
  has_one_attached :photo
  has_one_attached :coverimage

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

  def like_message(message)
    message.likes.create(user_id: id)
  end

  def undo_like(message)
    Like.find_by(user_id: id, message_id: message.id).destroy
  end

  def photo_path
    photo.attached? ? photo : 'default_avatar.png'
  end

  def coverimage_path
    coverimage.attached? ? coverimage : 'default_cover.jpg'
  end

  def users_to_follow
    following_ids = 'SELECT followed_id FROM relationships WHERE follower_id = :user_id'
    User
      .with_attached_photo
      .where("id NOT IN (#{following_ids}) AND id != :user_id", user_id: id)
      .select('fullname, id')
      .order(created_at: :desc)
      .limit(10)
  end
end
