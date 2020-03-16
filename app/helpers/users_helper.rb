module UsersHelper
  def stats_color(user)
    current_user == user ? 'stat-num-self' : 'stat-num-other'
  end
end
