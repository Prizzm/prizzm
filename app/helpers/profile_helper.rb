module ProfileHelper

  def your_profile?
    @user == current_user
  end

  def review_instruction_for item
    if item.review.blank?
      "Write review"
    else
      "Read review"
    end
  end

end
