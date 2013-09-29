require 'spec_helper'

describe Reply do
  it { should belong_to(:topic) }
end
