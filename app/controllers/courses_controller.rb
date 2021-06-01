class CoursesController < ApplicationController
  before_action :signed_in_as_admin?, except: %i[show index]
  layout 'courses'
  skip_before_action :require_login, only: %i[index show]
  skip_before_action :require_admin, only: %i[index show]

  def index # rubocop:disable Metrics/AbcSize
  end
end
