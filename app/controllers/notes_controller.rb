class NotesController < ApplicationController

  before_filter :load_case

  def create
    @note = @case.notebook.notes.create(params[:note])
    respond_to do |format|
      format.html { render :partial => 'cases/note', :locals  => {:note => @note} }
    end
  end 

  def update
    puts params.inspect
    @case.notebook.notes.find(params[:id]).update_attributes(params[:note])
    head :ok
  end

  def destroy
    @case.notebook.notes.find(params[:id]).destroy
    respond_to do |format|
      format.html {render :json => params[:id] }
    end 
  end

protected

  def load_case
    @case = current_user.cases.find(params[:case_id])
  end 
end
