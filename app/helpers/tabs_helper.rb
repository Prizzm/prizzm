module TabsHelper

  def tab_for(path)
    "active" if current_page?(path)
  end

end
