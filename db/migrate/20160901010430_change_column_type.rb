class ChangeColumnType < ActiveRecord::Migration
  
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
