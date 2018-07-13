class SessionsController < ApplicationController
  # before_action :set_session, only: [:show, :edit, :update, :destroy]
  
  # GET /sessions/new
  def new
    render :new
  end
  
  # POST /sessions
  def create
    @user = User.find_by_credentials(params[:users][:email],params[:users][:password])
    unless @user.nil?
      login!(@user)
      redirect_to user_url(@user)
    else
      flash.now[:errors] = ["Incorrect Email or Password"]
      redirect_to user_url(@user)
    end
  end
  
  # DELETE /sessions/1
  def destroy
    logout!
    redirect_to new_user_url
  end
  
end
