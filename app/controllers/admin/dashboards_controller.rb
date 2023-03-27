class Admin::DashboardsController < Admin::BaseController
  skip_before_action :require_login, only: %i[index]
  def index;end

end
