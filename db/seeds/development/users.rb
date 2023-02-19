10.times do |n|
  name = "user#{n}"
  email = "#{name}@example.com"
  prefecture = "青森県"
  text ="プロフィール文です。"
  user = User.find_or_initialize_by(email: email, activated: true)

  if  user.new_record?
      user.name = name
      user.email = email
      user.prefecture = prefecture
      user.text = text
      user.password = "password"
      user.save!
  end
end

puts "users = #{User.count}"
