class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.authenticate_with_credentials(params[:session][:email], params[:session][:password])

    if user
      session[:user_id] = user.id
      redirect_to '/'
    else
      Rails.logger.debug "Authentication failed. User: #{user.inspect}"
      
      flash[:alert] = 'Invalid email and/or password'

      redirect_to '/login'
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to '/login'
  end
end
