class GossipsController < ApplicationController
  def new
    @gossip = Gossip.new
  end

  def create
    @gossip = Gossip.new(title: params[:title], content: params[:content], user: User.find(1))
    
    if @gossip.save
      flash[:success] = "Le potin a bien été créé !"
      redirect_to '/'
    else
      render :new
    end
  end  
  
  def index
    @gossips = Gossip.all
  end

  def welcome
    @first_name = params[:first_name]
    puts params[:first_name].inspect
  end

  def show
    @gossip = Gossip.find(params[:id])
    @gossips = Gossip.all
  end

end
