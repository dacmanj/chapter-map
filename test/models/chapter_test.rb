require "test_helper"

describe Chapter do
  let(:chapter) { chapters(:pflagdc) }

  it "must be valid" do
    chapter.must_be :valid?
  end
end
