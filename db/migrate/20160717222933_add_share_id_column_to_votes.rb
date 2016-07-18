class AddShareIdColumnToVotes < ActiveRecord::Migration
  def change
    add_column :votes, :share_id, :integer
  end
end
