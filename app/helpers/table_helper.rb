# rubocop:disable Metrics/PerceivedComplexity, Metrics/MethodLength
module TableHelper
  def table_header(&)
    render 'shared/table/header', &
  end

  def table_cell(&)
    render 'shared/table/cell', &
  end

  def sort_link_to(name = nil, sort_name = nil, search_params = [], &block)
    if block.present?
      sort_name = name
      name = capture(&block)
    end

    current_sort = params[:sort]
    current_sort = params[:sort][1..] if params[:sort].present? && params[:sort].start_with?('-')

    icon = if current_sort != sort_name || current_sort.blank?
             svg_tag('icons/chevron_up_and_down',
                     svg_class: 'inline ml-2',
                     options: { g_color: 'none', fill: 'none', stroke: 'currentColor' })
           elsif params[:sort].start_with?('-') && current_sort == sort_name
             svg_tag('icons/chevron_up', size: 'xs', svg_class: 'inline ml-2')
           else
             svg_tag('icons/chevron_down', size: 'xs', svg_class: 'inline ml-2')
           end

    sort = if current_sort != sort_name || !params[:sort].start_with?('-')
             "-#{sort_name}"
           else
             sort_name
           end

    permitted_params = params.slice(:page, :per_page, *search_params).permit!.to_h

    link_to url_for(permitted_params.merge(sort:)), data: { turbo_action: 'replace' } do
      [
        name,
        icon
      ].join.html_safe
    end
  end
end

# rubocop:enable Metrics/PerceivedComplexity, Metrics/MethodLength
