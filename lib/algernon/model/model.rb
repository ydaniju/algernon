require "sqlite3"
require "algernon/model/table_maker"
require "algernon/model/orm"

module Algernon
  class Model
    extend Algernon::TableMaker
    extend Algernon::Orm
    DB = Orm::DB

    def save
      if id
        query = "UPDATE #{self.class.table_name} "\
                "SET #{update_field_set} "\
                "WHERE id = ?"
        DB.execute(query, table_values, id)
      else
        query = "INSERT INTO #{self.class.table_name} "\
                "(#{table_fields}) "\
                "VALUES(#{values_placeholders})"
        DB.execute(query, table_values)

        self.id = DB.execute("SELECT last_insert_rowid()")
      end
      self.class.find(id)
    end

    def update(parameters)
      parameters.each do |key, value|
        send("#{key}=", value)
      end

      save
    end

    def destroy
      DB.execute("DELETE FROM #{self.class.table_name} WHERE id= ?", id)
    end

    def table_fields
      columns_except_id.join(", ")
    end

    def columns_except_id
      self.class.columns.without_id.with_value(self)
    end

    def values_placeholders
      count = columns_except_id.count
      (["?"] * count).join(", ")
    end

    def table_values
      values = []
      columns_except_id.each do |field|
        values << send(field)
      end
      values
    end

    def update_field_set
      values = []
      columns_except_id.each do |field|
        values << "#{field} = ? "
      end
      values.join(", ")
    end

    class << self
      attr_reader :table_name, :fields

      def to_table(table_name)
        @table_name = table_name.to_s
        @fields = {}
        property :id, type: :integer, primary_key: true
      end

      def property(field_name, options = {})
        @fields[field_name] = options
        attr_accessor field_name
      end

      def create_table
        query = "CREATE TABLE IF NOT EXISTS #{@table_name}"\
                "(#{fields_builder(@fields)})"
        DB.execute(query)
      end

      def columns
        @model_columns ||= fields.keys
      end
    end

    private :table_fields, :columns_except_id, :values_placeholders,
            :table_values, :update_field_set
  end
end
