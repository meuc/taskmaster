require "rails_helper"

describe PickUser do
  let(:alice) { double("alice") }
  let(:bob) { double("bob") }
  let(:cindy) { double("cindy") }

  it "" do
    hash = {
      "small" => {
        1 => [],
        2 => [],
        0 => [bob, alice, cindy],
      },
      "big" => {
        1 => [],
        2 => [],
        0 => [bob, alice, cindy],
      },
    }

    expect(PickUser.call(hash, "small")).to eq bob
  end

  it "" do
    hash = {
      "small" => {
        1 => [bob],
        2 => [],
        0 => [alice, cindy],
      },
      "big" => {
        0 => [bob, alice, cindy],
        1 => [],
        2 => [],
      },
    }

    expect(PickUser.call(hash, "small")).to eq alice
  end

  it "" do
    hash = {
      "small" => {
        0 => [bob, alice, cindy],
        1 => [],
        2 => [],
      },
      "big" => {
        0 => [alice, cindy],
        1 => [bob],
        2 => [],
      },
    }

    expect(PickUser.call(hash, "small")).to eq alice
  end

  it "" do
    hash = {
      "small" => {
        0 => [bob, alice, cindy],
        1 => [],
        2 => [],
      },
      "big" => {
        0 => [alice, cindy],
        1 => [bob],
        2 => [],
      },
    }

    expect(PickUser.call(hash, "big")).to eq alice
  end

  it "" do
    hash = {
      "small" => {
        0 => [bob],
        1 => [alice, cindy],
        2 => [],
      },
      "big" => {
        0 => [bob, alice, cindy],
        1 => [],
        2 => [],
      },
    }

    expect(PickUser.call(hash, "big")).to eq bob
  end

  it "" do
    hash = {
      "small" => {
        0 => [bob, alice],
        2 => [cindy],
      },
      "big" => {
        0 => [cindy],
        1 => [alice],
        2 => [bob],
      },
    }

    expect(PickUser.call(hash, "small")).to eq alice
  end
end
