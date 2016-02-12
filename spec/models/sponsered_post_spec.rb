require 'rails_helper'

RSpec.describe SponseredPost, type: :model do
  let(:topic) { Topic.create!(name: RandomData.random_sentence, description: RandomData.random_paragraph) }
  let(:sponsered_post) { topic.sponsered_posts.create!(title: RandomData.random_sentence, body: RandomData.random_paragraph, price:rand(10)) }
  it { is_expected.to belong_to(:topic) }

  describe "attributes" do
    it "responds to title" do
      expect(sponsered_post).to respond_to(:title)
    end

    it "responds to body" do
      expect(sponsered_post).to respond_to(:body)
    end

    it "responds to price" do
      expect(sponsered_post).to respond_to(:price)
    end
  end
end
