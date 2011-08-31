class TagsController < ApplicationController
  before_filter :find_taggable, :except => :list

  def create
    tag = params[:tag].strip
    unless @taggable.tag_list.collect {|t| t.strip}.include? tag
      @taggable.tag_list.add tag
      @taggable.save_tags
    end
    head :ok
  end 

  def destroy
    @taggable.tag_list.remove params[:tag]
    @taggable.save_tags
    head :ok
  end 

  def index
    @items = current_user.items.tagged_with params[:tag] 
  end 

protected
  def find_taggable
    @taggable = object_class(params[:taggable_type]).find(params[:id])
  end 
end
