module TabsHelper  
  # Return "active" if path points to the active (current) page, nothing otherwise.
  def active_if_current(path)
    current_page?(path) ? "active" : ''
  end
  

end
