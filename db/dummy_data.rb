require "factory_bot"

include FactoryBot::Syntax::Methods

FactoryBot.definition_file_paths = [Rails.root.join("spec", "factories")]
FactoryBot.reload

if user = build(:user, email: "a@a", password: "aaaaaaa", password_confirmation: "aaaaaaa") and user.save
  
else
  user = create(:user, password: "aaaaaaa", password_confirmation: "aaaaaaa")
end
create(:shopping_address, user_id: user.id)

100.times do |i|
  item = create(:item, user_id: User.take.id, category_id: Category.find(Category.pluck(:id).sample).id)
  create(:image, item_id: item.id)
  create(:comment, user_id: user.id, item_id: item.id)
end