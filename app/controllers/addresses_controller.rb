class AddressesController < ApplicationController
    def new
      if params[:company_id].nil? == false
        @company = Company.find params[:company_id]
      end

      render :layout => false
    end

    def create
      @company =  Company.find(params[:company_id])
      @address = @company.addresses.create(params[:address])
      
      respond_to do |format|
        format.html {
           redirect_to company_root_path
         }
         format.js {
           @addresses = @company.addresses
         }
      end
    end


    def destroy
      current_company.addresses.find(params[:id]).destroy
      redirect_to company_root_path
    end 
end
