require 'rails_helper'

RSpec.describe Answer, type: :model do
  let(:question) { Question.create!(body: "Question Body", title: "Question Title", resolved: true) }
  let(:answer) { Answer.create!(body: "Answer Body", question: question) }

  describe "attributes" do
    it "responds to body" do
      expect(answer).to respond_to(:body)
    end
  end
end
