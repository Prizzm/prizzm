namespace :import do
  
  desc "Import compaines from compaines.csv file."
  task :companies => :environment do
    
    def build_address_for (company, type, address)
      unless address.blank? || address.to_s.include?("N/A")
        company.addresses.build :address_type => type.to_s, :address => address.to_s
      end
    end
    
    # Parse the csv & create the mapped objects..
    results = CsvMapper.import( Rails.root.join("imports/companies.csv") ) do
      start_at_row 1
      [name, website, twitter1, twitter2, twitter3, facebook1, facebook2, facebook3, phone_number, contact_url]
    end
    
    # Create the companies..
    results.each do |result|
      puts "Importing: #{result.name}"
      
      Company.find_or_initialize_by_name(result.name).tap do |company|
        company.url  = result.website
        company.addresses = []
        build_address_for company, :twitter, result.twitter1
        build_address_for company, :twitter, result.twitter2Com
        build_address_for company, :twitter, result.twitter3
        build_address_for company, :facebook, result.facebook1
        build_address_for company, :facebook, result.facebook2
        build_address_for company, :facebook, result.facebook3
        build_address_for company, :phone_number, result.phone_number
        build_address_for company, :website, result.contact_url
      end.save(false)
    end
    
  end
  
end