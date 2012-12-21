class UsersController < ApplicationController
  before_filter :signed_in_user, only: [:index, :edit, :update, :destroy] 
    #arranges for specified methods to be called before specific actions
  before_filter :correct_user,   only: [:edit, :update]  #? why is a method here called by a 'symboled' version?
  before_filter :admin_user,     only: :destroy          #? does this in combination with first before_filter ensure signed in && admin?

  def new
    @user = User.new
  end

  def show
    @user = User.find(params[:id])
    @microposts = @user.microposts.paginate(page: params[:page])
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      sign_in @user
      flash[:success] = "Welcome to the Sample App!"     
      redirect_to @user # Handle a successful save.
    else
      render 'new'
    end
  end

  def index
    #@users = User.all
    @users = User.paginate( page: params[:page] )
  end

  def edit 
#   @user = User.find(params[:id]) # this is redundant now because of before filter^ and correct_user call
  end

  def update
#   @user = User.find(params[:id]) # same as comment in edit
    if @user.update_attributes(params[:user])  #? so update action hits up users model to check which attributes can be updated.
          #update_attributes takes in a hash (provided here by params[:user]
      flash[:success] = "Profile updated"
      sign_in @user
      redirect_to @user
    else
      render 'edit'
    end
  end

  def destroy
    User.find(params[:id]).destroy #? so when we go :   link_to "delete", user, method: :delete it goes and pulls this users params?
    flash[:success] = "User destroyed."
    redirect_to users_url
  end

  private
   
    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_path) unless current_user?(@user)
    end
   
    def admin_user 
      redirect_to(root_path) unless current_user.admin?
    end
end
