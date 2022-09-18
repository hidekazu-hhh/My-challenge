class StaticPagesController < ApplicationController
  skip_before_action :require_login, only: %i[page start_page hope]
  def top
  end
end
