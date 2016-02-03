10_000.times do
  Thing.find_or_create_by content: Faker::Hacker.say_something_smart
end
