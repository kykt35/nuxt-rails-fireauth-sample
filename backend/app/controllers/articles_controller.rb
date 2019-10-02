class ArticlesController < ApplicationController
  before_action :authenticate_by_fireauth!
  def index
    

    render status: 200
    
  end

end
