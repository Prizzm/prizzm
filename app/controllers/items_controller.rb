class ItemsController < InheritedResources::Base
  belongs_to :user
  respond_to :html, :json
  layout :determine_layout

  create! do |success, failure| 
    success.html {redirect_to root_path}
  end

  update! do |success, failure| 
    success.html {redirect_to root_path}
  end
  
  def sort
    @user = current_user
    find_changed_item_ids
    update_item_ordering
    head :ok
  end

  # Update the rating on an Item belonging to a User.  The item.id and rating
  # are submitted via AJAX as a parameter.  Find Item in the database with the
  # corresponding ID and update its rating attribute with the supplied rating
  # value.
  def rate
    current_user.items.find(params[:object_id]).update_attribute(:rating, params[:rating])
    head :ok
  end

  private 
  # Apply a layout or not, based on the controller action:
  # If we are looking at a single item, use the normal application layout.
  # However for other AJAX actions, don't use any layout.
    def determine_layout
      ['show'].include?(action_name) ? 'application' : nil 
    end 

  #
    def find_changed_item_ids
      old_item_order = extract_ids(params[:old_item_order])
      new_item_order = extract_ids(params[:new_item_order])
      @old_item_ids = []
      @new_item_ids = []
      new_item_order.each_with_index do |item, index| 
        (old_item_order[index] == item) ? nil : (@new_item_ids << item; @old_item_ids << old_item_order[index]) 
      end
    end

    def update_item_ordering
      old_items = @user.items.find @old_item_ids
      old_positions = old_items.map{|o| o.position }
      @new_item_ids.each_with_index do |item_id, index|
        item = @user.items.find(item_id)
        item.update_attribute(:position, old_positions[index])
      end 
    end
  
    def extract_ids items
      items.map{|item| item.delete('item_').to_i}
    end
end
