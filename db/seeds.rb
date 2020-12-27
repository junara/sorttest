### Example of bulk insert
def user_params
  time = Faker::Time.backward
  {
    name: Faker::Name.name,
    email: Faker::Internet.email,
    created_at: time,
    updated_at: time
  }
end

def post_params(user_id)
  time = Faker::Time.backward
  {
    user_id: user_id,
    body: Faker::Lorem.paragraph,
    created_at: time,
    updated_at: time
  }
end

def comment_params(user_id, post_id)
  time = Faker::Time.backward
  {
    user_id: user_id,
    post_id: post_id,
    body: Faker::Lorem.paragraph,
    created_at: time,
    updated_at: time
  }
end

Comment.delete_all
Post.delete_all
User.delete_all

User.insert_all!(10.times.map { user_params })
pp User.count
#=> 10

user_ids = User.pluck(:id)

Post.insert_all!(100.times.map { post_params(user_ids.sample) })

post_ids = Post.pluck(:id)
Comment.insert_all!(10000.times.map { comment_params(user_ids.sample, post_ids.sample) })

### Example of Upsert
user = User.first
list = [
  {
    email: user.email,
    name: 'hoge',
    created_at: user.created_at,
    updated_at: Time.now
  },
  {
    email: 'fuga@fuga.co.jp',
    name: 'fuga',
    created_at: Time.now,
    updated_at: Time.now,
  }
]

User.upsert_all(list, unique_by: :email)

pp User.count
#=> 11