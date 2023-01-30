10.times do |n|
  name = "コミュニティ#{n}"
  maker = "user#{n}"
  text = "紹介文です。サンプルです。"
  community = Community.find_or_initialize_by(name: name)

  if  community.new_record?
      community.name = name
      community.maker = maker
      community.text = text
      community.save!
  end
end

puts "communities = #{Community.count}"