class String
  def snakify
    gsub!("::", "/")
    gsub!(/([A-Z]+)([A-Z][a-z])/, '\1_\2')
    gsub!(/([a-z\d])([A-Z])/, '\1_\2')
    tr!("-", "_")
    downcase!
    self
  end

  def camelify
    return self if self !~ /_/ && self =~ /[A-Z]+.*/
    split("_").map(&:capitalize).join
  end

  def constantify
    Object.const_get(self)
  end
end
