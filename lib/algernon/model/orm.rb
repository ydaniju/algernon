module Algernon
  module Orm
    DB ||= SQLite3::Database.new(File.join("database", "data.sqlite"))

    def create(params)
      model = new
      params.each do |key, value|
        model.send("#{key}=", value)
      end

      model.save
    end

    def all
      fields = columns_array.join(", ")
      data = DB.execute("SELECT id, #{fields} FROM #{table_name}")
      data.map! do |row|
        row_to_model(row)
      end

      data
    end

    def row_to_model(row)
      model = new

      columns_array.each_with_index do |field, index|
        model.send("#{field}=", row[index + 1]) if row
      end

      model
    end

    def find(id)
      fields = columns_array.join(", ")
      row = DB.execute(
        "SELECT id, #{fields} FROM #{table_name} WHERE id = ?",
        id
      ).first
      row_to_model(row) if row
    end

    def destroy(id)
      DB.execute("DELETE FROM #{table_name} WHERE id= ?", id)
    end

    def destroy_all
      DB.execute("DELETE FROM #{table_name}")
    end
  end
end
