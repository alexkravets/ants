class RedirectsController < ApplicationController
  def show
    redirect = Redirect.match(request)
    redirect_to redirect.path_to
  end
end
