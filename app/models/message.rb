class Message < ApplicationRecord
  belongs_to :user
  has_many :likes
  validates :text,
            presence: true,
            length: { minimum: 1, maximum: 300 }

  default_scope { order(created_at: :desc) }

  def self.feed(user, current_user:)
    users_liked = 'SELECT user_id FROM likes WHERE likes.message_id = messages.id'
    condition = "#{current_user.id} IN (#{users_liked})"

    like_id_condition = "user_id = #{current_user.id} AND message_id = messages.id"
    get_like_id = "SELECT likes.id FROM likes WHERE #{like_id_condition}"

    current_user_liked = "CASE WHEN #{condition} THEN TRUE ELSE FALSE END AS liked"
    like_id = "CASE WHEN #{condition} THEN (#{get_like_id}) ELSE NULL END AS like_id"
    num_likes = '(SELECT COUNT(*) FROM likes WHERE message_id = messages.id) AS num_likes'

    if user == current_user
      following_ids = 'SELECT followed_id FROM relationships WHERE follower_id = :user_id'
      Message
        .where("user_id IN (#{following_ids}) OR user_id = :user_id",
               user_id: user.id)
        .includes(user: :photo_attachment)
        .select("messages.*, #{current_user_liked}, #{like_id}, #{num_likes}")
    else
      user.messages
        .includes(user: :photo_attachment)
        .select("messages.*, #{current_user_liked}, #{like_id}, #{num_likes}")
    end
  end
end
