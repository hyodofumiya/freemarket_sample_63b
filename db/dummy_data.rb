def item_create(i, c_id)
  Item.create(
      name: "商品#{i}",
      discription: Faker::Coffee.blend_name,
      price: 100+i,
      condition: 0,
      size: 0,
      preparation_day: 0,
      status: 0,
      area: 2,
      delivary_fee: 0,
      user_id: 1,
      category_id: c_id,
  )
end

def image
  for index in 1..100 do 
    item_id = index
    photo = "https://blog-imgs-53.fc2.com/3/1/2/3120226/DSC_0868.jpg"
    date = Faker::Date
    Image.create(
      item_id: item_id,
      photo: photo,
      created_at: date,
      updated_at: date,
    )
  end
end

def item
  i = 1
  for i  in 1..100 do
    case i
    when i<30 then
      item_create(i,3)
    when i>=30&&i<60 then
      item_create(i,201)
    else
      item_create(i,346)
    end
  end
end

item
image