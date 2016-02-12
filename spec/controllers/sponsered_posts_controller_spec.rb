require 'rails_helper'

RSpec.describe SponseredPostsController, type: :controller do

  let(:my_topic) { Topic.create!(name: RandomData.random_sentence, description: RandomData.random_paragraph) }
  let(:my_sponsered_post) { my_topic.sponsered_posts.create!(title: RandomData.random_sentence, body: RandomData.random_paragraph, price: rand(100)) }

  describe "GET show" do
    it "returns http success" do
      get :show, topic_id: my_topic.id, id: my_sponsered_post.id

      expect(response).to have_http_status(:success)
    end

    it "renders the #show view" do
      get :show, topic_id: my_topic.id, id: my_sponsered_post.id

      expect(response).to render_template :show
    end

    it "assigns my_sponsered_post to @sponsered_post" do
      get :show, topic_id: my_topic.id, id: my_sponsered_post.id

      expect(assigns(:sponsered_post)).to eq(my_sponsered_post)
    end
  end

  describe "GET new" do
    it "returns http success" do
      get :new, topic_id: my_topic.id

      expect(response).to have_http_status(:success)
    end

    it "renders the #new view" do
      get :new, topic_id: my_topic.id

      expect(response).to render_template :new
    end

    it "instantiates @sponsered_post" do
      get :new, topic_id: my_topic.id

      expect(assigns(:sponsered_post)).not_to be_nil
    end
  end

  describe "POST create" do
    it "increases the sponsered post count by 1" do
      expect{post :create, topic_id: my_topic.id, sponsered_post: {title: RandomData.random_sentence, body: RandomData.random_paragraph, price: rand(100)}}.to change(SponseredPost, :count).by(1)
    end

    it "assigns the new sponsered post to @sponsered_post" do
      post :create, topic_id: my_topic.id, sponsered_post: {title: RandomData.random_sentence, body: RandomData.random_paragraph, price: rand(100)}

      expect(assigns(:sponsered_post)).to eq SponseredPost.last
    end

    it "redirects to the new sponsered post" do
      post :create, topic_id: my_topic.id, sponsered_post: {title: RandomData.random_sentence, body: RandomData.random_paragraph, price: rand(100)}

      expect(response).to redirect_to [my_topic, SponseredPost.last]
    end
  end

  describe "GET edit" do
    it "returns http success" do
      get :edit, topic_id: my_topic.id, id: my_sponsered_post.id

      expect(response).to have_http_status(:success)
    end

    it "renders the edit view" do
      get :edit, topic_id: my_topic.id, id: my_sponsered_post.id

      expect(response).to render_template :edit
    end

    it "assigns sponsered post to be updated to @sponsered_post" do
      get :edit, topic_id: my_topic.id, id: my_sponsered_post.id
      sponsered_post_instance = assigns(:sponsered_post)

      expect(sponsered_post_instance.id).to eq(my_sponsered_post.id)
      expect(sponsered_post_instance.title).to eq(my_sponsered_post.title)
      expect(sponsered_post_instance.body).to eq(my_sponsered_post.body)
      expect(sponsered_post_instance.price).to eq(my_sponsered_post.price)
    end
  end

  describe "PUT update" do
    it "updates post with the expected attributes" do
      new_title = RandomData.random_sentence
      new_body = RandomData.random_paragraph
      new_price = rand(100)
      put :update, topic_id: my_topic.id, id: my_sponsered_post.id, sponsered_post: {title: new_title, body: new_body, price: new_price}
      updated_sponsered_post = assigns(:sponsered_post)

      expect(updated_sponsered_post.id).to eq(my_sponsered_post.id)
      expect(updated_sponsered_post.title).to eq(new_title)
      expect(updated_sponsered_post.body).to eq(new_body)
      expect(updated_sponsered_post.price).to eq(new_price)
    end

    it "redirects to the updated post" do
      new_title = RandomData.random_sentence
      new_body = RandomData.random_paragraph
      new_price = rand(100)
      put :update, topic_id: my_topic.id, id: my_sponsered_post.id, sponsered_post: {title: new_title, body: new_body, price: new_price}

      expect(response).to redirect_to [my_topic, my_sponsered_post]
    end
  end

  describe "DELETE destroy" do
    it "deletes the sponsered post" do
      delete :destroy, topic_id: my_topic.id, id: my_sponsered_post.id
      count = SponseredPost.where({id: my_sponsered_post.id}).size

      expect(count).to eq(0)
    end

    it "redirects to the topic show" do
      delete :destroy, topic_id: my_topic.id, id: my_sponsered_post.id

      expect(response).to redirect_to my_topic
    end
  end

end
