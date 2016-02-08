require "random_data"

50.times do
  Post.create!(
    title: RandomData.random_sentence,
    body: RandomData.random_paragraph
  )
end
posts = Post.all

100.times do
  Comment.create!(
    post: posts.sample,
    body: RandomData.random_paragraph
  )
end

puts "Post and Comment Seed finished"
puts "#{Post.count} posts created"
puts "#{Comment.count} comments created"

25.times do
  Advertisement.create!(
    title: RandomData.random_sentence,
    copy: RandomData.random_paragraph,
    price: rand(100)
  )
end

puts "Advertisement Seed finished"
puts "#{Advertisement.count} advertisements created"
