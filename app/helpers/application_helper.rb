module ApplicationHelper
  def user_image
      User.all
  end 
  def text_url_to_link(text)
    require 'uri'
    uri_reg = URI.regexp(%w[http https])
    return text.gsub(uri_reg) {"<a href='#{$&}' target='_blank'\>#{$&}</a>"}
  end
end
