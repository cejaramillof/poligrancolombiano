class UsersController < ApplicationController
  before_action :authenticate_admin!
  before_action :set_user, only: [:approve, :edit, :update, :show]
  before_action :allow_without_password, only: [:update]

  def index
    if params[:approved] == "false"
      @users = User.where(approved: false)
    elsif params[:approved] == "true"
      @users = User.where(approved: true)
    else
      @users = User.all
    end
  end

  def approve
    @user.update(approved: 1, created_at: Time.now)
    redirect_to users_path(:approved => "false")
  end

  def edit
    @user.meals.build
  end

  def update
    if @user.update(user_params)
      redirect_to users_path
    else
      render 'edit'
    end
  end

  private
  def set_user
    @user = User.find(params[:id])
  end

  #save without password
  def allow_without_password
    if params[:user][:password].blank? && params[:user][:password_confirmation].blank?
      params[:user].delete(:password)
      params[:user].delete(:password_confirmation)
    end
  end

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :birth_date, :height, :sex, :name, :approved, :created_at, :admin, meals_attributes: Meal.attribute_names.map(&:to_sym).push(:_destroy))
  end
end