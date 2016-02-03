require 'rails_helper'

RSpec.describe Post, type: :model do
  let(:post) { Post.create!(title: "New Post Title", body: "New post body") }

  describe "attributes" do

    it "responds to Title" do
      expect(post).to respond_to(:title)
    end

    it "responds to Body" do
      expect(post).to respond_to(:body)
    end
  end
end
