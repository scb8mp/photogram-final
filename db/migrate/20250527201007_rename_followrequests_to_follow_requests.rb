class RenameFollowrequestsToFollowRequests < ActiveRecord::Migration[7.0]
  def change
    rename_table :followrequests, :follow_requests
  end
end
