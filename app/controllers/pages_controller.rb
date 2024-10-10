# frozen_string_literal: true

class PagesController < ApplicationController
  # authorize_resource class: false
  skip_before_action :authenticate_user!
  skip_authorization_check

  def front; end

  def map; end
  # @posts = Post.accessible_by(current_ability).order(created_at: :desc)

  def moon
    cookies[:moon] = { value: 'on' }
    redirect_to request.referrer || root_url
  end

  def sun
    cookies.delete(:moon)
    redirect_to request.referrer || root_url
  end

  def open_modal
    render turbo_stream: turbo_stream.append(
      :modal,
      partial: 'shared/modal',
      locals: { content: params[:content] }
    )
  end
end
