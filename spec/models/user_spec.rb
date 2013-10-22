require 'spec_helper'

describe User do
  it { should have_many(:topics) }
  it { should have_many(:replies) }
end
