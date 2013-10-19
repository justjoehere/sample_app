class UsersController < ApplicationController
  before_action :signed_in_user, only: [:edit, :update, :index, :destroy]
  #The before_action ensures signed_in_user applies to edits and updates
  #In english: before performing an update or an edit, execute the signed_in_user code

  before_action :correct_user,   only: [:edit, :update]
  before_action :admin_user,     only: :destroy

  #				Controller
  #request	URL		Action		Named route		Purpose
  #GET		/users		index		users_path		page to list all users
  #GET		/users/1	show		user_path(user)		page to show user
  #GET		/users/new	new		new_user_path		page to make a new user (signup)
  #POST		/users		create		users_path		create a new user
  #GET		/users/1/edit	edit		edit_user_path(user)	page to edit user with id 1
  #PATCH		/users/1	update		user_path(user)		update user
  #DELETE		/users/1	destroy		user_path(user)		delete user
  #Controller action for routes!

  def new
    @user=User.create
  end
  def index
    #@users = User.all
    @users=User.paginate(page: params[:page])
  end
  def create
    @user = User.new(user_params)
    if @user.save
      sign_in @user
      flash[:success] = "Welcome to the Sample App!"
      redirect_to @user
    else
      render 'new'
    end
  end

  def show
    #based on the action and route
    #going to /users/1 on a get request routes to show action in the controller
    #the params[:id] receives the /1
    @user = User.find(params[:id])
  end
  def edit
    #@user=User.find(params[:id])
    #the correct_user before filter defines @user, we can omit it from both actions. Section 9.2.2
  end
  def update
    #@user=User.find(params[:id])
    #the correct_user before filter defines @user, we can omit it from both actions
    if @user.update_attributes(user_params)
      #Handle successful update
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      render 'edit'
    end
  end
  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User deleted."
    redirect_to users_url
  end
  private
    def user_params
      #defines which parameters of the user model get passed.  Allows you to hide some
      #attributes when needed. http://ruby.railstutorial.org/chapters/sign-up#code-create_action_strong_parameters
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end

    #Before filters
    def signed_in_user
      store_location
      redirect_to signin_url, notice: "Please sign in" unless signed_in?
    end
    def correct_user
      @user=User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end
    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end
end
