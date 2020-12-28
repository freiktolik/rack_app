require_relative './base_controller.rb'

class PostsController < BaseController

  # GET /posts
  #
  def index
    @title = "So many posts"
    @posts = Post.all
    build_response render_template
  end

  # GET /posts/:id
  # GET /posts/:id?name=Optional%20Custom%20Name
  #
  def show
    post_name = params["name"] || "Post-#{params[:id]}"
    @title = "#{post_name}'s page"
    @post = Post.find(params[:id])
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
    post = Post.new(name: params['post']['name'])
    post.save
    redirect_to "/posts/#{post.id}"
  end
end