# frozen_string_literal: true

class PostsController < ApplicationController
  include Posts::Query

  before_action :set_post, except: %i[index create]
  before_action :authenticate_user!, except: %i[index show]

  def index
    @posts = posts_query.includes(:location, :spaces)
    @posts_count = @posts.size
    @location_name = Location.find(params[:location_id]).address if params[:location_id]
    @pagy, @posts = pagy(@posts, items: 20)
  end

  def show; end

  def create
    @post = current_user.posts.incomplete.first || Post.create!(creator: current_user)

    if @post.persisted?
      redirect_to post_wizard_path(id: Wizard::Posts::Router.first_step, post_id: @post.id)
    else
      flash.now[:error] = I18n.t('alert.general_error')
      render_flash
    end
  end

  def edit
    redirect_to post_wizard_path(id: Wizard::Posts::Router.first_step, post_id: @post.id)
  end

  def destroy
    if @post.destroy
      flash[:success] = I18n.t('posts.destroy_success')
      redirect_to posts_path
    else
      flash.now[:error] = I18n.t('alert.general_error')
      render_flash
    end
  end

  private

  def post_params
    params.require(:post).permit(:link_url)
  end

  def set_post
    @post = posts_query.find(params[:id])
  end
end
