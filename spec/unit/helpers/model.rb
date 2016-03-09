require "algernon/model/model"

class Model < Algernon::Model
  to_table :users

  property :name, type: :varchar, nullable: false
  property :age, type: :integer, default: 21

  create_table
end
