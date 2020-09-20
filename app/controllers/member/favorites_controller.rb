class Member::FavoritesController < ApplicationController
  def create
    @favorite = current_member.favorites.create(clinic_id: params[:clinic_id])
    redirect_back(fallback_location: root_path)
  end

  def destroy
    @clinic = Clinic.find(params[:clinic_id])
    @favorite = current_member.favorites.find_by(clinic_id: @clinic.id)
    @favorite.destroy 
    redirect_back(fallback_location: root_path)
  end

  def my_favorite
    @clinics = Clinic.joins(:favorites).where(favorites:{member_id: current_member.id})
  end
  
end