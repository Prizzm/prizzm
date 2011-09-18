class CorporateController < ApplicationController
  layout 'corporate'

  def home
    @company = current_company
  end

end
