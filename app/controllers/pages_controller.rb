class PagesController < ApplicationController
  def home
    # any instance variables for the view would go here,
    # e.g. @posts = Post.all
  end

  def profile
    # This action can be used to render a user profile page.
    # You can fetch user data and assign it to instance variables.
    # e.g. @user = User.find(params[:id])
  end
end
