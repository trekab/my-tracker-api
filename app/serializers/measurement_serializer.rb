class MeasurementSerializer
  include FastJsonapi::ObjectSerializer
  attributes :product_id, :category_id, :total
end
