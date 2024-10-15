# frozen_string_literal: true

class Manager
  FIRST_STEP = :url

  STEP_FORMS = {
    url: UrlForm,
    metadata: MetadataForm
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

  private

  def compute_possible_steps
    steps = []
    steps_path(FIRST_STEP, steps)
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
        .new(post: @post)
        .tap { |form| @instantiated_forms[step] = form }
    end
  end
end
