class Api::UsersController < ApplicationController
  before_action :doorkeeper_authorize!

  def show
    render json: current_resource_owner.as_json
  end

  private

  def current_resource_owner
    User.find(doorkeeper_token.resource_owner_id) if doorkeeper_token
  end
end
