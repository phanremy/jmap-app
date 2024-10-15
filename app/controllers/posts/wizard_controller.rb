# frozen_string_literal: true

module Posts
  class WizardController < ApplicationController
    before_action :initialize_variables, only: %i[show update]

    def show
      if @step_router.possible_step?(@step)
        set_form
        if @post.link_url.present?
          @locations_data = Location.accessible_by(current_ability)
                                    .order(:id)
                                    .map { |location| [location.address, location.id] }
          @post.inject_metadata
          @location_ids = @post.location_ids
        end
        render @step
      else
        render_error
      end
    end

    def update
      return render_error unless @step_router.possible_step?(@step)

      set_form

      if @form.submit(params[:post]) && @form.complete?
        if @form.next_step.nil?
          redirect_to post_path(@post)
        else
          redirect_to post_wizard_path(id: @form.next_step, post_id: @post.id)
        end
      else
        flash.now[:error] = @form.errors.full_messages.presence || I18n.t('alert.general_error')
        render_flash
        # redirect_to post_wizard_path(id: @step_router.current_step, post_id: @post.id)
      end
    end

    private

    def initialize_variables
      @post = current_user.posts.find(params[:post_id])
      @step = params[:id].to_sym
      @step_router = Wizard::Posts::Router.new(post: @post)
    rescue ActiveRecord::RecordNotFound
      flash.now[:error] = "Post not found"
      redirect_to root_path
    end

    def set_form
      @form ||= @step_router.form_for(@step).new(stuff: @post)
    end

    def render_error
      path = "#{Rails.public_path}/404.html"

      render file: path, status: :not_found, layout: nil
    end
  end
end
