# frozen_string_literal: true

module SvgHelper
  TW_SVG_DEFAULT_CLASS = 'svg-wrapper shrink-0'

  TW_VIEWBOXES = {
    'icons/chevron_down': '0 0 384 512',
    'icons/chevron_up': '0 0 384 512',
    'icons/chevron_up_and_down': '0 0 24 24',
    'icons/cross': '0 0 20 20',
    'icons/magnify': '0 0 24 24',
    'icons/question_mark_circle': '0 0 24 24',
    'icons/spinner': '0 0 512 512'
  }.freeze

  TW_SIZE_CLASS = {
    xs: 'h-3',
    sm: 'h-3.5',
    md: 'h-4',
    lg: 'h-[1.125rem]',
    xl: 'h-5',
    '2xl': 'h-6',
    '3xl': 'h-[1.875rem]',
    '4xl': 'h-9',
    '5xl': 'h-12'
  }.freeze

  def svg_tag(source, size: 'md', svg_class: '', options: {})
    g_color = options.delete(:g_color) || 'currentColor'
    view_box = options.delete(:viewBox) || view_box(source)

    render partial: 'shared/svg', locals: {
      source:,
      g_color:,
      options: {
        viewBox: view_box,
        class: svg_size(size) + (" #{svg_class}" if svg_class)
      }.merge!(options)
    }
  end

  private

  def view_box(source)
    TW_VIEWBOXES[source.to_sym] || '0 0 100 100'
  end

  def svg_size(size)
    "#{TW_SVG_DEFAULT_CLASS} #{TW_SIZE_CLASS.fetch(size.to_sym)}"
  end
end
