module CasesHelper
  def public_cases
    Case.publicly.all
  end 
end
