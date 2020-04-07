namespace :db do
  task dummy_data: :environment do
    load(File.join(Rails.root, 'db', 'dummy_data.rb'))
  end
end