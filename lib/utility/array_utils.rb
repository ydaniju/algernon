class Array
  def without_id
    reject { |key| key == :id }
  end

  def with_value(base)
    reject { |field| base.send(field).nil? }
  end
end
