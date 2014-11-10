require "test_helper"

describe User do
  let(:user) { users(:david) }

  it "must be valid" do
    user.must_be :valid?
  end

  it "must have password t1234567" do
    assert user.valid_password? 't1234567'
  end
end
