require_relative './base_controller.rb'

class PostsController < BaseController

  # GET /posts
  #
  def index
    build_response post_page("this should be a list of posts")
  end

  # GET /posts/:id
  #
  def show
    build_response post_page("this should show post ##{params[:id]}")
  end

  # GET /posts/new
  #
  def new
    build_response post_page("a page to create a new post")
  end

  # POST /posts
  # not implemented for now
  #
  def create
    redirect_to "/posts"
  end

  private

  def post_page(message)
    <<~HTML
      <html>
        <head><title>A Rack Demo</title></head>
        <body>
          <h1>This is PostsController##{params[:action]}</h1>
          <p>#{message}</p>
        </body>
      </html>
    HTML
  end
end