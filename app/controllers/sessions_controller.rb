class SessionsController < ApplicationController
  before_action :logged_user_redirect, only: %i[new create]

  def new; end

  def create
    user = User.find_by(username: params[:session][:username])
    if user&.authenticate(params[:session][:password])
      session[:user_id] = user.id
      flash[:success] = 'Hello bro.'
      redirect_to root_path
    else
      flash.now[:error] = 'Wrong login information.'
      render 'new'
    end
  end

  def destroy
    session[:user_id] = nil 
    flash[:success] = 'Bye bro.'
    redirect_to login_path
  end

  private

  def logged_user_redirect
    if logged_in?
      flash[:error] = 'You allready logged in.'
      redirect_to root_path
    end
  end
end
