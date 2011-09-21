class CorporateController < ApplicationController
  layout 'corporate'
  before_filter :authenticate_company!

  def home
    @company = current_company
  end
end
