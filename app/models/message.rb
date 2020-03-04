class Message < ApplicationRecord
  belongs_to :user
  has_many :likes
  validates :text,
            presence: true,
            length: { minimum: 1, maximum: 300 }

  default_scope { order(created_at: :desc) }

  def self.feed(user, current_user, user_logged_in:)
    current_user_liked = 
      "CASE 
       WHEN #{current_user.id} IN (SELECT user_id FROM likes WHERE likes.message_id = messages.id)
       THEN TRUE 
       ELSE FALSE 
       END 
       AS liked"
    if user_logged_in
      following_ids = 'SELECT followed_id FROM relationships WHERE follower_id = :user_id'
      Message.
        where("user_id IN (#{following_ids}) OR user_id = :user_id",
              user_id: user.id).
        includes(:user).
        select("messages.*, #{current_user_liked}")
    else
      user.messages.includes(:user).select("messages.*, #{current_user_liked}")
    end
  end
end
