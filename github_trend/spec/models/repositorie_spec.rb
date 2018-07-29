require 'rails_helper'

RSpec.describe Repositorie, type: :model do
  describe 'valudates' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:type) }
    it { is_expected.to validate_length_of(:name).is_at_most(25) }
  end
end
