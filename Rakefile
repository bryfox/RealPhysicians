desc "Require app files"
task :init do
  require File.expand_path(File.join(File.dirname(__FILE__), 'config/env.rb'))
end

namespace :db do
  
  desc "Destructively recreate database (DESTROYS ALL DATA)"
  task :bootstrap => :init do
    DataMapper.finalize
    DataMapper.auto_migrate!
  end

  desc "Migrate database tables"
  task :migrate => :init do
    DataMapper.auto_upgrade!
  end

  desc "Load Pseudo-random Dummy Data"
  task :fixtures => :bootstrap do
    Location.fix {{
      :address => /\d{2,4} \w+ St|Ave|Rd/.gen,
      :city    => /\w+/.gen,
      :country => /\w+/.gen
    }}

    Physician.fix {{
      :first_name => /\w+/.gen.gsub(/\b\w/){$&.upcase},
      :last_name  => /\w+/.gen.gsub(/\b\w/){$&.upcase},
      :hourly_fee => (rand * 50).round + 50,
      :can_volunteer => rand.round,
      :specialties => Physician::SPECIALTIES.random,
      :locations  => 2.of {Location.make},
      :degrees  => 1.of {Degree.make}
    }}

    Degree.fix {{
      :degree_date => Time.random.to_datetime,
      :degree_name => Degree::NAMES.random
    }}

    50.times {Physician.gen}

  end

end