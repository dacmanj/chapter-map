require "test_helper"

describe Attachment do
  let(:attachment) { Attachment.new }

  it "must be valid" do
    attachment.must_be :valid?
  end
end
