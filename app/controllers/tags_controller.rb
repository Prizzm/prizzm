class TagsController < ApplicationController
  before_filter :find_taggable

  def add
    @taggable.tag_list.add params[:tag]
    @taggable.save_tags
    head :ok
  end 

  def remove
    @taggable.tag_list.remove params[:tag]
    @taggable.save_tags
    head :ok
  end 


protected
  def find_taggable
    @taggable = object_class(params[:object_type]).find(params[:id])
  end 
end
