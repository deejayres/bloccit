require 'rails_helper'

RSpec.describe Labeling, type: :model do
  it { is_expected.to belong_to :labelable }
end
