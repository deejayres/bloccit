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

end
