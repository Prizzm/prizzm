class CompanyRegistrationsController < Devise::RegistrationsController
  layout "layouts/company_landing", :only => [:new]
end
