module Ohm
  class MutableSet
    def find_or_create(params)
      model = self.find(params).first
      if model.nil?
        model = self.model.create(params)
        self.add(model)
      end
      model
    end
  end

  class Model
    def self.find_or_create(params)
      self.find(params).first || self.create(params)
    end

    protected

    def self.to_indices(att, val)
      if val.kind_of? Model
        att = :"#{att}_id"
        val = val.id
      end

      raise IndexNotFound unless indices.include?(att)

      if val.kind_of?(Enumerable)
        val.map { |v| key[:indices][att][v] }
      else
        [key[:indices][att][val]]
      end
    end
  end
end