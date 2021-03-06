class Member::RelationshipsController < ApplicationController
  before_action :authenticate_member!

  def create
    follow = current_member.active_relationships.build(follower_id: params[:member_id])
    follow.save
    @member = Member.find(params[:member_id])
    @member.create_notification_follow!(current_member)
    redirect_back(fallback_location: root_path)
  end

  def destroy
    follow = current_member.active_relationships.find_by(follower_id: params[:member_id])
    follow.destroy
    redirect_back(fallback_location: root_path)
  end

end
