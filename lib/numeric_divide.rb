require "numeric_divide/version"

class Numeric
  def divide(separation, include_start: false, include_end: true)
    unless separation.positive?
      raise ArgumentError, "separation must positive value"
    end

    return [] if self.negative?

    divided_values = 0.step(self, separation).to_a

    unless include_start
      divided_values.shift
    end

    if include_end && divided_values.last != self
      end_value = self
      end_value = end_value.to_f if separation.is_a?(Float)
      divided_values.push end_value
    end

    divided_values
  end
end
