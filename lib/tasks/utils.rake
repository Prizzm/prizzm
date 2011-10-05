namespace :db do
  task :rebuild => [:drop, :migrate, "test:prepare"]
  # does NOT work... stick with shell aliases
  # rds='rake db:drop: rake db:migrate: rake db:test:prepare: rake db:seed'
  #task :reseed => [:drop, :migrate, "test:prepare", :seed]

  desc "This temporary task is to remove items with null user"
  task :clean_null => :environment do
    items = Item.find(:all, {
      :conditions => {
        :user_id => nil
      }
    });

    if items.count > 0
      items.each do |item|
        item.destroy
      end
    end
  end


  desc "This temporary task will destroy duplicate products and update relationships"
  task :clean_duplicates => :environment do
    items = Item.find(:all);

    if items.count > 0
      items.each do |item|
        product = Product.find(:first, :conditions => { :name => item.name});


        if product.nil? == false
          item.name    = nil;
          item.product = product
          item.company = product.company if product.company.nil? == false
          item.save
        end
      end
    end
  end

end


