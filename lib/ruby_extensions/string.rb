class String
  def limit(max_characters = 30, trailing_string = '..')
    str_length = self.length

    if str_length > max_characters
      short_string = self[0...max_characters-trailing_string.length].strip + trailing_string
    else
      short_string = self
    end 

    short_string
  end
end
