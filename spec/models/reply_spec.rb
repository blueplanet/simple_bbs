require 'spec_helper'

describe Reply do
  it { should belong_to(:topic) }
  it { should validate_presence_of(:body) }
end
