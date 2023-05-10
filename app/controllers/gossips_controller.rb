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
    @gossips = Gossip.order(updated_at: :desc) # Récupérer tous les potins et les trier par ordre de mise à jour décroissant
  end

  def show
    @gossip = Gossip.find(params[:id])
    @gossips = Gossip.all
    @comments = @gossip.comments
  end

  def edit
    @gossip = Gossip.find(params[:id])
  end

  def update
    @gossip = Gossip.find(params[:id])
    if @gossip.update(title: params[:title], content: params[:content])
      flash[:success] = "Le potin a été modifié avec succès."
      redirect_to gossip_path(params[:id])
    else
      render :edit
    end
  end

  def destroy
    @gossip = Gossip.find(params[:id])
    if @gossip.destroy
      flash[:success] = "Le potin a été détruit avec succès."
      redirect_to gossips_path
    else
      flash[:error] = "Le potin n'a pas été détruit."
      redirect_to gossip_path(params[:id])
    end
  end

end
