helpers do
  def logged_in?
    !!current_user
  end

  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  def require_login
    redirect '/sessions/new' unless logged_in?
  end

  def authorized?(user)
    logged_in? && current_user == user
  end

  # def post_owner(post_id)
  #   User.find_by_id(Event.find_by_id(event_id).user_id)
  # end

end
