# frozen_string_literal: true

class UsersController < ApplicationController
  load_and_authorize_resource

  def index
    params[:sort] ||= '-created_at'

    @pagy, @users = pagy users_query
    @search_params = %i[search admin confirmed]
  end

  def edit; end

  def update
    @user = User.find(params[:id])
    @user.skip_password_validation = true if params[:user][:password].blank?
    if @user.update(user_params)
      flash[:success] = I18n.t('users.update_success')
      redirect_to users_path
    else
      flash.now[:error] = @user.errors.full_messages
      render_flash
    end
  end

  def destroy
    @user = User.find(params[:id])
    if @user != current_user && @user.destroy
      flash[:success] = I18n.t('users.destroy_success')
      redirect_to users_path
    else
      flash.now[:error] = @user.errors.full_messages.presence || I18n.t('users.destroy_not_yourself')
      render_flash
    end
  end

  private

  def users_query
    User.accessible_by(current_ability)
        .email_query(params[:search])
        .admin_query(params[:admin])
        .confirmed_query(params[:confirmed])
        .apply_sort(params[:sort])
  end

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, :admin, :confirmed)
  end
end
