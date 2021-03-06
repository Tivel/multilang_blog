class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      log_in user
      redirect_to main_page_path(user.name)
    else
      render :new
    end
  end

  def destroy
    log_out
    redirect_to users_path
  end
end
