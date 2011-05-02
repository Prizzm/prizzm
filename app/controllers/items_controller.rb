class ItemsController < InheritedResources::Base
  belongs_to :user
  respond_to :html, :json
  layout nil, :except => :show

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

  def rate
    current_user.items.find(params[:object_id]).update_attribute(:rating, params[:rating])
    head :ok
  end

  private 
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
