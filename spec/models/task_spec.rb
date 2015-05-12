require "rails_helper"

describe Task do
  it "assigns tasks" do
    group = Group.create! name: "House"
    bob = create_user "Bob"
    alice = create_user "Alice"
    group.users << bob
    group.users << alice

    one = create_task(group, interval: "Daily", size: "small")
    one.update(user_id: bob.id)
    one = create_task(group, interval: "Daily", size: "small")
    one.update(user_id: bob.id)

    one = create_task(group, interval: "Daily", size: "big")
    one.update(user_id: alice.id)
    one = create_task(group, interval: "Daily", size: "big")
    one.update(user_id: alice.id)

    expect(group.users_and_number_of_tasks).to eq({
      "small" => {
        0 => [alice],
        2 => [bob],
      },
      "big" => {
        0 => [bob],
        2 => [alice],
      },
    })
  end

  it "assigns tasks" do
    group = Group.create! name: "House"
    bob = create_user "Bob"
    alice = create_user "Alice"
    users = [alice, bob]
    group.users << bob
    group.users << alice

    one = create_task(group, interval: "Daily", size: "small")
    one.assign_user
    users.map(&:reload)
    expect(one.user.first_name).to eq bob.first_name

    one = create_task(group, interval: "Daily", size: "small")
    one.assign_user
    users.map(&:reload)
    expect(one.user.first_name).to eq alice.first_name

    one = create_task(group, interval: "Daily", size: "big")
    one.assign_user
    users.map(&:reload)
    expect(one.user.first_name).to eq bob.first_name

    one = create_task(group, interval: "Daily", size: "big")
    one.assign_user
    users.map(&:reload)
    expect(one.user.first_name).to eq alice.first_name
  end

  it "assigns tasks" do
    group = Group.create! name: "House"
    bob = create_user "Bob"
    alice = create_user "Alice"
    users = [alice, bob]
    group.users << bob
    group.users << alice

    one = create_task(group, interval: "Daily", size: "small")
    one.assign_user
    users.map(&:reload)
    expect(one.user.first_name).to eq bob.first_name

    one = create_task(group, interval: "Daily", size: "big")
    one.assign_user
    users.map(&:reload)
    expect(one.user.first_name).to eq alice.first_name

    one = create_task(group, interval: "Daily", size: "big")
    one.assign_user
    users.map(&:reload)
    expect(one.user.first_name).to eq bob.first_name

    one = create_task(group, interval: "Daily", size: "small")
    one.assign_user
    users.map(&:reload)
    expect(one.user.first_name).to eq alice.first_name
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

  def create_task(group, interval: "small", size: "Daily")
    Task.create!(
      name: "Get milk",
      interval: interval,
      size: size,
      group_id: group.id,
    )
  end
end
