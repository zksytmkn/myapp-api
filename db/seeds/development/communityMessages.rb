10.times do |n|
  communityMessage_content = "メッセージになります。こちらサンプルですが、
  メッセージになります。こちらにメッセージを入力することになってます。#{n}"
  user_id = n+1
  community_id = 3
  communityMessage = CommunityMessage.find_or_initialize_by(user_id: user_id)

  if  communityMessage.new_record?
      communityMessage.user_id = user_id
      communityMessage.community_id = community_id
      communityMessage.communityMessage_content = communityMessage_content
      communityMessage.save!
  end
end

puts "communityMessages = #{CommunityMessage.count}"