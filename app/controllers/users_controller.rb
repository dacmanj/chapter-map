class UsersController < ApplicationController
  before_filter :authenticate_user!, :except => [:new, :create, :confirm]
  before_filter :correct_user?, :except => [:new, :create, :index,:delete_multiple, :confirm]
  before_filter :admin_user?

  def index
    @users = User.all
  end

  # POST /chapters
  # POST /chapters.json
#  def create
#    respond_to do |format|
#      if @user.save
#        UserMailer.create_user_email(@user).deliver
#        format.html { redirect_to root_path, :notice => 'User was successfully created. Check your email for a confirmation link.' }
#        format.json { render json: @user, status: :created, location: @user }
#      else
#        format.html { render action: "new", :notice => @user.errors }
#        format.json { render json: @user.errors, status: :unprocessable_entity }
#      end
#    end
#  end


  def edit
    @user = User.find(params[:id])
  end
  

  def confirm
    @user = User.activate(params)
    if @user
      flash[:notice] = "User successfully confirmed. You can now login!"
      redirect_to new_session_path
    else
      flash[:notice] = "Invalid confirmation link"
      redirect_to root_path
    end
  end

  def update
    @user = User.find(params[:id])

    respond_to do |format|
      if @user.update_attributes(params[:user])
          format.html { redirect_to chapters_path, notice: 'User profile successfully updated.' }
          format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # GET /users/new
  # GET /users/new.json
  def new
    @user = env['omniauth.identity'] ||= User.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @user }
    end
  end

  def show
    @user = User.find(params[:id])
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user = User.find(params[:id])
    @user.destroy

    respond_to do |format|
      format.html { redirect_to users_url }
      format.json { head :no_content }
    end
  end


  def delete_multiple
    @users = User.find(params[:user_ids])
    @users.each do |user|
      user.destroy
    end
    flash[:notice] = "Deleted users!"
    redirect_to users_path
  end

end
