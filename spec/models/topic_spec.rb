require 'spec_helper'

describe Topic do
  it { should belong_to :node }
  it { should have_many :replies }
end
