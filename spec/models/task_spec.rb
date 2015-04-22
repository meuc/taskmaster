require "rails_helper"

describe Task do
  it "gets users assigned" do
    group = Group.new
    user = create_user
    group.users << user
    task = create_task
    group.tasks << task
    
    task.assign_user

    expect(task.user).to eq user
  end
  
  it "gets users assigned when there are more users" do
    group = Group.new
    user = create_user
    group.users << user
    group.users << User.new
    group.users << User.new
    task = create_task
    group.tasks << task
    
    task.assign_user

    expect(task.user).to eq user
  end
  
  it "assigns users in turn" do
    group = Group.create! name: "House"
    bob = create_user "Bob"
    alice = create_user "Alice"
    cindy = create_user "Cindy"
    group.users << bob
    group.users << alice
    group.users << cindy
    
    one = create_task
    group.tasks << one
    one.assign_user
    
    two = create_task
    group.tasks << two
    two.assign_user
    
    three = create_task
    group.tasks << three
    three.assign_user

    expect(one.user.first_name).to eq bob.first_name
    expect(two.user.first_name).to eq cindy.first_name
    expect(three.user.first_name).to eq alice.first_name
  end
  
  it "assigns users in circle" do
    group = Group.create! name: "House"
    bob = create_user "Bob"
    alice = create_user "Alice"
    cindy = create_user "Cindy"
    group.users << bob
    group.users << alice
    group.users << cindy
    
    one = create_task
    group.tasks << one
    one.assign_user
    
    two = create_task
    group.tasks << two
    two.assign_user
    
    three = create_task
    group.tasks << three
    three.assign_user
    
    four = create_task
    group.tasks << four
    four.assign_user

    expect(one.user.first_name).to eq bob.first_name
    expect(two.user.first_name).to eq cindy.first_name
    expect(three.user.first_name).to eq alice.first_name
    expect(four.user.first_name).to eq bob.first_name
  end
  
  def create_user(first_name = "Bob")
    User.create!(
      first_name: first_name,
      last_name: "Panda",
      gender: "Male",
      birthdate: Date.today,
      email: first_name + "@example.com",
      password: "passwordlol"
    )
  end
  
  def create_task
    Task.create!(
       name: "Get milk",
       interval: "Always",
       size: "Rather large"
    )
  end
end