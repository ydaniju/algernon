class Task < Algernon::Model
  to_table :tasks

  property :title, type: :varchar, nullable: false
  property :description, type: :text
  property :created_at, type: :datetime
  property :updated_at, type: :datetime

  create_table
end
