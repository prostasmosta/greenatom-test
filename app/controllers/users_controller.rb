class UsersController < ApplicationController
  before_action :set_user, only: %i[show]

  def index
    page = params[:page] || 1
    per_page = params[:per_page] || 10

    @users = User.limit(per_page.to_i).offset((page.to_i - 1) * per_page.to_i)
    render json: User.as_json_collection(@users)
  end

  def show
    render json: @user.as_json_instance
  end

  def create
    @user = User.new(user_params)

    if @user.save
      @user.generate_auth_token!

      response.headers['Authorization'] = @user.auth_token
      render json: @user.as_json_instance, status: :created, location: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation,
                                 passport_data: %i[number issued_by issued_at])
  end
end
