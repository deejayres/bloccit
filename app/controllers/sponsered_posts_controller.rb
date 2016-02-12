class SponseredPostsController < ApplicationController
  def show
    @sponsered_post = SponseredPost.find(params[:id])
  end

  def new
    @topic = Topic.find(params[:topic_id])
    @sponsered_post = SponseredPost.new
  end

  def create
    @sponsered_post = SponseredPost.new
    @sponsered_post.title = params[:sponsered_post][:title]
    @sponsered_post.body = params[:sponsered_post][:body]
    @sponsered_post.price = params[:sponsered_post][:price]
    @topic = Topic.find(params[:topic_id])
    @sponsered_post.topic = @topic

    if @sponsered_post.save
      flash[:notice] = "Sponsered Post was saved"
      redirect_to [@topic, @sponsered_post]
    else
      flash.now[:alert] = "There was an error saving your sponsered post. Please try again."
      render :new
    end
  end

  def edit
    @sponsered_post = SponseredPost.find(params[:id])
  end

  def update
    @sponsered_post = SponseredPost.find(params[:id])
    @sponsered_post.title = params[:sponsered_post][:title]
    @sponsered_post.body = params[:sponsered_post][:body]
    @sponsered_post.price = params[:sponsered_post][:price]

    if @sponsered_post.save
      flash[:notice] = "Sponsered Post was saved."
      redirect_to [@sponsered_post.topic, @sponsered_post]
    else
      flash.new[:alert] = "There was an error saving the sponsered post. Please try again."
      render :edit
    end
  end

  def destroy
    @sponsered_post = SponseredPost.find(params[:id])

    if @sponsered_post.destroy
      flash[:notice] = "\"#{@sponsered_post.title}\" was deleted successfully."
      redirect_to @sponsered_post.topic
    else
      flash.now[:alert] = "There was an error deleting the sponsered post."
      render :show
    end
  end
end
