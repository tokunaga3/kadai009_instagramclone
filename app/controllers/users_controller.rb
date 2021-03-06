class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to new_session_path(@user.id)
    else
      render :new
    end
  end

  def update
    if @user.update(user_params)
      redirect_to user_path(@user.id), notice: "編集しました！"
    else
      render :edit
    end
  end

  def show
  end

  def edit
    if @user.id == current_user.id
    else
      redirect_to feeds_path, notice: "ログインユーザーが違うので編集できません"
    end
  end

  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'user was successfully destroyed.' }
    end
  end

  private
  def user_params
    params.require(:user).permit(:name, :email, :password,
                                 :password_confirmation, :image ,:image_cache ,:content)
  end
  def set_user
    @user = User.find(params[:id])
  end

end
