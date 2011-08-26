Prizzm::Application.configure do
  # Settings specified here will take precedence over those in config/application.rb

  # In the development environment your application's code is reloaded on
  # every request.  This slows down response time but is perfect for development
  # since you don't have to restart the webserver when you make code changes.
  config.cache_classes = false

  # Log error messages when you accidentally call methods on nil.
  config.whiny_nils = true

  # Show full error reports and disable caching
  config.consider_all_requests_local       = true
  config.action_view.debug_rjs             = true
  config.action_controller.perform_caching = false

  # Print deprecation notices to the Rails logger
  config.active_support.deprecation = :log

  # Only use best-standards-support built into browsers
  config.action_dispatch.best_standards_support = :builtin
  
  config.action_mailer.default_url_options = { :host => 'localhost:3000' }
  config.action_mailer.raise_delivery_errors = true
  config.action_mailer.perform_deliveries = true
  config.action_mailer.delivery_method = :smtp
  config.action_mailer.smtp_settings = { :host => 'localhost:3000', :port => 1025 }


  #A#c#t#i#o#n#M#a#i#l#e#r#:#:#B#a#s#e#.#s#m#t#p#_#s#e#t#t#i#n#g#s #= #{
    #:#a#d#d#r#e#s#s #=#> #"#s#m#t#p#.#s#e#n#d#g#r#i#d#.#n#e#t#"#,
    #:#p#o#r#t #=#> #'#2#5#'#,
    #:#a#u#t#h#e#n#t#i#c#a#t#i#o#n #=#> #:#p#l#a#i#n#,
    #:#u#s#e#r#_#n#a#m#e #=#> #E#N#V#[#'#S#E#N#D#G#R#I#D#_#U#S#E#R#N#A#M#E#'#]#,
    #:#p#a#s#s#w#o#r#d #=#> #E#N#V#[#'#S#E#N#D#G#R#I#D#_#P#A#S#S#W#O#R#D#'#]#,
    #:#d#o#m#a#i#n #=#> #E#N#V#[#'#S#E#N#D#G#R#I#D#_#D#O#M#A#I#N#'#]
  #}
end

