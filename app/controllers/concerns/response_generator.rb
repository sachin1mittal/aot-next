module Concerns::ResponseGenerator
  extend ::ActiveSupport::Concern

  def render_response(redirect_path: nil, success: true, message: '', data: {})
    respond_to do |format|
      format.html { redirect_to redirect_path if redirect_path }
      format.js
      format.json { render json: { success: success, message: message, data: serialized_data(data) } }
    end
  end

  def serialized_data(data)
    data.inject(data) do |h,(key, value)|
      if value.is_a?(Hash)
        h[key] = serialized_data(value)
      elsif serializable?(value)
        h[key] = serialize(value)
      else
        h[key] = value
      end
      h
    end
  end

  def serializable?(value)
    value.is_a?(ActiveRecord::Relation) || value.is_a?(ActiveRecord::Base)
  end

  def serialize(value)
    ActiveModel::Serializer.serializer_for(value).try(:new, value, root: false).try(:as_json)
  end

end

