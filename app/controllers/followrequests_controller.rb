class FollowrequestsController < ApplicationController
  def index
    matching_followrequests = FollowRequest.all

    @list_of_followrequests = matching_followrequests.order({ :created_at => :desc })

    render({ :template => "followrequests/index" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_followrequests = FollowRequest.where({ :id => the_id })

    @the_followrequest = matching_followrequests.at(0)

    render({ :template => "followrequests/show" })
  end

  def create
    the_followrequest = FollowRequest.new
    the_followrequest.recipient_id = params.fetch("query_recipient_id")
    the_followrequest.sender_id = params.fetch("query_sender_id")
    the_followrequest.status = params.fetch("query_status")

    if the_followrequest.valid?
      the_followrequest.save
      redirect_to("/followrequests", { :notice => "Followrequest created successfully." })
    else
      redirect_to("/followrequests", { :alert => the_followrequest.errors.full_messages.to_sentence })
    end
  end

  def update
    the_id = params.fetch("path_id")
    the_followrequest = FollowRequest.where({ :id => the_id }).at(0)

    the_followrequest.recipient_id = params.fetch("query_recipient_id")
    the_followrequest.sender_id = params.fetch("query_sender_id")
    the_followrequest.status = params.fetch("query_status")

    if the_followrequest.valid?
      the_followrequest.save
      redirect_to("/followrequests/#{the_followrequest.id}", { :notice => "Followrequest updated successfully."} )
    else
      redirect_to("/followrequests/#{the_followrequest.id}", { :alert => the_followrequest.errors.full_messages.to_sentence })
    end
  end

  def destroy
    the_id = params.fetch("path_id")
    the_followrequest = FollowRequest.where({ :id => the_id }).at(0)

    the_followrequest.destroy

    redirect_to("/followrequests", { :notice => "Followrequest deleted successfully."} )
  end
end
