module UserImageable

  #d#e#f #a#d#d#_#i#m#a#g#e#_#f#r#o#m#_#u#r#l #u#r#l
    #s#e#l#f#.#p#r#o#f#i#l#e#.#i#m#a#g#e#s#.#c#r#e#a#t#e#(#:#r#e#m#o#t#e#_#i#m#a#g#e#_#u#r#l #=#> #u#r#l#)
  #e#n#d 

  #d#e#f #a#d#d#_#i#m#a#g#e#_#f#r#o#m#_#f#i#l#e #i#m#a#g#e#_#d#a#t#a
    #s#e#l#f#.#i#m#a#g#e#s#.#c#r#e#a#t#e#(#i#m#a#g#e#_#d#a#t#a#)
  #e#n#d

  def main_image
    photo.url
  end

  def main_image_thumb
    photo.thumb.url
  end
end
