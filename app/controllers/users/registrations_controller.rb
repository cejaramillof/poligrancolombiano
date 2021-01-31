class Users::RegistrationsController < Devise::RegistrationsController
  # Override the action you want here.
  def new
    @user = User.new
    @user.meals.build
  end
  def edit
    @user.meals.build
  end
  private
  #save without password
  def update_resource(resource, params)
    resource.update_without_password(params)
  end
end