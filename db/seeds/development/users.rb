10.times do |n|
  name = "useruseruseruser#{n}"
  email = "#{name}@example.com"
  prefecture = "東京都"
  zipcode = "104-0061"
  street = "東京都中央区銀座6-18-2"
  building = "野村不動産銀座ビル 11階"
  text ="プロフィール文です。こちらにプロフィール文を入力します。プロフィール文です。こちらにプロフィール文を入力します。こちらにサンプルのプロフィール文を入力してください。プロフィール文です。こちらにプロフィール文を入力します。プロフィール文です。こちらにプロフィール文を入力します。こちらにサンプルのプロフィール文を入力してください。"
  user = User.find_or_initialize_by(email: email, confirmation_status: 0)

  if  user.new_record?
      user.name = name
      user.email = email
      user.prefecture = prefecture
      user.zipcode = zipcode
      user.street = street
      user.building = building
      user.text = text
      user.password = "password"
      user.save!
  end
end

puts "users = #{User.count}"
