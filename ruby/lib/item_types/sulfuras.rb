module ItemTypes
  module Sulfuras
    extend self

    def match?(item)
      item.name =~ /Sulfuras/
    end

    def update_item(_item)
      # no-op
    end
  end
end
