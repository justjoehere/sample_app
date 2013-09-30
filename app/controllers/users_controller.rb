class UsersController < ApplicationController
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
  end

  def show
    #based on the action and route
    #going to /users/1 on a get request routes to show action in the controller
    #the params[:id] receives the /1
    @user = User.find(params[:id])
  end
end
