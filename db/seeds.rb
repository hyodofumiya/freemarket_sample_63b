# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


require "factory_bot"

include FactoryBot::Syntax::Methods

FactoryBot.definition_file_paths = [Rails.root.join("spec", "factories")]
FactoryBot.reload

user = create(:user, email: "a@a", password: "aaaaaaa", password_confirmation: "aaaaaaa")
create(:shopping_address, user_id: user.id)
item = create(:item, user_id: user.id)
create(:image, item_id: item.id)
create(:comment, user_id: user.id, item_id: item.id)