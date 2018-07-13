class UsersController < ApplicationController
  # before_action 
  
  
  # GET /users/new
  def new
    @user = User.new
    render :new
  end
  
  def show
    @user = User.find(params[:id])
    render :show
  end
  
  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)
    
    if @user.save
      login!(@user)
      redirect_to user_url(@user)
    else
      format.html { render :new }
      format.json { render json: @user.errors, status: :unprocessable_entity }
    end
    
  end
  
  
  private
  
  # Never trust parameters from the scary internet, only allow the white list through.
  def user_params
    params.require(:users).permit(:email, :password)
  end
end
