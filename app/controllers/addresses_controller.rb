class AddressesController < ApplicationController
    def create
        @company =  Company.find(params[:company_id])
        @address = @company.addresses.create(params[:address])
        redirect_to company_path(@company)
    end
end
