FactoryBot.define do
  factory :image do    
    photo {Rack::Test::UploadedFile.new(Rails.root.join('public/material/pict/pict-reason-01.jpg'))}
  end
end
