require 'rails_helper'

RSpec.describe Post, type: :model do
  let(:topic) { Topic.create!(name: RandomData.random_sentence, description: RandomData.random_paragraph) }
  let(:user) { User.create!(name: "Bloccit User", email: "user@bloccit.com", password: "helloworld") }
  let(:post) { topic.posts.create!(title: RandomData.random_sentence, body: RandomData.random_paragraph, user: user) }

  it { is_expected.to have_many(:labelings) }
  it { is_expected.to have_many(:labels).through(:labelings) }
  it { is_expected.to have_many(:comments) }
  it { is_expected.to have_many(:votes) }

  it { is_expected.to belong_to(:topic) }
  it { is_expected.to belong_to(:user) }

  it { is_expected.to validate_presence_of(:title) }
  it { is_expected.to validate_presence_of(:body) }
  it { is_expected.to validate_presence_of(:topic) }
  it { is_expected.to validate_length_of(:user) }

  it { is_expected.to validate_length_of(:title).is_at_least(5) }
  it { is_expected.to validate_length_of(:body).is_at_least(20) }

  describe "attributes" do
      it "responds to Title" do
      expect(post).to respond_to(:title)
    end

    it "responds to Body" do
      expect(post).to respond_to(:body)
    end
  end

  describe "voting" do
    before do
      3.times { post.votes.create!(value: 1) }
      2.times { post.votes.create!(value: -1) }
      @up_votes = post.votes.where(value: 1).count
      @down_votes = post.votes.where(value: -1).count
    end

    describe "#up_votes" do
      it "counts the number of votes with value = 1" do
        expect(post.up_votes).to eq(@up_votes)
      end
    end

    describe "#down_votes" do
      it "counts the number of votes with value = -1" do
        expect(post.down_votes).to eq(@down_votes)
      end
    end

    describe "points" do
      it "returns the sum of all up and down votes" do
        expect(post.points).to eq(@up_votes - @down_votes)
      end
    end

    describe "#update_rank" do
      it "calculates the correct rank" do
        post.update_rank
        expect(post.rank).to eq(post.points + (post.created_at - Time.new(1970,1,1)) / 1.day.seconds)
      end

      it "updates the rank when an upvote is created" do
        old_rank = post.rank
        post.votes.create!(value: 1)

        expect(post.rank).to eq(old_rank + 1)
      end

      it "updates the rank when a downvote is created" do
        old_rank = post.rank
        post.votes.create!(value: -1)

        expect(post.rank).to eq(old_rank - 1)
      end
    end

    describe "#create_vote" do
      # it "triggers create_vote on create" do
      #   expect(post).to receive(:create_vote).at_least(:once)
      # end
      topic = Topic.create!(name: RandomData.random_sentence, description: RandomData.random_paragraph)
      user = User.create!(name: RandomData.random_name, email: RandomData.random_email, password: "helloworld")
      post = Post.create!(title: RandomData.random_sentence, body: RandomData.random_paragraph, user: user, topic: topic)

      it "sets the post up_votes value to 1" do
        expect(post.up_votes).to eq(1)
      end

      it "sets the post down_votes value to 0" do
        expect(post.down_votes).to eq(0)
      end
      it "associates the vote with the owner of the post" do
        expect(post.votes.first.user).to eq(post.user)
      end
    end
  end
end
