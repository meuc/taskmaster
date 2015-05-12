require "rails_helper"

describe TasksController do
  it "creates suggested tasks" do
    group = Group.create!(name: "Our house")
    bob = User.create!(
      email: "bob@example.com",
      password: ("a"*8),
      first_name: "Bob",
      last_name: "Bobson",
      gender: "Male",
      birthdate: Date.today,
      group_id: group.id,
    )
    alice = User.create!(
      email: "alice@example.com",
      password: ("a"*8),
      first_name: "Alice",
      last_name: "Aliceson",
      gender: "Male",
      birthdate: Date.today,
      group_id: group.id,
    )

    sign_in bob

    params = {
      "Vacuum"=>"1",
      "size_Vacuum"=>"big",
      "interval_Vacuum"=>"daily",
      "Do_the_dishes"=>"1",
      "size_Do_the_dishes"=>"big",
      "interval_Do_the_dishes"=>"daily",
      "Water_the_flowers"=>"1",
      "size_Water_the_flowers"=>"big",
      "interval_Water_the_flowers"=>"daily",
    }

    post :create_suggested, params

    expect(Task.count).to eq 3
    expect(bob.tasks.count).to eq 2
    expect(alice.tasks.count).to eq 1
  end
end
