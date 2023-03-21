module ApplicationHelper
  def icon(family, name)
    content_tag(:i, nil, class: "#{family} fa-#{name}")
  end
end
