require_relative './base_controller.rb'

class PostsController < BaseController

  # GET /posts
  #
  def index
    @title = "So many posts"
    @posts = (1..5).map do |i|
      OpenStruct.new(id: i, name: "post-#{i}")
    end
    build_response render_template
  end

  # GET /posts/:id
  # GET /posts/:id?name=Optional%20Custom%20Name
  #
  def show
    post_name = params["name"] || "Post-#{params[:id]}"
    @title = "#{post_name}'s page"
    @post = OpenStruct.new(id: params[:id], name: post_name)
    build_response render_template
  end

  # GET /posts/new
  #
  def new
    @title = "New post"
    build_response render_template
  end

  # POST /posts
  # not implemented for now
  #
  def create
    redirect_to "/posts"
  end
end