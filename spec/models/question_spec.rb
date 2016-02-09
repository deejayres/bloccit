require 'rails_helper'

RSpec.describe Question, type: :model do
  let(:question) { Question.create!(title: "New Question Title", body: "New question body", resolved: true ) }

  describe "attributes" do

    it "responds to Title" do
      expect(question).to respond_to(:title)
    end

    it "responds to Body" do
      expect(question).to respond_to(:body)
    end

    it "responds to Resolved" do
      expect(question).to respond_to(:resolved)
    end
  end
end
