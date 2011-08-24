class NotesController < ApplicationController

  before_filter :load_case

  def create
    @note = @case.notebook.create(params[:note])

    respond_to do |format|
      format.html { render :partial => 'case/note', :locals  => {:note => @note} }
      format.js { }
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
