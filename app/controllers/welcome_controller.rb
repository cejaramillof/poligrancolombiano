class WelcomeController < ApplicationController
  before_action :authenticate_user!
  before_action :outdated_user
  def index
  end

  def unregistered
  end

  def perfil
  end

  def dashboard

  end

end
