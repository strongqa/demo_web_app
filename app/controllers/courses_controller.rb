class CoursesController < ApplicationController
  before_action :signed_in_as_admin?, except: %i[index]
  layout 'courses'
  skip_before_action :require_login, only: %i[index]
  skip_before_action :require_admin, only: %i[index]

  def index; end
end
