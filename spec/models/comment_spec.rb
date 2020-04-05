require 'rails_helper'

RSpec.describe Comment, type: :model do
  describe "#create" do
    context "success" do
        it "is success registration with all value" do
            comment = build(:comment)
            expect(comment).to be_valid
        end
    end
    context "failure by nil" do
      it "is failure registration without comment" do
          comment = build(:comment, comment: nil)
          comment.valid?
          expect(comment.errors[:comment]).to include(I18n.t('errors.messages.blank'))
      end
    end
  end
end
