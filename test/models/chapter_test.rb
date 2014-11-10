require "test_helper"

describe Chapter do
  let(:chapter) { create(:chapter) }

  it "must be valid" do
    chapter.must_be :valid?
  end
end
