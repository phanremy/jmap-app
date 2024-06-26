# rubocop: disable Layout/HashAlignment

module DropdownHelper
  NARROW_NON_BREAKING_SPACE = 8239

  def dropdown(options = {}, &)
    options = dropdown_options(options).merge(content: capture(&))
    render 'shared/dropdown', **options
  end

  def dropdown_link(title, path, options = {}, &)
    dropdown_link_options = {
      title:       non_breaking(title),
      path:,
      turbo:       provided_key_or(options, :turbo, true),
      deactivated: provided_key_or(options, :deactivated, false)
    }
    render 'shared/dropdown_link', **dropdown_link_options
  end

  private

  def dropdown_options(options)
    {
      button_label_lg:     options[:button_label_lg] || I18n.t('actions.options'),
      button_label_sm:     options[:button_label_sm] || nil,
      by_default_visible:  provided_key_or(options, :by_default_visible, false),
      container_class:     options[:container_class],
      is_left:             provided_key_or(options, :is_left, true),
      is_top:              provided_key_or(options, :is_top, true),
      is_closing_on_click: provided_key_or(options, :is_closing_on_click, true)
    }
  end

  def provided_key_or(options, key, default)
    options.key?(key) ? options[key] : default
  end

  def non_breaking(string)
    string.sub(' ', [NARROW_NON_BREAKING_SPACE].pack('U*'))
  end
end

# rubocop: enable Layout/HashAlignment
