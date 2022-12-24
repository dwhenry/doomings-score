class ApplicationController < ActionController::Base
  include Pagy::Backend

  helper_method :current_user

  def current_user
    if cookies[:user]
      user = User.find_by(id: cookies[:user])
      return user if user
    end

    user = User.create(name: User.generate_name)
    cookies[:user] = user.id
    user
  end
end
