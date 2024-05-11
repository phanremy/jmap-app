# frozen_string_literal: true

module MapHelper
  def generate_json(data)
    JSON.generate(if data.is_a?(Array)
                    data.map { |hash| hash.transform_keys(&:to_s) }
                  else
                    data.transform_keys(&:to_s)
                  end)
  end
end
