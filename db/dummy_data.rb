def image
  100.times do |index|
    item_id = index % 55
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
  100.times do |i|
    case i
    when i<30 then
      c_id = 3
    when i>=30&&i<60 then
      c_id = 201
    else
      c_id = 346
    end
    Item.create(
        name: "商品#{+ i}",
        discription: Faker::Coffee.blend_name,
        price: 100+i,
        condition: 0,
        size: 0,
        preparation_day: 0,
        email: "#{i}@#{i}",
        status: 0,
        area: "#{i%46}",
        delivary_fee: 0,
        user_id: "#{i%3}",
        category_id: c_id,
    )
  end
end

item
image