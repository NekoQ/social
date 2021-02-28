class PostsController < ApplicationController
  def index
    puts params
    posts_number = params[:posts_number].to_i || 20
    start_date = params[:start_date]
    end_date = params[:end_date]
    lists = params[:lists]
    networks = params[:networks]
    text = params[:search_text]


    @posts = Post.filtered_by_lists(lists).filtered_by_network(networks).filtered_by_date(start_date, end_date)

    if params.has_key?(:search_text) && params[:search_text] != ''
      @posts = @posts.fast_search(text)
    end
    @posts = @posts.paginate(page: params[:page], per_page: 20)
  end

end
