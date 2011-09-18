class AddressesController < ApplicationController
    def create
        @company =  Company.find(params[:company_id])
        @address = @company.addresses.create(params[:address])
        redirect_to company_root_path
    end

    def destroy
      current_company.addresses.find(params[:id]).destroy
      redirect_to company_root_path
    end 
end
