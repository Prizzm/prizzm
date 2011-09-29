module IconHelper

  def edit_icon
    image_tag 'edit.png', :height => '50', :width => '50'
  end

  def delete_icon
    image_tag 'trash.png', :height => '50', :width => '50'
  end
end
