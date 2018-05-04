class ApplicationController < ActionController::Base
  def doorkeeper_unauthorized_render_options(error: nil)
    { json: { error: "Not authorized" } }
  end
end
