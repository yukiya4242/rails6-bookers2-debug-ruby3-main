class SearchesController < ApplicationController
  before_action :authenticate_user!


def search
  search_target = params[:search_target]
  search_query = params[:search_query]
  search_method = params[:search_method]

  case search_target
  when 'users'
    case search_method
    when 'exact'
      @results = User.where(name: search_query)
    when 'prefix'
      @results = User.where('name LIKE ?', "#{search_query}%")
    when 'suffix'
      @results = User.where('name LIKE ?', "%#{search_query}")
    when 'partial'
      @results = User.where('name LIKE ?', "%#{search_query}%")
    end
  when 'books'
    case search_method
    when 'exact'
      @books = Book.where(title: search_query)
    when 'prefix'
      @books = Book.where('title LIKE ?', "#{search_query}%")
    when 'suffix'
      @books = Book.where('title LIKE ?', "%#{search_query}")
    when 'partial'
      @books = Book.where('title LIKE ?', "%#{search_query}%")
    end
  end
end
end