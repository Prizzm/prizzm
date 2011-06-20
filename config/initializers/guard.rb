if Rails.env.development?
  case RUBY_PLATFORM
  when /darwin/i
    require 'rb-fsevent'
  when /linux/i
    require 'rb-inotify'
    require 'libnotify'
  end
end
