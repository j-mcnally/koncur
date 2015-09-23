class PagesController < ApplicationController
  protect_from_forgery with: :exception

  layout "devise"

  def invalid

  end

end
