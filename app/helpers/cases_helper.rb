module CasesHelper
  def public_cases
    #Case.publicly.all
    Case.all
  end
  
  # Address formatting..
  
  def formatted_addresses_for (company)
    unless company.addresses.blank?
      company.addresses.group_by(&:address_type).map do |type, addresses|
        header_for_address_type(type, addresses.count) <<
        content_tag(:ul) do
          addresses.map { |address| formatted_address(address) }.join(" ").html_safe
        end
      end.join("\n").html_safe
    else
      content_tag(:div, "No contact info yet..", :class => "placeholder")
    end
  end
  
  def header_for_address_type (type, count = 1)
    icon_class = Company::ADD_ICON[type]
    label = case type
      when "twitter" then "Twitter"
      when "facebook" then "Facebook"
      when "phone_number" then "Phone Numbers"
      when "website" then "Websites"
      when "street_address" then "Street Addresses"
    end
    
    content_tag(:h5, "#{label} (#{count})", :class => icon_class)
  end
  
  def formatted_address (address)
    type = address.address_type
    address = address.address
    shortened = truncate(address, :length => 30)
    
    content_tag(:li, :class => "#{type}-type") do
      case type
        when "twitter"
          link_to("@#{shortened}", "http://www.twitter.com/%s" % address, :target => "_blank", :title => "Visit on twitter.")
        when "facebook"
          link_to(shortened, address, :target => "_blank", :title => "Visit on facebook.")
        when "phone_number"
          link_to(shortened, "javascript:void(0);", :class => "call", "data-value" => address, :title => "Call #{address}.")
        when "website" 
          link_to(shortened, address, :target => "_blank", :title => "Visit #{address}.")
        when "street_address" 
          address # hmm?
      end
    end
  end
  
end