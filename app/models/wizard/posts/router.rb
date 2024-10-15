# frozen_string_literal: true

module Wizard
  module Posts
    class Router
      STEP_FORMS = {
        link_url: Wizard::Posts::LinkUrl,
        metadata: Wizard::Posts::Metadata
      }.freeze

      def initialize(post:)
        @post = post
        @instantiated_forms = {}
        @possible_steps = compute_possible_steps
      end

      def current_step
        @possible_steps.find do |step|
          return nil if step.nil?

          form = find_or_instantiate_form_for(step)
          !form.complete?
        end
      end

      def possible_step?(step)
        STEP_FORMS.include?(step)
      end

      def form_for(step)
        STEP_FORMS.fetch(step)
      end

      def self.first_step
        STEP_FORMS.keys.first
      end

      private

      def compute_possible_steps
        steps = []
        steps_path(STEP_FORMS.keys.first, steps)
        steps
      end

      def steps_path(starting_step, steps_acc)
        steps_acc.push(starting_step)

        return if starting_step.nil?

        form = find_or_instantiate_form_for(starting_step)
        steps_path(form.next_step, steps_acc) if form.complete?
      end

      def find_or_instantiate_form_for(step)
        @instantiated_forms.fetch(step) do
          form_for(step)
            .new(stuff: @post)
            .tap { |form| @instantiated_forms[step] = form }
        end
      end
    end
  end
end
