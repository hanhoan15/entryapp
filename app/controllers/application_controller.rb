class ApplicationController < ActionController::Base
  rescue_from StandardError, :with => :rescue_standard_error

  private
  def rescue_standard_error(e)
    respond_to do |format|
      format.html { redirect_to "/500" }
      format.all  { render nothing: true, status: 500}
    end
  end
end
