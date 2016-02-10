require 'rails_helper'

RSpec.describe TopicsController, type: :controller do

  let(:my_topic) { Topic.create!(name: RandomData.random_sentence, description: RandomData.random_paragraph) }

  describe "GET index" do
    it "returns HTTP success" do
      get :index

      expect(response).to have_http_status(:success)
    end

    it "assigns my_topic to @topics" do
      get :index

      expect(assigns(:topics)).to eq([my_topic])
    end
  end

  describe "GET show" do
    it "returns HTTP success" do
      get :show, { id: my_topic.id }

      expect(response).to have_http_status(:success)
    end

    it "renders :show" do
      get :show, { id: my_topic.id }

      expect(response).to render_template :show
    end

    it "assigns my_topic to @topic" do
      get :show, { id: my_topic.id }

      expect(assigns(:topic)).to eq(my_topic)
    end
  end

  describe "GET new" do
    it "returns HTTP success" do
      get :new

      expect(response).to have_http_status(:success)
    end

    it "renders :new" do
      get :new

      expect(response).to render_template :new
    end

    it "initializes @topic" do
      get :new

      expect(assigns(:topic)).not_to be_nil
    end
  end

  describe "POST create" do
    it "increases the number of topics by 1" do
      expect{ post :create, {topic: {name: RandomData.random_sentence, description: RandomData.random_paragraph}}}.to change(Topic, :count).by(1)
    end

    it "assigns Topic.last to @topic" do
      post :create, {topic: {name: RandomData.random_sentence, description: RandomData.random_paragraph}}

      expect(assigns(:topic)).to eq(Topic.last)
    end

    it "redirects to the new topic" do
      post :create, {topic: {name: RandomData.random_sentence, description: RandomData.random_paragraph}}

      expect(response).to redirect_to Topic.last
    end
  end

  describe "GET edit" do
    it "returns HTTP success" do
      get :edit, { id: my_topic.id }

      expect(response).to have_http_status(:success)
    end

    it "renders the #edit view" do
      get :edit, { id: my_topic.id }

      expect(response).to render_template :edit
    end

    it "assigns topic to be updated to @topic" do
      get :edit, { id: my_topic.id }
      topic_instance = assigns(:topic)

      expect(topic_instance.id).to eq(my_topic.id)
      expect(topic_instance.name).to eq(my_topic.name)
      expect(topic_instance.description).to eq(my_topic.description)
    end
  end

end
