class ChangeColumnType < ActiveRecord::Migration
  def change
    connection.execute(%q{
        alter table shares
        alter column lat
        type float using lat::float
    })
    connection.execute(%q{
        alter table shares
        alter column lon
        type float using lon::float
    })
  end
end
