require 'spec_helper'

describe ApplicationHelper do
  it { expect(helper).to respond_to :avatar_url }
end
