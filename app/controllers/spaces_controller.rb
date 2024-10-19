# frozen_string_literal: true

class SpacesController < ApplicationController
  load_and_authorize_resource
  before_action :set_space, only: %i[edit show update]

  def index
    @spaces = Space.accessible_by(current_ability).order(public: :desc, description: :asc)
    @pagy, @spaces = pagy(@spaces, items: 5)
  end

  def show
    @posts = @space.posts.order(updated_at: :desc)
  end

  def new
    @space = Space.new
    @space.owner = current_user
    set_users_data
  end

  def create
    @space = Space.new(space_params)
    @space.owner = current_user
    if @space.save
      flash[:success] = I18n.t('spaces.create_success')
      redirect_to @space
    else
      flash.now[:error] = @space.errors.full_messages
      render_flash
    end
  end

  def edit
    set_users_data
  end

  def update
    if @space.update(space_params)
      flash[:success] = I18n.t('spaces.update_success')
      redirect_to @space
    else
      flash.now[:error] = @space.errors.full_messages
      render_flash
    end
  end

  def destroy
    if @space.destroy
      flash[:success] = I18n.t('spaces.destroy_success')
      redirect_to spaces_path
    else
      flash.now[:error] = I18n.t('alert.general_error')
      render_flash
    end
  end

  private

  def space_params
    params.require(:space).permit(:description, user_ids: [])
  end

  def set_space
    @space = Space.find(params[:id])
  end

  def set_users_data
    @users_data = User.excluding(@space.owner).order(:email).pluck(:email, :id)
  end
end
