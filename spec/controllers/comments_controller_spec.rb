require 'rails_helper'
include SessionsHelper

RSpec.describe CommentsController, type: :controller do
  let(:my_user) { User.create!(name: 'Bloccit User', email: 'user@bloccit.com', password: 'helloworld') }
  let(:other_user) { User.create!(name: RandomData.random_name, email: RandomData.random_email, password: 'helloworld', role: 'member') }
  let(:my_topic) { Topic.create!(name: RandomData.random_sentence, description: RandomData.random_paragraph) }
  let(:my_post) { my_topic.posts.create!(title: RandomData.random_sentence, body: RandomData.random_paragraph, user: my_user) }
  let(:my_comment) { Comment.create!(body: 'Comment Body', post: my_post, topic: my_topic, user: my_user) }

  context "guest" do
    describe "POST create" do
      it "redirects the user to the sign in view" do
        post :create, post_id: my_post.id, comment: {body: RandomData.random_paragraph}

        expect(response).to redirect_to(new_session_path)
      end
    end

    describe "DELETE destroy" do
      it "redirects the user to the sign in view" do
        delete :destroy, post_id: my_post.id, id: my_comment.id

        expect(response).to redirect_to(new_session_path)
      end
    end
  end

  context "member doing CRUD on a comment they don't own" do
    before do
      create_session(other_user)
    end

    describe "POST create comment on post" do
      it "increases the number of comments by 1" do
        expect{ post :create, post_id: my_post.id, comment: {body: RandomData.random_sentence} }.to change(Comment, :count).by(1)
      end

      it "redirects to the post show view" do
        post :create, post_id: my_post.id, comment: {body: RandomData.random_sentence}

        expect(response).to redirect_to [my_topic, my_post]
      end
    end

    describe "POST create comment on topic" do
      it "increases the number of comments by 1" do
        expect{ post :create, topic_id: my_topic.id, comment: {body: RandomData.random_sentence} }.to change(Comment, :count).by(1)
      end

      it "redirects to the topic show view" do
        post :create, topic_id: my_topic.id, comment: {body: RandomData.random_sentence}

        expect(response).to redirect_to my_topic
      end
    end

    describe "DELETE destroy comment on post" do
      it "redirects the user to the posts show view" do
        delete :destroy, post_id: my_post.id, id: my_comment.id

        expect(response).to redirect_to [my_topic, my_post]
      end
    end

    describe "DELETE destroy comment on topic" do
      it "redirects the user to the topic show view" do
        delete :destroy, topic_id: my_topic.id, id: my_comment.id

        expect(response).to redirect_to my_topic
      end
    end
  end

  context "member doing CRUD on their own comment" do
    before do
      create_session(my_user)
    end

    describe "POST create comment on post" do
      it "increases the number of comments by 1" do
        expect{ post :create, post_id: my_post.id, comment: {body: RandomData.random_sentence} }.to change(Comment, :count).by(1)
      end

      it "redirects to the post show view" do
        post :create, post_id: my_post.id, comment: {body: RandomData.random_sentence}

        expect(response).to redirect_to [my_topic, my_post]
      end
    end

    describe "POST create comment on topic" do
      it "increases the number of comments by 1" do
        expect{ post :create, topic_id: my_topic.id, comment: {body: RandomData.random_sentence} }.to change(Comment, :count).by(1)
      end

      it "redirects to the topic show view" do
        post :create, topic_id: my_topic.id, comment: {body: RandomData.random_sentence}

        expect(response).to redirect_to my_topic
      end
    end

    describe "DELETE destroy comment on post" do
      it "deletes the comment" do
        delete :destroy, post_id: my_post.id, id: my_comment.id
        count = Comment.where({id: my_comment.id}).count
        expect(count).to eq 0
      end

      it "redirects the user to the posts show view" do
        delete :destroy, post_id: my_post.id, id: my_comment.id

        expect(response).to redirect_to [my_topic, my_post]
      end
    end

    describe "DELETE destroy comment on topic" do
      it "deletes the comment" do
        delete :destroy, topic_id: my_topic.id, id: my_comment.id
        count = Comment.where({id: my_comment.id}).count
        expect(count).to eq 0
      end

      it "redirects the user to the topic show view" do
        delete :destroy, topic_id: my_topic.id, id: my_comment.id

        expect(response).to redirect_to my_topic
      end
    end
  end

  context "admin user doing CRUD on a comment they don't own" do
    before do
      other_user.admin!
      create_session(other_user)
    end

    describe "POST create comment on post" do
      it "increases the number of comments by 1" do
        expect{ post :create, post_id: my_post.id, comment: {body: RandomData.random_sentence} }.to change(Comment, :count).by(1)
      end

      it "redirects to the post show view" do
        post :create, post_id: my_post.id, comment: {body: RandomData.random_sentence}

        expect(response).to redirect_to [my_topic, my_post]
      end
    end

    describe "POST create comment on topic" do
      it "increases the number of comments by 1" do
        expect{ post :create, topic_id: my_topic.id, comment: {body: RandomData.random_sentence} }.to change(Comment, :count).by(1)
      end

      it "redirects to the topic show view" do
        post :create, topic_id: my_topic.id, comment: {body: RandomData.random_sentence}

        expect(response).to redirect_to my_topic
      end
    end

    describe "DELETE destroy comment on post" do
      it "deletes the comment" do
        delete :destroy, post_id: my_post.id, id: my_comment.id
        count = Comment.where({id: my_comment.id}).count
        expect(count).to eq 0
      end

      it "redirects the user to the posts show view" do
        delete :destroy, post_id: my_post.id, id: my_comment.id

        expect(response).to redirect_to [my_topic, my_post]
      end
    end

    describe "DELETE destroy comment on topic" do
      it "deletes the comment" do
        delete :destroy, topic_id: my_topic.id, id: my_comment.id
        count = Comment.where({id: my_comment.id}).count
        expect(count).to eq 0
      end

      it "redirects the user to the topic show view" do
        delete :destroy, topic_id: my_topic.id, id: my_comment.id

        expect(response).to redirect_to my_topic
      end
    end
  end
end
