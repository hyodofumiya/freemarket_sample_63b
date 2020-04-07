FactoryBot.define do
  factory :image do
    association :item
    
    photo {Rack::Test::UploadedFile.new(Rails.root.join('public/material/pict/pict-reason-01.jpg'))}
  end
end
