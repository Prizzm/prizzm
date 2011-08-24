class NotesController < ApplicationController

  before_filter :load_case

  def create
    @note = @case.notebook.notes.create(:body => params[:note][:body])

    respond_to do |format|
      format.html { render :partial => 'cases/note', :locals  => {:note => @note} }
    end
  end 

  def delete
    @case.notebook.notes.find(params[:id]).destroy
    head :ok
  end

protected

  def load_case
    @case = current_user.cases.find(params[:case_id])
  end 
end
