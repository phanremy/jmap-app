# frozen_string_literal: true

module ButtonsHelper
  SIZE_CLASSES = { sm: 'font-normal py-1 px-3',
                   base: 'font-semibold py-2 px-4' }.freeze

  def primary_link(label, path, options = {})
    # options[:data] = { turbo: false }
    options[:class] = "#{options[:class]} bg-primary hover:bg-primary-darker text-primary-foreground " \
                      "#{size_classes(options)} text-center border border-transparent rounded".strip
    link_to label, path, options
  end

  def secondary_link(label, path, options = {})
    # options[:data] = { turbo: false }
    options[:class] = "#{options[:class]} bg-secondary hover:bg-secondary-darker text-secondary-foreground " \
                      "#{size_classes(options)} text-center border border-transparent rounded".strip
    link_to label, path, options
  end

  def destructive_button(label, path, turbo_confirm, options = {})
    options[:form] = { data: { turbo_confirm: } }
    options[:class] = "#{options[:class]} bg-destructive hover:bg-destructive-darker text-destructive-foreground " \
                      "#{size_classes(options)} text-center border border-transparent rounded".strip

    button_to label, path, method: :delete, **options
  end

  private

  def size_classes(options)
    SIZE_CLASSES[options[:size]] || SIZE_CLASSES[:base]
  end
end
