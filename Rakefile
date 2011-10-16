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

  desc "Load pseudo-random Dummy Data"
  task :fixtures => :bootstrap do
    Location.fix {{
      :address_street_address => /\d{2,4} \w+ (St|Ave|Rd)/.gen.title_case,
      :address_city    => /Abuja|Kano|Enugu|Lagos/.gen.title_case,
      :address_country_code => 'ng'
    }}

    Physician.fix {{
      :first_name => /\w+/.gen.title_case,
      :last_name  => /\w+/.gen.title_case,
      :hourly_fee => (rand * 50).round + 50,
      :can_volunteer => rand.round,
      :specialties => Array.new(rand(10)) {Physician::SPECIALTIES.random}.uniq,
      :locations  => 2.of {Location.pick},
      :degrees  => 1.of {Degree.make}
    }}

    Degree.fix {{
      :date   => Time.random.to_datetime,
      :name   => Degree::NAMES.random,
      :school => Degree::SCHOOLS.random
    }}

    10.times { Location.gen }
    50.times { Physician.gen }

  end

end