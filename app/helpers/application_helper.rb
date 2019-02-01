module ApplicationHelper
  def image_tag(source, options={})
    super(source, options) if source.present?
  end

  def form_error_messages!(resource)
    return '' if resource.errors.empty?

    messages = (resource.errors.messages.map do |key, value|
      (value.map {|e| content_tag(:li, e)}).join
    end).join

    html = <<-HTML
    <div class="alert alert-danger alert-block"> <button type="button"
    class="close" data-dismiss="alert">x</button>
      #{messages}
    </div>
    HTML

    html.html_safe
  end
end
