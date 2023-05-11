class GossipsController < ApplicationController
  before_action :authenticate_user, only: [:show, :edit, :create, :new, :update, :destroy]

  def new
    @gossip = Gossip.new
  end

  def create
    @gossip = Gossip.new(title: params[:title], content: params[:content], user: current_user, tag_ids: params[:tag])
    
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
    redirect_to root_path unless current_user == @gossip.user
  end
  
  def update
    @gossip = Gossip.find(params[:id])
    if current_user == @gossip.user && @gossip.update(title: params[:title], content: params[:content])
      flash[:success] = "Le potin a été modifié avec succès."
      redirect_to gossip_path(params[:id])
    else
      render :edit
    end
  end
  
  def destroy
    @gossip = Gossip.find(params[:id])
    if current_user == @gossip.user && @gossip.destroy
      flash[:success] = "Le potin a été détruit avec succès."
      redirect_to gossips_path
    else
      flash[:error] = "Le potin n'a pas été détruit."
      redirect_to gossip_path(params[:id])
    end
  end  

  def like
    @gossip = Gossip.find(params[:id])
    like = @gossip.likes.build(user: current_user)

    if like.save
      flash[:success] = "Vous avez aimé ce potin."
    else
      flash[:error] = "Une erreur s'est produite lors de l'ajout du like."
    end

    redirect_to gossip_path(@gossip)
  end

  def dislike
    @gossip = Gossip.find(params[:id])
    like = @gossip.likes.find_by(user: current_user)

    if like&.destroy
      flash[:success] = "Vous n'aimez plus ce potin."
    else
      flash[:error] = "Une erreur s'est produite lors de la suppression du like."
    end

    redirect_to gossip_path(@gossip)
  end

  private

  def authenticate_user
    unless current_user
      flash[:danger] = "Please log in."
      redirect_to new_session_path
    end
  end

end
