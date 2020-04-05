require 'rails_helper'

RSpec.describe Favorite, type: :model do
  describe "#create" do
    context "success" do
        it "is success registration with all value" do
            favorite = build(:favorite)
            expect(favorite).to be_valid
        end
    end
  end
end
