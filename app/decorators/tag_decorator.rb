class TagDecorator < ApplicationDecorator
  delegate_all
  def tag_name
    "#{object.name}"
  end
end
