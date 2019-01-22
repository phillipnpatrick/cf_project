FactoryBot.define do
   sequence(:email, 100) { |n| "user#{n}@hogwarts.edu" }
   
   factory :user, class: User do
       email
       password "goldensnitch"
       first_name "Harry"
       last_name "Potter"
       admin false
   end
   
   factory :admin, class: User do
       email
       password "elderwand"
       first_name "Albus"
       last_name "Dumbledore"
       admin true
   end
end