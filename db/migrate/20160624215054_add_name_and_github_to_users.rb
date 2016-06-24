class AddNameAndGithubToUsers < ActiveRecord::Migration
  def change
    add_column :users, :name, :string
    add_column :users, :GitHub, :string
  end
end
