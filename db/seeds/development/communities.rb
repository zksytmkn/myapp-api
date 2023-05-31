10.times do |n|
  name = "コミュニティ。#{n}"
  user_id = n+1
  description = "紹介文です。
  "
  community = Community.find_or_initialize_by(name: name)

  if  community.new_record?
      community.name = name
      community.user_id = user_id
      community.description = description
      community.save!
  end
end

puts "communities = #{Community.count}"