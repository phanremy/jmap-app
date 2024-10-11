# frozen_string_literal: true

class PostsController < ApplicationController
  before_action :set_post, except: %i[index new create]
  before_action :authenticate_user!, except: %i[index show]

  def index
    @posts = posts_query
    @posts_count = @posts.size
    @locations_data = Location.accessible_by(current_ability)
                              .order(:id)
                              .map { |location| [location.address, location.id] }
    @pagy, @posts = pagy(@posts, items: 20)
  end

  def show
    @metadata = @post.parsed_metadata
  end

  def new
    @post = Post.new
    set_locations_data
  end

  def create
    @post = Post.new(post_params)
    @post.creator = current_user
    if @post.save
      flash[:success] = I18n.t('posts.create_success')
      redirect_to @post
    else
      flash.now[:error] = @post.errors.full_messages
      render_flash
    end
  end

  def edit
    set_locations_data
  end

  def update
    if @post.update(post_params)
      flash[:success] = I18n.t('posts.update_success')
      redirect_to @post
    else
      flash.now[:error] = @post.errors.full_messages
      render_flash
    end
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

  def posts_query
    Post.accessible_by(current_ability)
        .includes(:location, :spaces)
        .location_query(params[:location_id])
        .order(created_at: :desc)
  end

  def post_params
    params.require(:post).permit(:title, :content, :url, :location_id)
  end

  def set_post
    @post = Post.find(params[:id])
  end

  def set_locations_data
    @locations_data = Location.accessible_by(current_ability)
                              .order(:id)
                              .map { |location| [location.address, location.id] }
  end
end
