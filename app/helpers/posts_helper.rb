# frozen_string_literal: true

module PostsHelper
  def post_drawer_title(location_name, posts_count)
    count = "#{posts_count} #{I18n.t('post', scope: 'activerecord.models', count: posts_count)}"

    return count unless location_name.present?

    "#{count} for #{location_name}"
  end

  def wizard_link_label
    parsed = Posts::Metadata::ALLOWED_URLS.values.map(&:to_s).join(', ')

    [I18n.t('link_url', scope: 'activerecord.attributes.post'),
     ' (', parsed, ')'].join
  end
end
